From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/6] ASoC: ac97: constify gpio_chip structures
Date: Sun, 11 Sep 2016 14:14:41 +0200
Message-ID: <1473596082-32690-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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

---
 sound/soc/soc-ac97.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index bc4a55b..6c8b0b0 100644
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
