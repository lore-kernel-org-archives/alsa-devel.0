From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Access driver data through
	platform from compressed ops
Date: Wed, 26 Oct 2016 17:06:40 +0100
Message-ID: <1477498000-10104-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 84682266834
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 18:06:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

As the compressed ops run on the platform side of things we should
really access the driver data through the platform pointer rather than
the CODEC pointer. As the compressed DAIs in our systems always connect
our CODEC to our platform this has never been an issue, but should still
be corrected. Additionally it clears the way for future core refactoring
work.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 2 +-
 sound/soc/codecs/wm5102.c  | 2 +-
 sound/soc/codecs/wm5110.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index f9e720b..1ed1329 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1066,7 +1066,7 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
 static int cs47l24_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct cs47l24_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
 	struct arizona *arizona = priv->core.arizona;
 	int n_adsp;
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a80a680..0136234 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1908,7 +1908,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 static int wm5102_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct wm5102_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
 
 	return wm_adsp_compr_open(&priv->core.adsp[0], stream);
 }
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index f1a4113..a9a8bc9 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2224,7 +2224,7 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 static int wm5110_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct wm5110_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
 	struct arizona *arizona = priv->core.arizona;
 	int n_adsp;
 
-- 
2.1.4
