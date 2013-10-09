From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH] ASoC: mc13783: add mixer controls
Date: Wed,  9 Oct 2013 17:01:44 +0200
Message-ID: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E76942654D6
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 17:01:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add more kcontrols for the alsa mixer infrastructure.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 sound/soc/codecs/mc13783.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index eedbf05..fafe999 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -534,6 +534,30 @@ static struct snd_soc_dapm_route mc13783_routes[] = {
 static const char * const mc13783_3d_mixer[] = {"Stereo", "Phase Mix",
 						"Mono", "Mono Mix"};
 
+static const char * const mc13783_alsp[] = {"Off", "Codec", "Right"};
+
+static const char * const mc13783_ahs[] = {"Codec", "Mixer"};
+
+static const struct soc_enum mc13783_enum_asp =
+	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 4, ARRAY_SIZE(mc13783_alsp),
+			mc13783_alsp);
+
+static const struct soc_enum mc13783_enum_alsp =
+	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 7, ARRAY_SIZE(mc13783_alsp),
+			mc13783_alsp);
+
+static const struct soc_enum mc13783_enum_ahs =
+	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 11, ARRAY_SIZE(mc13783_ahs),
+			mc13783_ahs);
+
+static const struct soc_enum mc13783_enum_arxout =
+	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 17, ARRAY_SIZE(mc13783_ahs),
+			mc13783_ahs);
+
+static const struct soc_enum mc13783_enum_codec =
+	SOC_ENUM_SINGLE(MC13783_AUDIO_RX1, 4, ARRAY_SIZE(mc13783_alsp),
+			mc13783_alsp);
+
 static const struct soc_enum mc13783_enum_3d_mixer =
 	SOC_ENUM_SINGLE(MC13783_AUDIO_RX1, 16, ARRAY_SIZE(mc13783_3d_mixer),
 			mc13783_3d_mixer);
@@ -541,8 +565,32 @@ static const struct soc_enum mc13783_enum_3d_mixer =
 static struct snd_kcontrol_new mc13783_control_list[] = {
 	SOC_SINGLE("Loudspeaker enable", MC13783_AUDIO_RX0, 5, 1, 0),
 	SOC_SINGLE("PCM Playback Volume", MC13783_AUDIO_RX1, 6, 15, 0),
+	SOC_SINGLE("PCM Playback Switch", MC13783_AUDIO_RX1, 5, 1, 0),
 	SOC_DOUBLE("PCM Capture Volume", MC13783_AUDIO_TX, 19, 14, 31, 0),
 	SOC_ENUM("3D Control", mc13783_enum_3d_mixer),
+	SOC_ENUM("Earpiece Switch", mc13783_enum_asp),
+	SOC_ENUM("Loudspeaker Switch", mc13783_enum_alsp),
+
+	SOC_ENUM("Headset Switch", mc13783_enum_ahs),
+	SOC_SINGLE("Headset Amp Right Switch", MC13783_AUDIO_RX0, 9, 1, 0),
+	SOC_SINGLE("Headset Amp Left Switch", MC13783_AUDIO_RX0, 10, 1, 0),
+
+	SOC_ENUM("Line out Amp Switch", mc13783_enum_arxout),
+	SOC_SINGLE("Line out Amp Right Switch", MC13783_AUDIO_RX0, 15, 1, 0),
+	SOC_SINGLE("Line out Amp Left Switch", MC13783_AUDIO_RX0, 16, 1, 0),
+
+	SOC_SINGLE("Codec Capture Mix Switch", MC13783_AUDIO_RX0, 21, 1, 0),
+	SOC_SINGLE("PCM Capture Mix Switch", MC13783_AUDIO_RX0, 22, 1, 0),
+	SOC_SINGLE("Line in Capture Mix Switch", MC13783_AUDIO_RX0, 23, 1, 0),
+
+	SOC_SINGLE("Codec Capture Volume", MC13783_AUDIO_RX1, 1, 15, 0),
+	SOC_SINGLE("Codec Capture Switch", MC13783_AUDIO_RX1, 0, 1, 0),
+
+	SOC_SINGLE("PGA Capture Volume", MC13783_AUDIO_RX1, 12, 15, 0),
+	SOC_SINGLE("PGA Capture Switch", MC13783_AUDIO_RX1, 10, 1, 0),
+
+	SOC_SINGLE("MC1 Capture Bias Switch", MC13783_AUDIO_TX, 0, 1, 0),
+	SOC_SINGLE("MC2 Capture Bias Switch", MC13783_AUDIO_TX, 1, 1, 0),
 };
 
 static int mc13783_probe(struct snd_soc_codec *codec)
-- 
1.8.4.rc3
