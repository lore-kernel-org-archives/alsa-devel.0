From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5514-spi: check irq status to
	schedule data copy in resume function
Date: Wed, 8 Nov 2017 15:04:22 +0800
Message-ID: <1510124662-5065-2-git-send-email-oder_chiou@realtek.com>
References: <1510124662-5065-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B87526742B
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 08:06:19 +0100 (CET)
In-Reply-To: <1510124662-5065-1-git-send-email-oder_chiou@realtek.com>
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

For wake on voice use case, we need to copy data from DSP buffer
to PCM stream when system wakes up by voice. However the edge
triggered IRQ could be missed when system wakes up, in that case
the irq function will not be called. If the substream was constructed
beforce suspend, we will schedule data copy in resume function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 0c0e209..c722f33 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -465,11 +465,21 @@ static int rt5514_suspend(struct device *dev)
 
 static int rt5514_resume(struct device *dev)
 {
+	struct snd_soc_platform *platform = snd_soc_lookup_platform(dev);
+	struct rt5514_dsp *rt5514_dsp =
+		snd_soc_platform_get_drvdata(platform);
 	int irq = to_spi_device(dev)->irq;
+	u8 buf[8];
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
 
+	if (rt5514_dsp->substream) {
+		rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
+		if (buf[0] & RT5514_IRQ_STATUS_BIT)
+			rt5514_schedule_copy(rt5514_dsp);
+	}
+
 	return 0;
 }
 
-- 
2.7.4
