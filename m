From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [Fwd: Re: Linux 2.6.10-ac8] - Patch breaks audio report
Date: Mon, 10 Jan 2005 18:28:31 +0000
Message-ID: <1105381333.12004.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YtvHT4YLFSnFCNSccH0p"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D98B617E
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 20:32:46 +0100 (MET)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 65F5841B36
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 20:32:44 +0100 (MET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j0AISWcV010490
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 18:28:32 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j0AISVsP010489
	for alsa-devel@alsa-project.org; Mon, 10 Jan 2005 18:28:31 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-YtvHT4YLFSnFCNSccH0p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

-----Forwarded Message-----
> From: Jules Villard <jvillard@ens-lyon.fr>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.6.10-ac8
> Date: Sun, 09 Jan 2005 18:16:41 +0100
> 
> Hello,
> 
> I'm experiencing some troubles with the patches you included in
> 2.6.10-ac5 about ALSA : the files open and play ok, but no sound is
> actually outputed...
> 
> I've found that the patch sound/pci/ac97/ac97_patch.c (hereby
> attached) is responsible for that (ie when I boot with the full patch 
> minus this one, the sound is ok).
> 
> Nothing special is printed in dmesg, so I've only attached my lspci 
> output and my .config (along with the patch).
> 
> Feel free to CC me if more details are needed, for I'm not on the lkml.
> 
> Regards,
> 
> Jules
> 
> 
> ______________________________________________________________________
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/sound/pci/ac97/ac97_patch.c linux-2.6.10/sound/pci/ac97/ac97_patch.c
> --- linux.vanilla-2.6.10/sound/pci/ac97/ac97_patch.c	2004-12-25 21:15:54.000000000 +0000
> +++ linux-2.6.10/sound/pci/ac97/ac97_patch.c	2005-01-06 19:29:28.000000000 +0000
> @@ -1013,8 +1013,20 @@
>   	return patch_build_controls(ac97, &snd_ac97_ad198x_spdif_source, 1);
>  }
>  
> +static const snd_kcontrol_new_t snd_ac97_ad1981x_jack_sense[] = {
> +	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 11, 1, 0),
> +	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0),
> +};
> +
> +static int patch_ad1981a_specific(ac97_t * ac97)
> +{
> +	return patch_build_controls(ac97, snd_ac97_ad1981x_jack_sense,
> +				    ARRAY_SIZE(snd_ac97_ad1981x_jack_sense));
> +}
> +
>  static struct snd_ac97_build_ops patch_ad1981a_build_ops = {
> -	.build_post_spdif = patch_ad198x_post_spdif
> +	.build_post_spdif = patch_ad198x_post_spdif,
> +	.build_specific = patch_ad1981a_specific
>  };
>  
>  int patch_ad1981a(ac97_t *ac97)
> @@ -1023,6 +1035,7 @@
>  	ac97->build_ops = &patch_ad1981a_build_ops;
>  	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
>  	ac97->flags |= AC97_STEREO_MUTES;
> +	snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11); /* HP jack sense */
>  	return 0;
>  }
>  
> @@ -1031,7 +1044,12 @@
>  
>  static int patch_ad1981b_specific(ac97_t *ac97)
>  {
> -	return patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1);
> +	int err;
> +
> +	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
> +		return err;
> +	return patch_build_controls(ac97, snd_ac97_ad1981x_jack_sense,
> +				    ARRAY_SIZE(snd_ac97_ad1981x_jack_sense));
>  }
>  
>  static struct snd_ac97_build_ops patch_ad1981b_build_ops = {
> @@ -1045,6 +1063,7 @@
>  	ac97->build_ops = &patch_ad1981b_build_ops;
>  	snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD198X_MSPLT, AC97_AD198X_MSPLT);
>  	ac97->flags |= AC97_STEREO_MUTES;
> +	snd_ac97_update_bits(ac97, AC97_AD_JACK_SPDIF, 1<<11, 1<<11); /* HP jack sense */
>  	return 0;
>  }
>  
> 
> 
> ______________________________________________________________________
> 00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
> 00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
> 00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
> 00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01)
> 00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
> 00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
> 02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> 02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> 02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
> 02:02.0 Network controller: Intel Corp.: Unknown device 4220 (rev 05)

--=-YtvHT4YLFSnFCNSccH0p
Content-Type: application/x-gzip; name="config.gz"
Content-Disposition: inline; filename="config.gz"
Content-Transfer-Encoding: base64

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

--=-YtvHT4YLFSnFCNSccH0p--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
