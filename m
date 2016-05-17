From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: Add channel
	constraints for refcap
Date: Tue, 17 May 2016 09:43:04 -0700
Message-ID: <1463503385-4535-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B34C265344
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 18:40:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, benzh@chromium.org, vinod.koul@intel.com, marc.herbert@intel.com, yang.a.fang@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Add constraint for ref DMIC to match with the
topology firmware config.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 7cc7251..463f0e5 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -339,8 +339,22 @@ static struct snd_pcm_hw_constraint_list constraints_16000 = {
 	.list  = rates_16000,
 };
 
+static const unsigned int ch_mono[] = {
+	1,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_refcap = {
+	.count = ARRAY_SIZE(ch_mono),
+	.list  = ch_mono,
+};
+
 static int skylake_refcap_startup(struct snd_pcm_substream *substream)
 {
+	substream->runtime->hw.channels_max = 1;
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_CHANNELS,
+					&constraints_refcap);
+
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 				SNDRV_PCM_HW_PARAM_RATE,
 				&constraints_16000);
-- 
1.9.1
