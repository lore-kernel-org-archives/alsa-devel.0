Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD928C001DF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 10:42:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCA4AE81;
	Tue,  8 Aug 2023 12:41:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCA4AE81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691491323;
	bh=T1GEx1gBJhD49Ap3dpqLZgH+mosTPhfbhvBfje1Wy3Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qVKfwbgPP1NLzs06zcTfsJQJR3Rf2ITclVAYQfv/mulXoS+sno3owhcoUSjy6RYKi
	 INEWnVcLNC+YavbQTWg+q/HfaV3bewirlW2wz92bh6eEdJruj7nfUgA3GGgld2Pfcy
	 0b43WqvkZ/juzmzGkijhJjdO/yRLnDxWdjLMbXGU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 454D4F80677; Tue,  8 Aug 2023 12:36:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8AB4F80677;
	Tue,  8 Aug 2023 12:36:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDE88F8016D; Mon,  7 Aug 2023 11:09:39 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D023F80087
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 11:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D023F80087
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0BDCF8016;
	Mon,  7 Aug 2023 17:09:21 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 17:09:20 +0800
Received: from [192.168.125.128] (113.72.146.246) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 17:09:19 +0800
Message-ID: <d89facb4-63f0-b30a-3612-639a81195fef@starfivetech.com>
Date: Mon, 7 Aug 2023 17:04:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 5/5] riscv: dts: starfive: Add the nodes and pins of
 I2Srx/I2Stx0/I2Stx1
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxim Kochetkov
	<fido_max@inbox.ru>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>
CC: Jose Abreu <joabreu@synopsys.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Walker Chen <walker.chen@starfivetech.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-riscv@lists.infradead.org>
References: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
 <20230802084301.134122-6-xingyu.wu@starfivetech.com>
 <8fc27960-fa82-c900-0414-75b10a118f15@linaro.org>
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <8fc27960-fa82-c900-0414-75b10a118f15@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.246]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: xingyu.wu@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XV42MS52LQQD6VOWVAFMSUJBXLL3AWZ3
X-Message-ID-Hash: XV42MS52LQQD6VOWVAFMSUJBXLL3AWZ3
X-Mailman-Approved-At: Tue, 08 Aug 2023 10:35:43 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XV42MS52LQQD6VOWVAFMSUJBXLL3AWZ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2023/8/6 5:04, Krzysztof Kozlowski wrote:
> On 02/08/2023 10:43, Xingyu Wu wrote:
>> Add I2Srx/I2Stx0/I2Stx1 nodes and pins configuration for the
>> StarFive JH7110 SoC.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
> 
> ...
> 
>> +
>>  	spi0_pins: spi0-0 {
>>  		mosi-pins {
>>  			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 05f843b8ca03..507312eb6053 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -512,6 +512,30 @@ tdm: tdm@10090000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		i2srx: i2srx@100e0000 {
> 
> Node names should be generic, so:
> i2s@

Will fix. Thanks.

> 
>> +			compatible = "starfive,jh7110-i2srx";
>> +			reg = <0x0 0x100e0000 0x0 0x1000>;
>> +			clocks = <&syscrg JH7110_SYSCLK_I2SRX_BCLK_MST>,
>> +				 <&syscrg JH7110_SYSCLK_I2SRX_APB>,
>> +				 <&syscrg JH7110_SYSCLK_MCLK>,
>> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
>> +				 <&mclk_ext>,
>> +				 <&syscrg JH7110_SYSCLK_I2SRX_BCLK>,
>> +				 <&syscrg JH7110_SYSCLK_I2SRX_LRCK>,
>> +				 <&i2srx_bclk_ext>,
>> +				 <&i2srx_lrck_ext>;
>> +			clock-names = "i2sclk", "apb", "mclk",
>> +				      "mclk_inner", "mclk_ext", "bclk",
>> +				      "lrck", "bclk_ext", "lrck_ext";
>> +			resets = <&syscrg JH7110_SYSRST_I2SRX_APB>,
>> +				 <&syscrg JH7110_SYSRST_I2SRX_BCLK>;
>> +			dmas = <0>, <&dma 24>;
>> +			dma-names = "tx", "rx";
>> +			starfive,syscon = <&sys_syscon 0x18 0x2>;
>> +			#sound-dai-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>>  		usb0: usb@10100000 {
>>  			compatible = "starfive,jh7110-usb";
>>  			ranges = <0x0 0x0 0x10100000 0x100000>;
>> @@ -736,6 +760,47 @@ spi6: spi@120a0000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		i2stx0: i2stx0@120b0000 {
> 
> i2s@

Will fix.

> 
>> +			compatible = "starfive,jh7110-i2stx0";
>> +			reg = <0x0 0x120b0000 0x0 0x1000>;
>> +			clocks = <&syscrg JH7110_SYSCLK_I2STX0_BCLK_MST>,
>> +				 <&syscrg JH7110_SYSCLK_I2STX0_APB>,
>> +				 <&syscrg JH7110_SYSCLK_MCLK>,
>> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
>> +				 <&mclk_ext>;
>> +			clock-names = "i2sclk", "apb", "mclk",
>> +				      "mclk_inner","mclk_ext";
>> +			resets = <&syscrg JH7110_SYSRST_I2STX0_APB>,
>> +				 <&syscrg JH7110_SYSRST_I2STX0_BCLK>;
>> +			dmas = <&dma 47>;
>> +			dma-names = "tx";
>> +			#sound-dai-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2stx1: i2stx1@120c0000 {
> 
> i2s@

Will fix.

Best regards,
Xingyu Wu

