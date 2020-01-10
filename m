Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A385FC282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:09:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B690920673
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L9MJ9SLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B690920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE60916A9;
	Fri, 10 Jan 2020 17:09:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE60916A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578672593;
	bh=C3wIsxm4KmCfMLbk+eVgEUlDd37UXyAC9ia83VtBz4E=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L9MJ9SLDjejfLomH1oFI9jRmACSr4aVITAEdAC9ai4zgN50s++tpP5G5IKdRcyhhB
	 xLhFPPH+tI+QDxfa/dmeeLynV1kRQzyGzu1AuZOYwAGwK8+r5H6Dl3XwWl/hjLndYR
	 xy0cn1A7pZHdD1hkbq5O/1Y6+KKY+A4JdH0Et8q8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30C85F80116;
	Fri, 10 Jan 2020 17:09:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6250AF8011C; Fri, 10 Jan 2020 17:09:01 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8569FF800E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 17:08:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8569FF800E4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 08:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; d="scan'208";a="224235858"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164])
 ([10.251.145.164])
 by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:08:52 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
 <20191227090826.GM3006@vkoul-mobl>
 <5be4d9df-0f46-d36f-471c-aae9e1f55cc0@linux.intel.com>
 <20200106054221.GN2818@vkoul-mobl>
 <32ae46a7-59ee-4815-270a-a519ff462345@linux.intel.com>
 <20200110064303.GX2818@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <39000dd7-3f77-bc33-0ad3-aa47ba2360f7@linux.intel.com>
Date: Fri, 10 Jan 2020 10:08:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110064303.GX2818@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


>>> The "big" difference is that probe is called by core (asoc) and not by
>>> driver onto themselves.. IMO that needs to go away.
>>
>> What I did is not different from what existed already with platform devices.
>> They were manually created, weren't they?
> 
> Manual creation of device based on a requirement is different, did I ask
> you why you are creating device :)
> 
> I am simple asking you not to call probe in the driver. If you need
> that, move it to core! We do not want these kind of things in the
> drivers...

What core are you talking about?

The SOF intel driver needs to create a device, which will then be bound 
with a SoundWire master driver.

What I am doing is no different from what your team did with 
platform_register_device, I am really lost on what you are asking.


>>>> FWIW, the implementation here follows what was suggested for Greybus 'Host
>>>> Devices' [1] [2], so it's not like I am creating any sort of dangerous
>>>> precedent.
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/greybus/es2.c#L1275
>>>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/greybus/hd.c#L124
>>>
>>> And if you look closely all this work is done by core not by drivers!
>>> Drivers _should_ never do all this, it is the job of core to do that for
>>> you.
>>
>> Please look at the code again, you have a USB probe that will manually call
>> the GreyBus device creation.
>>
>> static int ap_probe(struct usb_interface *interface,
>> 		    const struct usb_device_id *id)
>> {
>> 	hd = gb_hd_create(&es2_driver, &udev->dev, 	
>>
>>
>> static struct usb_driver es2_ap_driver = {
>> 	.name =		"es2_ap_driver",
>> 	.probe =	ap_probe, <<< code above
>> 	.disconnect =	ap_disconnect,
>> 	.id_table =	id_table,
>> 	.soft_unbind =	1,
>> };
> 
> Look closely the driver es2 calls into greybus core hd.c and gets the
> work done, subtle but a big differances in the approaches..

I am sorry, I have absolutely no idea what you are referring to.

The code I copy/pasted here makes no call to the greybus core, it's 
ap_probe -> gb_hd_create. No core involved. If I am mistaken, please 
show me what I got wrong.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
