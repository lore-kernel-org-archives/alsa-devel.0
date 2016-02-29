From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/9] ASoC: wm8994: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:15 +0100
Message-ID: <1456765278-5435-7-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D79102625D7
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

The DRC Mode like "AIF1DRC1 Mode" and EQ Mode like "AIF1.1 EQ Mode" in
wm8994 codec driver are enum ctls, while the current driver accesses
wrongly via value.integer.value[].  They have to be via
value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8994.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2ccbb322df77..a18aecb49935 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -362,7 +362,7 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int drc = wm8994_get_drc(kcontrol->id.name);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (drc < 0)
 		return drc;
@@ -469,7 +469,7 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 
 	if (block < 0)
 		return block;
-- 
2.7.2
