From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/14] ASoC: cs4271: Fix wrong value references
	for boolean kctl
Date: Tue, 10 Mar 2015 12:39:05 +0100
Message-ID: <1425987556-569-4-git-send-email-tiwai@suse.de>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C734C2604F8
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 12:39:23 +0100 (CET)
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
 sound/soc/codecs/cs4271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 79a4efcb894c..7d3a6accaf9a 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -286,7 +286,7 @@ static int cs4271_get_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.enumerated.item[0] = cs4271->deemph;
+	ucontrol->value.integer.value[0] = cs4271->deemph;
 	return 0;
 }
 
@@ -296,7 +296,7 @@ static int cs4271_put_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
-	cs4271->deemph = ucontrol->value.enumerated.item[0];
+	cs4271->deemph = ucontrol->value.integer.value[0];
 	return cs4271_set_deemph(codec);
 }
 
-- 
2.3.2
