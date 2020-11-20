Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EDC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:30:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359B72225B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qbsg6R3y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHxY6yDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359B72225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A03CC82B;
	Fri, 20 Nov 2020 17:29:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A03CC82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889848;
	bh=evb6wjGRVMwrWJRqEySL6t4LzK9d/Rg6xYP1e4Vt620=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qbsg6R3yoxwXA0s39IDErj2r4TxyTR5KzxwykGdwbQoUUH5Dk4X/6ryxk/IRgTS5w
	 31rOo3wVyIflLghvfNkjMIIOrx7hCUZICLJtwigf59DsKeAInEjiiiT0fvzpacqAyd
	 zKrYb5+eMlFyMdcJocsMGOACViFOjqq3jFo2QI0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 046C9F80258;
	Fri, 20 Nov 2020 17:19:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AF64F804CA; Fri, 20 Nov 2020 17:19:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E583F80258
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:19:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E583F80258
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FHxY6yDE"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B38D2408E;
 Fri, 20 Nov 2020 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889182;
 bh=evb6wjGRVMwrWJRqEySL6t4LzK9d/Rg6xYP1e4Vt620=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FHxY6yDE1rg6TPjAUR4pvA1eKCHn2JKmG1cx7McdjEANBo+yt1PCJM4d6dOqbG0ip
 2h5f/mgPxao2TkncQLmtdB3tWN3nyucKDgG9bK6fqtJJqj0r2LnHSzJANbcYFqW56A
 GCML3GdaINH8gaS1ctG9GlEJUvAvGRaEf1Kvu5a4=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 31/38] ASoC: ts3a227e: skip of_device_id table when !CONFIG_OF
Date: Fri, 20 Nov 2020 17:16:45 +0100
Message-Id: <20201120161653.445521-31-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

  sound/soc/codecs/ts3a227e.c:369:34: warning: ‘ts3a227e_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/ts3a227e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 3ed3b45fa7ba..962f5d48378a 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -366,11 +366,13 @@ static const struct i2c_device_id ts3a227e_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ts3a227e_i2c_ids);
 
+#ifdef CONFIG_OF
 static const struct of_device_id ts3a227e_of_match[] = {
 	{ .compatible = "ti,ts3a227e", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ts3a227e_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static struct acpi_device_id ts3a227e_acpi_match[] = {
-- 
2.25.1

