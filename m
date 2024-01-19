Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027B5C4725D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jan 2024 22:07:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3553B202;
	Fri, 19 Jan 2024 23:07:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3553B202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705702063;
	bh=bAiP8neWkuFOr1UcviXY9sGWpEscgq5SMLZxG3s9Dt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z+AgqQhsj6h/JrK9QPuD9y5VHTCW7bzTvQHHtL4KWjyiGfGRD7y5HDlQ7ozbVweZm
	 10lC4MGIbDaBG71ED6JzBKHROZTr38RHWjJoo0GZ0V2HUzh2KezLtQlC0xhA1ELerw
	 j6JtKvKPM4qIgwRoaGCQSVx2cSTa0XIIW++Hq0XE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37BB4F80570; Fri, 19 Jan 2024 23:07:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B6F91F8056F;
	Fri, 19 Jan 2024 23:07:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C83DF801F5; Fri, 19 Jan 2024 23:07:05 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 301A9F800C1
	for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2024 23:06:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 301A9F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=H0eg5u8Q
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8097C6160B;
	Fri, 19 Jan 2024 22:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E49C433F1;
	Fri, 19 Jan 2024 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705702012;
	bh=bAiP8neWkuFOr1UcviXY9sGWpEscgq5SMLZxG3s9Dt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0eg5u8QwEQ6ypQgu+Ro/nkwaVoSk6fZjoWXqYEmXDBBypv3SaURpbSvuGPnkUm9o
	 0iLO54XqFDrY5SKuQZx1PtWWdbaWIgzQTzV0z70555OEw/cl0wpl9rZN9FKfkiyBAu
	 SnG9Ko2Xb/Ck170Mviz7ss9Pl+yNAe9Xg7Gdjqf86+CfI4wXVZ78Auk6i3XkpHvEn8
	 o34tv8O0Sbg6s3KM1vurE0tBmVLz8HbPfZTpKnkQxTLGN+n1rFaTju4cEt2Sd0Ic8a
	 RkPd0onKWlpH1K9oGo+Gggwbv4VFEK2eJRyldbIWTPpp09a5rhij2/rv2jp9evvYPK
	 wyA/FwbQHedSA==
Date: Fri, 19 Jan 2024 16:06:48 -0600
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: olivier.moysan@foss.st.com, gregkh@linuxfoundation.org,
	richardcochran@gmail.com, arnd@kernel.org,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, mchehab@kernel.org, peng.fan@oss.nxp.com,
	pabeni@redhat.com, rcsekar@samsung.com,
	alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
	linux-serial@vger.kernel.org, Oleksii_Moisieiev@epam.com,
	linux-spi@vger.kernel.org, will@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
	conor+dt@kernel.org, linux-mmc@vger.kernel.org, kuba@kernel.org,
	linux-media@vger.kernel.org, arnaud.pouliquen@foss.st.com,
	andi.shyti@kernel.org, ulf.hansson@linaro.org,
	Frank Rowand <frowand.list@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-phy@lists.infradead.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org, lee@kernel.org,
	catalin.marinas@arm.com, mkl@pengutronix.de,
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, hugues.fruchet@foss.st.com,
	edumazet@google.com, netdev@vger.kernel.org, vkoul@kernel.org,
	wg@grandegger.com, linux-i2c@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH v9 02/13] dt-bindings: treewide: add access-controllers
 description
Message-ID: <170570200425.1132338.1743644162144723458.robh@kernel.org>
References: <20240105130404.301172-1-gatien.chevallier@foss.st.com>
 <20240105130404.301172-3-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105130404.301172-3-gatien.chevallier@foss.st.com>
Message-ID-Hash: QKMRSM3UQLRQ7FL2JLIOQNYXRHSEGISZ
X-Message-ID-Hash: QKMRSM3UQLRQ7FL2JLIOQNYXRHSEGISZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QKMRSM3UQLRQ7FL2JLIOQNYXRHSEGISZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 05 Jan 2024 14:03:53 +0100, Gatien Chevallier wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> Description of this property is added to all peripheral binding files of
> the peripheral under the STM32 firewall controller. It allows an accurate
> representation of the hardware, where various peripherals are connected
> to a firewall bus. The firewall can then check the peripheral accesses
> before allowing its device to probe.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> 
> Changes in V6:
> 	- Minor changes in commit message
> 	- Renamed access-controller to access-controllers
> 
> Changes in V5:
> 	- Discarded review tags as the content has changed
> 	- Renamed feature-domains to access-controller
> 
> Changes in V4:
> 	- Added Jonathan's tag for IIO
> 
> Changes in V2:
> 	- Add missing "feature-domains" property declaration
> 	  in bosch,m_can.yaml and st,stm32-cryp.yaml files
> 
>  Documentation/devicetree/bindings/crypto/st,stm32-cryp.yaml   | 4 ++++
>  Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml   | 4 ++++
>  Documentation/devicetree/bindings/dma/st,stm32-dma.yaml       | 4 ++++
>  Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml    | 4 ++++
>  Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml       | 4 ++++
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml   | 4 ++++
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 4 ++++
>  Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml   | 4 ++++
>  Documentation/devicetree/bindings/media/cec/st,stm32-cec.yaml | 4 ++++
>  Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml    | 4 ++++
>  .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml        | 4 ++++
>  Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml   | 4 ++++
>  Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml    | 4 ++++
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml          | 4 ++++
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml    | 4 ++++
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml        | 4 ++++
>  Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml  | 4 ++++
>  .../devicetree/bindings/regulator/st,stm32-vrefbuf.yaml       | 4 ++++
>  Documentation/devicetree/bindings/rng/st,stm32-rng.yaml       | 4 ++++
>  Documentation/devicetree/bindings/serial/st,stm32-uart.yaml   | 4 ++++
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml     | 4 ++++
>  Documentation/devicetree/bindings/sound/st,stm32-sai.yaml     | 4 ++++
>  Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml | 4 ++++
>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml      | 4 ++++
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml       | 4 ++++
>  Documentation/devicetree/bindings/usb/dwc2.yaml               | 4 ++++
>  26 files changed, 104 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

