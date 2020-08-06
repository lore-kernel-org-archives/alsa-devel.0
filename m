Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE5C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:26:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C38822D02
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JUgIdcx8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2UrWbacc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C38822D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6814A4E;
	Thu,  6 Aug 2020 20:25:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6814A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596738394;
	bh=AIpLTJlKFItG2jWXcrIaGnSQbfvgpjgzdq2hRWO00gM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JUgIdcx8CoGTUCMrcTX7HNiX2cf0coTflgEfq+/qm9UzI0gxk+IgeSj983uGQAeRB
	 EYANXMuL5NB6kSSwXC25VRA132zoBRBgcAZMJxNKlUyFBRdQoB9Xslt+iCFvFrwzOD
	 TROekqHX+GxZy0J0YNzAY9k3ybkhcpalyUbLwQ4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 236F5F802E7;
	Thu,  6 Aug 2020 20:23:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75CDCF802E8; Thu,  6 Aug 2020 20:23:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A392F802E3
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 20:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A392F802E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2UrWbacc"
Received: from localhost.localdomain (unknown [194.230.155.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3098F22DCC;
 Thu,  6 Aug 2020 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596738207;
 bh=AIpLTJlKFItG2jWXcrIaGnSQbfvgpjgzdq2hRWO00gM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2UrWbaccsVbgJ4PjuRufTVR4PiUR7F4mIKm0UOgmDP5hKj0u4JZl0JTQBhUXsyBDD
 cVfUeUlHld6rKFzcXSb1dtr4jmqFMEVQ4nNjsScLrUMqUwmlHN1WuBsjByqxxfDlTg
 RdRJ+wOC7pWeGOu85r1hKklai3x/43cWsukTya3k=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/41] ASoC: samsung: s3c2412-i2s: avoid hardcoded
 S3C2410_PA_IIS
Date: Thu,  6 Aug 2020 20:20:44 +0200
Message-Id: <20200806182059.2431-27-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Sangbeom Kim <sbkim73@samsung.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The constant requires indirectly including a machine header file,
but it's not actually used any more since commit 87b132bc0315 ("ASoC:
samsung: s3c24{xx,12}-i2s: port to use generic dmaengine API"), so
remove it completely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c  | 3 +--
 sound/soc/samsung/s3c-i2s-v2.h  | 3 +--
 sound/soc/samsung/s3c2412-i2s.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index ed21786104a1..e9481187a08c 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -616,8 +616,7 @@ int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 EXPORT_SYMBOL_GPL(s3c_i2sv2_iis_calc_rate);
 
 int s3c_i2sv2_probe(struct snd_soc_dai *dai,
-		    struct s3c_i2sv2_info *i2s,
-		    unsigned long base)
+		    struct s3c_i2sv2_info *i2s)
 {
 	struct device *dev = dai->dev;
 	unsigned int iismod;
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
index fe42b77999fd..8c6fc0d3d77e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.h
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -83,8 +83,7 @@ extern int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
  * @base: The base address for the registers.
  */
 extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
-			   struct s3c_i2sv2_info *i2s,
-			   unsigned long base);
+			   struct s3c_i2sv2_info *i2s);
 
 /**
  * s3c_i2sv2_cleanup - cleanup resources allocated in s3c_i2sv2_probe
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index b35d828c1cfe..edfa9d11d2e5 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -49,7 +49,7 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &s3c2412_i2s_pcm_stereo_out,
 					&s3c2412_i2s_pcm_stereo_in);
 
-	ret = s3c_i2sv2_probe(dai, &s3c2412_i2s, S3C2410_PA_IIS);
+	ret = s3c_i2sv2_probe(dai, &s3c2412_i2s);
 	if (ret)
 		return ret;
 
-- 
2.17.1

