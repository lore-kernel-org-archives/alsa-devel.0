From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 7/7] ASoC: core: mark expected switch fall-through
Date: Fri, 3 Aug 2018 11:34:30 -0500
Message-ID: <9d6ffc4ad5ecbd4287f5787e66aadc70f9168c2f.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 146568 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 82eb386..9cfe10d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -528,6 +528,7 @@ int snd_soc_suspend(struct device *dev)
 						"ASoC: idle_bias_off CODEC on over suspend\n");
 					break;
 				}
+				/* fall through */
 
 			case SND_SOC_BIAS_OFF:
 				if (component->driver->suspend)
-- 
2.7.4
