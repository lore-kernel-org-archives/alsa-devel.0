From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/19] ASoC: SOF: Intel: hda-stream: store
	stream capabilities
Date: Tue, 30 Apr 2019 18:09:29 -0500
Message-ID: <20190430230934.4321-15-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6A70F89726
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:05 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

Add stream_max into struct sof_intel_hda_dev to store the total hda
stream number that the platform can support, and initialize it at
stream_init.

This can be used later e.g. for stream bitmask.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 4 ++++
 sound/soc/sof/intel/hda.h        | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 47eff161c60e..39f4212bde4b 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -500,6 +500,7 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 	struct hdac_ext_stream *stream;
 	struct hdac_stream *hstream;
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	struct sof_intel_hda_dev *sof_hda = bus_to_sof_hda(bus);
 	int sd_offset;
 	int i, num_playback, num_capture, num_total, ret;
 	u32 gcap;
@@ -657,6 +658,9 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 		list_add_tail(&hstream->list, &bus->stream_list);
 	}
 
+	/* store total stream count (playback + capture) from GCAP */
+	sof_hda->stream_max = num_total;
+
 	return 0;
 }
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 3799a3518106..7cb2fb92c4eb 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -383,6 +383,9 @@ struct sof_intel_hda_dev {
 	/* if position update IPC needed */
 	u32 no_ipc_position;
 
+	/* the maximum number of streams (playback + capture) supported */
+	u32 stream_max;
+
 	int irq;
 
 	/* DMIC device */
-- 
2.17.1
