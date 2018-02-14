From: Mark Brown <broonie@kernel.org>
Subject: Applied "sgtl5000: change digital_mute policy" to the
	asoc tree
Date: Wed, 14 Feb 2018 15:37:55 +0000
Message-ID: <E1elz87-0003qc-OG@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F919267194
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 16:37:56 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Oleszczyk <oleszczyk.m@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   sgtl5000: change digital_mute policy

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c5489f9fc053c744c609f34b32efca395cc2fdad Mon Sep 17 00:00:00 2001
From: Michal Oleszczyk <oleszczyk.m@gmail.com>
Date: Fri, 2 Feb 2018 13:10:29 +0100
Subject: [PATCH] sgtl5000: change digital_mute policy

Current implementation mute codec in global way (DAC block).
That means when user routes sound not from I2S but from
AUX source (LINE_IN) it also will be muted by alsa core.
This should not happen.

Signed-off-by: Michal Oleszczyk <oleszczyk.m@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index e1ab5537d27a..c445a0794a27 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -529,10 +529,15 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 static int sgtl5000_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 adcdac_ctrl = SGTL5000_DAC_MUTE_LEFT | SGTL5000_DAC_MUTE_RIGHT;
+	u16 i2s_pwr = SGTL5000_I2S_IN_POWERUP;
 
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL,
-			adcdac_ctrl, mute ? adcdac_ctrl : 0);
+	/*
+	 * During 'digital mute' do not mute DAC
+	 * because LINE_IN would be muted aswell. We want to mute
+	 * only I2S block - this can be done by powering it off
+	 */
+	snd_soc_update_bits(codec, SGTL5000_CHIP_DIG_POWER,
+			i2s_pwr, mute ? 0 : i2s_pwr);
 
 	return 0;
 }
@@ -1237,6 +1242,10 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	 */
 	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
 
+	/* Unmute DAC after start */
+	snd_soc_update_bits(codec, SGTL5000_CHIP_ADCDAC_CTRL,
+		SGTL5000_DAC_MUTE_LEFT | SGTL5000_DAC_MUTE_RIGHT, 0);
+
 	return 0;
 
 err:
-- 
2.16.1
