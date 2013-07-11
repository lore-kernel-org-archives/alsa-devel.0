From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH] ASoC: Samsung: Set RFS and BFS in slave mode
Date: Thu, 11 Jul 2013 12:38:25 +0530
Message-ID: <1373526505-27115-2-git-send-email-padma.v@samsung.com>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, padma.v@samsung.com, padma.kvr@gmail.com
Cc: sbkim73@samsung.com, broonie@kernel.org, kgene.kim@samsung.com, abrestic@chromium.org
List-Id: alsa-devel@alsa-project.org

As per the User Manual, the RFS and BFS should be set in slave mode
for correct operation.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-on: https://gerrit-int.chromium.org/37841
Reviewed-by: Simon Glass <sjg@google.com>
---
 sound/soc/samsung/i2s.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 82ebb1a..3fcf8d7 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -742,13 +742,13 @@ static int config_setup(struct i2s_dai *i2s)
 		return -EAGAIN;
 	}
 
-	/* Don't bother RFS, BFS & PSR in Slave mode */
-	if (is_slave(i2s))
-		return 0;
-
 	set_bfs(i2s, bfs);
 	set_rfs(i2s, rfs);
 
+	/* Don't bother with PSR in Slave mode */
+	if (is_slave(i2s))
+		return 0;
+
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
-- 
1.7.4.4
