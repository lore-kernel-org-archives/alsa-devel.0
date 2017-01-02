From: jeeja.kp@intel.com
Subject: [PATCH v4 2/9] ASoC: Intel: Skylake: Add set_tristate
	DAI ops to enable SSP MCLK
Date: Mon,  2 Jan 2017 12:44:29 +0530
Message-ID: <1483341277-14475-3-git-send-email-jeeja.kp@intel.com>
References: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E3E42667D3
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 08:03:55 +0100 (CET)
In-Reply-To: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
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

Some machine requires MCLK to be enabled before SSP start up, so add
set_tristate() DAI ops to enable/disable SSP MCLK. This ops will be
called from machine which requires early MCLK and removes the usage of
enabling early MLCK in platform DAI prepare by default which is not
machine specific.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 10fa10d..3c16d41 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -396,6 +396,33 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 	return skl_tplg_be_update_params(dai, &p_params);
 }
 
+static int skl_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
+{
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_module_cfg *mconfig;
+	int stream;
+
+	if (dai->playback_active)
+		stream = SNDRV_PCM_STREAM_PLAYBACK;
+	else
+		stream = SNDRV_PCM_STREAM_CAPTURE;
+
+	mconfig = skl_tplg_be_get_cpr_module(dai, stream);
+	if (!mconfig)
+		return -EINVAL;
+
+	/*
+	 * To enable ssp clk explicitly before gateway copier is configured,
+	 * need to use dma control IPC.
+	 * Disable will be done when DSP gateway copier modules are deleted.
+	 */
+	if (!tristate)
+		return skl_dsp_set_dma_control(ctx, mconfig);
+
+	return 0;
+}
+
 static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
 		int cmd)
 {
@@ -646,7 +673,7 @@ static struct snd_soc_dai_ops skl_dmic_dai_ops = {
 
 static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
 	.hw_params = skl_be_hw_params,
-	.prepare = skl_be_prepare,
+	.set_tristate = skl_soc_dai_set_tristate,
 };
 
 static struct snd_soc_dai_ops skl_link_dai_ops = {
-- 
2.5.0
