Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F5C43461
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DC92071B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CMkDjflO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEfs4xSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DC92071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68042193E;
	Thu,  3 Sep 2020 22:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68042193E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165707;
	bh=1jaUTW1IS/d+0xKEIaljMnyEL+efvJY6RnPLC7maicM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMkDjflOALM/XwiXnIdj/4ky+g/v5NSJv6E3a+kcyIlkG9KGbh31JSkTGD0yoVTJK
	 xFS7CSXGC9GkdRyADCwuygTug84MB62jKj6Fu8f8TNR9+5A6ZljpUIB+RYgzcP/zYQ
	 fOo2PJPDQ5dYRj4+w/nQVWDBwFomZuhThRatpPqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A180CF80369;
	Thu,  3 Sep 2020 22:31:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D0D9F80369; Thu,  3 Sep 2020 22:31:36 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 467F6F802A1
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:31:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 467F6F802A1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BEfs4xSH"
Received: by mail-wr1-x442.google.com with SMTP id k15so4549991wrn.10
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
 b=BEfs4xSHwizz77U6lZSX3/6eX7M1nJLZidrzep+rfN5H0CTn46/t6zj/VgByNR5PVq
 NqvQCsx6atSOtJDMg+oEghtNF/7K4Al6FoAntExLKy3rkLHNunpNVRWQutA29C6lhA74
 mW3aeEbg+BzC1eUyR6eAUMkbaWBqx9k1rCnaGBCu+i+x08o7rF8awZ3Xk6BbhUuOQnA8
 xSdq+8MxZSHZV5P3dY0baUdTucgnGBh1gC1q0T2UdJsCnCBV7fKjwj9ju6je6To/zL4q
 ZEUWDsTUgpad2o+tvBjkqJR30pPm+UFhFcNxKxCA83M/U8tkEOxFetw5Y6zxcGK95V8/
 s4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
 b=mkOb6n93f1YtJp0OO03nlfXePaIVW/Ev1LO+7a2gNEihn8AEF01yZO8CEojryh3QFS
 M1mnacS+3rkDGWUgsGWNHQZ/WXWlztKLpmR6HcK+vfl79vyG8fUCCWmBxBHKxT2mFwG6
 h03WN5wKpM8Xk+IMS6w9fXVnKtJEHsNsmMfmCwo2iIZmyisEXG59yfZfDwrZ29aZ+fMw
 eKzs4qJYoPz2OxVw10oyXICPEU+plUG7JV9ABIXrh4RHrcvHov2jv6eeC3ynVnETeGuQ
 +E+v9hoG2BdbcvpJoi5RmRvPcF3O4ED4xOk2Dfu7A3e3cg9zRetFBms3gxhWSgZ47Lvg
 NofQ==
X-Gm-Message-State: AOAM532sTS5mAmYJzsndVInE+Wpn911vgIa9XgyL36Dcwv6BYJsxXLOv
 3zkUkNC78TwRHkmw+ANwGDY=
X-Google-Smtp-Source: ABdhPJyHugEjh1cQ8tGklBO7HKq6sQdT5S677ENDwIMCGD+BQJiogorF4mbzeAz92BSVsCqAUPChIw==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr4084522wrw.379.1599165063464; 
 Thu, 03 Sep 2020 13:31:03 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:31:02 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 17/20] arm64: dts: allwinner: Enable HDMI audio on Orange
 Pi PC 2
Date: Thu,  3 Sep 2020 22:30:31 +0200
Message-Id: <20200903203034.1057334-18-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Marcus Cooper <codekipper@gmail.com>, linux-sunxi@googlegroups.com,
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

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 7d7aad18f078..e6ed8774a17f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

