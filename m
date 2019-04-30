From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/19] ASoC: SOF: Intel: cnl: add pointer ops
	to use DPIB position
Date: Tue, 30 Apr 2019 18:09:19 -0500
Message-ID: <20190430230934.4321-5-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79D02F80C0D
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:58 +0200 (CEST)
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

Add .pcm_pointer ops for cannonlake to read DPIB/posbuf and get pointer
for ALSA, to align with apollolake.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/cnl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 3e95c1e5e491..36ae9b88d0dc 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -199,6 +199,7 @@ const struct snd_sof_dsp_ops sof_cnl_ops = {
 	.pcm_close	= hda_dsp_pcm_close,
 	.pcm_hw_params	= hda_dsp_pcm_hw_params,
 	.pcm_trigger	= hda_dsp_pcm_trigger,
+	.pcm_pointer	= hda_dsp_pcm_pointer,
 
 	/* firmware loading */
 	.load_firmware = snd_sof_load_firmware_raw,
-- 
2.17.1
