Return-Path: <SRS0=ZdwS=HS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A408C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 14:58:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F7364E07
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 14:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F7364E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0417850;
	Tue, 16 Feb 2021 15:57:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0417850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613487488;
	bh=bOCPseYYGvArkT5mu3VU8UuojJ6kMS4SwFb0n/OmXig=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A+hnOOXNJOr0L5nrLabZYcoZ73xh7y/ixvOB5JjWL2iU4ztWIZaaU+/54ARPZaLhQ
	 YzKu73EhiBN5XbmPcZDNWiXKIZ1Zvm3C3opwwpptIV/SLJxw94BixkrKWkSBniy5gB
	 3qsSX5dTAB2WDV52wQkmV9HGP7hm+Qja2scNlFRg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42CBCF80155;
	Tue, 16 Feb 2021 15:57:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95905F8015A; Tue, 16 Feb 2021 15:57:16 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11AC4F800AE
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2021 15:57:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11AC4F800AE
IronPort-SDR: gTHNaHOXGHREL7MfjCNYpIxxS91qqdUpJZyFIn4AI6GqyCTaOho+i+QIQ5UlLkvQm83RM/5AFZ
 2JNfLRbymoKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246969179"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; d="scan'208";a="246969179"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 06:57:02 -0800
IronPort-SDR: Zq8HeEFeVHOnTSnG3IYXfriCk8fqQlPxgpK1Y13YT0NeoKk6/diCeKu85sfiEYrJMO2cvVSdy8
 8Xdh08xlsvxA==
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; d="scan'208";a="361706392"
Received: from nshettyk-mobl1.amr.corp.intel.com (HELO [10.212.9.66])
 ([10.212.9.66])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 06:56:58 -0800
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To: Perry Yuan <perry979106@gmail.com>, Perry Yuan <Perry.Yuan@dell.com>,
 oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
 mgross@linux.intel.com
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
 <bf048701-4e6b-ad18-1a73-8bca5c922425@linux.intel.com>
 <79277bf2-3c9e-8b66-47a9-b926a2576f7f@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31982e8d-3b0d-7187-8798-900f95d876ee@linux.intel.com>
Date: Tue, 16 Feb 2021 08:56:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <79277bf2-3c9e-8b66-47a9-b926a2576f7f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mario.Limonciello@dell.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 platform-driver-x86@vger.kernel.org, broonie@kernel.org
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


>>> +static const struct acpi_device_id privacy_acpi_device_ids[] = {
>>> +    {"PNP0C09", 0},
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
>>> +
>>> +static struct platform_driver dell_privacy_platform_drv = {
>>> +    .driver = {
>>> +        .name = PRIVACY_PLATFORM_NAME,
>>> +        .acpi_match_table = ACPI_PTR(privacy_acpi_device_ids),
>>> +    },
>>
>> no .probe?
> Originally i added the probe here, but it cause the driver  .probe 
> called twice. after i use platform_driver_probe to register the driver 
> loading process, the duplicated probe issue resolved.
> 
> I
>>
>>> +    .remove = dell_privacy_acpi_remove,
>>> +};
>>> +
>>> +int __init dell_privacy_acpi_init(void)
>>> +{
>>> +    int err;
>>> +    struct platform_device *pdev;
>>> +    int privacy_capable = wmi_has_guid(DELL_PRIVACY_GUID);
>>> +
>>> +    if (!wmi_has_guid(DELL_PRIVACY_GUID))
>>> +        return -ENODEV;
>>> +
>>> +    privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
>>> +    if (!privacy_acpi)
>>> +        return -ENOMEM;
>>> +
>>> +    pdev = platform_device_register_simple(
>>> +            PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
>>> +    if (IS_ERR(pdev)) {
>>> +        err = PTR_ERR(pdev);
>>> +        goto pdev_err;
>>> +    }
>>> +    err = platform_driver_probe(&dell_privacy_platform_drv,
>>> +            dell_privacy_acpi_probe);
>>> +    if (err)
>>> +        goto pdrv_err;
>>
>> why is the probe done here? Put differently, what prevents you from 
>> using a 'normal' platform driver, and do the leds_setup in the .probe()?
> At first ,I used the normal platform driver framework, however tt cause 
> the driver  .probe called twice. after i use platform_driver_probe to 
> register the driver loading process, the duplicated probe issue resolved.

This sounds very odd...

this looks like a conflict with the ACPI subsystem finding a device and 
probing the driver that's associated with the PNP0C09 HID, and then this 
module __init  creating a device manually which leads to a second probe

Neither the platform_device_register_simple() nor 
platform_driver_probe() seem necessary?
