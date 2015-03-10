From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/14] ASoC: ak4641: Fix wrong value references
	for boolean kctl
Date: Tue, 10 Mar 2015 12:39:04 +0100
Message-ID: <1425987556-569-3-git-send-email-tiwai@suse.de>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 040392615C0
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
 sound/soc/codecs/ak4641.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 70861c7b1631..81b54a270bd8 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -76,7 +76,7 @@ static int ak4641_put_deemph(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
-	int deemph = ucontrol->value.enumerated.item[0];
+	int deemph = ucontrol->value.integer.value[0];
 
 	if (deemph > 1)
 		return -EINVAL;
@@ -92,7 +92,7 @@ static int ak4641_get_deemph(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.enumerated.item[0] = ak4641->deemph;
+	ucontrol->value.integer.value[0] = ak4641->deemph;
 	return 0;
 };
 
-- 
2.3.2
