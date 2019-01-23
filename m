From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v3 3/3] ASoC: Intel: glk: Add DAI links for
	Multi-Playback
Date: Wed, 23 Jan 2019 10:38:37 -0800
Message-ID: <1548268717-32596-4-git-send-email-yong.zhi@intel.com>
References: <1548268717-32596-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 92AEA2674A8
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 19:44:41 +0100 (CET)
In-Reply-To: <1548268717-32596-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, vkoul@kernel.org, pierre-louis.bossart@linux.intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Add FE DAI link to support parallel playback on 2 ports simultaneously.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3f92665..6d31808 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -50,6 +50,7 @@ struct bxt_card_private {
 enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
+	BXT_DPCM_AUDIO_HS_PB,
 	BXT_DPCM_AUDIO_REF_CP,
 	BXT_DPCM_AUDIO_DMIC_CP,
 	BXT_DPCM_AUDIO_HDMI1_PB,
@@ -404,6 +405,20 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &broxton_da7219_fe_ops,
 	},
+	[BXT_DPCM_AUDIO_HS_PB] = {
+		.name = "Bxt Audio Headset Playback",
+		.stream_name = "Headset Playback",
+		.cpu_dai_name = "System Pin2",
+		.platform_name = "0000:00:0e.0",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+		.ops = &broxton_da7219_fe_ops,
+	},
 	[BXT_DPCM_AUDIO_REF_CP] =
 	{
 		.name = "Bxt Audio Reference cap",
-- 
2.7.4
