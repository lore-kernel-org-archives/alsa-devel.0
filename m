From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: dapm: Add new widget type for
	constructing DAPM graphs on DSPs.
Date: Tue,  6 Jun 2017 15:44:42 +0100
Message-ID: <1496760282-6147-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BCA3266F01
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 16:44:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add some DAPM widget types to better support the construction of DAPM
graphs within DSPs.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-dapm.h  | 6 ++++++
 include/uapi/sound/asoc.h | 9 ++++++++-
 sound/soc/soc-topology.c  | 7 +++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a466f4bdc835..f142dace1c14 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,6 +510,12 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
 	snd_soc_dapm_kcontrol,		/* Auto-disabled kcontrol */
+	snd_soc_dapm_buffer,		/* DSP/CODEC internal buffer */
+	snd_soc_dapm_pipeline,		/* DSP/CODEC internal pipeline */
+	snd_soc_dapm_effect,		/* DSP/CODEC effect component */
+	snd_soc_dapm_src,		/* DSP/CODEC SRC component */
+	snd_soc_dapm_asrc,		/* DSP/CODEC ASRC component */
+	snd_soc_dapm_codec,		/* FW/SW coder/decoder component */
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 6702533c8bd8..b8993b3c55c6 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -73,7 +73,14 @@
 #define SND_SOC_TPLG_DAPM_DAI_IN	13
 #define SND_SOC_TPLG_DAPM_DAI_OUT	14
 #define SND_SOC_TPLG_DAPM_DAI_LINK	15
-#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DAI_LINK
+#define SND_SOC_TPLG_DAPM_BUFFER	16
+#define SND_SOC_TPLG_DAPM_PIPELINE	17
+#define SND_SOC_TPLG_DAPM_EFFECT	18
+#define SND_SOC_TPLG_DAPM_SIGGEN	19
+#define SND_SOC_TPLG_DAPM_SRC		20
+#define SND_SOC_TPLG_DAPM_ASRC		21
+#define SND_SOC_TPLG_DAPM_CODEC		22
+#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_CODEC
 
 /* Header magic number and string sizes */
 #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index e10dc353621a..468e74640570 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -242,6 +242,13 @@ static const struct soc_tplg_map dapm_map[] = {
 	{SND_SOC_TPLG_DAPM_DAI_IN, snd_soc_dapm_dai_in},
 	{SND_SOC_TPLG_DAPM_DAI_OUT, snd_soc_dapm_dai_out},
 	{SND_SOC_TPLG_DAPM_DAI_LINK, snd_soc_dapm_dai_link},
+	{SND_SOC_TPLG_DAPM_BUFFER, snd_soc_dapm_buffer},
+	{SND_SOC_TPLG_DAPM_PIPELINE, snd_soc_dapm_pipeline},
+	{SND_SOC_TPLG_DAPM_EFFECT, snd_soc_dapm_effect},
+	{SND_SOC_TPLG_DAPM_SIGGEN, snd_soc_dapm_siggen},
+	{SND_SOC_TPLG_DAPM_SRC, snd_soc_dapm_src},
+	{SND_SOC_TPLG_DAPM_ASRC, snd_soc_dapm_asrc},
+	{SND_SOC_TPLG_DAPM_CODEC, snd_soc_dapm_codec},
 };
 
 static int tplc_chan_get_reg(struct soc_tplg *tplg,
-- 
2.11.0
