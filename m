From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 8/9] ASoC: Intel: Skylake: Add multichannel
	support for HDMI
Date: Thu, 14 Apr 2016 10:07:35 +0530
Message-ID: <1460608656-8860-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB7E26655A
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 06:38:50 +0200 (CEST)
In-Reply-To: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Channel max is changed to 8 from stereo to support multichannel
capability for HDMI devices.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index dab0900..8de9212 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -51,7 +51,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 	.rate_min =		8000,
 	.rate_max =		48000,
 	.channels_min =		1,
-	.channels_max =		HDA_QUAD,
+	.channels_max =		8,
 	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
 	.period_bytes_min =	128,
 	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
@@ -682,7 +682,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "HDMI1 Playback",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
@@ -697,7 +697,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "HDMI2 Playback",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
@@ -712,7 +712,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "HDMI3 Playback",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_32000 |	SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
@@ -765,7 +765,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "iDisp1 Tx",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
 			SNDRV_PCM_FMTBIT_S24_LE,
@@ -777,7 +777,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "iDisp2 Tx",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
 			SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
@@ -790,7 +790,7 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	.playback = {
 		.stream_name = "iDisp3 Tx",
 		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|
 			SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE |
-- 
1.9.1
