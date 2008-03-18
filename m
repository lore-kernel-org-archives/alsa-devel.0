From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Use base ALC883 mixer for 6stack-dell model
Date: Tue, 18 Mar 2008 18:17:14 -0300
Message-ID: <200803181817.14376.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id DFCB4103883
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 22:17:16 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 2E61F3DCC6
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 18:17:16 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id IR0T4MdIobl2 for <alsa-devel@alsa-project.org>;
	Tue, 18 Mar 2008 18:17:15 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id A0DD53DCC4
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 18:17:15 -0300 (BRT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 3F4442F2C7
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 18:17:15 -0300 (BRT)
Content-Disposition: inline
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

After DAC assignment fix in ALC883, alc888_6st_dell_mixer is now the
same as alc883_base_mixer. Avoid duplicated code and use
alc883_base_mixer in 6stack-dell model, removing alc888_6st_dell_mixer
definition.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up alsa-kernel/pci/hda/patch_realtek.c.orig alsa-kernel/pci/hda/patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c.orig	2008-03-18 17:54:42.000000000 -0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2008-03-18 18:00:08.000000000 -0300
@@ -6992,46 +6992,6 @@ static struct snd_kcontrol_new alc888_3s
 	{ } /* end */
 };
 
-static struct snd_kcontrol_new alc888_6st_dell_mixer[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x09, 0x0, HDA_INPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		/* .name = "Capture Source", */
-		.name = "Input Source",
-		.count = 2,
-		.info = alc883_mux_enum_info,
-		.get = alc883_mux_enum_get,
-		.put = alc883_mux_enum_put,
-	},
-	{ } /* end */
-};
-
 static struct snd_kcontrol_new alc883_acer_aspire_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -7941,7 +7901,7 @@ static struct alc_config_preset alc883_p
 		.input_mux = &alc883_capture_source,
 	},
 	[ALC888_6ST_DELL] = {
-		.mixers = { alc888_6st_dell_mixer, alc883_chmode_mixer },
+		.mixers = { alc883_base_mixer, alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc888_6st_dell_verbs },
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,

-- 
[]'s
Herton
