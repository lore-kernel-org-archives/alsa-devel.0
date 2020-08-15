Return-Path: <SRS0=xC/7=BZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91FFC433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2020 11:25:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0457E23119
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2020 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i+e7UIzW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzvxEX87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0457E23119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8528C1664;
	Sat, 15 Aug 2020 13:24:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8528C1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597490742;
	bh=yKBCi59ha74wr/RTxZZP6HoPdnk1oJ+4prgXzkemx5w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i+e7UIzWW2ZyaIJEo3JoFfY/13iPY6uaQoN13j0oCJz4nCS0SvUje8SJQwfx7hOm0
	 gSrMliyYfTlIhrPUWmQF27h8a+6YmNV5BVfo/mQGSfjQCLNqrViVmLvI2Srq9xj9Zl
	 30JvW/nzr8vHLN2jEu/6yIuz9t0u88WA5Y0nIaGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 232EDF8014C;
	Sat, 15 Aug 2020 13:24:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E419EF800D3; Sat, 15 Aug 2020 13:24:49 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9225F800D3
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2020 13:24:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9225F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BzvxEX87"
Received: by mail-ed1-x542.google.com with SMTP id i26so8712376edv.4
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2020 04:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=/pYCqw4FJgQPrWvNgxirZK4mGQC6/Ct9Zlkxybe7NMM=;
 b=BzvxEX870Xh3lvpFQLGjz7Veu4ygb9dXO7nfFMPyo3sDsJRvTHw6edfND4yqselsR6
 URdlfuviGFFbRySestfN8PU7laLrFmG9iH1pfGTSdnXc1buyXBrCXETreK/M9kDopNRL
 WJVCQYEx4kOiyuYGPpSZqor0EFIDiuRi3/MTukfQc2pS2hP1YDgE2bIJtcPaiDIi01jL
 QPqZhDCVHMybZGVVBmfwQHHrGOI0OSwscrfWbmYsyGzHVVMqxiLtSfLKSqGFZsAisfLx
 tTVZWR8KsVBWy7Ia/VM6l+oBsSYy/3YIzmJgrrbDQR/h1yyH9KRorvdwgkPpPE2JDYVL
 C6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/pYCqw4FJgQPrWvNgxirZK4mGQC6/Ct9Zlkxybe7NMM=;
 b=DCaPiB5CQvrrMt15aIebcv5dIk6nqdJ5nNwuhByF8MlfdyXcK2rrpyxuYFGV5pNL02
 niCPdwEYefvzxCDJkti7t5BqVM34+ZqSHFMmlEKprhpGy4blO/zIiyBB1bRmz7/trYSZ
 yZBiLBIdD+axHAeNxYb8fu6ucFdJdeEKxAmHhzQixJKLFgIsSnO3KmrU7+vNJxewe3By
 9T2BDxovVAgd2OC+oJBhXIj6MaKbTIllYBnztdGYhmV2ahdnmSicXzniRCdxs2nZkDYk
 SAW6jImnpP64RrbQUru+P8wb1XDhsPBOopCdirzQmzANlZqAvOaFNSF6DZ5ab6zaaLnR
 GJkA==
X-Gm-Message-State: AOAM533PHGQLnqqyO+XkflzZ+3P1MKgJ+bqBqEBYqFkxsCzCvhAc3rLt
 WbgGYGN7mlc26m2huFVcdpI=
X-Google-Smtp-Source: ABdhPJzNUtJSkcac39yHBPS5OxPmkL38Y++peDytppNuvWlZm5hLmWf+eQB4YO0lfG/9XEr/QYT7Gg==
X-Received: by 2002:a50:fd8d:: with SMTP id o13mr6673800edt.313.1597490685719; 
 Sat, 15 Aug 2020 04:24:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id g19sm9106505ejz.5.2020.08.15.04.24.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 15 Aug 2020 04:24:45 -0700 (PDT)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [RFC PATCH v1 1/2] ASoC: rockchip-spdif: add description for rk3308
Date: Sat, 15 Aug 2020 13:24:36 +0200
Message-Id: <20200815112437.6662-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org
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

A test with the command below shows that the compatible string

"rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

is already in use, but is not added to a document.
The current fallback string "rockchip,rk3328-spdif" points to a data
set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
in the mainline as in the manufacturer kernel.
(Of the enum only RK_SPDIF_RK3288 is used.)
So if the properties don't change we might as well use the first SoC
in line as fallback string and add the description for rk3308 as:

"rockchip,rk3308-spdif", "rockchip,rk3066-spdif"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
enum rk_spdif_type {
	RK_SPDIF_RK3066,
	RK_SPDIF_RK3188,
	RK_SPDIF_RK3288,
	RK_SPDIF_RK3366,
};

static const struct of_device_id rk_spdif_match[] = {
	{ .compatible = "rockchip,rk3066-spdif",
	  .data = (void *)RK_SPDIF_RK3066 },
	{ .compatible = "rockchip,rk3188-spdif",
	  .data = (void *)RK_SPDIF_RK3188 },
	{ .compatible = "rockchip,rk3228-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3288-spdif",
	  .data = (void *)RK_SPDIF_RK3288 },
	{ .compatible = "rockchip,rk3328-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3366-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3368-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{ .compatible = "rockchip,rk3399-spdif",
	  .data = (void *)RK_SPDIF_RK3366 },
	{},
};
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index c46715265..26e986097 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
             - rockchip,rk3188-spdif
             - rockchip,rk3288-spdif
+            - rockchip,rk3308-spdif
           - const: rockchip,rk3066-spdif
 
   reg:
-- 
2.11.0

