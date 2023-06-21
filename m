Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E2FEB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 17:34:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 176CA82B;
	Wed, 21 Jun 2023 19:33:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 176CA82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687368849;
	bh=VfqGpYEIglQTk51i33OR5r1TFrQwDJbPB0c/7MTgQXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G3nXojM8W3LsSLeguVAwNGfXEtbpOcwgqyTbS8b/4a9dp8XEvNhAVV+nENSooQ4eX
	 bIHsglGgTuF+AzwZWtCLWqVbvpo37GBi9mUE8gbuPcnOVdJ0C6MuXKZk0PmhOPhMLc
	 /ekK4IihfBQ8wt2d4GU9pe4finhjovPkusUnCc4w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A44C0F80535; Wed, 21 Jun 2023 19:32:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F012EF80141;
	Wed, 21 Jun 2023 19:32:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4EBEF80141; Wed, 21 Jun 2023 19:32:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B43B7F80124
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 19:32:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B43B7F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lL5Wji/o
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED9D615FF;
	Wed, 21 Jun 2023 17:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F215EC433C8;
	Wed, 21 Jun 2023 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687368750;
	bh=VfqGpYEIglQTk51i33OR5r1TFrQwDJbPB0c/7MTgQXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lL5Wji/oNVr5PUKpng4sRLy9k9e/N1ftHA1H/u/QEfYMDF0txKa82VpDKcAWyENjq
	 9nFIxmUQ7OBdkawD4EgQTkdU0NN4WpeZkzIjDP76oY4AVYMD2Ve/9hScaIytGN5BD2
	 63jFjGe9ZIQBlCs2KzuYLE97Hv90ScP6yvHeyjp3lBHawrxbcIXXqzcaolcAHyUu20
	 RvVg5VUVR7oWBlnMjagDmW4se5Ij8db88LJB5ugxm2M7iT2tlHntQB51Dw55hhjoIb
	 69Yw7/LdTsDiPfDCzfXM2Ro0OAaZhHUdyOuQGIWEDkCugjRNycgeL8MQKN9AV3PIG2
	 8yytwf9fE/QwA==
Date: Wed, 21 Jun 2023 23:02:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>, Dipen Patel <dipenp@nvidia.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dilip Kota <eswara.kota@linux.intel.com>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
	linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 1/7] dt-bindings: phy: intel,combo-phy: restrict node
 name suffixes
Message-ID: <ZJM0Kh8+ZzfiFQlg@matsya>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: 3TCT7TDZRPNAVANC7MOZ2OJXIUXVNUJH
X-Message-ID-Hash: 3TCT7TDZRPNAVANC7MOZ2OJXIUXVNUJH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3TCT7TDZRPNAVANC7MOZ2OJXIUXVNUJH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 30-05-23, 16:48, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.

Applied, thanks

-- 
~Vinod
