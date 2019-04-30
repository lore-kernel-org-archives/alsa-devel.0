From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/19] ASoC: SOF: Intel: use
	snd_sof_pcm_period_elapsed
Date: Tue, 30 Apr 2019 18:09:26 -0500
Message-ID: <20190430230934.4321-12-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98DF2F89720
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:03 +0200 (CEST)
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

Switch to a wrapper function which schedules the actual call of
snd_pcm_period_elapsed after the current IPC is completed.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 6290b2df5e62..47eff161c60e 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -465,8 +465,8 @@ irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
 {
 	struct hdac_bus *bus = context;
 	struct sof_intel_hda_dev *sof_hda = bus_to_sof_hda(bus);
-	struct hdac_stream *s;
 	u32 status = snd_hdac_chip_readl(bus, INTSTS);
+	struct hdac_stream *s;
 	u32 sd_status;
 
 	/* check streams */
@@ -486,7 +486,7 @@ irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
 
 			/* Inform ALSA only in case not do that with IPC */
 			if (sof_hda->no_ipc_position)
-				snd_pcm_period_elapsed(s->substream);
+				snd_sof_pcm_period_elapsed(s->substream);
 
 		}
 	}
-- 
2.17.1
