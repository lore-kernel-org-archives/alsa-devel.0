From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/7] ASoC: Allow drivers to specify how many
	bits are significant on a DAI
Date: Wed, 18 Jan 2012 10:44:49 +0100
Message-ID: <1326879895-2973-2-git-send-email-peter.ujfalusi@ti.com>
References: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id B414924571
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 10:45:37 +0100 (CET)
Received: by mail-gx0-f177.google.com with SMTP id l1so4747071ggn.22
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 01:45:36 -0800 (PST)
In-Reply-To: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Most devices accept data in formats that don't correspond directly to
their internal format. ALSA allows us to set a msbits constraint which
tells userspace about this in case it finds it useful (for example, in
order to avoid wasting effort dithering bits that will be ignored when
raising the sample size of data) so provide a mechanism for drivers to
specify the number of bits that are actually significant on a DAI and
add the appropriate constraints along with all the others.

This is done slightly awkwardly as the constraint is specified per sample
size - we loop over every possible sample size, including ones that the
device doesn't support and including ones that have fewer bits than are
actually used, but this is harmless as the upper layers do the right thing
in these cases.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    1 +
 sound/soc/soc-pcm.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0992dff..55381fc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -505,6 +505,7 @@ struct snd_soc_pcm_stream {
 	unsigned int rate_max;		/* max rate */
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
+	unsigned int sig_bits;		/* number of bits of content */
 };
 
 /* SoC audio ops */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index cdc860a..8bb1793 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -63,6 +63,39 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 }
 
 /*
+ * List of sample sizes that might go over the bus for parameter
+ * application.  There ought to be a wildcard sample size for things
+ * like the DAC/ADC resolution to use but there isn't right now.
+ */
+static int sample_sizes[] = {
+	8, 16, 24, 32,
+};
+
+static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	int ret, i, bits;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		bits = dai->driver->playback.sig_bits;
+	else
+		bits = dai->driver->capture.sig_bits;
+
+	if (!bits)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
+		ret = snd_pcm_hw_constraint_msbits(substream->runtime,
+						   0, sample_sizes[i],
+						   bits);
+		if (ret != 0)
+			dev_warn(dai->dev,
+				 "Failed to set MSB %d/%d: %d\n",
+				 bits, sample_sizes[i], ret);
+	}
+}
+
+/*
  * Called by ALSA when a PCM substream is opened, the runtime->hw record is
  * then initialized and any private data can be allocated. This also calls
  * startup for the cpu DAI, platform, machine and codec DAI.
@@ -187,6 +220,9 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto config_err;
 	}
 
+	soc_pcm_apply_msb(substream, codec_dai);
+	soc_pcm_apply_msb(substream, cpu_dai);
+
 	/* Symmetry only applies if we've already got an active stream. */
 	if (cpu_dai->active) {
 		ret = soc_pcm_apply_symmetry(substream, cpu_dai);
-- 
1.7.8.3
