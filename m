From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:21:49 +0900
Message-ID: <E1aaasf-00083Z-CS@finisterre>
References: <1456765278-5435-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4E08265142
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:22:30 +0100 (CET)
In-Reply-To: <1456765278-5435-2-git-send-email-tiwai@suse.de>
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

   ASoC: wm8753: Fix enum ctl accesses in a wrong type

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

>From 0cad10539b281e88335afd765afaf9885dcfc3ef Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:01:10 +0100
Subject: [PATCH] ASoC: wm8753: Fix enum ctl accesses in a wrong type

"DAI Mode" ctl in wm8753 codec driver is enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8753.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 61299ca372ff..6f1024f48b19 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -233,7 +233,7 @@ static int wm8753_get_dai(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = wm8753->dai_func;
+	ucontrol->value.enumerated.item[0] = wm8753->dai_func;
 	return 0;
 }
 
@@ -244,7 +244,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 ioctl;
 
-	if (wm8753->dai_func == ucontrol->value.integer.value[0])
+	if (wm8753->dai_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
 	if (snd_soc_codec_is_active(codec))
@@ -252,7 +252,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 
 	ioctl = snd_soc_read(codec, WM8753_IOCTL);
 
-	wm8753->dai_func = ucontrol->value.integer.value[0];
+	wm8753->dai_func = ucontrol->value.enumerated.item[0];
 
 	if (((ioctl >> 2) & 0x3) == wm8753->dai_func)
 		return 1;
-- 
2.7.0
