From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 1/2] ASoC: mc13783: add mixer controls
Date: Fri, 11 Oct 2013 12:28:13 +0200
Message-ID: <1381487294-20406-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 20C22265665
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 12:28:43 +0200 (CEST)
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
Cc: kernel@pengutronix.de, Mark Brown <broonie@kernel.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Add more controls to the alsa mixer infrastructure.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
	- Fix some control names
	- remove controls that belong to DAPM

 sound/soc/codecs/mc13783.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index eedbf05..2b62737 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -541,8 +541,26 @@ static const struct soc_enum mc13783_enum_3d_mixer =
 static struct snd_kcontrol_new mc13783_control_list[] = {
 	SOC_SINGLE("Loudspeaker enable", MC13783_AUDIO_RX0, 5, 1, 0),
 	SOC_SINGLE("PCM Playback Volume", MC13783_AUDIO_RX1, 6, 15, 0),
+	SOC_SINGLE("PCM Playback Switch", MC13783_AUDIO_RX1, 5, 1, 0),
 	SOC_DOUBLE("PCM Capture Volume", MC13783_AUDIO_TX, 19, 14, 31, 0),
 	SOC_ENUM("3D Control", mc13783_enum_3d_mixer),
+
+	SOC_SINGLE("CDCOUT Switch", MC13783_AUDIO_RX0, 18, 1, 0),
+	SOC_SINGLE("Earpiece Amp Switch", MC13783_AUDIO_RX0, 3, 1, 0),
+	SOC_DOUBLE("Headset Amp Switch", MC13783_AUDIO_RX0, 10, 9, 1, 0),
+	SOC_DOUBLE("Line out Amp Switch", MC13783_AUDIO_RX0, 16, 15, 1, 0),
+
+	SOC_SINGLE("PCM Capture Mixin Switch", MC13783_AUDIO_RX0, 22, 1, 0),
+	SOC_SINGLE("Line in Capture Mixin Switch", MC13783_AUDIO_RX0, 23, 1, 0),
+
+	SOC_SINGLE("CODEC Capture Volume", MC13783_AUDIO_RX1, 1, 15, 0),
+	SOC_SINGLE("CODEC Capture Mixin Switch", MC13783_AUDIO_RX0, 21, 1, 0),
+
+	SOC_SINGLE("Line in Capture Volume", MC13783_AUDIO_RX1, 12, 15, 0),
+	SOC_SINGLE("Line in Capture Switch", MC13783_AUDIO_RX1, 10, 1, 0),
+
+	SOC_SINGLE("MC1 Capture Bias Switch", MC13783_AUDIO_TX, 0, 1, 0),
+	SOC_SINGLE("MC2 Capture Bias Switch", MC13783_AUDIO_TX, 1, 1, 0),
 };
 
 static int mc13783_probe(struct snd_soc_codec *codec)
-- 
1.8.4.rc3
