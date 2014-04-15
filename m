From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] ASoC: alc5623: Fix regmap endianness
Date: Tue, 15 Apr 2014 14:37:05 +0200
Message-ID: <1397565425-1746-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E4D0264FFF
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 14:39:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>
List-Id: alsa-devel@alsa-project.org

Commit 0cd257bf9b9b0cbb4fa1a5c988a232506997867c, "ASoC: alc5623:
Convert to direct regmap API usage" broke probing of the codec,
because of wrong endinness of the ID and codec version read from the
device. Fix this by removing the existing flipping of the endiannes,
and extracting the codec type byte from the word from the regmap.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 sound/soc/codecs/alc5623.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index f500905e9373..2acf82f4a08a 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1018,13 +1018,13 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 		dev_err(&client->dev, "failed to read vendor ID1: %d\n", ret);
 		return ret;
 	}
-	vid1 = ((vid1 & 0xff) << 8) | (vid1 >> 8);
 
 	ret = regmap_read(alc5623->regmap, ALC5623_VENDOR_ID2, &vid2);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to read vendor ID2: %d\n", ret);
 		return ret;
 	}
+	vid2 >>= 8;
 
 	if ((vid1 != 0x10ec) || (vid2 != id->driver_data)) {
 		dev_err(&client->dev, "unknown or wrong codec\n");
-- 
1.9.2
