From: Wu Fengguang <fengguang.wu@gmail.com>
Subject: Re: digital audio on ASUS P5QL-EM motherboard
Date: Sun, 16 Nov 2008 16:27:33 +0800
Message-ID: <20081116082733.GA20129@localhost>
References: <6d799ca1be9af898f664f82ade06d669@localhost>
	<20081115002724.GA5073@mail.ustc.edu.cn>
	<002f01c94770$adeba2a0$09c2e7e0$@ca>
	<20081116021525.GA7795@localhost>
	<003801c947b4$b857ffb0$2907ff10$@ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 09BDB24535
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 09:27:42 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id j3so1215259tid.8
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 00:27:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <003801c947b4$b857ffb0$2907ff10$@ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrei Tanas <andrei@tanas.ca>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 16, 2008 at 01:29:46AM -0500, Andrei Tanas wrote:
> > It seems that there are two problems:
> > - the SPDIF output PID for you board is 0x10 instead of 0x06
> You are right about this, it works with the patch you provided, with one
> caveat: ALC1200 uses ALC883 patch, so instead of changing ALC882_DIGOUT_NID,
> I changed ALC883_DIGOUT_NID.

Thank you!

You are the kind of smart people that are pleasant to work with ;-)

> How did you find out that it's 0x10 instead of 0x06? Has documentation on
> ALC1200 become available?

It's easy:

grep -i -C6 spdif /proc/asound/card0/codec\#0
grep -i -C6 'stereo digital' /proc/asound/card0/codec\#0

And check the connectivity between pin complex and audio output nodes.

> > - codec#1 is not probed properly
> I was responsible for the confusion with the missing codec. I set
> probe_mask=1 parameter (as suggested in some forum as a troubleshooting
> option for ALC1200) without trying to understand what it does. The probing
> actually seems to work correctly.

Thanks for the clarification. I failed to figure out by reading the code
why codec#1 is silently ignored, hence the brute force print-and-reset hack.

Now you can do a 'cat /proc/asound/card0/codec\#1' and read about the
HDMI codec. For it to work, you may need the bleeding edge Xorg drivers.

> Model autodetection:
> lspci -nn -vvv shows:
> 00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD
> Audio Controller [8086:3a3e]
>         Subsystem: ASUSTeK Computer Inc. Device [1043:82fe]
> 
> So this SND_PCI_QUIRK fixes it (except that it's currently relying on the
> temporary hack)
>
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -8206,6 +8206,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
>         SND_PCI_QUIRK(0x103c, 0x2a4f, "HP Samba", ALC888_3ST_HP),
>         SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
>         SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
> +       SND_PCI_QUIRK(0x1043, 0x82fe, "Asus P5Q", ALC883_6ST_DIG),
>         SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
>         SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI",
> ALC883_3ST_6ch_DIG),
>         SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_ASUS_EEE1601),

So let's create a new model?

Thank you,
Fengguang
---
 sound/pci/hda/patch_realtek.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- sound-2.6.orig/sound/pci/hda/patch_realtek.c
+++ sound-2.6/sound/pci/hda/patch_realtek.c
@@ -232,6 +232,7 @@ enum {
 	ALC883_3ST_6ch_INTEL,
 	ALC888_ASUS_M90V,
 	ALC888_ASUS_EEE1601,
+	ALC1200_ASUS_P5Q,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -6868,6 +6869,8 @@ static int patch_alc882(struct hda_codec
 #define ALC883_DIGOUT_NID	0x06
 #define ALC883_DIGIN_NID	0x0a
 
+#define ALC883_DIGOUT_NID_ASUS_P5Q	0x10
+
 static hda_nid_t alc883_dac_nids[4] = {
 	/* front, rear, clfe, rear_surr */
 	0x02, 0x03, 0x04, 0x05
@@ -8190,6 +8193,7 @@ static const char *alc883_models[ALC883_
 	[ALC883_CLEVO_M720]	= "clevo-m720",
 	[ALC883_FUJITSU_PI2515] = "fujitsu-pi2515",
 	[ALC883_3ST_6ch_INTEL]	= "3stack-6ch-intel",
+	[ALC1200_ASUS_P5Q]	= "asus-p5q",
 	[ALC883_AUTO]		= "auto",
 };
 
@@ -8208,6 +8212,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
 	SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", ALC883_3ST_6ch_DIG),
+	SND_PCI_QUIRK(0x1043, 0x82fe, "Asus P5Q-EM HDMI", ALC1200_ASUS_P5Q),
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_ASUS_EEE1601),
 	SND_PCI_QUIRK(0x105b, 0x0ce8, "Foxconn P35AX-S", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC883_6ST_DIG),
@@ -8555,6 +8560,17 @@ static struct alc_config_preset alc883_p
 		.unsol_event = alc883_eee1601_unsol_event,
 		.init_hook = alc883_eee1601_inithook,
 	},
+	[ALC1200_ASUS_P5Q] = {
+		.mixers = { alc883_base_mixer, alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID_ASUS_P5Q,
+		.dig_in_nid = ALC883_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+		.channel_mode = alc883_sixstack_modes,
+		.input_mux = &alc883_capture_source,
+	},
 };
