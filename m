From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Skylake: Fill BE blob with
	default params
Date: Fri,  5 Feb 2016 12:19:10 +0530
Message-ID: <1454654950-23091-8-git-send-email-vinod.koul@intel.com>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E1C26661E
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:46:20 +0100 (CET)
In-Reply-To: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When we have a path that connects to DSP sink and source, we
need to query the blob using the default params. So add a
function to query the params for such path

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7803a6f3c014..03a8762d1e3e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -260,6 +260,64 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 				multiplier;
 }
 
+static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
+						struct skl_sst *ctx)
+{
+	struct skl_module_cfg *m_cfg = w->priv;
+	int link_type, dir;
+	u32 ch, s_freq, s_fmt;
+	struct nhlt_specific_cfg *cfg;
+	struct skl *skl = get_skl_ctx(ctx->dev);
+
+	/* check if we already have blob */
+	if (m_cfg->formats_config.caps_size > 0)
+		return 0;
+
+	switch (m_cfg->dev_type) {
+	case SKL_DEVICE_DMIC:
+		link_type = NHLT_LINK_DMIC;
+		dir = 1;
+		s_freq = m_cfg->in_fmt[0].s_freq;
+		s_fmt = m_cfg->in_fmt[0].bit_depth;
+		ch = m_cfg->in_fmt[0].channels;
+		break;
+
+	case SKL_DEVICE_I2S:
+		link_type = NHLT_LINK_SSP;
+		if (m_cfg->hw_conn_type == SKL_CONN_SOURCE) {
+			dir = 1;
+			s_freq = m_cfg->in_fmt[0].s_freq;
+			s_fmt = m_cfg->in_fmt[0].bit_depth;
+			ch = m_cfg->in_fmt[0].channels;
+		} else {
+			dir = 0;
+			s_freq = m_cfg->out_fmt[0].s_freq;
+			s_fmt = m_cfg->out_fmt[0].bit_depth;
+			ch = m_cfg->out_fmt[0].channels;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* update the blob based on virtual bus_id and default params */
+	cfg = skl_get_ep_blob(skl, m_cfg->vbus_id, link_type,
+					s_fmt, ch, s_freq, dir);
+	if (cfg) {
+		m_cfg->formats_config.caps_size = cfg->size;
+		m_cfg->formats_config.caps = (u32 *) &cfg->caps;
+	} else {
+		dev_err(ctx->dev, "Blob NULL for id %x type %d dirn %d\n",
+					m_cfg->vbus_id, link_type, dir);
+		dev_err(ctx->dev, "PCM: ch %d, freq %d, fmt %d\n",
+					ch, s_freq, s_fmt);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void skl_tplg_update_module_params(struct snd_soc_dapm_widget *w,
 							struct skl_sst *ctx)
 {
@@ -433,6 +491,9 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 				return ret;
 		}
 
+		/* update blob if blob is null for be with default value */
+		skl_tplg_update_be_blob(w, ctx);
+
 		/*
 		 * apply fix/conversion to module params based on
 		 * FE/BE params
-- 
1.9.1
