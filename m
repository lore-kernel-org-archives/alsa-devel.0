From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add new widget type for
	constructing DAPM graphs on DSPs." to the asoc tree
Date: Fri, 30 Jun 2017 12:59:23 +0100
Message-ID: <E1dQua3-00082k-AO@finisterre>
References: <1498742546-23463-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3045267532
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:31 +0200 (CEST)
In-Reply-To: <1498742546-23463-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add new widget type for constructing DAPM graphs on DSPs.

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

>From 8a70b4544ef4f094cc2c52734e097cc358f56603 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Thu, 29 Jun 2017 14:22:24 +0100
Subject: [PATCH] ASoC: dapm: Add new widget type for constructing DAPM graphs
 on DSPs.

Add some DAPM widget types to better support the construction of DAPM
graphs within DSPs.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/soc/dapm.rst | 18 ++++++++++++++++++
 include/sound/soc-dapm.h         |  7 +++++++
 include/uapi/sound/asoc.h        | 10 +++++++++-
 sound/soc/soc-topology.c         |  8 ++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index a27f42befa4d..8e44107933ab 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -105,6 +105,24 @@ Pre
 	Special PRE widget (exec before all others)
 Post
 	Special POST widget (exec after all others)
+Buffer
+	Inter widget audio data buffer within a DSP.
+Scheduler
+	DSP internal scheduler that schedules component/pipeline processing
+	work.
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
index a466f4bdc835..344b96c206a3 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,6 +510,13 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
 	snd_soc_dapm_kcontrol,		/* Auto-disabled kcontrol */
+	snd_soc_dapm_buffer,		/* DSP/CODEC internal buffer */
+	snd_soc_dapm_scheduler,		/* DSP/CODEC internal scheduler */
+	snd_soc_dapm_effect,		/* DSP/CODEC effect component */
+	snd_soc_dapm_src,		/* DSP/CODEC SRC component */
+	snd_soc_dapm_asrc,		/* DSP/CODEC ASRC component */
+	snd_soc_dapm_encoder,		/* FW/SW audio encoder component */
+	snd_soc_dapm_decoder,		/* FW/SW audio decoder component */
 };
 
 enum snd_soc_dapm_subclass {
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 6702533c8bd8..78014ec56357 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -73,7 +73,15 @@
 #define SND_SOC_TPLG_DAPM_DAI_IN	13
 #define SND_SOC_TPLG_DAPM_DAI_OUT	14
 #define SND_SOC_TPLG_DAPM_DAI_LINK	15
-#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DAI_LINK
+#define SND_SOC_TPLG_DAPM_BUFFER	16
+#define SND_SOC_TPLG_DAPM_SCHEDULER	17
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
index 002772e3ba2c..dd3a391476ae 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -242,6 +242,14 @@ static const struct soc_tplg_map dapm_map[] = {
 	{SND_SOC_TPLG_DAPM_DAI_IN, snd_soc_dapm_dai_in},
 	{SND_SOC_TPLG_DAPM_DAI_OUT, snd_soc_dapm_dai_out},
 	{SND_SOC_TPLG_DAPM_DAI_LINK, snd_soc_dapm_dai_link},
+	{SND_SOC_TPLG_DAPM_BUFFER, snd_soc_dapm_buffer},
+	{SND_SOC_TPLG_DAPM_SCHEDULER, snd_soc_dapm_scheduler},
+	{SND_SOC_TPLG_DAPM_EFFECT, snd_soc_dapm_effect},
+	{SND_SOC_TPLG_DAPM_SIGGEN, snd_soc_dapm_siggen},
+	{SND_SOC_TPLG_DAPM_SRC, snd_soc_dapm_src},
+	{SND_SOC_TPLG_DAPM_ASRC, snd_soc_dapm_asrc},
+	{SND_SOC_TPLG_DAPM_ENCODER, snd_soc_dapm_encoder},
+	{SND_SOC_TPLG_DAPM_DECODER, snd_soc_dapm_decoder},
 };
 
 static int tplc_chan_get_reg(struct soc_tplg *tplg,
-- 
2.13.2
