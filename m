From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Fix type of clock rate pointer
	in arizona_set_sysclk" to the asoc tree
Date: Thu, 03 Dec 2015 21:02:10 +0000
Message-ID: <E1a4b10-0006r4-Cy@debutante>
References: <1449166507-3096-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A21FF26055E
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 22:02:21 +0100 (CET)
In-Reply-To: <1449166507-3096-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Fix type of clock rate pointer in arizona_set_sysclk

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1f0e1eae1521e9a00f1dfbcf7c51d785ade4179c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 3 Dec 2015 18:15:07 +0000
Subject: [PATCH] ASoC: arizona: Fix type of clock rate pointer in
 arizona_set_sysclk

Both the sysclk and asyncclk members of arizona_priv are signed by we
refer to them through an unsigned pointer. This patch fixes this small
harmless error.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d2731cf439c6..d90b3c51019a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1214,7 +1214,7 @@ int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	unsigned int reg;
 	unsigned int mask = ARIZONA_SYSCLK_FREQ_MASK | ARIZONA_SYSCLK_SRC_MASK;
 	unsigned int val = source << ARIZONA_SYSCLK_SRC_SHIFT;
-	unsigned int *clk;
+	int *clk;
 
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
-- 
2.6.2
