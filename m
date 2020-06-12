Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F5C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6772A20801
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SoN1wsHg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GAP2vffs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6772A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1ADF166F;
	Fri, 12 Jun 2020 18:19:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1ADF166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591978801;
	bh=aiGv8GVjhluqt3tsZ4oTJAh4DKKZWAziGItkaZ4l0Uc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SoN1wsHgRG8egXyCDjgK1XxwQ9jgaIdhZ94TVA6eQ9Gnzi0KTMwdHiTfhpKs6irEs
	 DhIyE4Sq1pTGKADO8ZRSNBvQZI/AqGg/Iz1bjaEa7Jok97V12Dic3V2GalyHYZYQYp
	 voMhH13Ooq4UEPvrCjAkwfZVCwH0nFexPtSYjytA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 307F6F801F7;
	Fri, 12 Jun 2020 18:19:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36111F8021C; Fri, 12 Jun 2020 18:19:09 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F224FF800CC
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 18:19:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F224FF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GAP2vffs"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CGJ3NZ008385;
 Fri, 12 Jun 2020 11:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1591978743;
 bh=qdnsUxScp0+e7+Rcpeem3AhfcgDvP3Hz7jFw8jx1lT8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=GAP2vffsMCWro9ZC609aRrgEkttKyDM6Il74FmQw2z8xIPhzCPGSy0CYsW/NGLE60
 Ju9BVR4rLSpgInOvL8Gw//psG6ukTo+mIAcM6R7FFDwrp+mChFs6Y2/NoUVsPR2wmV
 RLk2DMSfdaNRzzN4/O3QMueOLcyNW6bv/q9s/6us=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CGJ3Tb127945
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jun 2020 11:19:03 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 11:19:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 11:19:03 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CGJ2Rb045616;
 Fri, 12 Jun 2020 11:19:02 -0500
Subject: Re: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
To: Mark Brown <broonie@kernel.org>
References: <20200612160603.2456-1-dmurphy@ti.com>
 <20200612160603.2456-2-dmurphy@ti.com> <20200612160922.GL5396@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <0e482167-71c2-a128-b8b4-a054557d30e9@ti.com>
Date: Fri, 12 Jun 2020 11:18:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612160922.GL5396@sirena.org.uk>
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

On 6/12/20 11:09 AM, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 11:06:03AM -0500, Dan Murphy wrote:
>
>> -	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
>> +	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
>>   						      GPIOD_OUT_HIGH);
> This also changes the name from shut-down to shutdown which will be
> incompatible (IIRC we do try -gpio as well as -gpios).
Yes the non-standardish name was highlighted by Rob[1].

Also I checked the GPIO library and it looks at both -gpio and gpios as 
property suffixes.

Since this is a single GPIO the singular should be used in this case

[1] https://lore.kernel.org/patchwork/patch/1251670/

Dan

