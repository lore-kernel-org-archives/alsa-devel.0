From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514-spi: Get the period_bytes in the
	copy work to make sure the value correctly
Date: Mon, 17 Sep 2018 19:03:09 +0800
Message-ID: <1537182189-13694-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA3B2676A7
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 13:03:18 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com, yuhsuan@google.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The value of period_bytes will get the zero before the hw_params() is not
run completely. Move the function snd_pcm_lib_period_bytes() to copy work,
and make sure that is not zero.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 6478d10..4d46f45 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -91,6 +91,14 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 
 	runtime = rt5514_dsp->substream->runtime;
 	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
+	if (!period_bytes) {
+		schedule_delayed_work(&rt5514_dsp->copy_work, 5);
+		goto done;
+	}
+
+	if (rt5514_dsp->buf_size % period_bytes)
+		rt5514_dsp->buf_size = (rt5514_dsp->buf_size / period_bytes) *
+			period_bytes;
 
 	if (rt5514_dsp->get_size >= rt5514_dsp->buf_size) {
 		rt5514_spi_burst_read(RT5514_BUFFER_VOICE_WP, (u8 *)&buf,
@@ -149,13 +157,11 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 
 static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 {
-	size_t period_bytes;
 	u8 buf[8];
 
 	if (!rt5514_dsp->substream)
 		return;
 
-	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 	rt5514_dsp->get_size = 0;
 
 	/**
@@ -183,10 +189,6 @@ static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 
 	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
 
-	if (rt5514_dsp->buf_size % period_bytes)
-		rt5514_dsp->buf_size = (rt5514_dsp->buf_size / period_bytes) *
-			period_bytes;
-
 	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
 		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
 		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
-- 
2.7.4
