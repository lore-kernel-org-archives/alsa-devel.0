From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Add the sanity check for the
	driver_data in the resume function
Date: Mon, 20 Nov 2017 18:23:19 +0800
Message-ID: <1511173399-26065-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0922F2674FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 11:23:28 +0100 (CET)
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

If the rt5514 spi driver is loaded, but the snd_soc_platform_driver is not
loaded by the correct DAI settings, the NULL pointer will be gotten by
snd_soc_platform_get_drvdata in the resume function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index a7604b9..4339f23 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -483,10 +483,13 @@ static int __maybe_unused rt5514_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
 
-	if (rt5514_dsp->substream) {
-		rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
-		if (buf[0] & RT5514_IRQ_STATUS_BIT)
-			rt5514_schedule_copy(rt5514_dsp);
+	if (rt5514_dsp) {
+		if (rt5514_dsp->substream) {
+			rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf,
+				sizeof(buf));
+			if (buf[0] & RT5514_IRQ_STATUS_BIT)
+				rt5514_schedule_copy(rt5514_dsp);
+		}
 	}
 
 	return 0;
-- 
2.7.4
