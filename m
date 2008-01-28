From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: A Weird issue on Gigabyte board
Date: Mon, 28 Jan 2008 13:52:26 +0800
Message-ID: <1201499546.29927.6.camel@localhost.localdomain>
References: <1200559447.30641.49.camel@localhost.localdomain>
	<s5hd4s0g0wi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id C55BC24580
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 06:52:30 +0100 (CET)
In-Reply-To: <s5hd4s0g0wi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, Takashi:

The reporter rechecked.
The real reason is that he replaced the pci/hda instead of the
alsa-kernel/pci/hda/patch_realtek.c.
After he corrected this, the patch worked well.
Thank you very much!

Here is the patch for his machine:

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20080127/alsa-kernel/pci/hda/patch_realtek.c
2008-01-26 09:00:07.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-01-28 13:44:06.000000000
+0800
@@ -5884,6 +5884,7 @@ static struct snd_pci_quirk alc882_cfg_t
 	SND_PCI_QUIRK(0x1043, 0x817f, "Asus P5LD2", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x81d8, "Asus P5WD", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC882_6ST_DIG),
+	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P35 DS3R", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x28fb, "Targa T8", ALC882_TARGA), /* MSI-1049
T8  */
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC882_6ST_DIG),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Arima W820", ALC882_ARIMA),

On Thu, 2008-01-17 at 12:13 +0100, Takashi Iwai wrote:
> At Thu, 17 Jan 2008 16:44:07 +0800,
> Jiang zhe wrote:
> > 
> > Hi,
> > 
> > I meet with a weird issue.
> > Please refer to the bug 0003674 on bugtrack.alsa-project.org.
> > 
> > It use alc889 codec but the codec vendor id is 0885.
> > 
> > With the alsa-driver-hg20080110.tar.bz2, it works well with option
> > "model=6stack-dig".
> > 
> > But after I simply added the this line into the alc882_cfg_tbl[]:
> > SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P35-DS3R", ALC882_6ST_DIG),
> > 
> > The dmesg still show "hda_codec: Unknown model for ALC882, trying
> > auto-probe from BIOS...". and driver will crash.
> > 
> > With this patch, even loading it with option "model=6stack-dig" doesn't
> > help, driver will still crash.
> > 
> > I found a line in the dmesg:
> > "hda_intel: azx_get_response timeout, switching to polling mode: last
> > cmd=0xbe0f0009."
> > The Cad is 0xb.
> 
> Very weird.
> 
> > The codec_mask can change from 0x4 to 0x1:
> > alsa-kernel/pci/hda/hda_intel.c:732: codec_mask = 0x4
> > alsa-kernel/pci/hda/hda_intel.c:732: codec_mask = 0x1
> 
> This implies the hardware is somehow unstable.
> 
> 
> Anyway, try the patch below.  It cleans up a bit and avoids possible
> invalid commands, plus puts stack traces at a fatal communication
> error.
> 
> 
> Takashi
> 
> diff -r f94766e99413 pci/hda/hda_codec.c
> --- a/pci/hda/hda_codec.c	Thu Jan 17 11:28:47 2008 +0100
> +++ b/pci/hda/hda_codec.c	Thu Jan 17 12:13:30 2008 +0100
> @@ -2739,8 +2739,7 @@ int snd_hda_parse_pin_def_config(struct 
>  				 struct auto_pin_cfg *cfg,
>  				 hda_nid_t *ignore_nids)
>  {
> -	hda_nid_t nid, nid_start;
> -	int nodes;
> +	hda_nid_t nid, end_nid;
>  	short seq, assoc_line_out, assoc_speaker;
>  	short sequences_line_out[ARRAY_SIZE(cfg->line_out_pins)];
>  	short sequences_speaker[ARRAY_SIZE(cfg->speaker_pins)];
> @@ -2753,8 +2752,8 @@ int snd_hda_parse_pin_def_config(struct 
>  	memset(sequences_hp, 0, sizeof(sequences_hp));
>  	assoc_line_out = assoc_speaker = 0;
>  
> -	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid_start);
> -	for (nid = nid_start; nid < nodes + nid_start; nid++) {
> +	end_nid = codec->start_nid + codec->num_nodes;
> +	for (nid = codec->start_nid; nid < end_nid; nid++) {
>  		unsigned int wid_caps = get_wcaps(codec, nid);
>  		unsigned int wid_type =
>  			(wid_caps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
> diff -r f94766e99413 pci/hda/hda_intel.c
> --- a/pci/hda/hda_intel.c	Thu Jan 17 11:28:47 2008 +0100
> +++ b/pci/hda/hda_intel.c	Thu Jan 17 12:13:30 2008 +0100
> @@ -587,6 +587,7 @@ static unsigned int azx_rirb_get_respons
>  	snd_printk(KERN_ERR "hda_intel: azx_get_response timeout, "
>  		   "switching to single_cmd mode: last cmd=0x%08x\n",
>  		   chip->last_cmd);
> +	dump_stack(); /* It's an error - show stack trace */
>  	chip->rirb.rp = azx_readb(chip, RIRBWP);
>  	chip->rirb.cmds = 0;
>  	/* switch to single_cmd mode */
> @@ -1738,6 +1739,7 @@ static int __devinit azx_create(struct s
>  
>  	err = pci_request_regions(pci, "ICH HD audio");
>  	if (err < 0) {
> +		printk(KERN_ERR SFX "Fail to request regions\n");
>  		kfree(chip);
>  		pci_disable_device(pci);
>  		return err;
> diff -r f94766e99413 pci/hda/hda_local.h
> --- a/pci/hda/hda_local.h	Thu Jan 17 11:28:47 2008 +0100
> +++ b/pci/hda/hda_local.h	Thu Jan 17 12:13:30 2008 +0100
> @@ -375,7 +375,7 @@ static inline u32 get_wcaps(struct hda_c
>  {
>  	if (nid < codec->start_nid ||
>  	    nid >= codec->start_nid + codec->num_nodes)
> -		return snd_hda_param_read(codec, nid, AC_PAR_AUDIO_WIDGET_CAP);
> +		return 0;
>  	return codec->wcaps[nid - codec->start_nid];
>  }
>  
