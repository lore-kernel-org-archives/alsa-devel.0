From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ASoC: intel: bxt: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:37:21 +0200
Message-ID: <20170608213725.5378-4-tiwai@suse.de>
References: <20170608213725.5378-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BDB2C2673DC
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:33 +0200 (CEST)
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
index 1a68d043c803..1008076e084f 100644
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
@@ -230,11 +230,11 @@ static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
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
@@ -256,11 +256,11 @@ static const struct snd_soc_ops broxton_dmic_ops = {
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
2.13.0
