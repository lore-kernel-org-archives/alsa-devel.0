From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Remove unused "control_data" field
 of struct cs4271_private
Date: Fri, 30 Sep 2011 10:31:10 +0800
Message-ID: <1317349870.4193.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 15129244E2
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 04:31:26 +0200 (CEST)
Received: by gyg4 with SMTP id 4so1305368gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 19:31:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The control_data field is used to initialize the codec's control_data field,
but since this is also done by the snd-soc-cache core, the redundant
assignment can be removed and the field can be dropped.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs4271.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 083aab9..23d1bd5 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -156,7 +156,6 @@ static const u8 cs4271_dflt_reg[CS4271_NR_REGS] = {
 struct cs4271_private {
 	/* SND_SOC_I2C or SND_SOC_SPI */
 	enum snd_soc_control_type	bus_type;
-	void				*control_data;
 	unsigned int			mclk;
 	bool				master;
 	bool				deemph;
@@ -466,8 +465,6 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	int ret;
 	int gpio_nreset = -EINVAL;
 
-	codec->control_data = cs4271->control_data;
-
 	if (cs4271plat && gpio_is_valid(cs4271plat->gpio_nreset))
 		gpio_nreset = cs4271plat->gpio_nreset;
 
@@ -555,7 +552,6 @@ static int __devinit cs4271_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, cs4271);
-	cs4271->control_data = spi;
 	cs4271->bus_type = SND_SOC_SPI;
 
 	return snd_soc_register_codec(&spi->dev, &soc_codec_dev_cs4271,
@@ -595,7 +591,6 @@ static int __devinit cs4271_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, cs4271);
-	cs4271->control_data = client;
 	cs4271->bus_type = SND_SOC_I2C;
 
 	return snd_soc_register_codec(&client->dev, &soc_codec_dev_cs4271,
-- 
1.7.4.1
