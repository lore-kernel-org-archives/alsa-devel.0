From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: fsl: imx-audmux: Check if we are running
	a dt kernel
Date: Tue, 3 Sep 2013 14:52:19 -0300
Message-ID: <1378230739-24177-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 904B22617AB
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 19:55:11 +0200 (CEST)
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

In order to fix it, return an error when 'of_id' is NULL, which happens for the
non-dt case.

Also checked that audio is still functional when running the dt kernel for this 
board after applying this patch.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index ab17381..2b29b48 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -317,6 +317,9 @@ static int imx_audmux_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 			of_match_device(imx_audmux_dt_ids, &pdev->dev);
 
+	if (!of_id)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	audmux_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(audmux_base))
-- 
1.8.1.2
