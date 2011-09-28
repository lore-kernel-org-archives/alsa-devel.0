From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/6] ASoC: Remove unused "control_data" field of struct
 alc5623_priv
Date: Wed, 28 Sep 2011 10:01:26 +0800
Message-ID: <1317175286.14102.2.camel@phoenix>
References: <1317175218.14102.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317175218.14102.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

The control_data field is used to initialize the codec's control_data field,
but since this is also done by the snd-soc-cache core, the redundant
assignment can be removed and the field can be dropped.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5623.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 0517315..557b3af 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -40,7 +40,6 @@ MODULE_PARM_DESC(caps_charge, "ALC5623 cap charge time (msecs)");
 /* codec private data */
 struct alc5623_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	u8 id;
 	unsigned int sysclk;
 	u16 reg_cache[ALC5623_VENDOR_ID2+2];
@@ -1049,7 +1048,6 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, alc5623);
-	alc5623->control_data = client;
 	alc5623->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&client->dev,
-- 
1.7.4.1
