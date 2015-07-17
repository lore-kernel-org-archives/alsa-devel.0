From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Use reg_sequence for
	multi_reg_write/register_patch" to the asoc tree
Date: Fri, 17 Jul 2015 18:58:27 +0100
Message-ID: <E1ZG9tz-0005UI-42@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5AAF2606C3
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 19:58:36 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nariman Poushin <nariman@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5110: Use reg_sequence for multi_reg_write/register_patch

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

>From dc606e05468fc5e3b125bffdd54253f853bfbb8e Mon Sep 17 00:00:00 2001
From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Date: Fri, 17 Jul 2015 15:11:10 +0100
Subject: [PATCH] ASoC: wm5110: Use reg_sequence for
 multi_reg_write/register_patch

Introduced by:
commit 8019ff6cfc04
("regmap: Use reg_sequence for multi_reg_write / register_patch")

Interacting with:
commit d1acd31883d7
("ASoC: wm5110: Add special DRE on/off handling for the headphone path")

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b5c201b1e454..1f29991c1f71 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -185,7 +185,7 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct reg_default wm5110_no_dre_left_enable[] = {
+static const struct reg_sequence wm5110_no_dre_left_enable[] = {
 	{ 0x3024, 0xE410 },
 	{ 0x3025, 0x0056 },
 	{ 0x301B, 0x0224 },
@@ -203,7 +203,7 @@ static const struct reg_default wm5110_no_dre_left_enable[] = {
 	{ 0x3039, 0x3080 },
 };
 
-static const struct reg_default wm5110_dre_left_enable[] = {
+static const struct reg_sequence wm5110_dre_left_enable[] = {
 	{ 0x3024, 0x0231 },
 	{ 0x3025, 0x0B00 },
 	{ 0x301B, 0x0227 },
@@ -221,7 +221,7 @@ static const struct reg_default wm5110_dre_left_enable[] = {
 	{ 0x3039, 0x0B00 },
 };
 
-static const struct reg_default wm5110_no_dre_right_enable[] = {
+static const struct reg_sequence wm5110_no_dre_right_enable[] = {
 	{ 0x3074, 0xE414 },
 	{ 0x3075, 0x0056 },
 	{ 0x306B, 0x0224 },
@@ -239,7 +239,7 @@ static const struct reg_default wm5110_no_dre_right_enable[] = {
 	{ 0x3089, 0x3080 },
 };
 
-static const struct reg_default wm5110_dre_right_enable[] = {
+static const struct reg_sequence wm5110_dre_right_enable[] = {
 	{ 0x3074, 0x0231 },
 	{ 0x3075, 0x0B00 },
 	{ 0x306B, 0x0227 },
@@ -263,7 +263,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = priv->arizona;
 	unsigned int val = snd_soc_read(codec, ARIZONA_DRE_ENABLE);
-	const struct reg_default *wseq;
+	const struct reg_sequence *wseq;
 	int nregs;
 
 	switch (w->shift) {
@@ -354,7 +354,7 @@ static int wm5110_hp_ev(struct snd_soc_dapm_widget *w,
 
 static int wm5110_clear_pga_volume(struct arizona *arizona, int output)
 {
-	struct reg_default clear_pga = {
+	struct reg_sequence clear_pga = {
 		ARIZONA_OUTPUT_PATH_CONFIG_1L + output * 4, 0x80
 	};
 	int ret;
-- 
2.1.4
