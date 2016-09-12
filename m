From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ac97: constify gpio_chip structures" to the asoc tree
Date: Mon, 12 Sep 2016 20:05:46 +0100
Message-ID: <E1bjWY6-0002UO-Vs@debutante>
References: <1473596082-32690-6-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473596082-32690-6-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ac97: constify gpio_chip structures

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

>From 52abe54138d9b14b4a0a17742a53d2411bc5b167 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 11 Sep 2016 14:14:41 +0200
Subject: [PATCH] ASoC: ac97: constify gpio_chip structures

These structures are only used to copy into other structures, so declare
them as const.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct gpio_chip i@p = { ... };

@ok@
identifier r.i;
expression e;
position p;
@@
e = i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct gpio_chip e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct gpio_chip i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index bc4a55bb3fd9..6c8b0b0c56ec 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -116,7 +116,7 @@ static int snd_soc_ac97_gpio_direction_out(struct gpio_chip *chip,
 	return snd_soc_update_bits(codec, AC97_GPIO_CFG, 1 << offset, 0);
 }
 
-static struct gpio_chip snd_soc_ac97_gpio_chip = {
+static const struct gpio_chip snd_soc_ac97_gpio_chip = {
 	.label			= "snd_soc_ac97",
 	.owner			= THIS_MODULE,
 	.request		= snd_soc_ac97_gpio_request,
-- 
2.8.1
