From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: add 88200 and 96000 sampling rate support" to the asoc tree
Date: Wed, 31 Jul 2019 12:29:51 +0100 (BST)
Message-ID: <20190731112951.80FD42742CDE@ypsilon.sirena.org.uk>
References: <20190731074156.5620-1-chunguo.feng@amlogic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731074156.5620-1-chunguo.feng@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alsa-devel@alsa-project.org, bleung@chromium.org, broonie@kernel.org, chunguo.feng@amlogic.com, grundler@chromium.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, pierre-louis.bossart@linux.intel.com, RyanS.Lee@maximintegrated.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: add 88200 and 96000 sampling rate support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b9da500bde81ad820b5d95c6bf52fc33e1f490ee Mon Sep 17 00:00:00 2001
From: fengchunguo <chunguo.feng@amlogic.com>
Date: Wed, 31 Jul 2019 15:41:56 +0800
Subject: [PATCH] ASoC: max98373: add 88200 and 96000 sampling rate support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

88200 and 96000 sampling rate was not enabled on driver, so can't be played.

The error information:
max98373 3-0031：rate 96000 not supported
max98373 3-0031：ASoC: can't set max98373-aif1 hw params: -22

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
Link: https://lore.kernel.org/r/20190731074156.5620-1-chunguo.feng@amlogic.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
