From: chunguo feng <chunguo.feng@amlogic.com>
Subject: [PATCH] ASoC: max98383: add  88200 and 96000 sampling rate support
Date: Wed, 31 Jul 2019 13:40:03 +0800
Message-ID: <20190731054003.16076-1-chunguo.feng@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, RyanS.Lee@maximintegrated.com, bleung@chromium.org, pierre-louis.bossart@linux.intel.com, grundler@chromium.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chunguo.feng@amlogic.com
List-Id: alsa-devel@alsa-project.org

From: fengchunguo <chunguo.feng@amlogic.com>

88200 and 96000 sampling rate was not enabled on driver, so can't be played.

The error information:
max98373 3-0031：rate 96000 not supported
max98373 3-0031：ASoC: can't set max98373-aif1 hw params: -22

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
---
 sound/soc/codecs/max98373.c | 6 ++++++
 sound/soc/codecs/max98373.h | 2 ++
 2 files changed, 8 insertions(+)
 mode change 100644 => 100755 sound/soc/codecs/max98373.c
 mode change 100644 => 100755 sound/soc/codecs/max98373.h

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
old mode 100644
new mode 100755
index 528695cd6a1c..8c601a3ebc27
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -267,6 +267,12 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 	case 48000:
 		sampling_rate = MAX98373_PCM_SR_SET1_SR_48000;
 		break;
+	case 88200:
+		sampling_rate = MAX98373_PCM_SR_SET1_SR_88200;
+		break;
+	case 96000:
+		sampling_rate = MAX98373_PCM_SR_SET1_SR_96000;
+		break;
 	default:
 		dev_err(component->dev, "rate %d not supported\n",
 			params_rate(params));
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
old mode 100644
new mode 100755
index f6a37aa02f26..a59e51355a84
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -130,6 +130,8 @@
 #define MAX98373_PCM_SR_SET1_SR_32000 (0x6 << 0)
 #define MAX98373_PCM_SR_SET1_SR_44100 (0x7 << 0)
 #define MAX98373_PCM_SR_SET1_SR_48000 (0x8 << 0)
+#define MAX98373_PCM_SR_SET1_SR_88200 (0x9 << 0)
+#define MAX98373_PCM_SR_SET1_SR_96000 (0xA << 0)
 
 /* MAX98373_R2028_PCM_SR_SETUP_2 */
 #define MAX98373_PCM_SR_SET2_SR_MASK (0xF << 4)
-- 
2.22.0
