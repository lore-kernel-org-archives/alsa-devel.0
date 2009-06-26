From: Tony Vroon <tony@linx.net>
Subject: [PATCH] Line In for Acer Inspire 6530G model
Date: Fri, 26 Jun 2009 09:27:50 +0100 (BST)
Message-ID: <20090626082750.6D1B210092@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B0962479D
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 10:27:51 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Emilio =?ISO-8859-1?Q?L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Line In connector is set up as PIN_IN by default, using 
VREF_HIZ. It is connected to both ADCs, so add it to both 
input selectors.
Also add the ability to use the input mix (on a SoundBlaster 
one would call this "What You Hear").

Signed-off-by: Tony Vroon <tony@linx.net>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3345331..67dd883 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1560,18 +1560,22 @@ static struct hda_input_mux alc888_2_capture_sources[2] = {
 static struct hda_input_mux alc888_acer_aspire_6530_sources[2] = {
 	/* Interal mic only available on one ADC */
 	{
-		.num_items = 3,
+		.num_items = 5,
 		.items = {
 			{ "Ext Mic", 0x0 },
+			{ "Line In", 0x2 },
 			{ "CD", 0x4 },
+			{ "Input Mix", 0xa },
 			{ "Int Mic", 0xb },
 		},
 	},
 	{
-		.num_items = 2,
+		.num_items = 4,
 		.items = {
 			{ "Ext Mic", 0x0 },
+			{ "Line In", 0x2 },
 			{ "CD", 0x4 },
+			{ "Input Mix", 0xa },
 		},
 	}
 };
@@ -8189,6 +8193,8 @@ static struct snd_kcontrol_new alc888_acer_aspire_6530_mixer[] = {
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("LFE Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("LFE Playback Switch", 0x0f, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
