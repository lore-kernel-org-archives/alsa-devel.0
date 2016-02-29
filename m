From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/9] ASoC: wm9081: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:17 +0100
Message-ID: <1456765278-5435-9-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E939B2650DA
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

"Speaker Mode "ctl in wm9081 codec driver is enum, while the current
driver accesses wrongly via value.integer.value[].  They have to be
via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm9081.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index ccb3b15139ad..363b3b667616 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -344,9 +344,9 @@ static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 
 	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 	if (reg & WM9081_SPK_MODE)
-		ucontrol->value.integer.value[0] = 1;
+		ucontrol->value.enumerated.item[0] = 1;
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.enumerated.item[0] = 0;
 
 	return 0;
 }
@@ -365,7 +365,7 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 
 	/* Are we changing anything? */
-	if (ucontrol->value.integer.value[0] ==
+	if (ucontrol->value.enumerated.item[0] ==
 	    ((reg2 & WM9081_SPK_MODE) != 0))
 		return 0;
 
@@ -373,7 +373,7 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 	if (reg_pwr & WM9081_SPK_ENA)
 		return -EINVAL;
 
-	if (ucontrol->value.integer.value[0]) {
+	if (ucontrol->value.enumerated.item[0]) {
 		/* Class AB */
 		reg2 &= ~(WM9081_SPK_INV_MUTE | WM9081_OUT_SPK_CTRL);
 		reg2 |= WM9081_SPK_MODE;
-- 
2.7.2
