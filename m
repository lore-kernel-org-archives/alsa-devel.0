From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514-spi: Let the buf_size to align
	with period_bytes
Date: Wed, 8 Nov 2017 19:21:47 +0800
Message-ID: <1510140107-9920-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B7142266B38
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 12:21:55 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch lets the buf_size to align with period_bytes to prevent the
buffer reading over the real size of the DSP buffer and also avoid to
calculate the wrong size of remaining data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index c722f33..076116b 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -147,8 +147,13 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 
 static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 {
+	size_t period_bytes;
 	u8 buf[8];
 
+	if (!rt5514_dsp->substream)
+		return;
+
+	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 	rt5514_dsp->get_size = 0;
 
 	/**
@@ -176,6 +181,10 @@ static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 
 	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
 
+	if (rt5514_dsp->buf_size % period_bytes)
+		rt5514_dsp->buf_size = (rt5514_dsp->buf_size / period_bytes) *
+			period_bytes;
+
 	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
 		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
 		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
-- 
2.7.4
