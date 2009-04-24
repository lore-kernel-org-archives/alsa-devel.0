From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/2] ASoC: cs4270: add Master Playback Switch
Date: Fri, 24 Apr 2009 16:37:45 +0200
Message-ID: <1240583865-14407-2-git-send-email-daniel@caiaq.de>
References: <20090424135216.GF10450@buzzloop.caiaq.de>
	<1240583865-14407-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 99A462412E
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 16:37:58 +0200 (CEST)
In-Reply-To: <1240583865-14407-1-git-send-email-daniel@caiaq.de>
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
Cc: Mark Brown <broonie@sirena.org.uk>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

This adds a new control named 'Master Playback Switch' for cs4270
codecs. It is implemented using the new SOC_DOUBLE_EXT macro to catch
the put function and store the information about manually set mute
controls from userspace. When a manual mute is set, we don't want the
soc core to un-mute the outputs.

Renamed cs4270_mute() to cs4270_dai_mute() to avoid confusion.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@sirena.org.uk>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |   44 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 3c34fe6..0f453a0 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -109,6 +109,7 @@ struct cs4270_private {
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
+	unsigned int manual_mute;
 };
 
 /**
@@ -453,7 +454,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 }
 
 /**
- * cs4270_mute - enable/disable the CS4270 external mute
+ * cs4270_dai_mute - enable/disable the CS4270 external mute
  * @dai: the SOC DAI
  * @mute: 0 = disable mute, 1 = enable mute
  *
@@ -462,21 +463,52 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
  * board does not have the MUTEA or MUTEB pins connected to such circuitry,
  * then this function will do nothing.
  */
-static int cs4270_mute(struct snd_soc_dai *dai, int mute)
+static int cs4270_dai_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	int reg6;
 
 	reg6 = snd_soc_read(codec, CS4270_MUTE);
 
 	if (mute)
 		reg6 |= CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B;
-	else
+	else {
 		reg6 &= ~(CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B);
+		reg6 |= cs4270->manual_mute;
+	}
 
 	return snd_soc_write(codec, CS4270_MUTE, reg6);
 }
 
+/**
+ * cs4270_soc_put_mute - put callback for the 'Master Playback switch'
+ * 			 alsa control.
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * This function basically passes the arguments on to the generic
+ * snd_soc_put_volsw() function and saves the mute information in
+ * our private data structure. This is because we want to prevent
+ * cs4270_dai_mute() neglecting the user's decision to manually
+ * mute the codec's output.
+ *
+ * Returns 0 for success.
+ */
+static int cs4270_soc_put_mute(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs4270_private *cs4270 = codec->private_data;
+	int left = !ucontrol->value.integer.value[0];
+	int right = !ucontrol->value.integer.value[1];
+
+	cs4270->manual_mute = (left ? CS4270_MUTE_DAC_A : 0) |
+			      (right ? CS4270_MUTE_DAC_B : 0);
+
+	return snd_soc_put_volsw(kcontrol, ucontrol);
+}
+
 /* A list of non-DAPM controls that the CS4270 supports */
 static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume",
@@ -486,7 +518,9 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 	SOC_SINGLE("Zero Cross Switch", CS4270_TRANS, 5, 1, 0),
 	SOC_SINGLE("Popguard Switch", CS4270_MODE, 0, 1, 1),
 	SOC_SINGLE("Auto-Mute Switch", CS4270_MUTE, 5, 1, 0),
-	SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 1)
+	SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 1),
+	SOC_DOUBLE_EXT("Master Playback Switch", CS4270_MUTE, 0, 1, 1, 1,
+		snd_soc_get_volsw, cs4270_soc_put_mute)
 };
 
 /*
@@ -506,7 +540,7 @@ static struct snd_soc_dai_ops cs4270_dai_ops = {
 	.hw_params	= cs4270_hw_params,
 	.set_sysclk	= cs4270_set_dai_sysclk,
 	.set_fmt	= cs4270_set_dai_fmt,
-	.digital_mute	= cs4270_mute,
+	.digital_mute	= cs4270_dai_mute,
 };
 
 struct snd_soc_dai cs4270_dai = {
-- 
1.6.2.1
