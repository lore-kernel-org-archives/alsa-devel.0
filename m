From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da732x: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:23:28 +0900
Message-ID: <E1aaauG-00086h-GZ@finisterre>
References: <1456765482-5599-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2E6265703
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:23:48 +0100 (CET)
In-Reply-To: <1456765482-5599-1-git-send-email-tiwai@suse.de>
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

   ASoC: da732x: Fix enum ctl accesses in a wrong type

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

>From fe9aba13108ee8e15ae59009a26db02460dbb04f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:04:42 +0100
Subject: [PATCH] ASoC: da732x: Fix enum ctl accesses in a wrong type

"DAC1 High Pass Filter Mode" & co in da732x codec driver are enum,
while the current driver accesses wrongly via value.integer.value[].
They have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da732x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 1d5a89c5164b..461506a4ca6a 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -334,7 +334,7 @@ static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg = enum_ctrl->reg;
-	unsigned int sel = ucontrol->value.integer.value[0];
+	unsigned int sel = ucontrol->value.enumerated.item[0];
 	unsigned int bits;
 
 	switch (sel) {
@@ -368,13 +368,13 @@ static int da732x_hpf_get(struct snd_kcontrol *kcontrol,
 
 	switch (val) {
 	case DA732X_HPF_VOICE_EN:
-		ucontrol->value.integer.value[0] = DA732X_HPF_VOICE;
+		ucontrol->value.enumerated.item[0] = DA732X_HPF_VOICE;
 		break;
 	case DA732X_HPF_MUSIC_EN:
-		ucontrol->value.integer.value[0] = DA732X_HPF_MUSIC;
+		ucontrol->value.enumerated.item[0] = DA732X_HPF_MUSIC;
 		break;
 	default:
-		ucontrol->value.integer.value[0] = DA732X_HPF_DISABLED;
+		ucontrol->value.enumerated.item[0] = DA732X_HPF_DISABLED;
 		break;
 	}
 
-- 
2.7.0
