From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/9] ASoC: wm8753: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:10 +0100
Message-ID: <1456765278-5435-2-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B3DFA26149E
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

"DAI Mode" ctl in wm8753 codec driver is enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8753.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 61299ca372ff..6f1024f48b19 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -233,7 +233,7 @@ static int wm8753_get_dai(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = wm8753->dai_func;
+	ucontrol->value.enumerated.item[0] = wm8753->dai_func;
 	return 0;
 }
 
@@ -244,7 +244,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 ioctl;
 
-	if (wm8753->dai_func == ucontrol->value.integer.value[0])
+	if (wm8753->dai_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
 	if (snd_soc_codec_is_active(codec))
@@ -252,7 +252,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 
 	ioctl = snd_soc_read(codec, WM8753_IOCTL);
 
-	wm8753->dai_func = ucontrol->value.integer.value[0];
+	wm8753->dai_func = ucontrol->value.enumerated.item[0];
 
 	if (((ioctl >> 2) & 0x3) == wm8753->dai_func)
 		return 1;
-- 
2.7.2
