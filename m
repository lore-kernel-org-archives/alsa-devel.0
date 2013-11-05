From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/31] ASoC: wm5100: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:55 +0100
Message-ID: <1383673218-18405-9-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 134982651E3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm5100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index ac1745d030d6..4cf91deabc02 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1972,7 +1972,8 @@ static void wm5100_set_detect_mode(struct wm5100_priv *wm5100, int the_mode)
 {
 	struct wm5100_jack_mode *mode = &wm5100->pdata.jack_modes[the_mode];
 
-	BUG_ON(the_mode >= ARRAY_SIZE(wm5100->pdata.jack_modes));
+	if (WARN_ON(the_mode >= ARRAY_SIZE(wm5100->pdata.jack_modes)))
+		return;
 
 	gpio_set_value_cansleep(wm5100->pdata.hp_pol, mode->hp_pol);
 	regmap_update_bits(wm5100->regmap, WM5100_ACCESSORY_DETECT_MODE_1,
-- 
1.8.4.2
