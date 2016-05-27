From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v3 5/5] ASoC: Intel: Skylake: Use refcap device
	for mono recording
Date: Thu, 26 May 2016 21:31:16 -0700
Message-ID: <1464323476-28957-1-git-send-email-yong.zhi@intel.com>
References: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 36164265568
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2016 06:28:27 +0200 (CEST)
In-Reply-To: <1464182357-1305-1-git-send-email-yong.zhi@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, yang.a.fang@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Only mono channel is allowed for refcap device.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index d4e174f..d151f1f 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -401,8 +401,22 @@ static struct snd_pcm_hw_constraint_list constraints_16000 = {
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
