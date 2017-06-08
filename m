From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ASoC: intel: skl: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:37:23 +0200
Message-ID: <20170608213725.5378-6-tiwai@suse.de>
References: <20170608213725.5378-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE962673EB
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:34 +0200 (CEST)
In-Reply-To: <20170608213725.5378-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
2.13.0
