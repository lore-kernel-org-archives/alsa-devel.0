From: Veli-Matti Lintu <veli-matti.lintu@opinsys.fi>
Subject: Re: Patch for Intel-HDA ALC262 on FSC Lifebook C1410
Date: Fri, 12 Oct 2007 15:57:16 +0300
Message-ID: <1192193836.29174.57.camel@localhost>
References: <32444606.17521191841076426.JavaMail.root@intra>
	<23182792.17541191841181316.JavaMail.root@intra>
	<s5h1wc4vdm6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.opinsys.fi (59ec6c11.adsl.tnnet.fi [89.236.108.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 8911124532
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Oct 2007 14:57:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.opinsys.fi (Postfix) with ESMTP id EE84B94089
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Oct 2007 15:55:38 +0300 (EEST)
Received: from mail.opinsys.fi ([127.0.0.1])
	by localhost (mail.opinsys.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wR4HGaMSU0S2 for <alsa-devel@alsa-project.org>;
	Fri, 12 Oct 2007 15:55:38 +0300 (EEST)
Received: from [10.246.135.50] (unknown [10.246.135.50])
	by mail.opinsys.fi (Postfix) with ESMTP id E5FB194085
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Oct 2007 15:55:37 +0300 (EEST)
In-Reply-To: <s5h1wc4vdm6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ti, 2007-10-09 kello 11:30 +0200, Takashi Iwai kirjoitti:
> At Mon, 8 Oct 2007 13:59:41 +0300 (EEST),
> Veli-Matti Lintu wrote:
> > 
> > Hello,
> > 
> > After error and trial I got sound working on Fujitsu-Siemens Computers Lifebook C1410. Attached is a patch that works for me, but probably needs some cleaning.
> > 
> > The laptop uses an ALC262 chip that is also used on other FSC models, but the needed settings seem to be somewhat different from the existing Fujitsu-settings in patch_realtek.c. If I understand correctly, the chips use same subsystem ids, so the patch does not automatically detect the correct chipset. Maybe someone more knowledgeable can help with this? The patch names the internal mic as Int Mic and external mic that can be plugged in as Ext Mic.
> > 
> > There's some more background information in Ubuntu's Launchpad:
> > https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/125790
> > 
> > 
> > The patch is tested with kernel 2.6.22.9. I am not really familiar with alsa development, so I cannot say which version of the alsa drivers that kernel version uses. The environment where the testing was done is running Ubuntu 7.04 with alsa version 1.0.13. Only updated component is the kernel.
> > -------------------------------------------------------------------
> > lspci -nv (on C1410)
> > 
> > 00:1b.0 0403: 8086:27d8 (rev 02)
> >         Subsystem: 10cf:1397
> >         Flags: bus master, fast devsel, latency 0, IRQ 22
> >         Memory at f0640000 (64-bit, non-prefetchable) [size=16K]
> >         Capabilities: [50] Power Management version 2
> >         Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
> >         Capabilities: [70] Express Unknown type IRQ 0
> >         Capabilities: [100] Virtual Channel
> >         Capabilities: [130] Unknown (5)
> > -------------------------------------------------------------------
> > 
> > I hope someone with more knowledge about alsa drivers could have a look at this. The patch has been in internal use for a few weeks and people seem to be happy with it, so I hope also others can get their sound working.
> 
> First, thanks for the patch.
> 
> I think we can simply extend the existing fujitsu model.  The internal
> mic is likely a missing feature in that model, too.
> 
> So, could you check whether the latest ALSA driver does work for you
> "as is" (in a certain level)?  If not, could you just add
> alc262_EAPD_verbs to the initialization verbs for ALC262_FUTJISU?

Thanks for looking at this. I tested this against kernel 2.6.22.9 from
kernel.org and the patch seems to do the trick. Without
alc262_EAPD_verbs sound does not work and the mic settings need to be
added to get the mic working.

I do not have any other laptops using the same chip available for
testing, so I cannot say whether this affects other models using the
same chip.

Below is the diff from the actual sources that I used to test this:

-----------------------------------------------------------------------
--- pci/hda/patch_realtek.c 2007-09-26 21:03:01.000000000 +0300
+++ pci/hda/patch_realtek.c 2007-10-11 21:07:30.000000000 +0300
@@ -7064,6 +7064,7 @@
        .num_items = 2,
        .items = {
                { "Mic", 0x0 },
+               { "Int Mic", 0x1 },
                { "CD", 0x4 },
        },
 };
@@ -7179,6 +7180,9 @@
        HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
        HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
        HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+       HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+       HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1,
HDA_INPUT),
+       HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
        { } /* end */
 };

@@ -7649,7 +7653,8 @@
        },
        [ALC262_FUJITSU] = {
                .mixers = { alc262_fujitsu_mixer },
-               .init_verbs = { alc262_init_verbs,
alc262_fujitsu_unsol_verbs },
+               .init_verbs = { alc262_init_verbs, alc262_EAPD_verbs,
+                               alc262_fujitsu_unsol_verbs },
                .num_dacs = ARRAY_SIZE(alc262_dac_nids),
                .dac_nids = alc262_dac_nids,
                .hp_nid = 0x03,
-----------------------------------------------------------------------

Veli-Matti


> A patch I hacked quickly is below.  Try it as a reference, too.
> 
> 
> Takashi
> 
> diff -r a4cf3aa3dc5b pci/hda/patch_realtek.c
> --- a/pci/hda/patch_realtek.c	Tue Oct 09 10:34:06 2007 +0200
> +++ b/pci/hda/patch_realtek.c	Tue Oct 09 11:28:26 2007 +0200
> @@ -7810,6 +7810,7 @@ static struct hda_input_mux alc262_fujit
>  	.num_items = 2,
>  	.items = {
>  		{ "Mic", 0x0 },
> +		{ "Int Mic", 0x1 },
>  		{ "CD", 0x4 },
>  	},
>  };
> @@ -7915,6 +7916,9 @@ static struct snd_kcontrol_new alc262_fu
>  	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
>  	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
>  	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
> +	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
> +	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
> +	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
>  	{ } /* end */
>  };
>  
> @@ -8411,7 +8415,8 @@ static struct alc_config_preset alc262_p
>  	},
>  	[ALC262_FUJITSU] = {
>  		.mixers = { alc262_fujitsu_mixer },
> -		.init_verbs = { alc262_init_verbs, alc262_fujitsu_unsol_verbs },
> +		.init_verbs = { alc262_init_verbs, alc262_EAPD_verbs,
> +				alc262_fujitsu_unsol_verbs },
>  		.num_dacs = ARRAY_SIZE(alc262_dac_nids),
>  		.dac_nids = alc262_dac_nids,
>  		.hp_nid = 0x03,
