From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: pcm: Use wildcard msbits constraints
Date: Mon, 29 Dec 2014 18:43:38 +0100
Message-ID: <1419875018-30812-3-git-send-email-lars@metafoo.de>
References: <1419875018-30812-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E7ADF261586
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 18:43:43 +0100 (CET)
In-Reply-To: <1419875018-30812-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use the new wildcard msbits constraints instead of installing a constraint
for each available sample format width.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index eb87d96..d62d6a5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -301,15 +301,6 @@ static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
 	return symmetry;
 }
 
-/*
- * List of sample sizes that might go over the bus for parameter
- * application.  There ought to be a wildcard sample size for things
- * like the DAC/ADC resolution to use but there isn't right now.
- */
-static int sample_sizes[] = {
-	24, 32,
-};
-
 static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -318,17 +309,10 @@ static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
 	if (!bits)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
-		if (bits >= sample_sizes[i])
-			continue;
-
-		ret = snd_pcm_hw_constraint_msbits(substream->runtime, 0,
-						   sample_sizes[i], bits);
-		if (ret != 0)
-			dev_warn(rtd->dev,
-				 "ASoC: Failed to set MSB %d/%d: %d\n",
-				 bits, sample_sizes[i], ret);
-	}
+	ret = snd_pcm_hw_constraint_msbits(substream->runtime, 0, 0, bits);
+	if (ret != 0)
+		dev_warn(rtd->dev, "ASoC: Failed to set MSB %d: %d\n",
+				 bits, ret);
 }
 
 static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
-- 
1.8.0
