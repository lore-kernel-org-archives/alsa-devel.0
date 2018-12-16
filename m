From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/9] ASoC: Intel: Skylake: simplify boolean
	tests
Date: Sun, 16 Dec 2018 16:49:03 -0600
Message-ID: <20181216224910.16198-3-pierre-louis.bossart@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1819E2677E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:17 +0100 (CET)
In-Reply-To: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Detected with Coccinelle

skl-messages.c:419:5-32: WARNING: Comparison to bool
skl-pcm.c:1426:6-33: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-pcm.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index b0e6fb93eaf8..28c4806b196a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -416,7 +416,7 @@ int skl_resume_dsp(struct skl *skl)
 	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 
 	/* check if DSP 1st boot is done */
-	if (skl->skl_sst->is_first_boot == true)
+	if (skl->skl_sst->is_first_boot)
 		return 0;
 
 	/*
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 557f80c0bfe5..8e589d698c58 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1423,7 +1423,7 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 		if (!ops)
 			return -EIO;
 
-		if (skl->skl_sst->is_first_boot == false) {
+		if (!skl->skl_sst->is_first_boot) {
 			dev_err(component->dev, "DSP reports first boot done!!!\n");
 			return -EIO;
 		}
-- 
2.17.1
