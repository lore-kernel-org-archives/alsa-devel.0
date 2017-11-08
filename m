From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 4/7] ASoC: tpa6130a2: mark expected switch fall-through
Date: Wed, 8 Nov 2017 14:04:22 -0600
Message-ID: <e577b0ab7a298e7261f3297f6f7a495aa72e88e3.1510170034.git.garsilva@embeddedor.com>
References: <cover.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1510170034.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115164
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/tpa6130a2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 2e014c8..616cd4b 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -274,6 +274,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	default:
 		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
 			 data->id);
+		/* fall through */
 	case TPA6130A2:
 		regulator = "Vdd";
 		break;
-- 
2.7.4
