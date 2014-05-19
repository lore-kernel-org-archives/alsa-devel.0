From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Remove needless snd_soc_dapm_sync()
	from machine driver inits
Date: Mon, 19 May 2014 16:17:26 +0300
Message-ID: <1400505447-8313-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E9D572617AD
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 15:17:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

ALSA SoC core takes care of calling snd_soc_dapm_sync() at the end
snd_soc_instantiate_card() so there is no need to call it from machine
driver init functions.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c   | 1 -
 sound/soc/pxa/brownstone.c     | 2 --
 sound/soc/tegra/tegra_wm9712.c | 4 +---
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index dbc63d09f424..eee001f70964 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -105,7 +105,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 	snd_soc_dapm_enable_pin(dapm, "Internal Mic");
 
-	snd_soc_dapm_sync(dapm);
 	return ret;
 }
 
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 08acdc236bf8..9c128d4c8cbf 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -70,8 +70,6 @@ static int brownstone_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
 	snd_soc_dapm_nc_pin(dapm, "IN2LN");
 
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
index 25a7f8211ecf..de087ee3458a 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -50,9 +50,7 @@ static int tegra_wm9712_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
-
-	return snd_soc_dapm_sync(dapm);
+	return snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
 }
 
 static struct snd_soc_dai_link tegra_wm9712_dai = {
-- 
2.0.0.rc2
