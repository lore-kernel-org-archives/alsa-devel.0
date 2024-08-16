Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953ABC3DA4A
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:40:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31CE62C09;
	Fri, 16 Aug 2024 23:40:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31CE62C09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723844456;
	bh=E5pRy/NZev7CQ+5MeoeycTawER7eb3a9BUaFoSbrWzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F3IHRe6r8/5dOGiB/smn8pRTEQE0ouXbin5DLdnfmBJGTLBqH1TWiGITSan00Byur
	 scKSBSiE4kzVT5JDPNzcrEaL3bgtu7H8HiFiw8vhNaHPvkUxTszXibH618JJxi4x0M
	 pQj6BZl3ggxH/ZrH5kxe5SKEIUfa77uJw22jsaA4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79F5BF805BA; Fri, 16 Aug 2024 23:40:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0431AF80588;
	Fri, 16 Aug 2024 23:40:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE3F6F80423; Fri, 16 Aug 2024 23:35:39 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 94F05F800B0
	for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2024 23:35:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94F05F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cU+b8xGw
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 39B06CE2016;
	Fri, 16 Aug 2024 21:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457D4C32782;
	Fri, 16 Aug 2024 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723844123;
	bh=E5pRy/NZev7CQ+5MeoeycTawER7eb3a9BUaFoSbrWzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU+b8xGwPB2wjrNZN58g5rTTZ0K8gy2cVElnvOdNBJS+eRW2cTS6lty9cFaxEA1GE
	 nvwA8ZyQBoB9dS/JEHAfNUt28/UrQsNEIS2kzi3Al7cI1Ioji8cazLDcD+iPAYZWnO
	 6h2rmgQwXmGs/xssJ8nxyDCA/zRx1SVbFTtP6WXIDgjH8trJzxo+3p26PbZ5jjF5db
	 r5P3sixRrT+GaLUTRd2uX+eNfMF9bMLPOh/F/kKCPJ3PKicBeQajp9fkZtNS0CsYOE
	 LcaAZFcJXdh6W8bSCeUip+QLDhD9hqjKMG4y9TBsEelvDyR/V2v0oXSoSXe66tO1Yf
	 56BQ2GZJ3jCdA==
Date: Fri, 16 Aug 2024 15:35:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org, Kevin Lu <kevin-lu@ti.com>,
	linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Shenghao Ding <shenghao-ding@ti.com>,
	Mark Brown <broonie@kernel.org>, Baojun Xu <baojun.xu@ti.com>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: convert tlv320aic31xx.txt to yaml
Message-ID: <172384412184.2291163.5262701563861623648.robh@kernel.org>
References: <20240814174422.4026100-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814174422.4026100-1-Frank.Li@nxp.com>
Message-ID-Hash: 2H4AO7W2YCGS6QDQX4J3L4V6H4AOSMSC
X-Message-ID-Hash: 2H4AO7W2YCGS6QDQX4J3L4V6H4AOSMSC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2H4AO7W2YCGS6QDQX4J3L4V6H4AOSMSC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 14 Aug 2024 13:44:20 -0400, Frank Li wrote:
> Convert binding doc tlv320aic31xx.txt to yaml format.
> Additional change:
> - add i2c node in example.
> - replace MICBIAS_OFF with MICBIAS_2_0v in example because MICBIAS_OFF have
> been defined in header file.
> - add ref to dai-common.yaml.
> - add #sound-dai-cells.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800000/i2c@30a30000/codec@18:
> 	failed to match any schema with compatible: ['ti,tlv320dac3100']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/sound/ti,tlv320dac3100.yaml      | 127 ++++++++++++++++++
>  .../bindings/sound/tlv320aic31xx.txt          |  77 -----------
>  2 files changed, 127 insertions(+), 77 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

