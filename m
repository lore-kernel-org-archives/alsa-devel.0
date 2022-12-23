Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CB2C41535
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Dec 2022 09:06:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E235E6EA7;
	Fri, 23 Dec 2022 10:05:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E235E6EA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671786397;
	bh=etoPTdN7fqAEFQVxNFjFob/1OaJkCbXYZY/47T9at1o=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pGAx1iWcUg9F4IcaGgX3gTgB+k5RGa1FEMLnVutVEk1Ijye4IAcwVY7juhBcwsOU8
	 iWri3aND3XZzF//jifvMowSQ/hBrrw31JdgiQjdpA6Yt2grze7FToTcV0tY73BjEfQ
	 VX3b8MMc1Cxm5RWoLuRRFuCotSq6IV+INrcGEFoI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85979F8024E;
	Fri, 23 Dec 2022 10:05:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B53EF804AD; Fri, 23 Dec 2022 10:05:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53CC6F8024E
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2022 10:05:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53CC6F8024E
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=xFkazDvv
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BN95b9k061490;
 Fri, 23 Dec 2022 03:05:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1671786337;
 bh=krWiqS2oUAgZnBdjWUYd7ZyOWML2qAZv4M/kjqLdiK8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xFkazDvv3nVGN9g0bN4pGSRpbSAZpNHC0N5Bq3+E9lLHyMFJdRb6a4nKuzkFNA5XS
 LKgoJd9BkcXJs2Dth0WwBUiisJsp/hRUA6M/UG3a+e2pMBXg/1HWUp/5qESSIt3fSL
 A6+JUJfY7u2XnhGnhwsqNRHRVwkcVkOslXLo9Ris=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BN95bgR011373
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Dec 2022 03:05:37 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 23
 Dec 2022 03:05:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 23 Dec 2022 03:05:37 -0600
Received: from [172.24.145.60] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BN95Z4u028566;
 Fri, 23 Dec 2022 03:05:35 -0600
Message-ID: <c09a1673-7d6c-e2dc-1d29-eef3dc5bd486@ti.com>
Date: Fri, 23 Dec 2022 14:35:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20221221145216.11400-1-j-luthra@ti.com>
 <Y6RCN9DxeW7WacPD@sirena.org.uk>
From: Jai Luthra <j-luthra@ti.com>
In-Reply-To: <Y6RCN9DxeW7WacPD@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Mark,

On 22/12/22 17:10, Mark Brown wrote:
> On Wed, Dec 21, 2022 at 08:22:16PM +0530, Jai Luthra wrote:
>> Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.
>>
>> The following properties are still found in some old dts files, but will
>> be ignored by the driver:
> 
>> - assigned-clock-parents, assigned-clock-rates, assigned-clocks
> 
> These are from the common clock binding and will be handled by the clock
> code.

Thanks, I will send v5 where a follow-up commit adds the missing 
properties for clocks and port in the binding.

--
Jai
