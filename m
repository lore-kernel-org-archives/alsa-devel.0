From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5514: Fix the issue that the
	variable dereferenced before checking
Date: Fri, 17 Jun 2016 11:02:23 +0800
Message-ID: <1466132544-22916-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E26C2657B1
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 05:02:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch fixes the issue that variable dereferenced before checking
'rt5514_dsp->substream'. Move the assignment to after the variable
checking of 'rt5514_dsp->substream'.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 8a9382e..743f509 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -80,7 +80,7 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 {
 	struct rt5514_dsp *rt5514_dsp =
 		container_of(work, struct rt5514_dsp, copy_work.work);
-	struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
+	struct snd_pcm_runtime *runtime;
 	size_t period_bytes, truncated_bytes = 0;
 
 	mutex_lock(&rt5514_dsp->dma_lock);
@@ -89,6 +89,7 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 		goto done;
 	}
 
+	runtime = rt5514_dsp->substream->runtime;
 	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 
 	if (rt5514_dsp->buf_size - rt5514_dsp->dsp_offset <  period_bytes)
-- 
1.8.1.1.439.g50a6b54
