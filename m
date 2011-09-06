From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: ad1980: Return proper error if vendor id mismatch
Date: Tue, 06 Sep 2011 10:37:48 +0800
Message-ID: <1315276668.9619.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Roy Huang <roy.huang@analog.com>, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Return -ENODEV instead of 0 if vendor id mismatch.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ad1980.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 923b364..4c0fc30 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -200,18 +200,22 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Read out vendor ID to make sure it is ad1980 */
-	if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144)
+	if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144) {
+		ret = -ENODEV;
 		goto reset_err;
+	}
 
 	vendor_id2 = ac97_read(codec, AC97_VENDOR_ID2);
 
 	if (vendor_id2 != 0x5370) {
-		if (vendor_id2 != 0x5374)
+		if (vendor_id2 != 0x5374) {
+			ret = -ENODEV;
 			goto reset_err;
-		else
+		} else {
 			printk(KERN_WARNING "ad1980: "
 				"Found AD1981 - only 2/2 IN/OUT Channels "
 				"supported\n");
+		}
 	}
 
 	/* unmute captures and playbacks volume */
-- 
1.7.4.1
