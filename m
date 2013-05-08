From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 2/6] ASoC: ux500: Do not clear state if already idle
Date: Wed,  8 May 2013 09:14:17 +0200
Message-ID: <1367997261-32048-3-git-send-email-fabio.baltieri@linaro.org>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

As enable_msp gets called only after some audio data has been received,
if the userspace closes the device before sending any data it causes
ux500_msp_i2s_close to clear device state even if it was not previously
initialized.

This in turns leads to some non necessary but harmless writel, but also
to decrementing the pinctrl usage counter (pinctrl_rxtx_ref) below zero.

To prevent this from happening add a condition to skip register and
pinctrl clear if current msp state is already MSP_STATE_IDLE.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index a26c6bf..964cfd6 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -638,7 +638,7 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 	dev_dbg(msp->dev, "%s: Enter (dir = 0x%01x).\n", __func__, dir);
 
 	status = disable_msp(msp, dir);
-	if (msp->dir_busy == 0) {
+	if (msp->dir_busy == 0 && msp->msp_state != MSP_STATE_IDLE) {
 		/* disable sample rate and frame generators */
 		msp->msp_state = MSP_STATE_IDLE;
 		writel((readl(msp->registers + MSP_GCR) &
-- 
1.8.2
