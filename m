From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ASoC: dapm: set power_check callback for
	widgets that shouldnt be always on
Date: Fri,  1 Mar 2019 19:08:53 -0600
Message-ID: <20190302010853.18115-4-pierre-louis.bossart@linux.intel.com>
References: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C01AFF896DF
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 02:09:08 +0100 (CET)
In-Reply-To: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
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

Currently, buffers, schedulers, src's, encoders, decoders
and effect type dapm widgets remain always on as their
power_check method is not set. Setting this callback allows these
widgets in the audio path to be powered managed properly.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dapm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef6d161..4bc31b91fded 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3650,6 +3650,13 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_pga:
+	case snd_soc_dapm_buffer:
+	case snd_soc_dapm_scheduler:
+	case snd_soc_dapm_effect:
+	case snd_soc_dapm_src:
+	case snd_soc_dapm_asrc:
+	case snd_soc_dapm_encoder:
+	case snd_soc_dapm_decoder:
 	case snd_soc_dapm_out_drv:
 	case snd_soc_dapm_micbias:
 	case snd_soc_dapm_line:
-- 
2.17.1
