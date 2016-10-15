From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/7] ASoC: atmel_wm8904: constify snd_soc_ops structures
Date: Sat, 15 Oct 2016 16:55:46 +0200
Message-ID: <1476543351-17858-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
   2611    1536       0    4147    1033 sound/soc/atmel/atmel_wm8904.o
   2675    1480       0    4155    103b sound/soc/atmel/atmel_wm8904.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/atmel/atmel_wm8904.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -53,7 +53,7 @@ static int atmel_asoc_wm8904_hw_params(s
 	return 0;
 }
 
-static struct snd_soc_ops atmel_asoc_wm8904_ops = {
+static const struct snd_soc_ops atmel_asoc_wm8904_ops = {
 	.hw_params = atmel_asoc_wm8904_hw_params,
 };
 

