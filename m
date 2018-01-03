From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: change mask in snd_soc_get/put_volsw_sx
	to unsigned int" to the asoc tree
Date: Wed, 03 Jan 2018 15:43:04 +0000
Message-ID: <E1eWlC4-0000Sn-FD@debutante>
References: <1514781614-6039-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E9DF826766D
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 16:43:07 +0100 (CET)
In-Reply-To: <1514781614-6039-1-git-send-email-bgoswami@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Banajit Goswami <bgoswami@codeaurora.org>
Cc: plai@qti.qualcomm.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: change mask in snd_soc_get/put_volsw_sx to unsigned int

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

>From b9f902b7fd800214b5598a636ceb74bfe2db63be Mon Sep 17 00:00:00 2001
From: Banajit Goswami <bgoswami@codeaurora.org>
Date: Sun, 31 Dec 2017 20:40:14 -0800
Subject: [PATCH] ASoC: change mask in snd_soc_get/put_volsw_sx to unsigned int

If the result of (min + max) is negative in functions
snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(), there
will be an overflow for the variable 'mask'.
   UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:6
   signed integer overflow:
   -2147483648 - 1 cannot be represented in type 'int'

Fix this by updating the variable type of 'mask' to unsigned int.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 500f98c730b9..7144a51ddfa9 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -378,7 +378,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
 	unsigned int val;
 	int ret;
 
@@ -423,7 +423,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
-- 
2.15.1
