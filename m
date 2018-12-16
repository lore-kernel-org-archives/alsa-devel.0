From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 8/9] ASoC: Intel: Atom: work-around Coccinelle
	false-alarm
Date: Sun, 16 Dec 2018 16:49:09 -0600
Message-ID: <20181216224910.16198-9-pierre-louis.bossart@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EBA1A2678F6
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:25 +0100 (CET)
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, Julia Lawall <julia.lawall@lip6.fr>, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Coccinelle complains:
sst-atom-controls.c:1534:2-19: ERROR: Assignment of bool to non-0/1
constant

false alarm: that constant is declared as

Using a test that will be optimized away to work-around the issue

Cc: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index d1207ea53523..d00990852fdf 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1531,7 +1531,7 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_component *component)
 	snd_soc_dapm_new_widgets(dapm->card);
 
 	for (i = 0; i < gains; i++) {
-		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT;
+		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT ? true : false;
 		sst_gains[i].l_gain = SST_GAIN_VOLUME_DEFAULT;
 		sst_gains[i].r_gain = SST_GAIN_VOLUME_DEFAULT;
 		sst_gains[i].ramp_duration = SST_GAIN_RAMP_DURATION_DEFAULT;
-- 
2.17.1
