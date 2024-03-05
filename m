Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4945C54798
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:38:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65289A4A;
	Tue,  5 Mar 2024 15:38:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65289A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709649528;
	bh=dmp5KFcigV9N/0wkF+seHjqncGB1BmNzUlnwbTpFD8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tADVW27c9MojQhhA1nSk5V7+m09wLikobfExk9bE4XGCDtt/NirE+wgg4FGBoUuBb
	 HHYeLsUEkhPkFtuBm+631P8g7KCWfRKrTn1Hg6AbFj+MUrFViSuMqF2WfqpRaNkMCx
	 JiLpLISWl1fxrM/fSJ5LWwULMTok0NO48FczxEHU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13CA3F80578; Tue,  5 Mar 2024 15:37:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1D63F80652;
	Tue,  5 Mar 2024 15:37:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FD3EF805D5; Tue,  5 Mar 2024 15:37:14 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD7C3F80496
	for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2024 15:37:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD7C3F80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=df4Hrjwu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5299EC0008;
	Tue,  5 Mar 2024 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709649425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6o1HAKXtBl5rVLvoNigCvVZ6wM33rLm44ZB/B7ufNg=;
	b=df4HrjwuvptUVVpTjuESCaN83CMpEgi6TZgqQyQebF+TtMYicP6CvNanjzZhb+NMevKMaA
	I/voGdKrmqBZa9J/ifD3qF8CkCDbjPBK+KpEEBReS/mGxPt6GCp5HTz3p6/fjKxx1lw9qs
	uhOG++siVgIx/L/dSVXOAbusfzRwGzJn5QJj+9plfFdK49x7Dq4bJX+yeycd0YkOxmWtAZ
	wlg1K66c5OxEbOHkqBxUe9V79yH4aYlzOzu1hIhTMtUY5JPTNReCkIVZMhL92fQd/caxhg
	fJRu2JLjcDMDtyWG5e19/F8p31h8x2AUW+pQxYG/nlFo4Qxnk8skiOKK8821yA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 05 Mar 2024 15:36:34 +0100
Subject: [PATCH v4 7/7] arm64: dts: rockchip: add the internal audio codec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-rk3308-audio-codec-v4-7-312acdbe628f@bootlin.com>
References: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
In-Reply-To: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com
Message-ID-Hash: BVSCSH6HYFVTLQKODSRJUYEQGPRPGWFE
X-Message-ID-Hash: BVSCSH6HYFVTLQKODSRJUYEQGPRPGWFE
X-MailFrom: luca.ceresoli@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVSCSH6HYFVTLQKODSRJUYEQGPRPGWFE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The RK3308 has a built-in audio codec that connects internally to i2s_8ch_2
or i2s_8ch_3.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v4: nothing
Changed in v3: nothing

Changed in v2:
 - use generic node name
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 662c55fe9b77..962ea893999b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -803,6 +803,20 @@ cru: clock-controller@ff500000 {
 		assigned-clock-rates = <32768>;
 	};
 
+	codec: codec@ff560000 {
+		compatible = "rockchip,rk3308-codec";
+		reg = <0x0 0xff560000 0x0 0x10000>;
+		rockchip,grf = <&grf>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		clocks = <&cru SCLK_I2S2_8CH_TX_OUT>,
+			 <&cru SCLK_I2S2_8CH_RX_OUT>,
+			 <&cru PCLK_ACODEC>;
+		reset-names = "codec-reset";
+		resets = <&cru SRST_ACODEC_P>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@ff580000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xff581000 0x0 0x1000>,

-- 
2.34.1

