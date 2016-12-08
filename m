From: jeeja.kp@intel.com
Subject: [PATCH v3 08/13] ASoC: Intel: Skylake: Add supply
	widget as non DSP widget
Date: Thu,  8 Dec 2016 13:41:19 +0530
Message-ID: <1481184684-9620-9-git-send-email-jeeja.kp@intel.com>
References: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 278202667B2
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 09:01:39 +0100 (CET)
In-Reply-To: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Supply widgets to model clock supplies for SSP and add this widget type
dapm supply widget as non DSP widget to bypass while parsing the source
and sink dapm widget list.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 9cf8c51..edd0c60 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -87,6 +87,7 @@ static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w)
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai_out:
 	case snd_soc_dapm_switch:
+	case snd_soc_dapm_supply:
 		return false;
 	default:
 		return true;
@@ -1484,12 +1485,13 @@ static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
 	snd_soc_dapm_widget_for_each_source_path(w, p) {
 		if (p->connect && is_skl_dsp_widget_type(p->source) &&
 						p->source->priv) {
-
 			ret = skl_tplg_be_fill_pipe_params(dai,
 						p->source->priv, params);
 			if (ret < 0)
 				return ret;
 		} else {
+			if (p->source->id == snd_soc_dapm_supply)
+				continue;
 			ret = skl_tplg_be_set_src_pipe_params(dai,
 						p->source, params);
 			if (ret < 0)
@@ -1515,6 +1517,8 @@ static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
 			if (ret < 0)
 				return ret;
 		} else {
+			if (p->sink->id == snd_soc_dapm_supply)
+				continue;
 			ret = skl_tplg_be_set_sink_pipe_params(
 						dai, p->sink, params);
 			if (ret < 0)
-- 
2.5.0
