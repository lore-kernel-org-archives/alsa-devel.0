From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: correct direction in
	blob query" to the asoc tree
Date: Wed, 02 Mar 2016 13:00:43 +0900
Message-ID: <E1aaxxr-0003bz-QI@finisterre>
References: <1456799352-22653-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D514261515
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:00:47 +0100 (CET)
In-Reply-To: <1456799352-22653-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: correct direction in blob query

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

>From c7c6c73604ed4018cf7c22575d336a448ef8ccf5 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 1 Mar 2016 07:59:10 +0530
Subject: [PATCH] ASoC: Intel: Skylake: correct direction in blob query

The blob query for BE skl_tplg_update_be_blob() was not using
right values for direction for blob query, so fix that.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0
