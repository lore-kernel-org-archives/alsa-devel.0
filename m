From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/14] ASoC: pcm1681: Fix wrong value
	references for boolean kctl
Date: Tue, 10 Mar 2015 12:39:07 +0100
Message-ID: <1425987556-569-6-git-send-email-tiwai@suse.de>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0482C26164D
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 12:39:24 +0100 (CET)
In-Reply-To: <1425987556-569-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The correct values referred by a boolean control are
value.integer.value[], not value.enumerated.item[].
The former is long while the latter is int, so it's even incompatible
on 64bit architectures.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/pcm1681.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index a722a023c262..477e13d30971 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -118,7 +118,7 @@ static int pcm1681_get_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.enumerated.item[0] = priv->deemph;
+	ucontrol->value.integer.value[0] = priv->deemph;
 
 	return 0;
 }
@@ -129,7 +129,7 @@ static int pcm1681_put_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
 
-	priv->deemph = ucontrol->value.enumerated.item[0];
+	priv->deemph = ucontrol->value.integer.value[0];
 
 	return pcm1681_set_deemph(codec);
 }
-- 
2.3.2
