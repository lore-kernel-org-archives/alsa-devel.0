From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/9] ASoC: wm8904: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:11 +0100
Message-ID: <1456765278-5435-3-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AA713261483
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:01:27 +0100 (CET)
In-Reply-To: <1456765278-5435-1-git-send-email-tiwai@suse.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

"DRC Mode" and "EQ Mode" ctls in wm8904 codec driver are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 8172e499e6ed..edd7a7709194 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -396,7 +396,7 @@ static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (value >= pdata->num_drc_cfgs)
 		return -EINVAL;
@@ -467,7 +467,7 @@ static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (value >= pdata->num_retune_mobile_cfgs)
 		return -EINVAL;
-- 
2.7.2
