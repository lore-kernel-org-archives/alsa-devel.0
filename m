From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] ymfpci - re-enable legacy audio after
	suspend resume
Date: Fri, 9 Mar 2012 07:28:26 +0800
Message-ID: <CAN8ccia-mdoS4w5FHN_0tPnuCzfi2HaDb4nhZ3TdvV-8OezBvA@mail.gmail.com>
References: <CAN8ccibfK6Cpho5F5vk8jq_gbZQKp4_C3bMcZ6Ef4c+TU2=EBQ@mail.gmail.com>
	<s5h399jpohv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DAB3810BB40
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:28:26 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so783755wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 15:28:26 -0800 (PST)
In-Reply-To: <s5h399jpohv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

2012/3/8, Takashi Iwai <tiwai@suse.de>:
> At Thu, 8 Mar 2012 12:12:33 +0800,
> Raymond Yau wrote:
>>
>> Since the Legacy Audio Control register is reset to default after
>> suspend resume cycle
>>
>> need to enable the Legacy Audio Control Bit in order to use OPL3 FM Synth
>>
>> however it is still need to use sbiload  instrument loader to reload
>> the instruments
>
> Isn't it better to save and restore these PCI registers like below?
> It still doesn't solve the lost instrument problem, though.
>

I only use std.o3 and drums.o3

It seem that the playback of midi using aplaymidi can resume playback
after suspend with my ymf724f

so it seem that there is no need to reload the instrument with your patch

>
> ---
> diff --git a/include/sound/ymfpci.h b/include/sound/ymfpci.h
> index 444cd6b..1e35b16 100644
> --- a/include/sound/ymfpci.h
> +++ b/include/sound/ymfpci.h
> @@ -366,6 +366,8 @@ struct snd_ymfpci {
>  #ifdef CONFIG_PM
>  	u32 *saved_regs;
>  	u32 saved_ydsxgr_mode;
> +	u16 saved_saved_dsxg_legacy;
> +	u16 saved_saved_dsxg_elegacy;


Should be saved_dsxg_legacy and save_dsxg_elegacy.
How can this change back port to 2.6 kernel ?


>  #endif
>  };
>
> diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
> index 12a9a2b..a8159b81 100644
> --- a/sound/pci/ymfpci/ymfpci_main.c
> +++ b/sound/pci/ymfpci/ymfpci_main.c
> @@ -2317,6 +2317,10 @@ int snd_ymfpci_suspend(struct pci_dev *pci,
> pm_message_t state)
>  	for (i = 0; i < YDSXGR_NUM_SAVED_REGS; i++)
>  		chip->saved_regs[i] = snd_ymfpci_readl(chip, saved_regs_index[i]);
>  	chip->saved_ydsxgr_mode = snd_ymfpci_readl(chip, YDSXGR_MODE);
> +	pci_read_config_word(chip->pci, PCIR_DSXG_LEGACY,
> +			     &chip->saved_dsxg_legacy);
> +	pci_read_config_word(chip->pci, PCIR_DSXG_ELEGACY,
> +			     &chip->saved_dsxg_elegacy);
>  	snd_ymfpci_writel(chip, YDSXGR_NATIVEDACOUTVOL, 0);
>  	snd_ymfpci_writel(chip, YDSXGR_BUF441OUTVOL, 0);
>  	snd_ymfpci_disable_dsp(chip);
> @@ -2351,6 +2355,11 @@ int snd_ymfpci_resume(struct pci_dev *pci)
>
>  	snd_ac97_resume(chip->ac97);
>
> +	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY,
> +			      chip->saved_dsxg_legacy);
> +	pci_write_config_word(chip->pci, PCIR_DSXG_ELEGACY,
> +			      chip->saved_dsxg_elegacy);
> +
>  	/* start hw again */
>  	if (chip->start_count > 0) {
>  		spin_lock_irq(&chip->reg_lock);
>
>
