From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6] ASoC: Apply msbits constraint for sample
	size bigger than the msbits
Date: Thu, 19 Jan 2012 17:06:03 +0100
Message-ID: <1326989163-5187-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id AFAE124133
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 17:06:16 +0100 (CET)
Received: by mail-yx0-f170.google.com with SMTP id q1so49824yen.15
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 08:06:14 -0800 (PST)
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
to sample size bigger than the requested msbits.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark,

Let's try this way.
I think this implementation is quete clear for the first look to understand what
it is doing.

Regards,
Peter

 sound/soc/soc-pcm.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8bb1793..d6fdde2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -68,7 +68,7 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
  * like the DAC/ADC resolution to use but there isn't right now.
  */
 static int sample_sizes[] = {
-	8, 16, 24, 32,
+	32, 24, 16, 8,
 };
 
 static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
@@ -85,13 +85,20 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
-		ret = snd_pcm_hw_constraint_msbits(substream->runtime,
-						   0, sample_sizes[i],
-						   bits);
-		if (ret != 0)
-			dev_warn(dai->dev,
-				 "Failed to set MSB %d/%d: %d\n",
-				 bits, sample_sizes[i], ret);
+		if (sample_sizes[i] > bits) {
+			ret = snd_pcm_hw_constraint_msbits(substream->runtime,
+						      0, sample_sizes[i], bits);
+			if (ret != 0)
+				dev_warn(dai->dev,
+					 "Failed to set MSB %d/%d: %d\n",
+					 bits, sample_sizes[i], ret);
+		} else {
+			/*
+			 * The remaining sample sizes are smaller than the
+			 * requested msbits, we can bail out from the loop.
+			 */
+			break;
+		}
 	}
 }
 
-- 
1.7.8.3
