From: John Keeping <john@metanate.com>
Subject: [PATCH] ASoC: rockchip: i2s: fix playback after
	runtime resume
Date: Mon,  8 Jan 2018 12:23:01 +0000
Message-ID: <20180108122301.18255-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metanate.com (dougal.metanate.com [90.155.101.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 365D926698E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 13:23:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

When restoring registers during runtime resume, we must not write to
I2S_TXDR which is the transmit FIFO as this queues up a sample to be
output and pushes all of the output channels down by one.

This can be demonstrated with the speaker-test utility:

	for i in a b c; do speaker-test -c 2 -s 1; done

which should play a test through the left speaker three times but if the
I2S hardware starts runtime suspended the first sample will be played
through the right speaker.

Fix this by marking I2S_TXDR as volatile (which also requires marking it
as readble, even though it technically isn't).  This seems to be the
most robust fix, the alternative of giving I2S_TXDR a default value is
more fragile since it does not prevent regcache writing to the register
in all circumstances.

While here, also fix the configuration of I2S_RXDR and I2S_FIFOLR; these
are not writable so they do not suffer from the same problem as I2S_TXDR
but reading from I2S_RXDR does suffer from a similar problem.

Fixes: f0447f6cbb20 ("ASoC: rockchip: i2s: restore register during runtime_suspend/resume cycle", 2016-09-07)
Signed-off-by: John Keeping <john@metanate.com>
---
I'm not completely happy with marking I2S_TXDR as readable here, but I
can't see a better way to do this.  Neither "volatile" nor "precious"
seem to match exactly a writable FIFO register but this does at least
fix the bug and tegra30_ahub.c seems to take the same approach.

 sound/soc/rockchip/rockchip_i2s.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 908211e1d6fc..20855ed8e4b7 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -504,6 +504,7 @@ static bool rockchip_i2s_rd_reg(struct device *dev, unsigned int reg)
 	case I2S_INTCR:
 	case I2S_XFER:
 	case I2S_CLR:
+	case I2S_TXDR:
 	case I2S_RXDR:
 	case I2S_FIFOLR:
 	case I2S_INTSR:
@@ -518,6 +519,9 @@ static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case I2S_INTSR:
 	case I2S_CLR:
+	case I2S_FIFOLR:
+	case I2S_TXDR:
+	case I2S_RXDR:
 		return true;
 	default:
 		return false;
@@ -527,6 +531,7 @@ static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
 static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case I2S_RXDR:
 	default:
 		return false;
 	}
-- 
2.15.1
