Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE47C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:37:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005C220738
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pEA13ggl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S1QJCkhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005C220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14AA81888;
	Wed, 24 Jun 2020 19:36:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14AA81888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593020255;
	bh=gk2fjrsiUIKd1s65/70Wp2wlt60QKXl1Nalc1hJlMJ8=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pEA13gglGYbNHtyB2vLI8kBJEbNFf/mGKMsyFNgc8CkNs8wVPJkkOraSBWXDE6pSc
	 7v/Pkdri0yEj/LqcrgvjUnJjUamHwDwEf1tw0Rbu+5CChsd1mHx0COIgZ18OhFdn+t
	 bebEkRTMoCbjH6FyaOSpOxg+Otj6FM2AN0yOxKiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09503F801DB;
	Wed, 24 Jun 2020 19:36:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 660BAF80246; Wed, 24 Jun 2020 19:36:11 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06F4EF80162
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 19:36:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06F4EF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S1QJCkhF"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHa4PC059738;
 Wed, 24 Jun 2020 12:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1593020164;
 bh=b7I1LZjktpXQtE/2SIxPlGxZJRi/hvLLHrKcEtNIZXM=;
 h=Subject:From:To:CC:References:Date:In-Reply-To;
 b=S1QJCkhF8V2NBByGKWtk/vz55e0z8N2FwVrqdXywrH2vywZFUrpZmygqW7vY+d6VS
 epUUkxSSnuWq2cwb/FgbEXggJWNYIj8qrsgQ2/QiwZSAd5FqGcMcAkNnKpiYKGxLD/
 Qz8TWD/dVnP6AXrMZWTYpTFZCv+Fvzl3/uadznk4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHa4ap044210
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jun 2020 12:36:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:36:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:36:03 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHa3tG127913;
 Wed, 24 Jun 2020 12:36:03 -0500
Subject: Re: [PATCH v5 3/7] ASoC: tas2562: Fix format issue for extra space
 before a comma
From: Dan Murphy <dmurphy@ti.com>
To: Mark Brown <broonie@kernel.org>
References: <20200624161459.19248-1-dmurphy@ti.com>
 <20200624161459.19248-4-dmurphy@ti.com> <20200624162917.GK5472@sirena.org.uk>
 <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
Message-ID: <370c71e3-731b-3549-adb0-597abb217cfc@ti.com>
Date: Wed, 24 Jun 2020 12:36:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, devicetree@vger.kernel.org
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

On 6/24/20 11:58 AM, Dan Murphy wrote:
> Mark
>
> On 6/24/20 11:29 AM, Mark Brown wrote:
>> On Wed, Jun 24, 2020 at 11:14:55AM -0500, Dan Murphy wrote:
>>> Fix the issue found that there is an extra space before a comma in the
>>> volume control.
>>>
>>> Fixes: bf726b1c86f2c ("ASoC: tas2562: Add support for digital volume 
>>> control")
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>   arch/arm/boot/compressed/fdt.h             |   66 +
>>>   arch/arm/boot/compressed/libfdt.h          | 2072 
>>> ++++++++++++++++++++
>>>   arch/arm/boot/compressed/libfdt_internal.h |  173 ++
>>>   sound/soc/codecs/tas2562.c                 |    2 +-
>> I'm guessing those libfdt changes weren't supposed to be here?
>
> No they were not those must have been added when I verified the build.
>
Can this patchset get a review as well so I can fix before I post v6?

Not sure what the current work load is for review or merge.

Dan


> Dan
>
