From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/15] ASoC: SOF: Intel: hda: save handle to
	sdev in sof_intel_hda_stream
Date: Wed, 12 Jun 2019 12:23:33 -0500
Message-ID: <20190612172347.22338-2-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D18E2F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:23:54 +0200 (CEST)
In-Reply-To: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add a snd_sof_dev member to sof_intel_hda_stream. This will be
used to access the snd_sof_dev during link hw_params callback.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
