Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DF7C2D0A6
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:38:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BB520678
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aROlGai+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSzV1aYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BB520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B30911A9C;
	Thu,  3 Sep 2020 22:37:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B30911A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165505;
	bh=3qpPj476P4yVvf0oMSTpHlnbubmnEf5hxsIUd1oDQPs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aROlGai+d4unyRxz5fdggtHWupNWZJBowM5fzqjkXI34u3ZfRfTqXHWZyjw9Ibtmi
	 K//lfuiyf4ThqBEiuJ3pqZ//krC9iq0Yo3CZX0+SVsCSxAc5esivFkD0UMg7/BcDmP
	 F5shSh6Ltqk9e0/yTz5GHDoApe0vqzCDBzIK+Jjs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 696DAF80344;
	Thu,  3 Sep 2020 22:31:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D58D6F80339; Thu,  3 Sep 2020 22:31:18 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DD69F802F7
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:30:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DD69F802F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CSzV1aYj"
Received: by mail-wm1-x342.google.com with SMTP id a9so4139294wmm.2
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2020 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I49qX4p3R5f0D/cfuMt37KBf23v3/L+E2eSH2MZxqyM=;
 b=CSzV1aYjyXMA+ThlgRn7cci8rIEX5STM39i8LXl6eAR1hk+g6v2+sjurymyzXj24DW
 DAlAXhSTKhhRfJzIiXxpCm3+liwUA9WU2Hlt0wgo8zpCJuHYz0CMp6A1zdqNttc8/hxP
 TC7NSVfH/eC07z5O8fcYwYCHDth71yq4Rna0Mr43QWesC6z/jxHcThvh8ZNOfPHdFBxm
 f3ZtZO+ZMLeaJXgLwePVuL3xqfrGlU5MrexfNI/5uUylzH4svGhmVzCGJ8jVSalB4UDJ
 koiSWTLUhBf6IWMBM5kMUiZtolpSDuhuk1nBMCgU5CaLLCfktoxw7ShE0dGCNGvLZ9Dk
 cpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I49qX4p3R5f0D/cfuMt37KBf23v3/L+E2eSH2MZxqyM=;
 b=RTpiiohI26FkPUf2nhPyUJpph9gMJ46gIUHFHoWdYhTSODe03yvieSwhMJdeWl5uA2
 4jhNboFKszRuNKddW0ZJebXHV0U1ulknwza0CFHeWy9+uiXDjP/cDoxi1D0IejQL4N3X
 gi8ta2F2wbXfm69deyw2l7aI3bwWuJcLHkmW5FzRjwp3JNwvAnSnXkTcJgKAatk9Z2/+
 S6DC5nX435ynd19LSnkWpVrietLB+Atse678oyOvf0k9ZRUj1mS018rtnq3mgLDlOtTj
 2y1uN3KXh7rpXgaZlbZLJ5On/GpmUrbxi0BSX1dXd32rVmimhij91jrQCeuo44RphAAh
 79tQ==
X-Gm-Message-State: AOAM532h44l6NlCqL1SEVYFHOlFzG2W/BEq89PaPoWwKCykXLPnTWd8W
 Mfz6XVdLQtPGzRJvneZ4HT0=
X-Google-Smtp-Source: ABdhPJy5CGi5+Z8rjupOyEJsdtu5n4tI7FD43iDEcopKLSxFhEJ+qzOIV5ZHmtekurdvtvJycDajQw==
X-Received: by 2002:a05:600c:2053:: with SMTP id
 p19mr4214447wmg.50.1599165056187; 
 Thu, 03 Sep 2020 13:30:56 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:30:55 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 11/20] arm: dts: sunxi: h3/h5: Add HDMI audio
Date: Thu,  3 Sep 2020 22:30:25 +0200
Message-Id: <20200903203034.1057334-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
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

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3dca6d89cab9..ebb109c828d9 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,24 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -806,6 +824,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

