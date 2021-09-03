Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B16FC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 13:59:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D8A610A2
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 13:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16D8A610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B840D1887;
	Fri,  3 Sep 2021 15:58:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B840D1887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630677573;
	bh=e+Wif2RGx1T6H0/qWTLnsm2hLXFSlfkltNNIUpQwrXQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vpjM44NwGKhp2SScCA4XiMsMNqIXGVHwiT7FWd3S900Xtp5FCv7qh2hSw8MTtqsMg
	 wVYHGygzP/5iSNX/IzxbCov/zyOuWdXXK8q2SFbTsh9Fo1qXTiM8WOUKo50mAtGzTy
	 hbPiOpNy6iqr2jfP6GSQw2M4zm/5J6Nc6oYNTspY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45EDAF80088;
	Fri,  3 Sep 2021 15:58:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1352F80254; Fri,  3 Sep 2021 15:58:40 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB3ADF80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 15:58:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB3ADF80088
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206547521"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; d="scan'208";a="206547521"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2021 06:58:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; d="scan'208";a="462387673"
Received: from seangorm-mobl.amr.corp.intel.com (HELO [10.251.136.111])
 ([10.251.136.111])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2021 06:58:20 -0700
Subject: Re: [PATCH v5 1/2] ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
To: David Rhodes <drhodes@opensource.cirrus.com>, broonie@kernel.org,
 robh@kernel.org, ckeepax@opensource.cirrus.com, brian.austin@cirrus.com,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 david.rhodes@cirrus.com
References: <20210816224310.344931-1-drhodes@opensource.cirrus.com>
 <20210816224310.344931-2-drhodes@opensource.cirrus.com>
 <a0be6858-0d98-7f26-9ba5-f290c9809b5c@linux.intel.com>
 <cdabe1e9-5411-d2b6-d629-8ec87aa4c764@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7c38ddb4-9ccc-130d-e977-4f39b01e2c9e@linux.intel.com>
Date: Fri, 3 Sep 2021 08:58:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cdabe1e9-5411-d2b6-d629-8ec87aa4c764@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



>> Is the ACPI probe smart enough to deal with two different drivers
>> registering for the *same* HID?
>>
>> I haven't seen any precedent, e.g. the RT6777 uses a different ACPI HID
>> for its I2C and SPI modes.
>>
>>
> 
> I2C and SPI buses, when they are looking for a driver with an ID that
> matches a device declared in ACPI, will iterate over drivers that belong
> to the bus only (bus_for_each_drv()). It is not possible for an I2C
> driver to be matched during SPI device enumeration or vice versa.

That's good but that use of the same HID for two different solutions is
still be problematic. On ACPI solutions, we use the HID as a key to
identify what machine driver to load, see e.g. snd_soc_acpi_find_machine().
By using the *same* HID, you will prevent that machine detection from
uniquely identifying what mode is used, and force the machine detection
to be expanded with e.g. DMI-based quirks. It's really far from ideal
for integrators. The only case where this would work with impacts on the
machine selection would be if the choice of the SPI and I2C modes had no
impact on the functionality of the device, but is this really the case?
