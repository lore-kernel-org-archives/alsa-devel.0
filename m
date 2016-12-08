From: Kirtika Ruchandani <kirtika@chromium.org>
Subject: [PATCH] ASoC: Intel: Skylake: remove unused 'runtime' variable
Date: Wed,  7 Dec 2016 22:26:20 -0800
Message-ID: <1481178380-139648-1-git-send-email-kirtika@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: Kirtika Ruchandani <kirtika@chromium.org>, arnd@arndb.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

skl_platform_open() defines and sets 'struct snd_pcm_runtime* runtime'
but does not use it. Compiling with W=1 gives the following warning,
fix it.

sound/soc/intel/skylake/skl-pcm.c: In function ‘skl_platform_open’:
sound/soc/intel/skylake/skl-pcm.c:941:26: warning: variable ‘runtime’ set but not used [-Wunused-but-set-variable]

This was introduced with the initial driver commit a40e693c7f5e
("ASoC: Intel: Add Skylake HDA platform driver").
This is a harmless warning and is only being fixed to reduce the noise
with W=1 in the kernel.

Fixes: a40e693c7f5e ("ASoC: Intel: Add Skylake HDA platform driver")
Cc: Jeeja KP <jeeja.kp@intel.com>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kirtika Ruchandani <kirtika@chromium.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 84b5101..3254507 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -938,14 +938,12 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {

 static int skl_platform_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime;
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai_link *dai_link = rtd->dai_link;

	dev_dbg(rtd->cpu_dai->dev, "In %s:%s\n", __func__,
					dai_link->cpu_dai_name);

-	runtime = substream->runtime;
	snd_soc_set_runtime_hwparams(substream, &azx_pcm_hw);

	return 0;
--
2.8.0.rc3.226.g39d4020
