From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: [PARTIAL PATCH] snd-hda-intel on Medion WIM2160
Date: Wed, 19 Sep 2007 20:26:27 +0200
Message-ID: <200709192026.28082.bero@arklinux.org>
References: <200709111416.24299.bero@arklinux.org>
	<s5hwsuupw9h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UnW8GJvWBigRnYS"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.arklinux.org (mail.arklinux.osuosl.org [140.211.166.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 2139224608
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 20:28:43 +0200 (CEST)
In-Reply-To: <s5hwsuupw9h.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_UnW8GJvWBigRnYS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 13 September 2007, Takashi Iwai wrote:
> > The patch below fixes it, but unfortunately, Medion MD2 uses the same PCI
> > (and subvendor/subdevice) ID -- so the patch quite likely breaks Medion
> > MD2 support.
>
> In that case, try to reset board_config after
> snd_hda_check_board_config() but before setup_preset().  See
> patch_alc885() for example (appeariny in the latest ALSA tree, also in
> mm tree).

Will do...

> Otherwise it looks OK to me.  But, what is the primary difference in
> the setup between MD2 and WIM2160?

I don't know -- I made it work by trial and error (I don't have access to any 
hardware specs or the likes). By some more trial and error, I could minimize 
the patch some more - it's down to editing the init_verbs and mixers.
In the mixers, this one seems to be the key:
HDA_BIND_MUTE("Master Playback Switch", 0x0c, 2, HDA_INPUT)

Maybe we can get it to work with both MD2 and WIM2160 by using the MD2 mixers 
with this one added.

I'm not familiar enough with sound drivers in general to fiddle with the verbs 
and be reasonably sure I'm not breaking the MD2.

--Boundary-00=_UnW8GJvWBigRnYS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="medion-wim2160-sound-try2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="medion-wim2160-sound-try2.patch"

--- linux-2.6.22/sound/pci/hda/patch_realtek.c.wim2160snd~	2007-09-14 15:51:28.000000000 +0200
+++ linux-2.6.22/sound/pci/hda/patch_realtek.c	2007-09-14 15:53:21.000000000 +0200
@@ -169,6 +169,7 @@
 	ALC883_ACER,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,	
+	ALC883_MEDION_WIM2160,
 	ALC883_LAPTOP_EAPD,
 	ALC883_LENOVO_101E_2ch,
 	ALC883_LENOVO_NB0763,
@@ -6235,6 +6236,32 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc883_medion_wim2160_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Master Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("iMic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("iMic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x09, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 2,
+		.info = alc883_mux_enum_info,
+		.get = alc883_mux_enum_get,
+		.put = alc883_mux_enum_put,
+	},
+	{ } /* end */
+};	
+
 static struct snd_kcontrol_new alc883_chmode_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -6640,6 +6667,7 @@
 	[ALC883_ACER]		= "acer",
 	[ALC883_MEDION]		= "medion",
 	[ALC883_MEDION_MD2]	= "medion-md2",
+	[ALC883_MEDION_WIM2160]	= "medion-wim2160",
 	[ALC883_LAPTOP_EAPD]	= "laptop-eapd",
 	[ALC883_LENOVO_101E_2ch] = "lenovo-101e",
 	[ALC883_LENOVO_NB0763]	= "lenovo-nb0763",
@@ -6684,7 +6712,8 @@
 	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC888_6ST_HP),
 	SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
 	SND_PCI_QUIRK(0x103c, 0x2a4f, "HP Samba", ALC888_3ST_HP),
-	SND_PCI_QUIRK(0x17c0, 0x4071, "MEDION MD2", ALC883_MEDION_MD2),
+	//SND_PCI_QUIRK(0x17c0, 0x4071, "MEDION MD2", ALC883_MEDION_MD2),
+	SND_PCI_QUIRK(0x17c0, 0x4071, "Medion WIM2160", ALC883_MEDION_WIM2160),
 	{}
 };
 
@@ -6814,6 +6843,20 @@
 		.unsol_event = alc883_medion_md2_unsol_event,
 		.init_hook = alc883_medion_md2_automute,
 	},	
+	[ALC883_MEDION_WIM2160] = {
+		.mixers = { alc883_medion_wim2160_mixer },
+		.init_verbs = { alc883_init_verbs, alc883_lenovo_nb0763_verbs},
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_capture_source,
+		.unsol_event = alc883_medion_md2_unsol_event,
+		.init_hook = alc883_medion_md2_automute,
+	},
 	[ALC883_LAPTOP_EAPD] = {
 		.mixers = { alc883_base_mixer,
 			    alc883_chmode_mixer },

--Boundary-00=_UnW8GJvWBigRnYS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_UnW8GJvWBigRnYS--
