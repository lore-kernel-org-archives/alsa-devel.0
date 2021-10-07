Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC73BC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 02:42:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72586113E
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 02:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D72586113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FC601607;
	Thu,  7 Oct 2021 04:41:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FC601607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633574533;
	bh=icffpm45hME51EE2tsK8D8Zf/jIvMI14/Zq8Hnc8Ql4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pLqxrh1x2eeBQvHoddebtMhP/mAFN1WeZCu2bJMDCwLmIQW0ob2iXFe250FxpdvUD
	 lfnS1+AQFJHJBRYTd8hAUk9vfyqyijnuKzbXx0MeDvV6E8rckTCVm4Q69RjqS12d8o
	 o/sRzcrNrS+FQ9ZDqositmOfXMGugkzBk4OwZNLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D525FF8028B;
	Thu,  7 Oct 2021 04:41:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C14FAF802A0; Thu,  7 Oct 2021 04:41:20 +0200 (CEST)
Received: from dnyon.com (dnyon.com [82.223.165.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A11DF800FE
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 04:41:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A11DF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="iMZ12a4P"
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net
 [81.39.194.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id BD7663FD72;
 Thu,  7 Oct 2021 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1633574439; bh=icffpm45hME51EE2tsK8D8Zf/jIvMI14/Zq8Hnc8Ql4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iMZ12a4PKQyiaBryxw569+aqSrGYUx7TNIfjLyhVtDPjDPcu2KEORbVbx/tkZfyPt
 gMx2HMA+4hsEiIlRT06zdKESp9bpFtXMMtd4gb5AR/DJYnoim52rhtj/tIN3cQqBFT
 O+DaPKKfcA6wa6zs1wfokkkIlHwGZsgRPqbxKxElJUukh+KB5rsodVhk6PVn434gIm
 /wxKdoG9c+CzQ1V5RdNt5BhtaZ9sPVu/t66hM+av0vER/m5/vhX7Ou9BhXpBvuZWGX
 cGxpfinxyEOopYLXX4XslBWcD6noQhdlzt76+uedriZVVUMH0CCIfSSyxZFP5sCkky
 Uyqtr6OUVUQuQ==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date: Thu,  7 Oct 2021 04:38:56 +0200
Message-Id: <d74b12a79ae9ca728d5d9e64c55b3e59e8c0e509.1633572679.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633572679.git.atafalla@dnyon.com>
References: <cover.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Alejandro Tafalla <atafalla@dnyon.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The max98927 codec on some devices requires pulling a reset gpio before
responding to any i2c command. This commit adds support for it through
an optional reset-gpios property.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 sound/soc/codecs/max98927.c | 25 +++++++++++++++++++++++++
 sound/soc/codecs/max98927.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..5ba5f876eab8 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -897,6 +897,19 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 			"Failed to allocate regmap: %d\n", ret);
 		return ret;
 	}
+	
+	max98927->reset_gpio 
+		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(max98927->reset_gpio)) {
+		ret = PTR_ERR(max98927->reset_gpio);
+		return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");
+	}
+
+	if (max98927->reset_gpio) {
+		gpiod_set_value_cansleep(max98927->reset_gpio, 0);
+		/* Wait for i2c port to be ready */
+		usleep_range(5000, 6000);
+	}
 
 	/* Check Revision ID */
 	ret = regmap_read(max98927->regmap,
@@ -921,6 +934,17 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
+static int max98927_i2c_remove(struct i2c_client *i2c)
+{
+	struct max98927_priv *max98927 = i2c_get_clientdata(i2c);
+
+	if (max98927->reset_gpio) {
+		gpiod_set_value_cansleep(max98927->reset_gpio, 1);
+	}
+
+	return 0;
+}
+
 static const struct i2c_device_id max98927_i2c_id[] = {
 	{ "max98927", 0},
 	{ },
@@ -952,6 +976,7 @@ static struct i2c_driver max98927_i2c_driver = {
 		.pm = &max98927_pm,
 	},
 	.probe  = max98927_i2c_probe,
+	.remove = max98927_i2c_remove,
 	.id_table = max98927_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 05f495db914d..13f5066d7419 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -255,6 +255,7 @@ struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct max98927_pdata *pdata;
+	struct gpio_desc *reset_gpio; 
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
-- 
2.33.0

