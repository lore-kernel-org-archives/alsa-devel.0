From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: cs42l51: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:02:59 +0100
Message-ID: <1456765379-5527-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F8A6266017
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:03:01 +0100 (CET)
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
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

"PCM channel mixer" ctl in cs42l51 codec driver is enum, while the
current driver accesses wrongly via value.integer.value[].  They have
to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

like other patchsets, I didn't put Cc to stable.  If this driver is
used for 64bit archs, feel free to put Cc to stable.

 sound/soc/codecs/cs42l51.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index b3951524339f..35488f14e237 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -60,15 +60,15 @@ static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
 	switch (value) {
 	default:
 	case 0:
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.enumerated.item[0] = 0;
 		break;
 	/* same value : (L+R)/2 and (R+L)/2 */
 	case 1:
 	case 2:
-		ucontrol->value.integer.value[0] = 1;
+		ucontrol->value.enumerated.item[0] = 1;
 		break;
 	case 3:
-		ucontrol->value.integer.value[0] = 2;
+		ucontrol->value.enumerated.item[0] = 2;
 		break;
 	}
 
@@ -85,7 +85,7 @@ static int cs42l51_set_chan_mix(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned char val;
 
-	switch (ucontrol->value.integer.value[0]) {
+	switch (ucontrol->value.enumerated.item[0]) {
 	default:
 	case 0:
 		val = CHAN_MIX_NORMAL;
-- 
2.7.2
