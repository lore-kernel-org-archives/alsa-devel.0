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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363EC63697
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B8420674
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HhE20eXl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKkdf4FD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B8420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDB1917A9;
	Tue, 17 Nov 2020 20:46:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDB1917A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605642425;
	bh=e+4jMuE3VUHm+2qUjfzAZ4kV4lv1HTbcyOo0fZzpQVk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HhE20eXla4nQ4NNEf5uIoN5lwCPphTrowWs7YqfyVmU3lthg6ecKFGZ/UmARD/wky
	 11DTwwpNTIFsSHHqSfhmf5L6xSVWUWQF85lZjlAGE14CU9hWieRE3wiToHgpos9f5a
	 1bcPEfsfuyHIormZLlnQ37qMlaeAWJKAHCxjoAlE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17325F804C3;
	Tue, 17 Nov 2020 20:45:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C06DDF804BC; Tue, 17 Nov 2020 20:45:31 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BBF6F8025E
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 20:45:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BBF6F8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oKkdf4FD"
Received: by mail-ed1-x541.google.com with SMTP id e18so23767580edy.6
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qLZ92o7SKXRNCO4EpTsjSi6r9gNUjFUim5asS0HF/w0=;
 b=oKkdf4FDYOBcmRjaWF0djFWKvkEqMKLs8V80Y1M3AuCZSdPVZPQadXdiS6A1MtHNlU
 tON1BGPFwyeiGJ1066SUnIc3fqf0Bfv4cjJF8DLF1zA0tHI7XMZcOIiO5+ZzzaGh1jgZ
 tkwRnw4K2HLlTi4Rgr1ErjdxqsqGgJ3RqPaz+IchvRiEGvuLadjlSvx++D3mccEGuKGQ
 3w5aoTYSVWBq+V3BupHllZOk4/0hxww1fmflisiadpt+RRH51V0hqOn+oOILJKje73nu
 L5xBl0gUosjFuWFxdgqFqhJE3jffW4bvC/f7No6YZMBpSJu1ijPc8o0jdH+m3aB4ki1a
 Vfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qLZ92o7SKXRNCO4EpTsjSi6r9gNUjFUim5asS0HF/w0=;
 b=Yu0gbMkRYS1pb4z7MAqjTUe6kYGoP2RmZqj37oW02CC8MuH4Eh7Gw9GUgu0CrOZX1B
 lh786pt9SUkT23txX90iX9V8ABkGMo0xbnSW8RmC7WMY7UL+Ve4/MXQGa0E4Klgjq2dh
 5kjmDBrQu4K9CThOXI4j8S7G3nAJDgBNVMiHksCu77w+XzkTSP8q9mh4HF0ScDEjExye
 Uip98mC/aHgw2ZckKwLdH1dcNg8SxXdH3XgdXL0wPG945OF6OYf+Y5ro8rTy9iWGpWUC
 YEB/qnhaBKuH2ixmzohBskBgiXQpRh5KPq3S5Rc3sozhkaoeOMTwp8PULN8x9VMekU4L
 rlZA==
X-Gm-Message-State: AOAM533ZgLT5tbFXefEtWFzDXni/c9RKI8BSCxZTCLj5T9uwpU4/BCBO
 28OSooFi9j8DJHM5vjzQ8g0=
X-Google-Smtp-Source: ABdhPJxTXIBU54JqmMAwvF6EOMr/MiPBAO9XomS/YrWcH+/VIo1h+Y3x2QhXOy3CZ7L2oxRaE1WIFA==
X-Received: by 2002:a05:6402:2d7:: with SMTP id
 b23mr21720443edx.196.1605642318630; 
 Tue, 17 Nov 2020 11:45:18 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id w2sm727972ejc.109.2020.11.17.11.45.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Nov 2020 11:45:18 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v4 2/7] clk: rockchip: fix i2s gate bits on rk3066 and rk3188
Date: Tue, 17 Nov 2020 20:45:02 +0100
Message-Id: <20201117194507.14843-3-jbx6244@gmail.com>
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

The Rockchip PX2/RK3066 uses these bits in CRU_CLKGATE7_CON:

hclk_i2s_8ch_gate_en  bit 4 (dtsi: i2s0)
hclk_i2s0_2ch_gate_en bit 2 (dtsi: i2s1)
hclk_i2s1_2ch_gate_en bit 3 (dtsi: i2s2)

The Rockchip PX3/RK3188 uses this bit in CRU_CLKGATE7_CON:

hclk_i2s_2ch_gate_en  bit 2 (dtsi: i2s0)

The bits got somehow mixed up in the clk-rk3188.c file.
The labels in the dtsi files are not suppose to change.
The sclk and hclk names should match for
"trace_event=clk_disable,clk_enable",
so remove GATE HCLK_I2S0 from the common clock tree and
fix the bits in the rk3066 and rk3188 clock tree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index db8c58813..0b76ad34d 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -449,7 +449,6 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 
 	/* hclk_cpu gates */
 	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
-	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
 	GATE(0, "hclk_cpubus", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 8, GFLAGS),
 	/* hclk_ahb2apb is part of a clk branch */
@@ -634,8 +633,9 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 12, GFLAGS,
 			&rk3066a_i2s2_fracmux),
 
-	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
+	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_CIF1, "hclk_cif1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 6, GFLAGS),
 	GATE(HCLK_HDMI, "hclk_hdmi", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 
@@ -728,6 +728,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 10, GFLAGS,
 			&rk3188_i2s0_fracmux),
 
+	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_imem0", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 	GATE(0, "hclk_imem1", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 15, GFLAGS),
 
-- 
2.11.0

