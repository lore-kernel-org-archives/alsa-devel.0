From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH 2/2] ASoC: SOF: Intel: fix reset of
	host_period_bytes
Date: Tue,  2 Jul 2019 20:11:44 +0800
Message-ID: <20190702121144.7809-2-yang.jie@linux.intel.com>
References: <20190702121144.7809-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67A9EF80058
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 14:06:36 +0200 (CEST)
In-Reply-To: <20190702121144.7809-1-yang.jie@linux.intel.com>
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
Cc: marcin.rajwa@intel.com, Keyon Jie <yang.jie@linux.intel.com>, ranjani.sridharan@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Marcin Rajwa <marcin.rajwa@linux.intel.com>

This patch prevents the reset of host period bytes.
The parameter has been used to keep information about
completion of period copy. Right now we keep this
information in period_irq.

Signed-off-by: Marcin Rajwa <marcin.rajwa@linux.intel.com>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 sound/soc/sof/intel/hda-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index 9b730f183529..c7022346aba0 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -116,9 +116,9 @@ int hda_dsp_pcm_hw_params(struct snd_sof_dev *sdev,
 	/* disable SPIB, to enable buffer wrap for stream */
 	hda_dsp_stream_spib_config(sdev, stream, HDA_DSP_SPIB_DISABLE, 0);
 
-	/* set host_period_bytes to 0 if no IPC position */
+	/* update no_period_irq flag for ipc params */
 	if (hda && hda->no_ipc_position)
-		ipc_params->host_period_bytes = 0;
+		ipc_params->no_period_irq = 1;
 
 	ipc_params->stream_tag = hstream->stream_tag;
 
-- 
2.20.1
