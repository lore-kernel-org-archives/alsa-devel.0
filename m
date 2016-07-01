From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: patch reg-0x8a" to the asoc tree
Date: Fri, 01 Jul 2016 12:04:36 +0200
Message-ID: <E1bIvJM-0004Tq-1Z@finisterre>
References: <1467337746-3900-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6FBE2614FD
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 12:04:48 +0200 (CEST)
In-Reply-To: <1467337746-3900-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: patch reg-0x8a

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

>From e62ebf156f009e0cadf11f5b680066cc6dc8fcfe Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 1 Jul 2016 09:49:06 +0800
Subject: [PATCH] ASoC: rt5645: patch reg-0x8a

reg-8a assign the tracking source for each ASRC tracker. The default
value is 0x0000 which means all ASRC trackers will track LRCK1. But
in most cases, we wish each ASRC tracker track the corresponding LRCK.
i.e. ASRC1 tracks LRCK1, ASRC2 tracks LRCK2 and so on. So, we rewrite
reg-8a as 0x0120.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d70847c9eeb0..97bf96e2c57b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -63,6 +63,7 @@ static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x20,	0x611f},
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
+	{RT5645_ASRC_4, 0x0120},
 };
 
 static const struct reg_sequence rt5650_init_list[] = {
@@ -157,7 +158,7 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0x83, 0x0000 },
 	{ 0x84, 0x0000 },
 	{ 0x85, 0x0000 },
-	{ 0x8a, 0x0000 },
+	{ 0x8a, 0x0120 },
 	{ 0x8e, 0x0004 },
 	{ 0x8f, 0x1100 },
 	{ 0x90, 0x0646 },
@@ -314,7 +315,7 @@ static const struct reg_default rt5650_reg[] = {
 	{ 0x83, 0x0000 },
 	{ 0x84, 0x0000 },
 	{ 0x85, 0x0000 },
-	{ 0x8a, 0x0000 },
+	{ 0x8a, 0x0120 },
 	{ 0x8e, 0x0004 },
 	{ 0x8f, 0x1100 },
 	{ 0x90, 0x0646 },
-- 
2.8.1
