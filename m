Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72B6E7106D
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 13:44:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7968586F;
	Thu, 21 Sep 2023 15:43:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7968586F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695303856;
	bh=EWdJvIwF6uv0RWl2Gt/yW75HzMTZ/s3XRzzcEYnfV7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aTXErDzIYTm1XG1MJkieM8EIuwX6u+z9bAfci452bzWRLdgKlJstD1dAU8T8ShE6R
	 lx1Aawe/l7s+iQoIKbZHhVrTqgyJfYA9uscckklrjptEK/7hmgBApoJ7LCex02rJeO
	 fsjn340bp0BzxtynLIIb3GGITJCmMsThBHchlfp8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03C35F8025A; Thu, 21 Sep 2023 15:43:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B7B1CF8025A;
	Thu, 21 Sep 2023 15:43:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05346F8025A; Thu, 21 Sep 2023 15:43:20 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 24CCAF800AA
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 15:43:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24CCAF800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QH0o15QG
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C1BC4B8204F;
	Thu, 21 Sep 2023 13:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20FC4E685;
	Thu, 21 Sep 2023 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695303788;
	bh=EWdJvIwF6uv0RWl2Gt/yW75HzMTZ/s3XRzzcEYnfV7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QH0o15QG+AubVg6W1pk+o3mUkrKs+CPmKCMeHbIP1NMLSk+MCAMvzuby9ymnvm0l+
	 kcRFHkUzLgmT18elmBM8npwxFYWov8LWYK4xwcb36u78XXIktx9JgCpO/gFilF26P+
	 sJYdwerntMLkuNJoHidrfuR/Dtf9VoaY6DySkwWlTgCLFS62/iUVO/77lyxW0awSjh
	 e+Na9Fgm4E0lIFMtDuxLp4NuelMx7q3NKWawVBceg+HYdNsMGU0DhVLNJWq9raAmg2
	 uTfklCCHQXvDvD8Gv9HSfn8SKqdxhGrbExHxWVea06k7LponKAdd0t6s+MVBcxKP9q
	 k7+r35VqwpAZw==
Date: Thu, 21 Sep 2023 15:43:05 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 08/31] phy: rockchip-inno-usb2: Split ID interrupt phy
 registers
Message-ID: <ZQxIaU6ITbTGBkVC@matsya>
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-9-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829171647.187787-9-knaerzche@gmail.com>
Message-ID-Hash: DUVNQPFKZGVFV6TZIEV552HDHI2TYPT4
X-Message-ID-Hash: DUVNQPFKZGVFV6TZIEV552HDHI2TYPT4
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DUVNQPFKZGVFV6TZIEV552HDHI2TYPT4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 29-08-23, 19:16, Alex Bee wrote:
> Commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ") added ID
> detection interrupt registers. However the current implementation assumes
> that falling and rising edge interrupt are always enabled in registers
> spaning over subsequent bits.
> That is not the case for RK312x's version of the phy and this
> implementation can't be used as-is, since there are bits with different
> purpose in between.
> 
> This splits up the register definitions for id_det_en, id_det_en and
> id_det_clr registers in rising and falling edge variants.
> It's required as preparation to support RK312x's Innosilicon usb2 phy as
> well in this driver and matches pretty much to what the vendor does, so I'm
> not expecting issues for other SoCs with that change.

This fails to apply for phy/next

-- 
~Vinod
