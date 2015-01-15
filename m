From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/17] ASoC: alc5632: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:09 +0100
Message-ID: <1421322737-19077-10-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C23A260600
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:25 +0100 (CET)
In-Reply-To: <1421322737-19077-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/alc5632.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 0763026..db3283a 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -116,18 +116,20 @@ static inline int alc5632_reset(struct regmap *map)
 static int amp_mixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	/* to power-on/off class-d amp generators/speaker */
 	/* need to write to 'index-46h' register :        */
 	/* so write index num (here 0x46) to reg 0x6a     */
 	/* and then 0xffff/0 to reg 0x6c                  */
-	snd_soc_write(w->codec, ALC5632_HID_CTRL_INDEX, 0x46);
+	snd_soc_write(codec, ALC5632_HID_CTRL_INDEX, 0x46);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_write(w->codec, ALC5632_HID_CTRL_DATA, 0xFFFF);
+		snd_soc_write(codec, ALC5632_HID_CTRL_DATA, 0xFFFF);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_write(w->codec, ALC5632_HID_CTRL_DATA, 0);
+		snd_soc_write(codec, ALC5632_HID_CTRL_DATA, 0);
 		break;
 	}
 
-- 
1.8.0
