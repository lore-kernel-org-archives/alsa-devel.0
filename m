From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: core utils: Dont set DMA params for BE
	substreams
Date: Fri, 13 Sep 2013 18:09:47 +0100
Message-ID: <1379092188-7385-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 059A82610A8
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:10:03 +0200 (CEST)
In-Reply-To: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

BE substreams dont require dummy DMA configs so dont set any.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 29b211e..5e63365 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -75,7 +75,11 @@ static const struct snd_pcm_hardware dummy_dma_hardware = {
 
 static int dummy_dma_open(struct snd_pcm_substream *substream)
 {
-	snd_soc_set_runtime_hwparams(substream, &dummy_dma_hardware);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* BE's dont need dummy params */
+	if (!rtd->dai_link->no_pcm)
+		snd_soc_set_runtime_hwparams(substream, &dummy_dma_hardware);
 
 	return 0;
 }
-- 
1.8.1.2
