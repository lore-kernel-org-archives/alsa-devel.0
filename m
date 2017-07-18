From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Modify the default value for
	ASRC function" to the asoc tree
Date: Tue, 18 Jul 2017 14:48:52 +0100
Message-ID: <E1dXSrs-0008Dk-Pp@debutante>
References: <1500019873-30391-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF450266C4D
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 15:49:01 +0200 (CEST)
In-Reply-To: <1500019873-30391-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Modify the default value for ASRC function

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

>From d26ed933581d924937aa92251afe1751cf86661c Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Tue, 18 Jul 2017 10:12:58 +0800
Subject: [PATCH] ASoC: rt5663: Modify the default value for ASRC function

The patch modifies the default value for ASRC function. It could prevent
the pop noise and recording no sound with ASRC function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 71c073c63866..d3f7bc2173e8 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -60,6 +60,7 @@ struct rt5663_priv {
 
 static const struct reg_sequence rt5663_patch_list[] = {
 	{ 0x002a, 0x8080 },
+	{ 0x0086, 0x0028 },
 };
 
 static const struct reg_default rt5663_v2_reg[] = {
@@ -509,7 +510,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0082, 0x0000 },
 	{ 0x0083, 0x0000 },
 	{ 0x0084, 0x0000 },
-	{ 0x0086, 0x0008 },
+	{ 0x0086, 0x0028 },
 	{ 0x0087, 0x0000 },
 	{ 0x008a, 0x0000 },
 	{ 0x008b, 0x0000 },
-- 
2.13.2
