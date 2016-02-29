From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ASoC: tlv320dac33: Fix enum ctl accesses
	in a wrong type
Date: Mon, 29 Feb 2016 18:08:03 +0100
Message-ID: <1456765684-5717-5-git-send-email-tiwai@suse.de>
References: <1456765684-5717-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A345265483
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:08:06 +0100 (CET)
In-Reply-To: <1456765684-5717-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

"FIFO Mode" ctl in tlv320dac33 codec driver is enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
2.7.2
