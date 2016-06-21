From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: patch reg-0x8a" to the asoc tree
Date: Tue, 21 Jun 2016 19:52:36 +0100
Message-ID: <E1bFQmq-0008LE-3Y@debutante>
References: <1466136482-21944-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FC86267DD5
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 20:52:49 +0200 (CEST)
In-Reply-To: <1466136482-21944-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: patch reg-0x8a

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

>From 874352a763ba2df55093d2651158be40999e9cbe Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 17 Jun 2016 12:08:02 +0800
Subject: [PATCH] ASoC: rt5670: patch reg-0x8a

reg-8a assign the tracking source for each ASRC tracker. The default
value is 0x0000 which means all ASRC trackers will track LRCK1. But
in most case, we wish each ASRC tracker track the corresponding LRCK.
i.e. ASRC1 tracks LRCK1, ASRC2 tracks LRCK2 and so on. So, we rewrite
reg-8a as 0x0123.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0af5ddbef1da..8ef467f64f03 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -55,6 +55,7 @@ static const struct reg_sequence init_list[] = {
 	{ RT5670_PR_BASE + 0x14, 0x9a8a },
 	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
 	{ RT5670_PR_BASE + 0x3d, 0x3640 },
+	{ 0x8a, 0x0123 },
 };
 
 static const struct reg_default rt5670_reg[] = {
@@ -131,7 +132,7 @@ static const struct reg_default rt5670_reg[] = {
 	{ 0x87, 0x0000 },
 	{ 0x88, 0x0000 },
 	{ 0x89, 0x0000 },
-	{ 0x8a, 0x0000 },
+	{ 0x8a, 0x0123 },
 	{ 0x8b, 0x0000 },
 	{ 0x8c, 0x0003 },
 	{ 0x8d, 0x0000 },
-- 
2.8.1
