From: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] ASoC: cs42l73: Remove trailing semicolon
Date: Thu, 11 Jan 2018 16:27:04 +0000
Message-ID: <20180111162704.25246-1-luisbg@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Luis de Bethencourt <luisbg@kernel.org>
List-Id: alsa-devel@alsa-project.org

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 sound/soc/codecs/cs42l73.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index dde37e569ade..aebaa97490b6 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1355,7 +1355,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	ret = regmap_read(cs42l73->regmap, CS42L73_REVID, &reg);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
-		return ret;;
+		return ret;
 	}
 
 	dev_info(&i2c_client->dev,
-- 
2.15.1
