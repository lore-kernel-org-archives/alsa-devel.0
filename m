From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8994: Fix enum ctl accesses in a wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:19:58 +0900
Message-ID: <E1aaaqs-00080d-Or@finisterre>
References: <1456765278-5435-7-git-send-email-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1456765278-5435-7-git-send-email-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8994: Fix enum ctl accesses in a wrong type

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

>From 8019c0b37cd5a87107808300a496388b777225bf Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:01:15 +0100
Subject: [PATCH] ASoC: wm8994: Fix enum ctl accesses in a wrong type

The DRC Mode like "AIF1DRC1 Mode" and EQ Mode like "AIF1.1 EQ Mode" in
wm8994 codec driver are enum ctls, while the current driver accesses
wrongly via value.integer.value[].  They have to be via
value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm8994.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2ccbb322df77..a18aecb49935 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -362,7 +362,7 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int drc = wm8994_get_drc(kcontrol->id.name);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (drc < 0)
 		return drc;
@@ -469,7 +469,7 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (block < 0)
 		return block;
-- 
2.7.0
