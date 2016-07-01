From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: fix reg-2f default value." to
	the asoc tree
Date: Fri, 01 Jul 2016 12:04:41 +0200
Message-ID: <E1bIvJR-0004Uq-Pq@finisterre>
References: <1467289764-2659-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BB7D426646C
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 12:04:53 +0200 (CEST)
In-Reply-To: <1467289764-2659-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, broonie@kernel.org, PC.Liao@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: fix reg-2f default value.

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

>From fdfe3b32db70aa49d1d60a1ddd2280099174bddb Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 1 Jul 2016 09:49:05 +0800
Subject: [PATCH] ASoC: rt5645: fix reg-2f default value.

The default value of reg-2f in codec rt5650 is 0x5002, not 0x1002.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3c6594da6c9c..d70847c9eeb0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -253,7 +253,7 @@ static const struct reg_default rt5650_reg[] = {
 	{ 0x2b, 0x5454 },
 	{ 0x2c, 0xaaa0 },
 	{ 0x2d, 0x0000 },
-	{ 0x2f, 0x1002 },
+	{ 0x2f, 0x5002 },
 	{ 0x31, 0x5000 },
 	{ 0x32, 0x0000 },
 	{ 0x33, 0x0000 },
-- 
2.8.1
