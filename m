From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Reset DSP pipe in
	skl_pcm_hw_free
Date: Mon,  2 Apr 2018 12:15:49 +0530
Message-ID: <1522651550-27236-3-git-send-email-sriramx.periyasamy@intel.com>
References: <1522651550-27236-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE66266A73
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 08:54:44 +0200 (CEST)
In-Reply-To: <1522651550-27236-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Divya Prakash <divya1.prakash@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Divya Prakash <divya1.prakash@intel.com>

Currently during destroy pipeline the gateway is disabled
before DMA completion. This leads to improper draining of
data and subsequently causing issues on HD-Audio DMA.
Hence added a new pipe reset IPC in skl_pcm_hw_free in
which the Gateway Enable(GEN bit) is reset to 0 after
DMA completion in skl_pcm_trigger.

Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 5ac0a12007c2..afa86b9e4dcf 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -382,9 +382,21 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct skl *skl = get_skl_ctx(dai->dev);
+	struct skl_module_cfg *mconfig;
+	int ret;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
+	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
+
+	if (mconfig) {
+		ret = skl_reset_pipe(skl->skl_sst, mconfig->pipe);
+		if (ret < 0)
+			dev_err(dai->dev, "%s:Reset failed ret =%d",
+						__func__, ret);
+	}
+
 	snd_hdac_stream_cleanup(hdac_stream(stream));
 	hdac_stream(stream)->prepared = 0;
 
-- 
2.7.4
