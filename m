Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE80C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:25:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C7222269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="toMHuBcz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zMPhRu0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C7222269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1456717B4;
	Fri, 20 Nov 2020 17:24:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1456717B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889519;
	bh=hUJkunHo8Nfcr2uWL1x9GpPMBlvI204ks175M5PYJr4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=toMHuBczer29Yk39vbsWSq1xuk/GXMrdAdqAbB5cVhUmfimEZtJcKM55H+rDzkxgd
	 rjStShJFzvNWAMAsPoHVwHrRLhSXb5srANyZ+0uKrM0V1y0kCVJO9XCg5I3++lSaRL
	 Om4XWRGUSytB4juVY8gPHyNJfrWcbs0oU9ST31CA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5500EF8053D;
	Fri, 20 Nov 2020 17:18:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEDFFF8053B; Fri, 20 Nov 2020 17:18:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08D18F80525
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08D18F80525
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zMPhRu0O"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE1A924137;
 Fri, 20 Nov 2020 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889124;
 bh=hUJkunHo8Nfcr2uWL1x9GpPMBlvI204ks175M5PYJr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zMPhRu0Os3XEKHUs+gGQOmsihnr3R/UocQ7H0e1Ol0a61S50PPPs4pbp3QjRPE2C1
 0UPxFy/E5EGty3PwH1bNn4cuHw67Z4+7SoMFvJxT/ee9E+xlkkZq17Mh5Q80DzTJvi
 xfJYeQ6OstFhB5AZ3cuGsLKEDoK+FJBVdnz2s8t4=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 17/38] ASoC: da7219: skip of_device_id table when !CONFIG_OF
Date: Fri, 20 Nov 2020 17:16:31 +0100
Message-Id: <20201120161653.445521-17-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
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

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/da7219.c:1705:34: warning: ‘da7219_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 0b3b7909efc9..e9b45daec0ca 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1702,11 +1702,13 @@ static struct snd_soc_dai_driver da7219_dai = {
  * DT/ACPI
  */
 
+#ifdef CONFIG_OF
 static const struct of_device_id da7219_of_match[] = {
 	{ .compatible = "dlg,da7219", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da7219_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id da7219_acpi_match[] = {
-- 
2.25.1

