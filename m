From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320dac33: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:22:58 +0900
Message-ID: <E1aaatm-00084b-AI@finisterre>
References: <1456765684-5717-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B4E265B83
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:23:16 +0100 (CET)
In-Reply-To: <1456765684-5717-5-git-send-email-tiwai@suse.de>
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

   ASoC: tlv320dac33: Fix enum ctl accesses in a wrong type

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

>From 8733f99c23726532918034f4ae599d9e6d27bd1e Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:08:03 +0100
Subject: [PATCH] ASoC: tlv320dac33: Fix enum ctl accesses in a wrong type

"FIFO Mode" ctl in tlv320dac33 codec driver is enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320dac33.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 781398fb2841..f7a6ce7e5fb1 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -446,7 +446,7 @@ static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = dac33->fifo_mode;
+	ucontrol->value.enumerated.item[0] = dac33->fifo_mode;
 
 	return 0;
 }
@@ -458,17 +458,16 @@ static int dac33_set_fifo_mode(struct snd_kcontrol *kcontrol,
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (dac33->fifo_mode == ucontrol->value.integer.value[0])
+	if (dac33->fifo_mode == ucontrol->value.enumerated.item[0])
 		return 0;
 	/* Do not allow changes while stream is running*/
 	if (snd_soc_codec_is_active(codec))
 		return -EPERM;
 
-	if (ucontrol->value.integer.value[0] < 0 ||
-	    ucontrol->value.integer.value[0] >= DAC33_FIFO_LAST_MODE)
+	if (ucontrol->value.enumerated.item[0] >= DAC33_FIFO_LAST_MODE)
 		ret = -EINVAL;
 	else
-		dac33->fifo_mode = ucontrol->value.integer.value[0];
+		dac33->fifo_mode = ucontrol->value.enumerated.item[0];
 
 	return ret;
 }
-- 
2.7.0
