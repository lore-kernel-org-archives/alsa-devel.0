Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7758C77B73
	for <alsa-devel@archiver.kernel.org>; Wed, 31 May 2023 04:29:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D37F03E8;
	Wed, 31 May 2023 06:28:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D37F03E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685507351;
	bh=g9gEk9ucZABjhCJRLeSNeLHuSwXc1EUU4mIGULdD1n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fcofbxYqGAqFAfUnt/iI+/spFhs+XuvFSsLuvhdlb/z9T1qJ6VpKOE2oQGNofMre7
	 m4oO4bTKyxxrVjnkU6EAgG54CdnldAi8UZLpXU3waQC5laxL6uZ19r1PiTZlrWkMsO
	 7McVCH6ramjzFgT2CqeKFBp5p+/AAdY15xMRHOtA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6AB78F80510; Wed, 31 May 2023 06:27:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 869A0F80510;
	Wed, 31 May 2023 06:27:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D423F805B1; Wed, 31 May 2023 06:27:16 +0200 (CEST)
Received: from muru.com (muru.com [72.249.23.125])
	by alsa1.perex.cz (Postfix) with ESMTP id A5FA6F805AE
	for <alsa-devel@alsa-project.org>; Wed, 31 May 2023 06:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5FA6F805AE
Received: from localhost (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTPS id E585681A7;
	Wed, 31 May 2023 04:27:02 +0000 (UTC)
Date: Wed, 31 May 2023 07:27:01 +0300
From: Tony Lindgren <tony@atomide.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 1/7] dt-bindings: phy: intel,combo-phy: restrict node
 name suffixes
Message-ID: <20230531042701.GO14287@atomide.com>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: YCQ7Z3MVUAQGEVSQ7Y3Q5S4STHU65PWD
X-Message-ID-Hash: YCQ7Z3MVUAQGEVSQ7Y3Q5S4STHU65PWD
X-MailFrom: tony@atomide.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YCQ7Z3MVUAQGEVSQ7Y3Q5S4STHU65PWD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [230530 14:49]:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.

Reviewed-by: Tony Lindgren <tony@atomide.com>
