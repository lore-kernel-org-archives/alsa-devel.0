From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] [ALSA] soc - fsl_ssi.c fix "BUG: scheduling
	while atomic"
Date: Thu, 8 May 2008 20:01:12 +0400
Message-ID: <20080508160112.GA17085@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by alsa0.perex.cz (Postfix) with SMTP id C0DEA246D4
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 18:01:13 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes following bug caught with PREEMPT enabled:

root@b1:~# cat /dev/dsp > /dev/null
BUG: scheduling while atomic: cat/965/0x00000003
Call Trace:
[df165ce0] [c0008e84] show_stack+0x4c/0x1ac (unreliable)
[df165d20] [c001c18c] __schedule_bug+0x64/0x78
[df165d30] [c02b3344] schedule+0x2d8/0x334
[df165d70] [c02b3674] schedule_timeout+0x64/0xe4
[df165db0] [c002c05c] msleep+0x1c/0x34
[df165dc0] [c01f2fe0] fsl_ssi_trigger+0x130/0x144
[df165dd0] [c01ece54] soc_pcm_trigger+0x94/0xb8
[df165df0] [c01da764] snd_pcm_do_start+0x48/0x60
[df165e00] [c01da630] snd_pcm_action_single+0x4c/0xb4
[df165e20] [c01e0f50] snd_pcm_lib_read1+0x2a0/0x2d4
[df165e70] [c01ec274] snd_pcm_oss_read3+0xf0/0x13c
[df165eb0] [c01ec2e4] snd_pcm_oss_read2+0x24/0x4c
[df165ec0] [c01ec4ac] snd_pcm_oss_read+0x1a0/0x1f0
[df165ef0] [c0076478] vfs_read+0xb4/0x108
[df165f10] [c00768cc] sys_read+0x4c/0x90
[df165f40] [c00117a4] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe9a8d4
    LR = 0x10002b24

We must not sleep with irqs disabled, so replace msleep with mdelay.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 sound/soc/fsl/fsl_ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b2a11b0..f588545 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -416,7 +416,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
 			 * to put data into its FIFO.  Without it, ALSA starts
 			 * to complain about overruns.
 			 */
-			msleep(1);
+			mdelay(1);
 		}
 		break;
 
-- 
1.5.5.1
