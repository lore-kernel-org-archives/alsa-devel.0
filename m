Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4009C00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:53:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3E020578
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NV2FZnnJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAg/Wot2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3E020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8C8D1658;
	Fri, 30 Oct 2020 15:52:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8C8D1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604069613;
	bh=jC0LUumJcBZgXoJcfIauGEXVjrDZQV+Ps8LaPWWCpBw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NV2FZnnJwileWfuuMnkCEaI3A6GiTmAJS7zBpMwJdTeBl8kds45QX2BjI9Usqq2G0
	 NOAck1D432HNiYFtK6l+0y39kJaPtuE5M3zvZoBIUrSq91Ds1sbfTiB7R1ZdOzVjje
	 StIxtxkZf+njem/mOsqkYEI8NuebhYRqmA8SV7bI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2210F80528;
	Fri, 30 Oct 2020 15:47:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F035F80528; Fri, 30 Oct 2020 15:47:41 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F3D5F80524
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 15:47:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F3D5F80524
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HAg/Wot2"
Received: by mail-ot1-x32d.google.com with SMTP id n15so5740607otl.8
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DcxJttVJPuefUSZyGyu/mOpEqxZT+d3F8rDRrStvw20=;
 b=HAg/Wot2lobXoMZzDzeRlBy6HiM7gf8w/Y1DibKsoL2Z1u5vu5Hle8J55reIPywx0g
 DxkAWrZtfKwvNLEPHpNeV0tTEkw5cS+BZFWaQ0W4R76s8RaroOFFPbexCEGAuwQQR9aa
 57JHr1i3T2Mw12C3JHLO09zgWzw0oDIgisNRqz4OwPhX7OeChhkToLGN49IOC9w2eGHQ
 Sc15BZ5CS04UhFSFpH34rOxANPGJ4NRHXKYmRbbeEr3BkSSbGZYFuREJpeWsXXMTwvgs
 1T6osRQ4wMlGruHHruI1zlnUitA+VfP1JXdKj6m8cRcK+N2xKl6VGy70mm1PdKRBkBmV
 5TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DcxJttVJPuefUSZyGyu/mOpEqxZT+d3F8rDRrStvw20=;
 b=COdOT7fjDaT6/RNVGzxGvZUeOBZPgNuYR9a6jBAgAofymdAyjGVMxJFsPaBNDVJgdY
 tGaREJxwe1V5E5GBvLr8MoijtXinbE6f63323OhHdR73Xu3TIuFe6iUzUndon28Gc2Br
 a7g/1+p/5aPWhrKwbkLzX7XzNXwTpIrf0kT0TSyyoenehCaByGtJJibqE37q4UI1FGbs
 yrHGJWu1ZGFlZT8zt/thGYVLN7poIl+sKCE3cYT6BdekUnDSFM6VQJKSEy094Vnt2CLx
 jhJh1q4nFQryrjqT8bzUOSVu4z0RLLaJApQiSraM9jW1vW5X9suJEUn+JHOKY7fU/K74
 IIvw==
X-Gm-Message-State: AOAM531iycJKnMaFGRXtufiRWoL96l7+6ipv21MmmxY8T8B19JqeWA3M
 sbVXVy22IAjOVeS5B0UGC2Odei65sfdKzQ==
X-Google-Smtp-Source: ABdhPJxn9qZf+LM4hk27YO0jHAmOCxZs1cQgIQXn2jsLewVxXPBD1fXNRtSew9+I9GVm6X0MmGEJhg==
X-Received: by 2002:a9d:1c7:: with SMTP id e65mr2089985ote.22.1604069254826;
 Fri, 30 Oct 2020 07:47:34 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr.
 [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:47:34 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v10 13/15] arm64: defconfig: Enable Allwinner i2s driver
Date: Fri, 30 Oct 2020 15:46:46 +0100
Message-Id: <20201030144648.397824-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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

Acked-by: Chen-Yu Tsai <wens@csie.org>
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

