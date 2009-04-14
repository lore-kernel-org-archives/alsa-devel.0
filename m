From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/14] ASoC: Provide core support for symmetric
	sample rates
Date: Tue, 14 Apr 2009 13:33:04 +0100
Message-ID: <1239712393-6428-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4BB02434B
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:17 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Many devices require symmetric configurations of capture and playback
data formats, often due to shared clocking but sometimes also due to
other shared playback and record configuration in the device. Start
providing core support for this by allowing the DAIs or the machine
to specify that the sample rates used should be kept symmetric.

A flag symmetric_rates is provided in the snd_soc_dai and
snd_soc_dai_link structures. If this is set in either of the DAIs or in
the machine then a constraint will be applied when a stream is already
open preventing any changes in sample rate.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |    1 +
 include/sound/soc.h     |    6 ++++++
 sound/soc/soc-core.c    |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1367647..22b729f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -208,6 +208,7 @@ struct snd_soc_dai {
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
+	unsigned int symmetric_rates:1;
 
 	/* DAI runtime info */
 	struct snd_pcm_runtime *runtime;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index a40bc6f..b1f2f88 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -417,6 +417,12 @@ struct snd_soc_dai_link  {
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_codec *codec);
 
+	/* Symmetry requirements */
+	unsigned int symmetric_rates:1;
+
+	/* Symmetry data - only valid if symmetry is being enforced */
+	unsigned int rate;
+
 	/* DAI pcm */
 	struct snd_pcm *pcm;
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 99712f6..dd28009 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -113,6 +113,35 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 }
 #endif
 
+static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_dai_link *machine = rtd->dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	int ret;
+
+	if (codec_dai->symmetric_rates || cpu_dai->symmetric_rates ||
+	    machine->symmetric_rates) {
+		dev_dbg(card->dev, "Symmetry forces %dHz rate\n", 
+			machine->rate);
+
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						   SNDRV_PCM_HW_PARAM_RATE,
+						   machine->rate,
+						   machine->rate);
+		if (ret < 0) {
+			dev_err(card->dev,
+				"Unable to apply rate symmetry constraint: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Called by ALSA when a PCM substream is opened, the runtime->hw record is
  * then initialized and any private data can be allocated. This also calls
@@ -221,6 +250,13 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto machine_err;
 	}
 
+	/* Symmetry only applies if we've already got an active stream. */
+	if (cpu_dai->active || codec_dai->active) {
+		ret = soc_pcm_apply_symmetry(substream);
+		if (ret != 0)
+			goto machine_err;
+	}
+
 	pr_debug("asoc: %s <-> %s info:\n", codec_dai->name, cpu_dai->name);
 	pr_debug("asoc: rate mask 0x%x\n", runtime->hw.rates);
 	pr_debug("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
@@ -521,6 +557,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	machine->rate = params_rate(params);
+
 out:
 	mutex_unlock(&pcm_mutex);
 	return ret;
-- 
1.6.2.2
