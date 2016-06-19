From: Clive Messer <clive.messer@digitaldreamtime.co.uk>
Subject: [PATCH V2 1/1] ASoC: pcm5102a: Support 352k8 and 384k
	sample rates
Date: Sun, 19 Jun 2016 21:42:02 +0100
Message-ID: <1466368922-6555-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
References: <1466358768-31787-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dreamtime.org (barcelona.digitaldreamtime.co.uk
 [85.158.46.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 636872625FE
 for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2016 22:42:14 +0200 (CEST)
In-Reply-To: <1466358768-31787-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
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
Cc: Clive Messer <clive.messer@digitaldreamtime.co.uk>
List-Id: alsa-devel@alsa-project.org

Add support for 352k8 and 384k samples rates to pcm5102a codec
driver, with SNDRV_PCM_RATE_KNOT and a constraint list.

Signed-off-by: Clive Messer <clive.messer@digitaldreamtime.co.uk>
---
 sound/soc/codecs/pcm5102a.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm5102a.c b/sound/soc/codecs/pcm5102a.c
index ed51567..53dfc99 100644
--- a/sound/soc/codecs/pcm5102a.c
+++ b/sound/soc/codecs/pcm5102a.c
@@ -21,16 +21,51 @@
 
 #include <sound/soc.h>
 
+static const u32 pcm5102a_rates[] = {
+	8000, 16000, 32000, 44100, 48000, 88200, 96000, 176400, 192000,
+	352800, 384000,
+};
+
+static const struct snd_pcm_hw_constraint_list pcm5102a_constraint_rates = {
+	.count = ARRAY_SIZE(pcm5102a_rates),
+	.list = pcm5102a_rates,
+};
+
+static int pcm5102a_dai_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int ret;
+
+	dev_dbg(codec->dev, "%s: set rates (8k-384k) constraint\n", __func__);
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &pcm5102a_constraint_rates);
+	if (ret != 0) {
+		dev_err(codec->dev, "%s: Failed to set rates constraint: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops pcm5102a_dai_ops = {
+	.startup = pcm5102a_dai_startup,
+};
+
 static struct snd_soc_dai_driver pcm5102a_dai = {
 	.name = "pcm5102a-hifi",
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			   SNDRV_PCM_FMTBIT_S24_LE |
 			   SNDRV_PCM_FMTBIT_S32_LE
 	},
+	.ops = &pcm5102a_dai_ops,
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_pcm5102a;
-- 
2.5.5
