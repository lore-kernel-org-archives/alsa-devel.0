Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C9C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:46:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF4520773
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mriN0LeF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCArb9Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF4520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A72E1112;
	Tue,  7 Jul 2020 16:45:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A72E1112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594133209;
	bh=KKrFoWs3r1t/bqw5NbBtb/IrinF8OVTLZaCMpSn0t6A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mriN0LeFjpIw9hd4BMo5HmNf+BvjiozwbsiPLmYPrlJ5FfSQbnlZlFsNTd5Zt/F6Z
	 cKcREN8KNxWKn3zTpEmjUI+35z9FH1wS2HLpoKZk6F4NXZyOMIgr94ymEjZ33UFYwG
	 C6iOroPBKFXAqLSekxMH954Nk4YXb7/YHBGUc9Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 608FFF8034F;
	Tue,  7 Jul 2020 16:38:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1D00F80339; Tue,  7 Jul 2020 16:38:19 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DEBCF802EC
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DEBCF802EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="tCArb9Ls"
Received: by mail-wm1-x341.google.com with SMTP id 17so46726644wmo.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GCffUQZ+pBFslq04fueNayccH0ricdllCgVoeeuKMEc=;
 b=tCArb9LsSLq+aVcEfeY/D9+tTEQA8kHXj8jhWU8fUQ/Hfthrxq7wIL0yzRbqiDggKF
 LLb6K/hpGjG6tDzvWLQLDok4RiXnwLVNqo1Ix6PMEE7VUDc/L7RM22VD1/ATUN8Nd+Xo
 SzGI2YL2xDLlGdHYZkf5kWkqnVqyzZ63daz/wUYAPiNfSqNAt9XdYyobyo8fakiRkD6D
 IjsnO/iHnU7jo3f1V5LwfCHwcg9roIE7U06Rm0Y2d8FUXJ/UktGRIySgFCnZelByi3UR
 kO9wusr32JupfE8yYgTpQPQC4wgFjEQplbyc3gahTZvfhO8fiKKCZsL85quYSPIcsm5X
 gGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GCffUQZ+pBFslq04fueNayccH0ricdllCgVoeeuKMEc=;
 b=trnrGvEaAT8CdBe08stmTmzNwtvSKx5dpcuUx5lIH0/GotpnHsUYPUGch0B/j6yqmq
 y2BEHelE5y8LHmgUowsd6tnD8bHHVjxnSPS7JejdMghL/Ol+8xn/ZMlPi4s5GLS4lRSW
 e+ur+qFzacxRsVv8Vgwj45IpYryN7shwrOE+GNod2BWNN3WEteV7/rd7qY5x9WgWrD3v
 xwrpoj2Bl7IE9/WKHCHLbSZFpNMV6YkMtXLNzomHBL4GZ0t/kCDNiGYEAfTzafa+Ua6H
 9s5YqrfFnG8/In4XkMuJ2cizsybFJLaKVCZTxNATkaa9p4SAmgy1TjiAo222YYzfR2Rs
 HyWw==
X-Gm-Message-State: AOAM533iaFs/mLEeD9qbd2CMAy5LBdSva0Vpae9OP3D2OIbPGVtBdnHa
 bj2MMW0UbbYYhHGA28sSkSLTOQ==
X-Google-Smtp-Source: ABdhPJxi/g4zQkVIJX8OngdL3aznYyoNUDfajtADY4HZRSl9CebNjwejLE0wLy1LX5mEM6UT5D72lQ==
X-Received: by 2002:a05:600c:2187:: with SMTP id
 e7mr4499060wme.171.1594132690196; 
 Tue, 07 Jul 2020 07:38:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:38:09 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 16/28] ASoC: sunxi: sun4i-i2s: Demote half-documented
 kerneldoc header
Date: Tue,  7 Jul 2020 15:37:30 +0100
Message-Id: <20200707143742.2959960-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Andrea Venturi <be17068@iperbole.bo.it>,
 Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
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

Ideally the author or someone 'in the know' should come back and
provide the remainder of the documentation.  Until the kerneldoc
checkers have been satisfied, let's just demote the header to a
standard comment block.

Fixes the following W=1 kernel build warning(s):

 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'bclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'num_bclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'mclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'num_mclk_dividers' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'get_bclk_parent_rate' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'get_sr' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'get_wss' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'set_chan_cfg' not described in 'sun4i_i2s_quirks'
 sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member 'set_fmt' not described in 'sun4i_i2s_quirks'

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrea Venturi <be17068@iperbole.bo.it>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a5..34c24e3cedc78 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -126,7 +126,7 @@
 
 struct sun4i_i2s;
 
-/**
+/*
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
-- 
2.25.1

