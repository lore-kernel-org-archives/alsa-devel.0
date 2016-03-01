From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: correct direction in
	blob query
Date: Tue,  1 Mar 2016 07:59:10 +0530
Message-ID: <1456799352-22653-2-git-send-email-vinod.koul@intel.com>
References: <1456799352-22653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 532E5261483
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 03:26:48 +0100 (CET)
In-Reply-To: <1456799352-22653-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The blob query for BE skl_tplg_update_be_blob() was not using
right values for direction for blob query, so fix that.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c95bbce8ad5d..af7722ab7207 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -273,10 +273,11 @@ static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 	if (m_cfg->formats_config.caps_size > 0)
 		return 0;
 
+	dev_dbg(ctx->dev, "Applying default cfg blob\n");
 	switch (m_cfg->dev_type) {
 	case SKL_DEVICE_DMIC:
 		link_type = NHLT_LINK_DMIC;
-		dir = 1;
+		dir = SNDRV_PCM_STREAM_CAPTURE;
 		s_freq = m_cfg->in_fmt[0].s_freq;
 		s_fmt = m_cfg->in_fmt[0].bit_depth;
 		ch = m_cfg->in_fmt[0].channels;
@@ -285,15 +286,15 @@ static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 	case SKL_DEVICE_I2S:
 		link_type = NHLT_LINK_SSP;
 		if (m_cfg->hw_conn_type == SKL_CONN_SOURCE) {
-			dir = 1;
-			s_freq = m_cfg->in_fmt[0].s_freq;
-			s_fmt = m_cfg->in_fmt[0].bit_depth;
-			ch = m_cfg->in_fmt[0].channels;
-		} else {
-			dir = 0;
+			dir = SNDRV_PCM_STREAM_PLAYBACK;
 			s_freq = m_cfg->out_fmt[0].s_freq;
 			s_fmt = m_cfg->out_fmt[0].bit_depth;
 			ch = m_cfg->out_fmt[0].channels;
+		} else {
+			dir = SNDRV_PCM_STREAM_CAPTURE;
+			s_freq = m_cfg->in_fmt[0].s_freq;
+			s_fmt = m_cfg->in_fmt[0].bit_depth;
+			ch = m_cfg->in_fmt[0].channels;
 		}
 		break;
 
-- 
1.9.1
