From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/17] ASoC: twl6040: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 15 Jan 2015 12:52:07 +0100
Message-ID: <1421322737-19077-8-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 951272605A6
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:24 +0100 (CET)
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
 sound/soc/codecs/twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 90f47f9..aeec27b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -234,7 +234,7 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	u8 hslctl, hsrctl;
 
 	/*
@@ -261,7 +261,7 @@ static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 static int twl6040_ep_drv_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-- 
1.8.0
