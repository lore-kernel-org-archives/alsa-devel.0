From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5514: Add the sanity checks of the
	buffer related address
Date: Mon, 31 Jul 2017 13:47:42 +0800
Message-ID: <1501480063-32225-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A24D266F16
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 07:47:52 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, shumingf@realtek.com, bardliao@realtek.com, chinyue@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch add the sanity checks of the buffer related address to make sure
the addresses are valid.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 950d1ff..6f513cc 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -173,9 +173,14 @@ static irqreturn_t rt5514_spi_irq(int irq, void *data)
 	rt5514_dsp->buf_rp = buf[0] | buf[1] << 8 | buf[2] << 16 |
 				buf[3] << 24;
 
+	if (rt5514_dsp->buf_rp % 8)
+		rt5514_dsp->buf_rp = (rt5514_dsp->buf_rp / 8) * 8;
+
 	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
 
-	schedule_delayed_work(&rt5514_dsp->copy_work, 0);
+	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
+		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
+		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4
