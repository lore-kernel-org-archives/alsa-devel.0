From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/7] ASoC: qcom: storm: constify snd_soc_ops structures
Date: Sat, 15 Oct 2016 16:55:48 +0200
Message-ID: <1476543351-17858-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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
   1420     512       0    1932     78c sound/soc/qcom/storm.o
   1484     456       0    1940     794 sound/soc/qcom/storm.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/qcom/storm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -58,7 +58,7 @@ static int storm_ops_hw_params(struct sn
 	return 0;
 }
 
-static struct snd_soc_ops storm_soc_ops = {
+static const struct snd_soc_ops storm_soc_ops = {
 	.hw_params	= storm_ops_hw_params,
 };
 

