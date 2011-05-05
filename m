From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/12] ASoC: SSM2602: Properly annotate i2c
	probe and remove functions
Date: Thu,  5 May 2011 16:59:12 +0200
Message-ID: <1304607560-15083-4-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 4F711103A0B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:44 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

Annotate the i2c probe and remove functions with __devinit and __devexit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 02390dd..6444d34 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -594,7 +594,7 @@ static struct spi_driver ssm2602_spi_driver = {
  *    low  = 0x1a
  *    high = 0x1b
  */
-static int ssm2602_i2c_probe(struct i2c_client *i2c,
+static int __devinit ssm2602_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct ssm2602_priv *ssm2602;
@@ -614,7 +614,7 @@ static int ssm2602_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int ssm2602_i2c_remove(struct i2c_client *client)
+static int __devexit ssm2602_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	kfree(i2c_get_clientdata(client));
@@ -634,7 +634,7 @@ static struct i2c_driver ssm2602_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ssm2602_i2c_probe,
-	.remove = ssm2602_i2c_remove,
+	.remove = __devexit_p(ssm2602_i2c_remove),
 	.id_table = ssm2602_i2c_id,
 };
 #endif
-- 
1.7.2.5
