From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASOC: tpa6130a2: add static qualifier for
	file local symbols" to the asoc tree
Date: Tue, 27 Sep 2016 09:18:04 -0700
Message-ID: <E1bov52-0003d4-4M@finisterre>
References: <1474929911-6005-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FA7E265D93
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:18:19 +0200 (CEST)
In-Reply-To: <1474929911-6005-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Helen Koike <helen.koike@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

The patch

   ASOC: tpa6130a2: add static qualifier for file local symbols

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

>From 3cadd224474d60ee06cebafc63db9cd5f8cc47f7 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 Sep 2016 07:45:11 +0900
Subject: [PATCH] ASOC: tpa6130a2: add static qualifier for file local symbols

Sparse reports a below warning.

tpa6130a2.c:193:33: warning: symbol 'tpa6130a2_component_driver' was not declared. Should it be static?

The symbol is just used inner the file. Forthermore, it's constant. Thus,
it's better to add static and const qualifier.

This commit adds it.

Fixes: cb7e62256e99 (ASoC: tpa6130a2: Register component)
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 3712db0881d0..2e014c80d113 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -199,7 +199,7 @@ static const struct snd_soc_dapm_route tpa6130a2_dapm_routes[] = {
 	{ "Right PGA", NULL, "Power" },
 };
 
-struct snd_soc_component_driver tpa6130a2_component_driver = {
+static const struct snd_soc_component_driver tpa6130a2_component_driver = {
 	.name = "tpa6130a2",
 	.probe = tpa6130a2_component_probe,
 	.dapm_widgets = tpa6130a2_dapm_widgets,
-- 
2.9.3
