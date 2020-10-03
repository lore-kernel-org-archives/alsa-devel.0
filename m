Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C325C41604
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:24:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FB0206B8
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hZckWPv8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddz+TfC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FB0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11B9F192B;
	Sat,  3 Oct 2020 16:23:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11B9F192B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601735052;
	bh=63PwjMoKOIgU/GVYaDEIDWdFMSqI4wcqX1rFWcHLYp4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZckWPv8LfCLCNzkvpQ6oaGAs7EhZUum/mFWnYVFdZR38urf/Cmpl8ayW8oZnod8O
	 fZjoS9VKtSTkpi9IoFfJTK5iuZMC2Bb+vAtGlNNnc3xKBwk/Fk/DJDGbicjvo+aq/p
	 bzHOh6eaAmY0cuhk2vn4shgrHYdKbopPUAXm7uVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04BECF802FE;
	Sat,  3 Oct 2020 16:20:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3784FF802FF; Sat,  3 Oct 2020 16:20:16 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1ACC4F802E8
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2020 16:20:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ACC4F802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Ddz+TfC8"
Received: by mail-wm1-x342.google.com with SMTP id w2so4363848wmi.1
 for <alsa-devel@alsa-project.org>; Sat, 03 Oct 2020 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wtWLIs+ABqD/g0IXPDD3VKHyPb2fpUunYsOW1RNzSt8=;
 b=Ddz+TfC8thUbjRIWE9CADEThm6NXn/JNQM+w/Q3utD0NBJ6IcW+akyWxTBPAnDpwXZ
 LEgqkF1FrNlGychpUEFYv1iijq7vHGUlyg7oo4BMGbsyCFL7JhXcJc76YOKj2/aLmzO9
 4iN3D56FWZPQ4zXVSCDQRQFnvlrNBCtbuFXgjYkUe7PnoC4Fce+WKgxq6uRnNihvU/Bv
 wHEQa7ceZSmQ5eBM1c4sO9k15TCVWuxOSv9iV/KS/bK8AecdJkwb4tZ/swt3Yu2eDfhT
 nc5OizHUO0ZD4P7qOcHrXW+D8zE63YewwKWCc+qenE2kg0otGmksMtzWiaOwO8deSHO8
 tktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wtWLIs+ABqD/g0IXPDD3VKHyPb2fpUunYsOW1RNzSt8=;
 b=qWGC+CxLUTlOfIiYgx+oeGCIUmikH59BlsPiOBr+WiTjrOX7o+nrzoeTCO/1G2Gp03
 9o6fyA/XqlPTRDAcimkrb6JZxsTF7/PDqtRr/xT7kzPfTuEYSVwgl1rYmU2Qrx8q95JG
 x7xSd8FR3agwNRdJ504AvLL3LVBYb2J8Y0QisyLAaccusJBXBB8acZ0jbsaYwTdkMBd4
 FZ7FDC+Mw4ArE/PM7NlO4S8EthT0Nnxdc5xo9AbOuHN4TBvPT36ROfVscCEecj7+Gj3I
 lxeJhR02BDK77GINTPBrNbX8NXmAssTQENxFK3/c+8AxvWzgp0K9YjW2ihWx8ADmYMQd
 CAnw==
X-Gm-Message-State: AOAM531Im36AXGzXWsmALivvqlrPvOGqemiuvxSxdOcfZyQOT0Vc0R1p
 he+tBVqh9CtTS0fc4GBlrbQ=
X-Google-Smtp-Source: ABdhPJwyRb8w/rx6X6ysFFBP/QwM5NvVJjNcFLbvn8VRGVBYvWjvHFz59deU9DPiR+2A0vSYHgIDsQ==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr2904628wmh.72.1601734811519; 
 Sat, 03 Oct 2020 07:20:11 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr
 (213-245-241-245.rev.numericable.fr. [213.245.241.245])
 by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 07:20:10 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 08/14] ASoC: sun4i-i2s: fix coding-style for callback
 definition
Date: Sat,  3 Oct 2020 16:19:44 +0200
Message-Id: <20201003141950.455829-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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

Checkpatch script produces warning:
WARNING: function definition argument 'const struct sun4i_i2s *'
should also have an identifier name.

Let's fix this by adding identifier name to get_bclk_parent_rate()
and set_fmt() callback definition.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index fef68146d648..86266879d4bc 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -180,13 +180,13 @@ struct sun4i_i2s_quirks {
 	const struct sun4i_i2s_clk_div	*mclk_dividers;
 	unsigned int			num_mclk_dividers;
 
-	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *i2s);
 	int	(*get_sr)(unsigned int width);
 	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(const struct sun4i_i2s *i2s, unsigned int fmt);
 };
 
 struct sun4i_i2s {
-- 
2.25.1

