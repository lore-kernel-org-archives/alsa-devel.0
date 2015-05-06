From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/5] ASoC: Intel: load hw_defaults in hw_params
	of ssp be
Date: Wed,  6 May 2015 22:06:42 +0530
Message-ID: <1430930204-32184-4-git-send-email-vinod.koul@intel.com>
References: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C6726070A
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:34 +0200 (CEST)
In-Reply-To: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, praveen.diwakar@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathyanarayana.nujella@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

We have the SSP defaults now and we need to load then in hw_params callback
of BE SSP DAI ops.

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.h     |  2 ++
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index eea715605130..da13f6fa7d1c 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -869,4 +869,6 @@ struct sst_enum {
 	SOC_DAPM_ENUM(SST_MUX_CTL_NAME(xpname, xinstance), \
 			  SST_SSP_MUX_ENUM(xreg, xshift, xtexts))
 
+void sst_fill_ssp_defaults(struct snd_soc_dai *dai);
+
 #endif
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 2fbaf2c75d17..1fb2448e0fed 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -434,13 +434,22 @@ static int sst_enable_ssp(struct snd_pcm_substream *substream,
 
 	if (!dai->active) {
 		ret = sst_handle_vb_timer(dai, true);
-		if (ret)
-			return ret;
-		ret = send_ssp_cmd(dai, dai->name, 1);
+		sst_fill_ssp_defaults(dai);
 	}
 	return ret;
 }
 
+static int sst_be_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+
+	if (dai->active == 1)
+		ret = send_ssp_cmd(dai, dai->name, 1);
+	return ret;
+}
+
 static void sst_disable_ssp(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
@@ -465,6 +474,7 @@ static struct snd_soc_dai_ops sst_compr_dai_ops = {
 
 static struct snd_soc_dai_ops sst_be_dai_ops = {
 	.startup = sst_enable_ssp,
+	.hw_params = sst_be_hw_params,
 	.shutdown = sst_disable_ssp,
 };
 
-- 
1.9.1
