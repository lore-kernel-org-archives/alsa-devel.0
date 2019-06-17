From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: reserve host DMA
	channel for hostless streams" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:24 +0100 (BST)
Message-ID: <20190617152425.03C30440049@finisterre.sirena.org.uk>
References: <20190612172347.22338-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEC12F89736
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:25 +0200 (CEST)
In-Reply-To: <20190612172347.22338-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: reserve host DMA channel for hostless streams

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 6b2239e3337b4c46b850078a6fc8f1a70ebe1c1f Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:37 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: reserve host DMA channel for hostless
 streams

Due to the HW programming sequence requirement that the host
and link DMA channels need to be coupled/decoupled during pcm
hw_params, the host DMA channel corresponding to the link
DMA channel in use for hostless streams needs to be reserved.
This is achieved by adding a host_reserved flag in the
sof_intel_hda_stream structure which is checked when assigning
a host DMA channel.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c    | 11 ++++++++++-
 sound/soc/sof/intel/hda-stream.c | 10 +++++++++-
 sound/soc/sof/intel/hda.h        |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index c270fd7a0878..a514f9cf5c9a 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -75,7 +75,7 @@ static struct hdac_ext_stream *
 
 		hda_stream = hstream_to_sof_hda_stream(hstream);
 
-		/* check if available */
+		/* check if link is available */
 		if (!hstream->link_locked) {
 			if (stream->opened) {
 				/*
@@ -89,6 +89,12 @@ static struct hdac_ext_stream *
 				}
 			} else {
 				res = hstream;
+
+				/*
+				 * This must be a hostless stream.
+				 * So reserve the host DMA channel.
+				 */
+				hda_stream->host_reserved = 1;
 				break;
 			}
 		}
@@ -368,6 +374,9 @@ static int hda_link_hw_free(struct snd_pcm_substream *substream,
 	snd_hdac_ext_stream_release(link_dev, HDAC_EXT_STREAM_TYPE_LINK);
 	link_dev->link_prepared = 0;
 
+	/* free the host DMA channel reserved by hostless streams */
+	hda_stream->host_reserved = 0;
+
 	return 0;
 }
 
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 1cd94e7631a8..a3f7c91469ec 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -155,6 +155,7 @@ struct hdac_ext_stream *
 hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct sof_intel_hda_stream *hda_stream;
 	struct hdac_ext_stream *stream = NULL;
 	struct hdac_stream *s;
 
@@ -163,8 +164,15 @@ hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction)
 	/* get an unused stream */
 	list_for_each_entry(s, &bus->stream_list, list) {
 		if (s->direction == direction && !s->opened) {
-			s->opened = true;
 			stream = stream_to_hdac_ext_stream(s);
+			hda_stream = container_of(stream,
+						  struct sof_intel_hda_stream,
+						  hda_stream);
+			/* check if the host DMA channel is reserved */
+			if (hda_stream->host_reserved)
+				continue;
+
+			s->opened = true;
 			break;
 		}
 	}
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 376b1ca51e2b..2862b4b3b07c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -413,6 +413,7 @@ struct sof_intel_hda_stream {
 	struct hdac_ext_stream hda_stream;
 	struct sof_intel_stream stream;
 	int hw_params_upon_resume; /* set up hw_params upon resume */
+	int host_reserved; /* reserve host DMA channel */
 };
 
 #define hstream_to_sof_hda_stream(hstream) \
-- 
2.20.1
