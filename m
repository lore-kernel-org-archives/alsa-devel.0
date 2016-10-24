From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: storm: constify snd_soc_ops structures" to the asoc tree
Date: Mon, 24 Oct 2016 19:01:29 +0100
Message-ID: <E1byjYv-0000ro-8b@debutante>
References: <1476543351-17858-5-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476543351-17858-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: storm: constify snd_soc_ops structures

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

>From 251fc7a58eca13e4af385cc6458b5533596ddb10 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 15 Oct 2016 16:55:48 +0200
Subject: [PATCH] ASoC: qcom: storm: constify snd_soc_ops structures

Check for snd_soc_ops structures that are only stored in the ops field of a
snd_soc_dai_link structure.  This field is declared const, so snd_soc_ops
structures that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_soc_ops i@p = { ... };

@ok1@
identifier r.i;
struct snd_soc_dai_link e;
position p;
@@
e.ops = &i@p;

@ok2@
identifier r.i, e;
position p;
@@
struct snd_soc_dai_link e[] = { ..., { .ops = &i@p, }, ..., };

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_soc_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_soc_ops i = { ... };
// </smpl>

The effect on the layout of the .o file is shown by the following output of
the size command, first before then after the transformation:

   text    data     bss     dec     hex filename
   1420     512       0    1932     78c sound/soc/qcom/storm.o
   1484     456       0    1940     794 sound/soc/qcom/storm.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/storm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index 2d833bffdba0..8fcac2ac3aa6 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -58,7 +58,7 @@ static int storm_ops_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops storm_soc_ops = {
+static const struct snd_soc_ops storm_soc_ops = {
 	.hw_params	= storm_ops_hw_params,
 };
 
-- 
2.8.1
