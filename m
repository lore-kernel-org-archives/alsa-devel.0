From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2] ASoC: fsl: imx-audmux: Do not call
	imx_audmux_parse_dt_defaults() on non-dt kernel
Date: Tue, 3 Sep 2013 15:14:12 -0300
Message-ID: <1378232052-25697-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DE5265354
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 20:16:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Booting a mx51babbage board with a non-dt kernel leads to the following crash:

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = 80004000
[0000001c] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.0-next-20130903 #287
task: 9f860000 ti: 9f862000 task.ti: 9f862000
PC is at of_get_next_available_child+0x5c/0x68
LR is at of_get_next_available_child+0x1c/0x68
pc : [<8043ea58>]    lr : [<8043ea18>]    psr: 60000193
sp : 9f863d58  ip : 00000000  fp : 9f863d74
r10: 9f89a010  r9 : 9f862000  r8 : 807bb26c
r7 : 80615d5c  r6 : 00000000  r5 : 60000113  r4 : 00000000
r3 : 00000000  r2 : 808770a4  r1 : 00000011  r0 : 60000113
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 90004019  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0x9f862240)
Stack: (0x9f863d58 to 0x9f864000)

This is caused by commit 8548a464b9 (ASoC: imx-audmux: Read default 
configuration from devicetree).

In order to fix this, add a check for 'of_id' so that 
imx_audmux_parse_dt_defaults() only gets called when a dt kernel is running.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Only call imx_audmux_parse_dt_defaults for dt kernel.

 sound/soc/fsl/imx-audmux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index ab17381..d3bf71a 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -335,7 +335,8 @@ static int imx_audmux_probe(struct platform_device *pdev)
 	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_init();
 
-	imx_audmux_parse_dt_defaults(pdev, pdev->dev.of_node);
+	if (of_id)
+		imx_audmux_parse_dt_defaults(pdev, pdev->dev.of_node);
 
 	return 0;
 }
-- 
1.8.1.2
