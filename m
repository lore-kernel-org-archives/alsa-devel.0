From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 1/8] ASoC: Intel: Skylake: fix widget
	handling
Date: Tue, 24 Jul 2018 19:50:48 -0500
Message-ID: <20180725005055.18138-2-pierre-louis.bossart@linux.intel.com>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 840E52676D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 02:52:30 +0200 (CEST)
In-Reply-To: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

include DAPM Mux and output widgets into the list.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 76dde12cc2bb..2620d77729c5 100644
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
