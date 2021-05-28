Return-Path: <SRS0=FleP=KX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFDC2B9F7
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 14:17:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251B16124B
	for <alsa-devel@archiver.kernel.org>; Fri, 28 May 2021 14:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251B16124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDF8B16FB;
	Fri, 28 May 2021 16:16:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDF8B16FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622211465;
	bh=iNxBNW4SSptwhcnpvgl2tbTyOmoi56zJOm9WU01asGI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0xg3ZhAJ0vJp/ZWpvodMXBcXmL68g50gu+cuccdTc50TWxb4bJJeOSfF/32r8gXm
	 agQlQqDJvUlWxJNF2u5nsKfPLW1Czwqc8+7HFh4ySHTEY0jC77hfUn0SHQRkNKo5X/
	 M31tKKFhrO0adNfRp06EYh6YlOhbAScZfYMVcQng=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 351D0F804D6;
	Fri, 28 May 2021 16:14:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00C3DF8029B; Fri, 28 May 2021 12:51:50 +0200 (CEST)
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05783F800F9
 for <alsa-devel@alsa-project.org>; Fri, 28 May 2021 12:51:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05783F800F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mailoo.org header.i=@mailoo.org
 header.b="P4AQhR1d"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
 t=1622199080; bh=iNxBNW4SSptwhcnpvgl2tbTyOmoi56zJOm9WU01asGI=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=P4AQhR1djESmACH18/d3g73K5J3ldKKGm87I1GuDAYS3ObioRwGV+KwApDIofwlEn
 l6VpAU2Jo92Eni3JffNKTbuRsKeKpFoJtutjZKTqadb3FOvjYwvF4JO/ajND66jCL+
 +44qnyyx212Tj+nZ0KWgmkCHlagfpK3aJHInPKjc=
Received: by 192.168.90.15 [192.168.90.15] with ESMTP
 via proxy.mailoo.org [213.182.55.207]
 Fri, 28 May 2021 12:51:19 +0200 (CEST)
X-EA-Auth: qKy0orTZIIiVMo0/dMQZTXTZ1ji/g72TwrHjujjnoSQ0wvoGfk2lLoGU5PSkvy1IFugCdt7AcjLb6aEvFqXqXtfszauthTo3wbKolVOjGPo=
From: Vincent Knecht <vincent.knecht@mailoo.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] ASoC: codecs: tfa989x: Add support for tfa9897
Date: Fri, 28 May 2021 12:50:59 +0200
Message-Id: <20210528105101.508254-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 May 2021 16:14:27 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>
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

Add specific init function to poke needed registers & values for this IC

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 sound/soc/codecs/tfa989x.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index 408e26eee108..6d94865c534b 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -44,6 +44,7 @@
 #define TFA989X_CURRENTSENSE4		0x49
 
 #define TFA9895_REVISION		0x12
+#define TFA9897_REVISION		0x97
 
 struct tfa989x_rev {
 	unsigned int rev;
@@ -175,6 +176,29 @@ static const struct tfa989x_rev tfa9895_rev = {
 	.init	= tfa9895_init,
 };
 
+static int tfa9897_init(struct regmap *regmap)
+{
+	int ret;
+
+	/* Reduce slewrate by clearing iddqtestbst to avoid booster damage */
+	ret = regmap_write(regmap, TFA989X_CURRENTSENSE3, 0x0300);
+	if (ret)
+		return ret;
+
+	/* Enable clipping */
+	ret = regmap_clear_bits(regmap, TFA989X_CURRENTSENSE4, 0x1);
+	if (ret)
+		return ret;
+
+	/* Set required TDM configuration */
+	return regmap_write(regmap, 0x14, 0x0);
+}
+
+static const struct tfa989x_rev tfa9897_rev = {
+	.rev	= TFA9897_REVISION,
+	.init	= tfa9897_init,
+};
+
 /*
  * Note: At the moment this driver bypasses the "CoolFlux DSP" built into the
  * TFA989X amplifiers. Unfortunately, there seems to be absolutely
@@ -280,6 +304,7 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id tfa989x_of_match[] = {
 	{ .compatible = "nxp,tfa9895", .data = &tfa9895_rev },
+	{ .compatible = "nxp,tfa9897", .data = &tfa9897_rev },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tfa989x_of_match);
-- 
2.31.1



