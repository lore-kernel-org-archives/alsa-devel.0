Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DEC54FD0
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 12:07:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955E22071C
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 12:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FzCQ+gni";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vftiurRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E22071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDD0E169C;
	Sun, 26 Apr 2020 14:06:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDD0E169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587902846;
	bh=xGeoYGlgQvcBRppJRDrAqfM9FYNW8e/gPb31NpPXocg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FzCQ+gnixn+FeKSYJCvO3aRutKfkFoRqwZAMUrWHi2yNZnailVPmLiVzQLuSdlo7n
	 xWFw3tbUxVlwsnhY9najijgo3ZJXT9DZkD22/eiapD1pj22GagVgwrxXpc3o8+kW8w
	 XRrgCyN0WcaCdyWhHpsRLD7OwE6bfqtiiZdfJogc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4434F802A0;
	Sun, 26 Apr 2020 14:04:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6692AF80291; Sun, 26 Apr 2020 14:04:56 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D7FCF80113
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 14:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D7FCF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="vftiurRM"
Received: by mail-wm1-x342.google.com with SMTP id h4so3107317wmb.4
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TZMguin0qF+PG0k2dkN3ezS7N4XttGAbuy5WT8MZbio=;
 b=vftiurRMFrp9UJSlnfcY2kxkimb8O8bOGD0/SAMLHFdv5zcWKBboL9WM5sV1ea85BF
 GF0dm0POD9E5MjzmtN4W/zNpXU2pvfxXp7AOmyCLXTGgIjnyRMgA6pfvMvX1wDl1lBDD
 SQwf7sA31Oar7Tia4SxX7Njri/7ko/OsMGIxiAHKIjroHMMZvEPsFRZiy5ARMwgslden
 9usgYO0DNFLef3w3B1UKuAPCXyzSyA/wU71BXEMy9Ow5aEbosnfJqfpS4zZiHjdqcQ3o
 vjzrAWq46FDqwPKwk0CQsndCFt9Qy8gNeVV5FHlGq91NQXAoWJHGpFkqVGUAWaBl9vlM
 Z57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TZMguin0qF+PG0k2dkN3ezS7N4XttGAbuy5WT8MZbio=;
 b=ivxWm8bR/lovr2gKvEXHfFN8KnKSwbPRG5z0NICWc1klGbJmdWKH3qu92jCjnrUWUv
 yylxAutT9Jea/1v7sK5ADLVs4rV3vSRPNN12H1Qke01oJUt3tWoJ4OAr+zf1DehfRhzV
 xNp0yFtvvVjCTxwe3CX342/tZ7l36hdQmi1/TFXnmDWZVqMPt5v/fYJQ1EIlPebwyEsp
 JsKbHi1/jy+SBc+RAd72xk/Xh9Ubah4Wy6imCS6+GC9yVBdYZHMDnOxXfluX58f1yYft
 jbDUvzz91brEYg4Kht6UGO5rhYDOdLINjQa5iqDoRU1Bg0rYBfyLWLpjHCSOULQEa92j
 uxTw==
X-Gm-Message-State: AGi0PuYUKCbz2Y4/TyAuoIcDEKB2moTEtULij7atCy6ArBiWchHTIUts
 PWbragWNBOpK5jTRZouV+kwKI781nIuKPQ==
X-Google-Smtp-Source: APiQypLThTyvf1ycYY1ugZwNSBUMPwNwiXiATnmOGXr+ZmCBZ+kYsICRhwugaNkeCjuyXI87+CsDnw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr20956181wmh.93.1587902688948; 
 Sun, 26 Apr 2020 05:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
 by smtp.gmail.com with ESMTPSA id
 s24sm11120026wmj.28.2020.04.26.05.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2020 05:04:48 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/7] arm: dts: sunxi: h3/h5: Add HDMI audio
Date: Sun, 26 Apr 2020 14:04:37 +0200
Message-Id: <20200426120442.11560-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Jernej Skrabec <jernej.skrabec@siol.net>, linux-kernel@vger.kernel.org,
 Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
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
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 9be13378d4df..3a4262294950 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "allwinner,hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
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
@@ -672,6 +691,7 @@
 			dmas = <&dma 27>;
 			resets = <&ccu RST_BUS_I2S2>;
 			dma-names = "tx";
+			allwinner,playback-channels = <8>;
 			status = "disabled";
 		};
 
@@ -806,6 +826,7 @@
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.20.1

