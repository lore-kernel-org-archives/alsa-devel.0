From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 13/13] ASoC: Intel: Skylake: fix widget
	handling
Date: Fri,  1 Jun 2018 22:54:01 -0500
Message-ID: <20180602035401.26934-14-pierre-louis.bossart@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6763826783D
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 05:54:24 +0200 (CEST)
In-Reply-To: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

include DAPM Mux and output widgets into the list.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 5ed17218c57c..5700080387ed 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -108,6 +108,9 @@ static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai_out:
 	case snd_soc_dapm_switch:
+	case snd_soc_dapm_output:
+	case snd_soc_dapm_mux:
+
 		return false;
 	default:
 		return true;
-- 
2.14.1
