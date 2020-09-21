Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4BCC43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:38:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4471F214F1
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iNaK/48S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZLznLo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4471F214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05E71706;
	Mon, 21 Sep 2020 12:37:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05E71706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600684703;
	bh=+RfYBz/Rj8O5KxCb8uCFafkT4TJfTlahyp2IDTlfBgc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNaK/48SIYhbghmUJxb1ui7Y20Q35scgLvl4V3W1oFwC8zNRjyDZIm/SFbCYf1feG
	 AD/blA+GV/sW5AllyEJL7HCeSvgD2qa34MeUbxeSyAYdWRx1tYJaJGkxgQn1JCABxX
	 lb5gKZSEU4XPf1k1mfb/T74REs0Pp5v+P3UcI0Ag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B799DF80361;
	Mon, 21 Sep 2020 12:28:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14C6AF80317; Mon, 21 Sep 2020 12:28:24 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3406BF802E9
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 12:27:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3406BF802E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="XZLznLo2"
Received: by mail-wr1-x444.google.com with SMTP id w5so12140646wrp.8
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
 b=XZLznLo2jfFPdSaxiKZTg7MtS6c3Vq8nSL0BrXqnKhEmEMj4nAXUDkYUKfDZmXkbIG
 Ol7gVNHrY9BHzdGcAN0ZpVljHSGsxU/wYkJOnShoPQNaYW9TZ88kjtkMPtOFBYdqMMPi
 9oWrNASrcn3o9Wjqayz4RqD45Ktso9UkJ3DauPOsjLXD9pBhX9SOvkAJq7MMxkmarkeI
 Baid58BWRKF02WoGgVfD9ozZTDDNpqScPaC9rIhEe3z/VXDAa/iWTqY7bWxhaybT3SLx
 PQLaNaEVBVDG79n0sivqEmY6FDZkajwG2Xs4+sEsWzcShq1INT9d7NNtNNhhqMXnemIi
 7Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dZhYwaoUjzd/wEdIR2SZMGyqDMCzyDmEzzuRB3l0wN4=;
 b=HM8QHfYJFsGs5fw7ckSNFsbvdgAm6Mu4rfuyjGYiyOuWriDlgn7Q9huFknNqjAmeQe
 aSMtkFwMITvLuvIuFfJpiqXT/gRMUUhNIv7nnoL/TdmGWDpVMHBS8FYf3xNRRb5JQzl8
 hqoAB11bPImUHILwpj1Ne5kdlHZRCOmfOtYQcARvaGATZu9ZXkeY+SKGnWiWkgBHM3Oj
 bwjV7crJHBQKMG8yjElk2/DEryv913t4sO5sWQ0uQcNpt2mrAWcDs9NMdT4/G60Kb9i5
 caVtBXLE4MnaLjIsbyviftf5G1mtRpMCWYKV606XBz2YUP26e+Al/1FPaVzFafKuJObA
 Gl0w==
X-Gm-Message-State: AOAM530BGyU5XH0R9MmnwtXqRvUca1lGvdKIimku5XGIYdVUmvMuIq3b
 3+uFoDx0fY58cosRZjVTUZQ=
X-Google-Smtp-Source: ABdhPJziKBu3aDQ3wWp2KsJ3eALaG5McqT6UYk+W9KKgrwPnZdByOHcVDimcFNCrrUtfKy+Sxchang==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr49418820wru.232.1600684076477; 
 Mon, 21 Sep 2020 03:27:56 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 03:27:55 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v4 17/22] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date: Mon, 21 Sep 2020 12:27:26 +0200
Message-Id: <20200921102731.747736-18-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com,
 =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 329cf276561e..b54b02e59085 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@ &i2c1_pins {
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

