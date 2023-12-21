Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BA2C35274
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Dec 2023 22:01:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18C32DEE;
	Thu, 21 Dec 2023 23:01:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18C32DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703196117;
	bh=Mu966ENzqAzL5zVpXkX0okIrHoGjPvhJ8rqTFtXNsxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s85xxTIBBRWJonYg37cKO1VH+sq3zCmEygZ2wflenCBxfWig0sI5fkQw/3OWGAJXZ
	 +yOs5DguT0a+qbOZih4AxQppIun98uJeZiuSSdAUWyCFDr1+BtHO/HAeU3x1rK+Xjg
	 1s/nH398R3ncBrHqV8zfNItXxlPQbjz8wp1lPznM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92231F805B6; Thu, 21 Dec 2023 23:01:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62AE4F805AB;
	Thu, 21 Dec 2023 23:01:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 239B2F80568; Thu, 21 Dec 2023 23:01:20 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0C32F804DA
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2023 23:01:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0C32F804DA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=S2O8QXVK
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 8AEDAB821CD;
	Thu, 21 Dec 2023 22:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B2EC433C8;
	Thu, 21 Dec 2023 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703196075;
	bh=Mu966ENzqAzL5zVpXkX0okIrHoGjPvhJ8rqTFtXNsxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2O8QXVKb3ZUGIFC0OpGxRRynfGqmj+gp7FTRV7NaqGkWM4IE05+Gqd4cUFQEQYL4
	 wG8CTj9V0h17GQd4DGWTQ/ID88OjucDGd4K+yDcA/dII3YbqJZwo8/WEGbw+0/BCww
	 uvzyeWwpnjNf8BE09DbyfTe4eatwQUCKS88qqoFVuq4Fb0xHA3dCIj/qvA6T9heVw1
	 XMReR5iaSQzexSnB5wS2XhpBfBxtK/INvsJIBmzcaV4NgQ/FFgNRrpnmVxI9gmQ0P9
	 68dzeUi++eubqSxVn0qTA5U4n6uBSTfo0lld+kP5+b9rRlCVwpuJxK42akZsycfsTr
	 Hh/bbpwOTtWRw==
Received: (nullmailer pid 166032 invoked by uid 1000);
	Thu, 21 Dec 2023 22:01:11 -0000
Date: Thu, 21 Dec 2023 16:01:11 -0600
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: mchehab@kernel.org, rcsekar@samsung.com, olivier.moysan@foss.st.com,
 Frank Rowand <frowand.list@gmail.com>, dmaengine@vger.kernel.org,
 linux-crypto@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
 mkl@pengutronix.de, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 davem@davemloft.net, conor+dt@kernel.org, fabrice.gasnier@foss.st.com,
 pabeni@redhat.com, linux-media@vger.kernel.org, catalin.marinas@arm.com,
 netdev@vger.kernel.org, Oleksii_Moisieiev@epam.com,
 linux-serial@vger.kernel.org, hugues.fruchet@foss.st.com,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, arnd@kernel.org,
 linux-iio@vger.kernel.org, will@kernel.org, edumazet@google.com,
 linux-stm32@st-md-mailman.stormreply.com, krzysztof.kozlowski+dt@linaro.org,
 ulf.hansson@linaro.org, alexandre.torgue@foss.st.com,
 devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
 herbert@gondor.apana.org.au, vkoul@kernel.org, robh+dt@kernel.org,
 kuba@kernel.org, wg@grandegger.com, lee@kernel.org, peng.fan@oss.nxp.com,
 linux-phy@lists.infradead.org, arnaud.pouliquen@foss.st.com,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 linux-arm-kernel@lists.infradead.org, andi.shyti@kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH v8 06/13] of: property: fw_devlink: Add support for
 "access-controller"
Message-ID: <170319607084.165973.14576693798188042387.robh@kernel.org>
References: <20231212152356.345703-1-gatien.chevallier@foss.st.com>
 <20231212152356.345703-7-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212152356.345703-7-gatien.chevallier@foss.st.com>
Message-ID-Hash: YH7VS3TPMO52GAV2RPOOXH6AZIJS2SJF
X-Message-ID-Hash: YH7VS3TPMO52GAV2RPOOXH6AZIJS2SJF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YH7VS3TPMO52GAV2RPOOXH6AZIJS2SJF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 12 Dec 2023 16:23:49 +0100, Gatien Chevallier wrote:
> Allows tracking dependencies between devices and their access
> controller.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> 
> Changes in V6:
>     	- Renamed access-controller to access-controllers
> 
> Changes in V5:
> 	- Rename feature-domain* to access-control*
> 
> Patch not present in V1
> 
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

