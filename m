From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 04/11] ASoC: Intel: Skylake: Don't return failure on machine driver reload
Date: Mon, 17 Jun 2019 13:36:37 +0200
Message-ID: <20190617113644.25621-5-amadeuszx.slawinski@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When we unload and reload machine driver, we shouldn't return that we
failed to initialize. This allows to reload machine driver, without
having to unload whole stack.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 489ecef311ad..5e3421cc0feb 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1418,11 +1418,6 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 		if (!ops)
 			return -EIO;
 
-		if (!skl->skl_sst->is_first_boot) {
-			dev_err(component->dev, "DSP reports first boot done!!!\n");
-			return -EIO;
-		}
-
 		/*
 		 * Disable dynamic clock and power gating during firmware
 		 * and library download
-- 
2.17.1
