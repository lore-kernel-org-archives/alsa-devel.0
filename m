From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Fix shifts for mixer switches"
	to the asoc tree
Date: Fri, 20 Nov 2015 18:20:26 +0000
Message-ID: <E1ZzqIM-0003vL-PE@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4B5E26664F
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:38 +0100 (CET)
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
To: John Keeping <john@metanate.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Fix shifts for mixer switches

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 113b0b20fc123bc522ded68ea710d789b0415ebe Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Fri, 20 Nov 2015 11:42:22 +0000
Subject: [PATCH] ASoC: es8328: Fix shifts for mixer switches

These are all off by one; the playback and bypass switches are the top
two bits of the registers, which are at shifts 7 and 6 not 8 and 7.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 969e337dc17c..84f5eb07a91b 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -205,18 +205,18 @@ static const struct snd_kcontrol_new es8328_right_line_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 8, 1, 0),
-	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 7, 1, 0),
-	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 8, 1, 0),
-	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 7, 1, 0),
+	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 7, 1, 0),
+	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 6, 1, 0),
+	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 7, 1, 0),
+	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 6, 1, 0),
 };
 
 /* Right Mixer */
 static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 8, 1, 0),
-	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 7, 1, 0),
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 8, 1, 0),
-	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 7, 1, 0),
+	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 7, 1, 0),
+	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 6, 1, 0),
+	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 7, 1, 0),
+	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 6, 1, 0),
 };
 
 static const char * const es8328_pga_sel[] = {
-- 
2.6.2
