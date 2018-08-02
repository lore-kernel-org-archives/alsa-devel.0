From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v2] ASoC: Intel: bxt: Use refcap device for
	mono recording
Date: Thu,  2 Aug 2018 18:21:31 -0500
Message-ID: <1533252091-31918-1-git-send-email-yong.zhi@intel.com>
References: <1533143039-5428-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 32E452677D8
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 01:21:45 +0200 (CEST)
In-Reply-To: <1533143039-5428-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, vkoul@kernel.org, naveen.m@intel.com, jenny.tc@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

The refcap capture device supports mono recording only, this patch
adds the channel constraints.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
Changes since v1:
- Remove renaming of "Refcap".
- Add Reviewed-by tag.

 sound/soc/intel/boards/bxt_da7219_max98357a.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index be6e4b40bf03..6f052fc8d1e2 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -324,8 +324,22 @@ static const struct snd_pcm_hw_constraint_list constraints_16000 = {
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
 static int broxton_refcap_startup(struct snd_pcm_substream *substream)
 {
+	substream->runtime->hw.channels_max = 1;
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_refcap);
+
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE,
 			&constraints_16000);
-- 
2.7.4
