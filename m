From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 9/9] ASoC: max98927: Changed device property read function
Date: Mon, 28 Aug 2017 16:31:01 -0700
Message-ID: <1503963061-14763-9-git-send-email-ryans.lee@maximintegrated.com>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index f944659..4867f78 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -861,14 +861,14 @@ static void max98927_slot_config(struct i2c_client *i2c,
 	struct max98927_priv *max98927)
 {
 	int value;
+	struct device *dev = &i2c->dev;
 
-	if (!of_property_read_u32(i2c->dev.of_node,
-		"vmon-slot-no", &value))
+	if (!device_property_read_u32(dev, "vmon-slot-no", &value))
 		max98927->v_l_slot = value & 0xF;
 	else
 		max98927->v_l_slot = 0;
-	if (!of_property_read_u32(i2c->dev.of_node,
-		"imon-slot-no", &value))
+
+	if (!device_property_read_u32(dev, "imon-slot-no", &value))
 		max98927->i_l_slot = value & 0xF;
 	else
 		max98927->i_l_slot = 1;
-- 
1.9.1
