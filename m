From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fill BE blob with
	default params" to the asoc tree
Date: Mon, 08 Feb 2016 18:01:31 +0000
Message-ID: <E1aSq7v-0002jZ-BP@debutante>
References: <1454654950-23091-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6646A260786
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 19:01:42 +0100 (CET)
In-Reply-To: <1454654950-23091-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fill BE blob with default params

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2d1419a329e7de825c03738ad2ac532153239388 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 5 Feb 2016 12:19:10 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fill BE blob with default params

When we have a path that connects to DSP sink and source, we
need to query the blob using the default params. So add a
function to query the params for such path

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a7be03665dd4..216d7a8e5680 100644
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
2.7.0.rc3
