Return-Path: <SRS0=ok5v=X6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30597C3E8AB
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 08:57:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB017222C0
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 08:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rAhj99Wo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n7m3APz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB017222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D87411691;
	Sat,  5 Oct 2019 10:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D87411691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570265839;
	bh=dSqLiQZM3LRsqko2rhNe4K1PX7eDT2eM0wZGCXhWeOs=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAhj99WoCP2CqyqwvSTIFKOKZknck37riYD0vtsc6/aoZcX+SQWGHMLL2Ajl3+CWS
	 9Q+DJNq/tA+B7JrzApkwhctE87IyKkRzXd5yqEK4tuhzGPgBgKOAxAB1fxrnN15iWd
	 A9c19iOUPYq7G7DIA8KRlo29hr0CSVXtfyhFjwV0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C33FF805A0;
	Sat,  5 Oct 2019 10:55:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2309EF800DE; Sat,  5 Oct 2019 10:55:33 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 533CEF800DE
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2019 10:55:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 533CEF800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="n7m3APz3"
Received: by mail-yb1-xb49.google.com with SMTP id 133so6984136ybn.19
 for <alsa-devel@alsa-project.org>; Sat, 05 Oct 2019 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Z6x5CooX+KOT5/OTrrb8SPQO8MJH2PsqtriuzR88xtc=;
 b=n7m3APz3VUmQOXs0/g4RrvMfgMp9zLlAp50+h5iGUOJDdIGNVoELmoQQwqXgw7wxCe
 mAc5ZlhoRfcl7+7u6oPp/saujThzylOJvAUDiDpi0qt5LUGmIZaVnhp1gRSsVBPJivMf
 4dMG5Iiq/z1MlhjqabU3uWNupHbTtjrAOHbjWaIXTOwstYe05Hei2e3EaC8Uk6FHOO9k
 POOshi0egRMG/7rLuoFOvTbuDOow5vUYCeB+wmHGBwS+0CtsWgb9i7Nhrmd5KCG/7GNj
 nr6fG+BNT8qbAhJi2B8qDE/sEVnAVKH8PmeDY6Yrb9UI/VA7g+NLF+8G9K3c5x1s78sR
 mv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Z6x5CooX+KOT5/OTrrb8SPQO8MJH2PsqtriuzR88xtc=;
 b=XG7YEmIxBrgjft7nT3BGSoWHCZPXjGPULVrfOS4CS5c/WE/30q46hDxCB+vFBl2fkt
 mK2bm8YT8O4C+D8Yp6X3KHUAb0DBB9eJFxLrOhcDHsqzaKdUKvwvXRVtCBusgg56uP0m
 1Ywfux9MjcQb6J9eRl5K6FIZcjEK937TowOu27OC23RV17YHnqQuaZuYg1iOHUq/21/q
 MiieQ4c/P+4LtNArrn0m30yDm1kfjcZV1xHYvUY2z7coWAXQt5gfWTOQDoPMY8ICXaRL
 oQiScZP4oICzybuXsWwCUHcEt/PfAjnH7liq3FslWJVXXXu9oxzDb6lyE5jzsTLvuaMv
 tvLA==
X-Gm-Message-State: APjAAAUcxQb3gGqS/7JphlGeKPpCn1dgi7r+GGZDNKE1v+koBwTy+MQu
 PIk3Hkh/3vCuSuoOJFZrnfbkfErQifKO
X-Google-Smtp-Source: APXvYqweytEHeVNLbY+AIyEYtjZfnoblLM6j7sVR3Tqp1Z6jD2P2BOgGSKO13eEdqXR8jgTDuHgLfSW2CsPt
X-Received: by 2002:a81:db13:: with SMTP id u19mr7898490ywm.160.1570265728291; 
 Sat, 05 Oct 2019 01:55:28 -0700 (PDT)
Date: Sat,  5 Oct 2019 16:55:00 +0800
In-Reply-To: <20191005085509.187179-1-tzungbi@google.com>
Message-Id: <20191005164320.01.I374c311eaca0d47944a37b07acbe48fdb74f734d@changeid>
Mime-Version: 1.0
References: <20191005085509.187179-1-tzungbi@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, tzungbi@google.com,
 robh+dt@kernel.org, enric.balletbo@collabora.com, bleung@google.com,
 dgreid@google.com
Subject: [alsa-devel] [PATCH v2 01/10] platform/chrome: cros_ec: remove
	unused EC feature
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Remove unused EC_FEATURE_AUDIO_CODEC.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 include/linux/platform_data/cros_ec_commands.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 98415686cbfa..43b8f7dae4cc 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1277,8 +1277,6 @@ enum ec_feature_code {
 	 * MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE.
 	 */
 	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS = 37,
-	/* EC supports audio codec. */
-	EC_FEATURE_AUDIO_CODEC = 38,
 	/* The MCU is a System Companion Processor (SCP). */
 	EC_FEATURE_SCP = 39,
 	/* The MCU is an Integrated Sensor Hub */
-- 
2.23.0.581.g78d2f28ef7-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
