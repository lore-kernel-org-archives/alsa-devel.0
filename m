Return-Path: <SRS0=1Izd=FK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773BC433FE
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 13:36:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AC92312B
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Dec 2020 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AC92312B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3737717A8;
	Sun,  6 Dec 2020 14:36:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3737717A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607261816;
	bh=s8FuYgKJ78wSn3OGugmA8kez5JuseWvs+rnANyhbNJo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YJny/gbigYrIukp/q90o76/S6EbL/eP3PrvPE9E26PyOwDXi4+sNXKzXLnrhQi8Rh
	 W1xw0KxrAD/5G+NhYO2kLlxOR+bc3NcRYpC9pB3/XnUge1PvNmxEzqwdp1GfUcgrR4
	 vdla2gEwdn+fb+EXTGXZpQmuaRzVWvAZq9x7cB0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E192FF804E2;
	Sun,  6 Dec 2020 14:34:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07C52F804C3; Sun,  6 Dec 2020 14:34:20 +0100 (CET)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18A90F80218
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2020 14:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18A90F80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YdnQLiCB"
Received: by mail-ed1-x542.google.com with SMTP id cm17so10832603edb.4
 for <alsa-devel@alsa-project.org>; Sun, 06 Dec 2020 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
 b=YdnQLiCBK/wBANdCyVFkDIuYa/Owf4imk6/kuZS+qLWOfNAnswRN6psvtJ+xR0sEmt
 ATVRfxNf+UUyiETI3QWMjzXJpGSoB5x0PF4tOzzbpLjuBtI3pBsExo8hF/wendpfC1Ls
 G50g+Gh6D1SAaAgkjYElwb5rF7b5wvXUkO9vFy/fzd/XkZgd+Zc/HqnAoH6PVb8m6saR
 QbtwHR4HI471Ws4jqKUEBawrQDuKmQrjASR3CWaScxinx7qj7hwrObD//yqNrmxiawgC
 rPBMHlrH8dTfgBoq1q84zAdYk8H9J0yq8MjmlJaPa/TvqPsIoqgkycNFhCNKwFNL/oGN
 4PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XzfD+8x/gl2vij+zxF0vgPJlMvOnmt8qPR/mutEO1AU=;
 b=hOrc526Vuri5zex24KChi32QHjhoRRklhsHEAuSJmTR785Txf2xglEsBZ3pl2CigIh
 QSDsVL4qiHBo1gsDHxSzgh5nCvgUiqztIcjRyW0J0wPRckyQmtawaXHm71xRYhcLMKjy
 7+eGa/Ov2dC4bGJPdrGTF+4IYfw8MZheydCTyFO16xNnLIimiHlSn5jSGRBfbVzmeuQ2
 z6iat4oRbd40NuyV+NAfyxJ9HwK1+67gEgjbjznvCSnrUBzQ/sa2PdBZCY9ZF0JOUrEu
 PwnkMjl8rmOOYsPr+IdqDT89qFfSwbJUjcGzosmwIB/wUnIJAOKzXS00S2vqW9skfCwt
 l7Lw==
X-Gm-Message-State: AOAM532LUo8890PSi+W8TmMR24I8zmqN/EdyB/uQF5IPgROltFnFiibh
 TbsBYtZVQn5Y9JERDzQlxK8=
X-Google-Smtp-Source: ABdhPJyTcga5ryTaOcjxeErZN0uSNiSlX+EAdf/VgZlWQgBUllwgGITJy/IVUbE7EtRHuBbkau4EpQ==
X-Received: by 2002:aa7:d784:: with SMTP id s4mr15760934edq.215.1607261649141; 
 Sun, 06 Dec 2020 05:34:09 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id qh23sm7770129ejb.71.2020.12.06.05.34.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 06 Dec 2020 05:34:08 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v6 3/5] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to
 hdmi node
Date: Sun,  6 Dec 2020 14:33:53 +0100
Message-Id: <20201206133355.16007-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206133355.16007-1-jbx6244@gmail.com>
References: <20201206133355.16007-1-jbx6244@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, broonie@kernel.org, hjc@rock-chips.com,
 dri-devel@lists.freedesktop.org, lgirdwood@gmail.com,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org, daniel@ffwll.ch,
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

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to the 'hdmi' node for 'rk3066a.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 252750c97..67fcb0dc9 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -124,6 +124,7 @@
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.11.0

