From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 9/9] ASoC: Intel: Skylake: Add HDMI FE and
	BE cpu dais
Date: Wed, 17 Feb 2016 21:34:07 +0530
Message-ID: <1455725047-7303-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B56AF2654BA
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:04:21 +0100 (CET)
In-Reply-To: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch enables HDMI support in passthrough mode in skylake.
Skylake supports 3 pin widgets in HDMI codec, so add 3 FE and 3
BE dais

Add required hw info, formats, rates to support HDMI.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 78 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index bbb6c28..dab0900 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -676,6 +676,51 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+{
+	.name = "HDMI1 Pin",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "HDMI1 Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "HDMI2 Pin",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "HDMI2 Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "HDMI3 Pin",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "HDMI3 Playback",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
 
 /* BE CPU  Dais */
 {
@@ -715,14 +760,41 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
-	.name = "iDisp Pin",
+	.name = "iDisp1 Pin",
 	.ops = &skl_link_dai_ops,
 	.playback = {
-		.stream_name = "iDisp Tx",
+		.stream_name = "iDisp1 Tx",
 		.channels_min = HDA_STEREO,
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "iDisp2 Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "iDisp2 Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
+			SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "iDisp3 Pin",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "iDisp3 Tx",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
+			SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
 {
-- 
1.9.1
