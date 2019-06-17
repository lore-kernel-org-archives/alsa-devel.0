From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: save handle to sdev in
	sof_intel_hda_stream" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:29 +0100 (BST)
Message-ID: <20190617152429.6281A440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35825F8972F
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:30 +0200 (CEST)
In-Reply-To: <20190612172347.22338-2-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Intel: hda: save handle to sdev in sof_intel_hda_stream

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

>From 7623ae793c28cc0928c5d1292542dbb92fc2e9e2 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:33 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: save handle to sdev in
 sof_intel_hda_stream

Add a snd_sof_dev member to sof_intel_hda_stream. This will be
used to access the snd_sof_dev during link hw_params callback.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-stream.c | 4 ++++
 sound/soc/sof/intel/hda.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index c92006f89499..1cd94e7631a8 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -564,6 +564,8 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 		if (!hda_stream)
 			return -ENOMEM;
 
+		hda_stream->sdev = sdev;
+
 		stream = &hda_stream->hda_stream;
 
 		stream->pphc_addr = sdev->bar[HDA_DSP_PP_BAR] +
@@ -617,6 +619,8 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 		if (!hda_stream)
 			return -ENOMEM;
 
+		hda_stream->sdev = sdev;
+
 		stream = &hda_stream->hda_stream;
 
 		/* we always have DSP support */
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 6c7dee2627d0..502b0a3c2e3c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -409,6 +409,7 @@ static inline struct hda_bus *sof_to_hbus(struct snd_sof_dev *s)
 }
 
 struct sof_intel_hda_stream {
+	struct snd_sof_dev *sdev;
 	struct hdac_ext_stream hda_stream;
 	struct sof_intel_stream stream;
 	int hw_params_upon_resume; /* set up hw_params upon resume */
-- 
2.20.1
