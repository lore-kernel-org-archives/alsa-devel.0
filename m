Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C2C63697
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:48:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAE02222E
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nzk2uQdP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv9iMNUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAE02222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D54E17C1;
	Tue, 17 Nov 2020 20:47:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D54E17C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605642527;
	bh=e1CdGycGD6LX6+DJfyJDdmzXiXHPLIi8pyzGeSRKKJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nzk2uQdPySOgV4okYZN7oQi7e8WZxyA+gOTdme+Kaw1oX73RlfCjXqEzbnYjP2+YL
	 CO5nrtovazQrd4v0yplnymNL0btvn+5ezZ4MM25rerizc3WMH9+OB9DKTUW3alLn53
	 7Jqh5dixS7bguurPcnooXufLx0+KooSOKHoW65GA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00A57F804ED;
	Tue, 17 Nov 2020 20:45:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB1B3F804CB; Tue, 17 Nov 2020 20:45:39 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A119DF804B1
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 20:45:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A119DF804B1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="gv9iMNUE"
Received: by mail-ed1-x541.google.com with SMTP id l5so23714965edq.11
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
 b=gv9iMNUExdomLmhZ6/3RtkBaW3AhpWBSUWSrMO1oLfdXYLZKQ0dl9R4nUwEcxPz1V0
 mijrwHA55UDncYNgagM9CjzpkasGyZQoc3OpbH5CXsWqB2RXLkTBzhyOkCyKX2oxJpeb
 Cwkb3M6jllsXM2EVpeBVtFwAtu16JC1xGqamfyB9l0yrXPxgPasdkyldRj/5V4DH6Awd
 iNOINqDFXEiDXichdp0Q/ygBI5MghrASAsL7lKCJ8uR6kmH3Q5B2JU5Dl2Czrb8IMnf+
 ndjcDuDSRacZCVEFgjLl1RQo58XMQZZ6lrS28sjX1rAs/o4SH4t8XgaWKHyUJXwmiPpv
 ov7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/M45YtMWBHvWX7HJgiaCX3duzycDxACgeh25TxK15Eg=;
 b=UyPG27h4/QZkAQToQcJC8ODV38YYhcompIhd/8p9qFdf05ya0N635ByjcDrF/drKBI
 ObftHM7RzDG6dL3ycaaqXDSpU0go47hYdgNSGrbaHvBfi1EHfajNoZ4BUGXC+7ybIaFg
 qCORdsfgOpH9JS2zzaX5Iq3ITHfZVsc2kPRkc+9GTOGa954I77KvxtfB8j2wNS++bnK7
 lcrnkrTvE5Xnf2lZZQv73m3RdovxZCaEzByi9oVHHV6kSR0pleumXNKrXO1Ev/NHC3vg
 k8WYfp1pxcTjqRBfm+ZQB76MRH0z4oWUoWe/IN+X8mlfnCPJ/z756Jk2eNaqfu5jN+xE
 KaHg==
X-Gm-Message-State: AOAM533fNwp/a6k+izqy+hdZ0iwHEDg/cr0XKJ1ktei6SIqH3ZYT9+cL
 C/FV8a8VbRV4M3dqxOIAa40=
X-Google-Smtp-Source: ABdhPJw0SEhxpFWNTsu1mkMrCWY8UFWsWPMj03LOTEeqmIC1KaMO+Jigt4JOZdpDCQfeyl7XDV8vHQ==
X-Received: by 2002:a05:6402:6d6:: with SMTP id
 n22mr23176808edy.82.1605642323246; 
 Tue, 17 Nov 2020 11:45:23 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id w2sm727972ejc.109.2020.11.17.11.45.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Nov 2020 11:45:22 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v4 6/7] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
Date: Tue, 17 Nov 2020 20:45:06 +0100
Message-Id: <20201117194507.14843-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201117194507.14843-1-jbx6244@gmail.com>
References: <20201117194507.14843-1-jbx6244@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
 airlied@linux.ie, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org, lgirdwood@gmail.com,
 sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, daniel@ffwll.ch,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Add hdmi-sound node to rk3066a.dtsi, so that it
can be reused by boards with HDMI support.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 67fcb0dc9..f91ce3054 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -49,6 +49,22 @@
 		ports = <&vop0_out>, <&vop1_out>;
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+	};
+
 	sram: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x10000>;
-- 
2.11.0

