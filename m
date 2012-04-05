From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: imx-audmux: Fix ssi port numbers in
	sysfs
Date: Thu,  5 Apr 2012 09:45:51 -0300
Message-ID: <1333629952-18243-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8D951247C9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 14:46:05 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so661389yhn.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Apr 2012 05:46:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: joancarles@fqingenieria.es, Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Doing a 'cat /sys/kernel/debug/audmux/ssi7' causes the following oops to be printed by the kernel:

Uhandled fault: external abort on non-linefetch (0x008) at 0xf53b003c
Internal error: : 8 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (3.3.0-00033-gecc726e-dirty #307)
PC is at audmux_read_file+0x68/0x2f4
LR is at clk_enable+0x3c/0x48
pc : [<c001b8c8>]   lr : [<c00190a0>]    psr: a0000013
sp : c3ad3f38  ip : c30a4000  fp : 00000003
r10: 00001000  r9 : be83fb00  r8 : c3ad3f80
r7 : c3ad3f80  r6 : 00000007  r5 : 00031010  r4 : c30a5000
r3 : f53b0000  r2 : 0000003c  r1 : 380fa100  r0 : c068dda0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 83034000  DAC: 00000015
Process cat (pid: 1042, stack limit = 0xc3ad2270)
Stack: (0xc3ad3f38 to 0xc3ad4000)
3f20:                                                      c3139180 00000000
3f40: c3bc6500 00001000 be83fb00 c3ad3f80 00001000 c3ad2000 00000000 c0095f3c
3f60: 00000003 c3bc6508 c3bc6500 be83fb00 00000000 00000000 00001000 c0096010
3f80: 00000000 00000000 b6fe2050 00000000 00001000 be83fb00 00000003 00000003
3fa0: c000eb88 c000e9e0 00001000 be83fb00 00000003 be83fb00 00001000 00000000
3fc0: 00001000 be83fb00 00000003 00000003 00000001 00000001 00000000 00000003
3fe0: 000bec8c be83fae0 0000f808 b6ea8d5c 60000010 00000003 7dff7ede 749bedf1
[<c001b8c8>] (audmux_read_file+0x68/0x2f4) from [<c0095f3c>] (vfs_read+0xb0/0x144)
[<c0095f3c>] (vfs_read+0xb0/0x144) from [<c0096010>] (sys_read+0x40/0x70)
[<c0096010>] (sys_read+0x40/0x70) from [<c000e9e0>] (ret_fast_syscall+0x0/0x2c)
Code: e1a02186 e2822004 e3500000 e7935186 (e7937002)
---[ end trace 4d046e31309023de ]---

Fix the ssi port numbers in sysfs to fix this problem.

Reported-by: Joan Carles <joancarles@fqingenieria.es>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 1765a19..d467a1b 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -152,7 +152,7 @@ static void __init audmux_debugfs_init(void)
 		return;
 	}
 
-	for (i = 1; i < 8; i++) {
+	for (i = 0; i < MX31_AUDMUX_PORT6_SSI_PINS_6 + 1; i++) {
 		snprintf(buf, sizeof(buf), "ssi%d", i);
 		if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
 					 (void *)i, &audmux_debugfs_fops))
-- 
1.7.1
