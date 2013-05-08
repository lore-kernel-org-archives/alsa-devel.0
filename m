From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH v2 2/6] ASoC: ux500: Do not clear state if
	already idle
Date: Wed,  8 May 2013 10:39:14 +0200
Message-ID: <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
References: <20130508080448.GG3102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0480326168D
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 10:39:27 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id m15so1542537wgh.17
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 01:39:27 -0700 (PDT)
In-Reply-To: <20130508080448.GG3102@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

As enable_msp gets called only after some audio data has been received,
if the userspace closes the device before sending any data it causes
ux500_msp_i2s_close to clear device state even if it was not previously
initialized.

This in turn leads to some non necessary but harmless writel, but also
to decrementing the pinctrl usage counter (pinctrl_rxtx_ref) below zero.

To prevent this from happening add a condition to skip register and
pinctrl clear if current msp state is already MSP_STATE_IDLE.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Changes from v1:
- fix grammatical error in commit message

Thanks,
Fabio

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
