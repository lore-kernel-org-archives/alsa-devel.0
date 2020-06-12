Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F292C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:28:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC76A207ED
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L1tEQ/DI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRvp5ktR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC76A207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 672A8166D;
	Fri, 12 Jun 2020 18:27:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 672A8166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591979288;
	bh=4DsMfLJMQXVxy/R7t7qAHX4wz0S2PMFYbo1tNTv9gNc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1tEQ/DIyCmVrIPMxiGqmdsKUSBIFYd6FpBmcHM6qMa4kJLVJzcT1kDE+z2sf7MTi
	 diRm0w6F7B09jdX1Ie0O8cPq4v1tUgLkiVb4MyWB6fg9GtPxJ9R/rQ65GroBmm8ucc
	 x3RDJ5X0O6S9RTjaxTT4ER7djYd+ujAmxxRTZNSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 071B5F801F7;
	Fri, 12 Jun 2020 18:27:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10C51F8021C; Fri, 12 Jun 2020 18:27:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 048DEF800CC
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 18:27:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 048DEF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRvp5ktR"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CGRAm3015312;
 Fri, 12 Jun 2020 11:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1591979230;
 bh=Fkgey716kLKI5iJmQP/27R3X8I0hgKSTact+Z6ZhrrA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=nRvp5ktRa3UD52SFpinmzJWjGxRQgF6w36M+Y5QezRyrFu+O77uOkdTRy5rYRC/9T
 2HAjkKHhYeD82VhVoUaw0508z3QU8ZX8aATV+IiDjNm0gUjY5LPcdFuseNoUtICQjV
 J8WiQ/nQSDELSHTB4ouX2r/5ye2r0+hoM8Y/Czk0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CGRAOA025356;
 Fri, 12 Jun 2020 11:27:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 11:27:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 11:27:09 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CGR9nZ003371;
 Fri, 12 Jun 2020 11:27:09 -0500
Subject: Re: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
To: Mark Brown <broonie@kernel.org>
References: <20200612160603.2456-1-dmurphy@ti.com>
 <20200612160603.2456-2-dmurphy@ti.com> <20200612160922.GL5396@sirena.org.uk>
 <0e482167-71c2-a128-b8b4-a054557d30e9@ti.com>
 <20200612162200.GM5396@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <432c41fe-8afa-2ccb-8917-fd64f4895144@ti.com>
Date: Fri, 12 Jun 2020 11:27:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612162200.GM5396@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
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

Mark

On 6/12/20 11:22 AM, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 11:18:57AM -0500, Dan Murphy wrote:
>> On 6/12/20 11:09 AM, Mark Brown wrote:
>>> On Fri, Jun 12, 2020 at 11:06:03AM -0500, Dan Murphy wrote:
>>>> -	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
>>>> +	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
>>>>    						      GPIOD_OUT_HIGH);
>>> This also changes the name from shut-down to shutdown which will be
>>> incompatible (IIRC we do try -gpio as well as -gpios).
>> Yes the non-standardish name was highlighted by Rob[1].
> Yes, but we released with it so it's an ABI now and we should still
> support the old name.

Well should we then just revert back to the non-standard name and just 
fix up the code?

Or should we support both properties?

Dan

