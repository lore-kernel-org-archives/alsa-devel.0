From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ALSA: hda - Revert power_save option
	default value
Date: Mon, 12 Mar 2018 14:14:53 +0100
Message-ID: <534c274a-b0b4-f96f-7812-edd4d7ce67df@redhat.com>
References: <20180312130440.27134-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D5C9266E43
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 14:14:55 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id 188so16009041wme.1
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 06:14:55 -0700 (PDT)
In-Reply-To: <20180312130440.27134-1-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 12-03-18 14:04, Takashi Iwai wrote:
> With the commit 1ba8f9d30817 ("ALSA: hda: Add a power_save
> blacklist"), we changed the default value of power_save option to -1
> for processing the power-save blacklist.
> Unfortunately, this seems breaking user-space applications that
> actually read the power_save parameter value via sysfs and judge /
> adjust the power-saving status.  They see the value -1 as if the
> power-save is turned off, although the actual value is taken from
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT and it can be a positive.
> 
> So, overall, passing -1 there was no good idea.  Let's partially
> revert it -- at least for power_save option default value is restored
> again to CONFIG_SND_HDA_POWER_SAVE_DEFAULT.  Meanwhile, in this patch,
> we keep the blacklist behavior and make is adjustable via the new
> option, pm_blacklist.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199073
> Fixes: 1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thank you for taking care of this and not just reverting my patch.

Your fix looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   sound/pci/hda/hda_intel.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 96143df19b21..d5017adf9feb 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -181,11 +181,15 @@ static const struct kernel_param_ops param_ops_xint = {
>   };
>   #define param_check_xint param_check_int
>   
> -static int power_save = -1;
> +static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
>   module_param(power_save, xint, 0644);
>   MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
>   		 "(in second, 0 = disable).");
>   
> +static bool pm_blacklist = true;
> +module_param(pm_blacklist, bool, 0644);
> +MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
> +
>   /* reset the HD-audio controller in power save mode.
>    * this may give more power-saving, but will take longer time to
>    * wake up.
> @@ -2300,10 +2304,9 @@ static int azx_probe_continue(struct azx *chip)
>   
>   	val = power_save;
>   #ifdef CONFIG_PM
> -	if (val == -1) {
> +	if (pm_blacklist) {
>   		const struct snd_pci_quirk *q;
>   
> -		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
>   		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
>   		if (q && val) {
>   			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
> 
