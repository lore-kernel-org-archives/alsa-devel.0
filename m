From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: skl: Constify hw_constraints" to
	the asoc tree
Date: Tue, 13 Jun 2017 22:08:33 +0100
Message-ID: <E1dKt3B-0000UN-8r@debutante>
References: <20170608213725.5378-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F41D2670B1
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 23:08:42 +0200 (CEST)
In-Reply-To: <20170608213725.5378-6-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: skl: Constify hw_constraints

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

>From 617647ae2880cf291293048f8cfd54f8111acb1c Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 8 Jun 2017 23:37:23 +0200
Subject: [PATCH] ASoC: intel: skl: Constify hw_constraints

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 16 ++++++++--------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 16 ++++++++--------
 sound/soc/intel/boards/skl_rt286.c              | 12 ++++++------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 3b12bc1fa518..5ed0aa27b467 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -266,21 +266,21 @@ static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
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
 	2,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
@@ -348,11 +348,11 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int channels_dmic[] = {
+static const unsigned int channels_dmic[] = {
 	2, 4,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
 	.count = ARRAY_SIZE(channels_dmic),
 	.list = channels_dmic,
 	.mask = 0,
@@ -384,11 +384,11 @@ static const struct snd_soc_ops skylake_dmic_ops = {
 	.startup = skylake_dmic_startup,
 };
 
-static unsigned int rates_16000[] = {
+static const unsigned int rates_16000[] = {
 	16000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_16000 = {
+static const struct snd_pcm_hw_constraint_list constraints_16000 = {
 	.count = ARRAY_SIZE(rates_16000),
 	.list  = rates_16000,
 };
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index eb7751b0599b..01b8b140bb08 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -297,21 +297,21 @@ static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
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
 	2,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
@@ -397,11 +397,11 @@ static const struct snd_soc_ops skylake_nau8825_ops = {
 	.hw_params = skylake_nau8825_hw_params,
 };
 
-static unsigned int channels_dmic[] = {
+static const unsigned int channels_dmic[] = {
 	2, 4,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
 	.count = ARRAY_SIZE(channels_dmic),
 	.list = channels_dmic,
 	.mask = 0,
@@ -433,11 +433,11 @@ static const struct snd_soc_ops skylake_dmic_ops = {
 	.startup = skylake_dmic_startup,
 };
 
-static unsigned int rates_16000[] = {
+static const unsigned int rates_16000[] = {
 	16000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_16000 = {
+static const struct snd_pcm_hw_constraint_list constraints_16000 = {
 	.count = ARRAY_SIZE(rates_16000),
 	.list  = rates_16000,
 };
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index f5ab7b8d51d1..e08c71625fd0 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -165,21 +165,21 @@ static int skylake_hdmi_init(struct snd_soc_pcm_runtime *rtd)
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
 	2,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
@@ -264,11 +264,11 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int channels_dmic[] = {
+static const unsigned int channels_dmic[] = {
 	2, 4,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
 	.count = ARRAY_SIZE(channels_dmic),
 	.list = channels_dmic,
 	.mask = 0,
-- 
2.11.0
