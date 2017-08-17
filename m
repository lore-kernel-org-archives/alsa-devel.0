From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: aux1x: make snd_soc_ops const" to the asoc tree
Date: Thu, 17 Aug 2017 18:13:15 +0100
Message-ID: <E1diOM7-0008Qv-6W@debutante>
References: <1502902770-3758-2-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502902770-3758-2-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, heiko@sntech.de, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: aux1x: make snd_soc_ops const

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

>From 052fba77f57b9f243ad3a45a21c809bddcd03627 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:29:24 +0530
Subject: [PATCH] ASoC: aux1x: make snd_soc_ops const

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/db1200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 5c73061d912a..301e1fc9a377 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -99,7 +99,7 @@ static int db1200_i2s_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_soc_ops db1200_i2s_wm8731_ops = {
+static const struct snd_soc_ops db1200_i2s_wm8731_ops = {
 	.startup	= db1200_i2s_startup,
 };
 
-- 
2.13.3
