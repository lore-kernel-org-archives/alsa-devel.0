From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: Fix uninitialized warning in rt5665_i2s_pin_event()" to the asoc tree
Date: Wed, 17 May 2017 10:53:30 +0100
Message-ID: <E1dAve6-00076A-Fz@debutante>
References: <1494837239-2479-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494837239-2479-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: Fix uninitialized warning in rt5665_i2s_pin_event()

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

>From b98ae9ad559fea64dee5fcc8e3ba4bf936ceb5e6 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 May 2017 10:33:59 +0200
Subject: [PATCH] ASoC: rt5665: Fix uninitialized warning in
 rt5665_i2s_pin_event()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc 4.1.2:

    sound/soc/codecs/rt5665.c: In function ‘rt5665_i2s_pin_event’:
    sound/soc/codecs/rt5665.c:2610: warning: ‘mask1’ may be used uninitialized in this function
    sound/soc/codecs/rt5665.c:2610: warning: ‘val2’ may be used uninitialized in this function
    sound/soc/codecs/rt5665.c:2610: warning: ‘val1’ may be used uninitialized in this function

The first one is currently a false positive, as rt5665_i2s_pin_event()
is never called with snd_soc_dapm_widget.shift set to a value not
handled by the switch() statement.  But that may change, so
preinitialize mask1 to fix this, like is already done for mask2.

The last two are false-positives, the compiler is just not smart enough
to notice the mask and val variables are always used together.

Fixes: 9b5d3865b3b410d2 ("ASoC: rt5665: set i2s pin share configuration")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 26bf157ca293..c0f36d85ee4d 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2607,7 +2607,7 @@ static int rt5665_i2s_pin_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	unsigned int val1, val2, mask1, mask2 = 0;
+	unsigned int val1, val2, mask1 = 0, mask2 = 0;
 
 	switch (w->shift) {
 	case RT5665_PWR_I2S2_1_BIT:
@@ -2635,13 +2635,17 @@ static int rt5665_i2s_pin_event(struct snd_soc_dapm_widget *w,
 	}
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, RT5665_GPIO_CTRL_1, mask1, val1);
+		if (mask1)
+			snd_soc_update_bits(codec, RT5665_GPIO_CTRL_1,
+					    mask1, val1);
 		if (mask2)
 			snd_soc_update_bits(codec, RT5665_GPIO_CTRL_2,
 					    mask2, val2);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, RT5665_GPIO_CTRL_1, mask1, 0);
+		if (mask1)
+			snd_soc_update_bits(codec, RT5665_GPIO_CTRL_1,
+					    mask1, 0);
 		if (mask2)
 			snd_soc_update_bits(codec, RT5665_GPIO_CTRL_2,
 					    mask2, 0);
-- 
2.11.0
