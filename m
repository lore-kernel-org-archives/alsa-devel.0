From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: dapm: Add new widget type for
	constructing DAPM graphs on DSPs.
Date: Fri,  9 Jun 2017 16:23:49 +0100
Message-ID: <1497021829-5680-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E6DD1266AB2
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 17:24:06 +0200 (CEST)
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
graphs within DSPs

Changes v1.
  o Added some documentation.
  o Split codec widget into encoder and decoder to avoid confusion with HW
    CODECS.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Documentation/sound/soc/dapm.rst | 18 ++++++++++++++++++
 include/sound/soc-dapm.h         |  7 +++++++
 include/uapi/sound/asoc.h        | 10 +++++++++-
 sound/soc/soc-topology.c         |  8 ++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index a27f42befa4d..78d63f6a35fa 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -105,6 +105,24 @@ Pre
 	Special PRE widget (exec before all others)
 Post
 	Special POST widget (exec after all others)
+Buffer
+	Inter widget audio data buffer within a DSP.
+Pipeline
+	Collection of widgets within a DSP, can represent a sequence of DSP
+	widgets and their collective configuration.
+Effect
+	Widget that performs an audio processing effect.
+SRC
+	Sample Rate Converter within DSP or CODEC
+ASRC
+	Asynchronous Sample Rate Converter within DSP or CODEC
+Encoder
+	Widget that encodes audio data from one format (usually PCM) to another
+	usually more compressed format.
+Decoder
+	Widget that decodes audio data from a compressed format to an
+	uncompressed format like PCM.
+
 
 (Widgets are defined in include/sound/soc-dapm.h)
 
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a466f4bdc835..68fea6d97199 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,6 +510,13 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
 	snd_soc_dapm_kcontrol,		/* Auto-disabled kcontrol */
+	snd_soc_dapm_buffer,		/* DSP/CODEC internal buffer */
+	snd_soc_dapm_pipeline,		/* DSP/CODEC internal pipeline */
+	snd_soc_dapm_effect,		/* DSP/CODEC effect component */
+	snd_soc_dapm_src,		/* DSP/CODEC SRC component */
+	snd_soc_dapm_asrc,		/* DSP/CODEC ASRC component */
+	snd_soc_dapm_encoder,		/* FW/SW audio encoder component */
+	snd_soc_dapm_decoder,		/* FW/SW audio decoder component */
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 6702533c8bd8..8a4fdf3e7e2e 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -73,7 +73,15 @@
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
+#define SND_SOC_TPLG_DAPM_ENCODER	22
+#define SND_SOC_TPLG_DAPM_DECODER	23
+#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DECODER
 
 /* Header magic number and string sizes */
 #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 12e189701924..b82d2755c2ac 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -242,6 +242,14 @@ static const struct soc_tplg_map dapm_map[] = {
 	{SND_SOC_TPLG_DAPM_DAI_IN, snd_soc_dapm_dai_in},
 	{SND_SOC_TPLG_DAPM_DAI_OUT, snd_soc_dapm_dai_out},
 	{SND_SOC_TPLG_DAPM_DAI_LINK, snd_soc_dapm_dai_link},
+	{SND_SOC_TPLG_DAPM_BUFFER, snd_soc_dapm_buffer},
+	{SND_SOC_TPLG_DAPM_PIPELINE, snd_soc_dapm_pipeline},
+	{SND_SOC_TPLG_DAPM_EFFECT, snd_soc_dapm_effect},
+	{SND_SOC_TPLG_DAPM_SIGGEN, snd_soc_dapm_siggen},
+	{SND_SOC_TPLG_DAPM_SRC, snd_soc_dapm_src},
+	{SND_SOC_TPLG_DAPM_ASRC, snd_soc_dapm_asrc},
+	{SND_SOC_TPLG_DAPM_ENCODER, snd_soc_dapm_encoder},
+	{SND_SOC_TPLG_DAPM_DECODER, snd_soc_dapm_decoder},
 };
 
 static int tplc_chan_get_reg(struct soc_tplg *tplg,
-- 
2.11.0
