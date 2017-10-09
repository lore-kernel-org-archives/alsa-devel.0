From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Add dai load ops for
	dais from topology
Date: Mon,  9 Oct 2017 11:20:31 +0530
Message-ID: <20171009055032.12158-3-guneshwor.o.singh@intel.com>
References: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ECE96266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 07:50:50 +0200 (CEST)
In-Reply-To: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Since FE dais can come from topology, add dai_load ops
for the dais from topology.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      | 8 ++++++++
 sound/soc/intel/skylake/skl-topology.c | 1 +
 sound/soc/intel/skylake/skl-topology.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 9ca69b1fc128..4380e40c6af0 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -977,6 +977,14 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 },
 };
 
+int skl_dai_load(struct snd_soc_component *cmp,
+		 struct snd_soc_dai_driver *pcm_dai)
+{
+	pcm_dai->ops = &skl_pcm_dai_ops;
+
+	return 0;
+}
+
 static int skl_platform_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 27bcb62568fb..a96f02109540 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3331,6 +3331,7 @@ static struct snd_soc_tplg_ops skl_tplg_ops  = {
 	.io_ops = skl_tplg_kcontrol_ops,
 	.io_ops_count = ARRAY_SIZE(skl_tplg_kcontrol_ops),
 	.manifest = skl_manifest_load,
+	.dai_load = skl_dai_load,
 };
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index bc3c29161ed0..b10b53597eae 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -502,4 +502,7 @@ int skl_pcm_host_dma_prepare(struct device *dev,
 			struct skl_pipe_params *params);
 int skl_pcm_link_dma_prepare(struct device *dev,
 			struct skl_pipe_params *params);
+
+int skl_dai_load(struct snd_soc_component *cmp,
+		 struct snd_soc_dai_driver *pcm_dai);
 #endif
-- 
2.14.2
