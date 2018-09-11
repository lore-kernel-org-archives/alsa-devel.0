From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Fix UBSAN warning at
	snd_soc_get/put_volsw_sx()" to the asoc tree
Date: Tue, 11 Sep 2018 12:05:40 +0100 (BST)
Message-ID: <20180911110540.56AC11121AF8@debutante.sirena.org.uk>
References: <1536658161-31656-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8CE12676EB
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:05:42 +0200 (CEST)
In-Reply-To: <1536658161-31656-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ae7d1247d8673ebfd686b17e759d4be391165368 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Tue, 11 Sep 2018 14:59:21 +0530
Subject: [PATCH] ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()

In functions snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(),
if the result of (min + max) is negative, then fls() returns
signed integer with value as 32. This leads to signed integer
overflow as complete operation is considered as signed integer.

UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:50
signed integer overflow:
-2147483648 - 1 cannot be represented in type 'int'
Call trace:
[<ffffff852f746fe4>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff852f746fe4>] dump_stack+0xec/0x158 lib/dump_stack.c:51
[<ffffff852f7b5f3c>] ubsan_epilogue+0x18/0x50 lib/ubsan.c:164
[<ffffff852f7b6840>] handle_overflow+0xf8/0x130 lib/ubsan.c:195
[<ffffff852f7b68f0>] __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:211
[<ffffff85307971a0>] snd_soc_get_volsw_sx+0x1a8/0x1f8 sound/soc/soc-ops.c:382

Typecast the operation to unsigned int to fix the issue.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 592efb370c44..f4dc3d445aae 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -373,7 +373,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	unsigned int val;
 	int ret;
 
@@ -418,7 +418,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
-- 
2.19.0.rc2
