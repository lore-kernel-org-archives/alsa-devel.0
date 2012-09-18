From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH] ASoC: imx-audmux: remove null check of
	audmux_base in audmux_read_file
Date: Tue, 18 Sep 2012 16:38:30 +0800
Message-ID: <1347957510-20590-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CFCB261793
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 10:37:48 +0200 (CEST)
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
Cc: s.hauer@pengutronix.de, shawn.guo@linaro.org, Richard Zhao <richard.zhao@freescale.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When audmux_read_file is called, it means the driver is already
initialised successfully, so we don't need to check audmux_base.

It also fix smatch warning:
sound/soc/fsl/imx-audmux.c:78 audmux_read_file() warn: possible memory leak of 'buf'

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index e7c800e..524ce62 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -74,9 +74,6 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	if (!audmux_base)
-		return -ENOSYS;
-
 	if (audmux_clk)
 		clk_prepare_enable(audmux_clk);
 
-- 
1.7.9.5
