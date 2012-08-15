From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Check the power state when
 power_save option is changed
Date: Wed, 15 Aug 2012 04:19:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8170D4A@SHSMSX101.ccr.corp.intel.com>
References: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
 <s5hfw7pu5ue.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8170A84@SHSMSX101.ccr.corp.intel.com>
 <s5hhas5zgak.wl%tiwai@suse.de>	<s5hehn9zeku.wl%tiwai@suse.de>
 <s5ha9xxzehm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id F15C0265EB8
 for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2012 05:50:03 +0200 (CEST)
In-Reply-To: <s5ha9xxzehm.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Many thanks, Takashi!  These two patches work well.

Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, August 14, 2012 11:21 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: [PATCH 2/2] ALSA: hda - Check the power state when power_save
> option is changed
> 
> ... by calling the newly introduced snd_hda_power_sync().
> 
> I had to reimplement a wheel for adding the trigger at changing the
> parameter -- the parameter set ops is overwritten to pass the integer
> parameter, then trigger the power-state sync.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 58
> ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> 23ad7e2..330a5ff 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -110,8 +110,15 @@ MODULE_PARM_DESC(beep_mode, "Select HDA
> Beep registration mode "
>  #endif
> 
>  #ifdef CONFIG_SND_HDA_POWER_SAVE
> +static int param_set_xint(const char *val, const struct kernel_param
> +*kp); static struct kernel_param_ops param_ops_xint = {
> +	.set = param_set_xint,
> +	.get = param_get_int,
> +};
> +#define param_check_xint param_check_int
> +
>  static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
> -module_param(power_save, int, 0644);
> +module_param(power_save, xint, 0644);
>  MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
>  		 "(in second, 0 = disable).");
> 
> @@ -502,6 +509,9 @@ struct azx {
> 
>  	/* reboot notifier (for mysterious hangup problem at power-down) */
>  	struct notifier_block reboot_notifier;
> +
> +	/* card list (for power_save trigger) */
> +	struct list_head list;
>  };
> 
>  /* driver types */
> @@ -2407,6 +2417,48 @@ static void azx_power_notify(struct hda_bus
> *bus)
>  		 !bus->power_keep_link_on)
>  		azx_stop_chip(chip);
>  }
> +
> +static DEFINE_MUTEX(card_list_lock);
> +static LIST_HEAD(card_list);
> +
> +static void azx_add_card_list(struct azx *chip) {
> +	mutex_lock(&card_list_lock);
> +	list_add(&chip->list, &card_list);
> +	mutex_unlock(&card_list_lock);
> +}
> +
> +static void azx_del_card_list(struct azx *chip) {
> +	mutex_lock(&card_list_lock);
> +	list_del_init(&chip->list);
> +	mutex_unlock(&card_list_lock);
> +}
> +
> +/* trigger power-save check at writing parameter */ static int
> +param_set_xint(const char *val, const struct kernel_param *kp) {
> +	struct azx *chip;
> +	struct hda_codec *c;
> +	int prev = power_save;
> +	int ret = param_set_int(val, kp);
> +
> +	if (ret || prev == power_save)
> +		return ret;
> +
> +	mutex_lock(&card_list_lock);
> +	list_for_each_entry(chip, &card_list, list) {
> +		if (!chip->bus || chip->disabled)
> +			continue;
> +		list_for_each_entry(c, &chip->bus->codec_list, list)
> +			snd_hda_power_sync(c);
> +	}
> +	mutex_unlock(&card_list_lock);
> +	return 0;
> +}
> +#else
> +#define azx_add_card_list(chip) /* NOP */ #define
> +azx_del_card_list(chip) /* NOP */
>  #endif /* CONFIG_SND_HDA_POWER_SAVE */
> 
>  #ifdef CONFIG_PM
> @@ -2607,6 +2659,8 @@ static int azx_free(struct azx *chip)  {
>  	int i;
> 
> +	azx_del_card_list(chip);
> +
>  	azx_notifier_unregister(chip);
> 
>  	if (use_vga_switcheroo(chip)) {
> @@ -2914,6 +2968,7 @@ static int __devinit azx_create(struct snd_card
> *card, struct pci_dev *pci,
>  	chip->dev_index = dev;
>  	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);
>  	INIT_LIST_HEAD(&chip->pcm_list);
> +	INIT_LIST_HEAD(&chip->list);
>  	init_vga_switcheroo(chip);
> 
>  	chip->position_fix[0] = chip->position_fix[1] = @@ -3291,6 +3346,7
> @@ static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip)
>  	chip->running = 1;
>  	power_down_all_codecs(chip);
>  	azx_notifier_register(chip);
> +	azx_add_card_list(chip);
> 
>  	return 0;
> 
> --
> 1.7.11.4
