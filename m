From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 27/32] ASoC: wm8994: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 13:37:43 +0100
Message-ID: <1416746269-4935-27-git-send-email-lars@metafoo.de>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id F0492261683
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 13:38:10 +0100 (CET)
In-Reply-To: <1416746269-4935-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8994.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index dbca6e0..36b767f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4391,8 +4391,6 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
-	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FLL1_LOCK + i,
 				&wm8994->fll_locked[i]);
-- 
1.8.0
