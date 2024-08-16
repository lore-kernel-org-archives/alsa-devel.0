Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FB2C52D7D
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:41:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A5B82C12;
	Fri, 16 Aug 2024 23:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A5B82C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723844467;
	bh=aCbMzVqI8Gt1qrS/CvCiLsKB2HJ1HtyWwRU+x7CdzEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eXQpyiugAbh4QTAvo6pLUX88Qfcx68veU0n9q68/SvL9eLBrQ9mUOt9XAnG2kpkuc
	 m2ze0at11nBcwIpn+pilyp30XuIEdVI1VIjCYFCYGgP++XhSC4wGRzIpsiqTzoPQRf
	 738Hz0rfVNDFfzBRblOv9vrNq6ihH75UxAswo+Ds=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48FC9F805E9; Fri, 16 Aug 2024 23:40:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95007F805E1;
	Fri, 16 Aug 2024 23:40:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DAF2F80423; Fri, 16 Aug 2024 23:37:46 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 92EAEF8016E
	for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2024 23:37:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92EAEF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=F9XhEKeK
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C080BCE20BC;
	Fri, 16 Aug 2024 21:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F1CC32782;
	Fri, 16 Aug 2024 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723844260;
	bh=aCbMzVqI8Gt1qrS/CvCiLsKB2HJ1HtyWwRU+x7CdzEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9XhEKeK46Nfrhal5YW2CTH8AYTrg2rden9ipRGn3m8tSq1qB2GxDFWvb1VqC1CPX
	 86Hb7vDdybQU7WD8qL15DJSI+Ub+lr90KWuSYZJNYTDQ/ddn9GND77KNttun5+3ieg
	 pni9CL0zUwOS0C4q5HKdVBiiu0dDR0mXgdBSdYZrtcc3PagNIKqGjrIoJYPBQlk+YX
	 bhw3jUkX9fgx9p8hk32BZz59poKcRdYZUBYAh24K+FSq+2R2Zrm9JQXFR2+sEcWnPz
	 cNBAukzoeMZtajMuEcyzMZBn3a+YRBBoQLvXjYMMO0/uMP+Qmdrcb2iHRxQhRzFyEE
	 rx+3c6+1CMyYQ==
Date: Fri, 16 Aug 2024 15:37:39 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	Shenghao Ding <shenghao-ding@ti.com>, linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kevin Lu <kevin-lu@ti.com>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Baojun Xu <baojun.xu@ti.com>,
	alsa-devel@alsa-project.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: Convert tpa6130a2.txt to yaml
Message-ID: <172384423481.2293778.2612322675664493468.robh@kernel.org>
References: <20240814175129.4027097-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814175129.4027097-1-Frank.Li@nxp.com>
Message-ID-Hash: WA4CF6WY6Q7FE437QDZLGZI3X6GKGQSR
X-Message-ID-Hash: WA4CF6WY6Q7FE437QDZLGZI3X6GKGQSR
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WA4CF6WY6Q7FE437QDZLGZI3X6GKGQSR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 14 Aug 2024 13:51:28 -0400, Frank Li wrote:
> Convert binding doc tpa6130a2.txt to yaml format.
> Additional change:
>   - add ref to dai-common.yaml
>   - add i2c node in example
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800000/i2c@30a20000/amp@60:
> 	failed to match any schema with compatible: ['ti,tpa6130a2']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/sound/ti,tpa6130a2.yaml          | 55 +++++++++++++++++++
>  .../devicetree/bindings/sound/tpa6130a2.txt   | 27 ---------
>  2 files changed, 55 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tpa6130a2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tpa6130a2.txt
> 

With MAINTAINERS fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

