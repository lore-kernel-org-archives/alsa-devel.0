Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C31C55179
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B658020724
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z5LLVzgb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr4NHz6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B658020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDEA816CE;
	Tue, 27 Oct 2020 19:36:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDEA816CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603823830;
	bh=60zxquPKLnsbksZbwegVG6qgSflf7ml96IH/ixcT+5A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5LLVzgbrS5y5wCbW6BCtnacztrsCDSJAzBEWyu2gi95Y9RgvPkZoyOV2K4Bnlm3w
	 zB4tiXvEoGzP6FayDfvvQKJJf6M3ldoRiA4i6SNI//+VkhcE5YbDEsd8XH4xmQll2h
	 nDkTjiapA52s/T4jZuubugQYMUZLpQwFwqCYNHXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4CC1F80511;
	Tue, 27 Oct 2020 19:32:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8D4EF804E5; Tue, 27 Oct 2020 19:32:21 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 304BDF804C2
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 19:32:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 304BDF804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qr4NHz6b"
Received: by mail-wr1-x441.google.com with SMTP id h5so3036311wrv.7
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Q1L59OjiDLpqGnNODju6fMwtd7Ss5Fh+8syeSPkSMs=;
 b=qr4NHz6bm05lZeqaartO3EjR8pFWyaqj3VDBOvDv8jBjxAuQCdrUzUcGSO0hbOFZbI
 cQW/AwGJU4gSV8ALHf077Te761/PN2Y4liN4ZBMbhead6bYJCIqkzDD8WTkknmQhNguh
 2uyKgReepohknYihfBJBbPDoq/Rp8T8yLhzQ3nxtYwaDF44utBCuDdHlnr+/PFmc1wNv
 VPOwRxDPBnCu833tyKv+gMTrbOnZOjLf7xFek3sNzgQOdNwCO4uwPqeegehvxMiB03lI
 JwCvlS3xBOe0WgggzWjpNpT/AoTfBla6sU5JDEMDfqtRHf8L5IGCl9OK3PXkdKXI/Ahw
 s5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Q1L59OjiDLpqGnNODju6fMwtd7Ss5Fh+8syeSPkSMs=;
 b=LB0f93tL05elWkcRWU5XCrzYefc8v6Uc/noSXaXSrI3VkJy/Ox6+y/jR5Gb/w29s5a
 EKnCLSjExDc1rpW179pIleFuxl0vV6hnsU1B2XubmpglSveHTrb9LhJ8gNTDgPMYw3zh
 EvWxTfZ4JmoOIdNUwP2rOfdR0UB+BUUAtnAiBtvhkrkyRIaV5sgQ+GjLdT0/ViohWjvY
 cm03y8Dt5OrCMtKfq1IsRNVcGIu4zm+aSrYi2YAUmhzC+fF88ErWzcw9JlEKvBr2NNea
 sxKUPcCHDjPLg1mGwpZt/f2Ni5aiJiDXMiFaee+s6Uhywy88XSlkAwQheMftRjUAFtdT
 8ftw==
X-Gm-Message-State: AOAM533tgkRaO6w9s70FG3b60aTPeGuKO9kXHwgpQtKBsRUeUPC+8ity
 +PTAZEXNKs60+yH4viCzEx4CCxeRAZe9fA==
X-Google-Smtp-Source: ABdhPJw6yj+heMDTliwHemk6LvJ/wQOTTX6O5m3SvjVsdUREddIGSEd28TtoCEP2g2DrMfqI/9VHDA==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr4631760wrs.342.1603823525818; 
 Tue, 27 Oct 2020 11:32:05 -0700 (PDT)
Received: from localhost.localdomain
 (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
 by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 11:32:04 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v9 12/14] arm64: defconfig: Enable Allwinner i2s driver
Date: Tue, 27 Oct 2020 19:31:47 +0100
Message-Id: <20201027183149.145165-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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

Enable Allwinner I2S driver for arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17a2df6a263e..3f89f427a355 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -706,6 +706,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_I2S=m
 CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
-- 
2.25.1

