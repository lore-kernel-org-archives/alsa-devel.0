From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5] ASoC: Apply msbits constraint for sample
	size bigger than the msbits
Date: Wed, 18 Jan 2012 16:05:14 +0100
Message-ID: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151]) by alsa0.perex.cz (Postfix) with SMTP id 00CB024652
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:05:28 +0100 (CET)
Received: by mail-yx0-f172.google.com with SMTP id l5so216961yen.31
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 07:05:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In order to avoid confusing the applications with msbits bigger
than the selected sample size apply the msbits constraint only
to sample seze bigger than the requested msbits.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Mark,

Converted to use while loop.
We run the loop as long as the sample size is bigger than the requested
msbits.
Most of the drivers require 24/32 configuration, so not point of looping
for smaller sample sizes.

Regards,
Peter

 sound/soc/soc-pcm.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8bb1793..ef41a39 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -68,13 +68,14 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
  * like the DAC/ADC resolution to use but there isn't right now.
  */
 static int sample_sizes[] = {
-	8, 16, 24, 32,
+	32, 24, 16, 8,
 };
 
 static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
-	int ret, i, bits;
+	int ret, bits;
+	int i = 0;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		bits = dai->driver->playback.sig_bits;
@@ -84,14 +85,14 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 	if (!bits)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
-		ret = snd_pcm_hw_constraint_msbits(substream->runtime,
-						   0, sample_sizes[i],
-						   bits);
+	/* Apply constraint only for sample size bigger than requested msbits */
+	while (sample_sizes[i] > bits && i < ARRAY_SIZE(sample_sizes)) {
+		ret = snd_pcm_hw_constraint_msbits(substream->runtime, 0,
+						   sample_sizes[i], bits);
 		if (ret != 0)
-			dev_warn(dai->dev,
-				 "Failed to set MSB %d/%d: %d\n",
+			dev_warn(dai->dev, "Failed to set MSB %d/%d: %d\n",
 				 bits, sample_sizes[i], ret);
+		i++;
 	}
 }
 
-- 
1.7.8.3
