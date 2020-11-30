Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CAC64E8A
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 01:53:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB30E20757
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 01:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B06iPhGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB30E20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FD5116D0;
	Mon, 30 Nov 2020 02:52:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FD5116D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606701189;
	bh=MY+LW17GSXVBizLZira9jUeS58ZgUnulaWts5neqjpY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B06iPhGE9+TF1feEW9G39Gf5nAtHv3LpYJSAqrTxXEBCNCDVFq3DzSuUi3+F5iDvM
	 j9oN4C80QQoEc0zz9DD+jSre1CRQAygw7dpJujhqHpQ6+Hxfx8rrgg27PXif6PvVhk
	 Nn49y31Ssl6WdRGVql3E11ss3QsmUdNB3l87P4Xw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B851EF80148;
	Mon, 30 Nov 2020 02:52:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14A5EF80168; Mon, 30 Nov 2020 02:52:17 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E90CBF80087
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 02:52:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E90CBF80087
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74]
 helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1kjYME-0007OY-Vw; Mon, 30 Nov 2020 02:52:03 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: (subset) [PATCH v5 0/7] Enable rk3066a HDMI sound
Date: Mon, 30 Nov 2020 02:51:58 +0100
Message-Id: <160670107988.1055391.2625216014157320355.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, lgirdwood@gmail.com,
 mturquette@baylibre.com, hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org,
 daniel@ffwll.ch, sboyd@kernel.org, linux-clk@vger.kernel.org,
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

On Wed, 18 Nov 2020 14:58:15 +0100, Johan Jonker wrote:
> First fix some legacy things in clk-rk3188.c that was never updated,
> because probably nobody used rk3066a I2S before in the mainline kernel.
> Update the rk3066a HDMI documents with a #sound-dai-cells property.
> Include the code for sound in the HDMI driver.
> Add a simple-sound-card compatible node to rk3066a.dtsi,
> because I2S0 and HDMI TX are connected internally.
> And as last enable rk3066a HDMI sound in the rk3066a-mk808.dts file.
> 
> [...]

Applied, thanks!

[1/7] clk: rockchip: add CLK_SET_RATE_PARENT to sclk for rk3066a i2s and uart clocks
      commit: 5868491e1257786628fdd2457dfb77609f49f91d
[2/7] clk: rockchip: fix i2s gate bits on rk3066 and rk3188
      commit: caa2fd752ecb80faf7a2e1cdadc737187934675e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
