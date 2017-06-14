From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: bxt: Constify hw_constraints" to
	the asoc tree
Date: Wed, 14 Jun 2017 11:12:53 +0100
Message-ID: <E1dL5ID-0007fP-Il@debutante>
References: <20170614073306.22646-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E22F126720D
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 12:12:59 +0200 (CEST)
In-Reply-To: <20170614073306.22646-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: bxt: Constify hw_constraints

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

>From 21031d531eb33a6ad0251ff661a539802700c6e5 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 14 Jun 2017 09:33:06 +0200
Subject: [PATCH] ASoC: intel: bxt: Constify hw_constraints

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 ++++++------
 sound/soc/intel/boards/bxt_rt298.c            | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3a8c4d954a91..1429eb391da8 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -238,31 +238,31 @@ static int broxton_da7219_fe_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_rates = {
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list  = rates,
 	.mask = 0,
 };
 
-static unsigned int channels[] = {
+static const unsigned int channels[] = {
 	DUAL_CHANNEL,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
 };
 
-static unsigned int channels_quad[] = {
+static const unsigned int channels_quad[] = {
 	QUAD_CHANNEL,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels_quad = {
+static const struct snd_pcm_hw_constraint_list constraints_channels_quad = {
 	.count = ARRAY_SIZE(channels_quad),
 	.list = channels_quad,
 	.mask = 0,
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 36ee7480e9f1..0c3a3cbcb884 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -207,11 +207,11 @@ static const struct snd_soc_ops broxton_rt298_ops = {
 	.hw_params = broxton_rt298_hw_params,
 };
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_rates = {
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list  = rates,
 	.mask = 0,
@@ -227,11 +227,11 @@ static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int channels_dmic[] = {
+static const unsigned int channels_dmic[] = {
 	1, 2, 3, 4,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
 	.count = ARRAY_SIZE(channels_dmic),
 	.list = channels_dmic,
 	.mask = 0,
@@ -253,11 +253,11 @@ static const struct snd_soc_ops broxton_dmic_ops = {
 	.startup = broxton_dmic_startup,
 };
 
-static unsigned int channels[] = {
+static const unsigned int channels[] = {
 	2,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
-- 
2.11.0
