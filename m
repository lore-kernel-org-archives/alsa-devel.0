From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 1/5] ASoC: Apply msbits constraint for
	sample size bigger than the msbits
Date: Wed, 18 Jan 2012 12:18:22 +0100
Message-ID: <1326885506-6140-2-git-send-email-peter.ujfalusi@ti.com>
References: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id E211D103B3A
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:18:43 +0100 (CET)
Received: by mail-yx0-f174.google.com with SMTP id m6so817623yen.33
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 03:18:42 -0800 (PST)
In-Reply-To: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
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
 sound/soc/soc-pcm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8bb1793..e5e804d 100644
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
@@ -85,6 +85,8 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
+		if (sample_sizes[i] <= bits)
+			break;
 		ret = snd_pcm_hw_constraint_msbits(substream->runtime,
 						   0, sample_sizes[i],
 						   bits);
-- 
1.7.8.3
