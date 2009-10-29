From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: TWL4030: Vibra motor stop fix when
	it is driven with audio
Date: Thu, 29 Oct 2009 11:58:09 +0200
Message-ID: <1256810290-20478-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1256810290-20478-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 33D362466A
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 10:58:54 +0100 (CET)
In-Reply-To: <1256810290-20478-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, ext-jari.vanhala@nokia.com
List-Id: alsa-devel@alsa-project.org

From: Jari Vanhala <ext-jari.vanhala@nokia.com>

This patch fixes vibrator playing incoherently, when driven
with audio. There is something wrong in switch 3 at
H-bridge and VIBRA_SET still affects PWM generator.
Slowest value fixes things.

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 9163713..ccaeb36 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -613,6 +613,13 @@ static int handsfreerpga_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int vibramux_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	twl4030_write(w->codec, TWL4030_REG_VIBRA_SET, 0xff);
+	return 0;
+}
+
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
 	struct snd_soc_device *socdev = codec->socdev;
@@ -1243,8 +1250,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			0, 0, NULL, 0, handsfreerpga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* Vibra */
-	SND_SOC_DAPM_MUX("Vibra Mux", TWL4030_REG_VIBRA_CTL, 0, 0,
-		&twl4030_dapm_vibra_control),
+	SND_SOC_DAPM_MUX_E("Vibra Mux", TWL4030_REG_VIBRA_CTL, 0, 0,
+			   &twl4030_dapm_vibra_control, vibramux_event,
+			   SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_MUX("Vibra Route", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_vibrapath_control),
 
-- 
1.6.5.1
