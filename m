From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove unused control_data and mutex
 fields from struct alc5632_priv
Date: Sun, 13 Nov 2011 11:56:28 +0800
Message-ID: <1321156588.23115.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 039E7246F4
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 04:56:40 +0100 (CET)
Received: by ggnq2 with SMTP id q2so2410863ggn.38
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 19:56:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrey Danin <danindrey@mail.ru>, Liam@alsa-project.org, Leon Romanovsky <leon@leon.nu>, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5632.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index ee6a497..bfb48ba 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -68,8 +68,6 @@ static const u16 alc5632_reg_defaults[] = {
 /* codec private data */
 struct alc5632_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
-	struct mutex mutex;
 	u8 id;
 	unsigned int sysclk;
 };
@@ -1092,9 +1090,7 @@ static int alc5632_i2c_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, alc5632);
-	alc5632->control_data = client;
 	alc5632->control_type = SND_SOC_I2C;
-	mutex_init(&alc5632->mutex);
 
 	ret =  snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5632, &alc5632_dai, 1);
-- 
1.7.5.4
