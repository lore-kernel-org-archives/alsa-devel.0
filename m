From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: glk: Add DAI links for
	Multi-Playback
Date: Wed,  4 Apr 2018 10:16:58 +0530
Message-ID: <1522817219-3750-5-git-send-email-naveen.m@intel.com>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 77AE626762F
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 06:47:48 +0200 (CEST)
In-Reply-To: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Add new FE DAI link to support: Parallel playback on 2 ports simultaneously

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 7725aa1..5ead754 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -51,6 +51,7 @@ struct bxt_card_private {
 enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
+	BXT_DPCM_AUDIO_HS_PB,
 	BXT_DPCM_AUDIO_REF_CP,
 	BXT_DPCM_AUDIO_DMIC_CP,
 	BXT_DPCM_AUDIO_HDMI1_PB,
@@ -571,6 +572,17 @@ static struct snd_soc_dai_link geminilake_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &broxton_da7219_fe_ops,
 	},
+	[BXT_DPCM_AUDIO_HS_PB] = {
+		.name = "Bxt Audio Headset Playback",
+		.stream_name = "Headset Playback",
+		.cpu_dai_name = "System Pin2",
+		.platform_name = "0000:00:0e.0",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.dpcm_playback = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
 	[BXT_DPCM_AUDIO_REF_CP] = {
 		.name = "Bxt Audio Reference cap",
 		.stream_name = "Refcap",
-- 
2.7.4
