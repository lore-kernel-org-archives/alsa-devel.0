From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: wm8994: Fix missing break in switch
Date: Mon, 6 Aug 2018 07:14:51 -0500
Message-ID: <20180806121451.GA14954@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Add missing break statement in order to prevent the code from falling
through to the default case.

Cc: stable@vger.kernel.org
Addresses-Coverity-ID: 115050 ("Missing break in switch")
Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 62f8c5b..14f1b0c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2432,7 +2432,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
 					    WM8994_OPCLK_ENA, 0);
 		}
-		/* fall through */
+		break;
 
 	default:
 		return -EINVAL;
-- 
2.7.4
