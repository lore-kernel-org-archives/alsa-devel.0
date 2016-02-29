From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/9] ASoC: wm8996: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:16 +0100
Message-ID: <1456765278-5435-8-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E98DE26510B
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

"DSP1 EQ Mode" and "DSP2 EQ Mode" ctls in wm8996 codec driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8996.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8d7d6c01a2f7..f99b34f7647b 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -416,7 +416,7 @@ static int wm8996_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	struct wm8996_pdata *pdata = &wm8996->pdata;
 	int block = wm8996_get_retune_mobile_block(kcontrol->id.name);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (block < 0)
 		return block;
-- 
2.7.2
