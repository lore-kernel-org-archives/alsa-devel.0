From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 6/6] ASoC: constify gpio_chip structures
Date: Sun, 11 Sep 2016 14:14:42 +0200
Message-ID: <1473596082-32690-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
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
 sound/soc/codecs/rt5677.c |    2 +-
 sound/soc/codecs/wm5100.c |    2 +-
 sound/soc/codecs/wm8903.c |    2 +-
 sound/soc/codecs/wm8962.c |    2 +-
 sound/soc/codecs/wm8996.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 278467d..5605750 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2285,7 +2285,7 @@ static int wm5100_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 				  (1 << WM5100_GP1_DIR_SHIFT));
 }
 
-static struct gpio_chip wm5100_template_chip = {
+static const struct gpio_chip wm5100_template_chip = {
 	.label			= "wm5100",
 	.owner			= THIS_MODULE,
 	.direction_output	= wm5100_gpio_direction_out,
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 837c8b9..6e887c2 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1830,7 +1830,7 @@ static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			   !!value << WM8903_GP1_LVL_SHIFT);
 }
 
-static struct gpio_chip wm8903_template_chip = {
+static const struct gpio_chip wm8903_template_chip = {
 	.label			= "wm8903",
 	.owner			= THIS_MODULE,
 	.request		= wm8903_gpio_request,
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9f67922..fd2731d 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3357,7 +3357,7 @@ static int wm8962_gpio_direction_out(struct gpio_chip *chip,
 	return 0;
 }
 
-static struct gpio_chip wm8962_template_chip = {
+static const struct gpio_chip wm8962_template_chip = {
 	.label			= "wm8962",
 	.owner			= THIS_MODULE,
 	.request		= wm8962_gpio_request,
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 5eba8ff..8affa49 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2184,7 +2184,7 @@ static int wm8996_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 				  (1 << WM8996_GP1_DIR_SHIFT));
 }
 
-static struct gpio_chip wm8996_template_chip = {
+static const struct gpio_chip wm8996_template_chip = {
 	.label			= "wm8996",
 	.owner			= THIS_MODULE,
 	.direction_output	= wm8996_gpio_direction_out,
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 68268f2..7df422c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4657,7 +4657,7 @@ static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 	return regmap_irq_get_virq(data, irq);
 }
 
-static struct gpio_chip rt5677_template_chip = {
+static const struct gpio_chip rt5677_template_chip = {
 	.label			= "rt5677",
 	.owner			= THIS_MODULE,
 	.direction_output	= rt5677_gpio_direction_out,
