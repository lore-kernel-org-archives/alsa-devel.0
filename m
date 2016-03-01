From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8904: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:21:46 +0900
Message-ID: <E1aaasc-000835-Mj@finisterre>
References: <1456765278-5435-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C461A261483
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:22:55 +0100 (CET)
In-Reply-To: <1456765278-5435-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8904: Fix enum ctl accesses in a wrong type

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

>From c41a024c4e770fff999f4164cc4d1696e5f17437 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:01:11 +0100
Subject: [PATCH] ASoC: wm8904: Fix enum ctl accesses in a wrong type

"DRC Mode" and "EQ Mode" ctls in wm8904 codec driver are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 8172e499e6ed..edd7a7709194 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -396,7 +396,7 @@ static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (value >= pdata->num_drc_cfgs)
 		return -EINVAL;
@@ -467,7 +467,7 @@ static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (value >= pdata->num_retune_mobile_cfgs)
 		return -EINVAL;
-- 
2.7.0
