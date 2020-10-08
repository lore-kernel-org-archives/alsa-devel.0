Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D613C4363A
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:32:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F91206F7
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HrRzoic3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F91206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F3681682;
	Thu,  8 Oct 2020 15:31:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F3681682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602163956;
	bh=l9Dps9niKKgPTXJMOfVANsKpaPh5Q67u4NZwUt2itIg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HrRzoic3i713mbC7pCCutxQqlbTNRoT+nEx0FFbTIESqnRDhVJL6qx9nhoYHOAAxK
	 1Qo3/5WrIvhuAsUN5lpeGA3QXUtTGzdiL60lI9yGcoYjkvUPsNAT2PR4pr/bk0DqgG
	 xyWHMS1YUHx6aBrn6M6zNYKI0seujzZZTFopcNtc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89F9FF80163;
	Thu,  8 Oct 2020 15:31:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBA20F80164; Thu,  8 Oct 2020 15:31:43 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89AC3F8015B
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2020 15:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89AC3F8015B
IronPort-SDR: dpnze4/xjDhHtOo0w+p9Ha3aYf5Iqx7xhoJBY8/C285iREXZtt7O7KlFEUd4krj9nN+fWm7fCg
 DM2EgK8IdsgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="182761048"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; d="scan'208";a="182761048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2020 06:31:20 -0700
IronPort-SDR: EDWXFozQHFQugMLk+t2v3OyALx6ntuphaaBF0B3QTsIyGXiDKUwLoWCds50m5lGqyVlFEZQU9B
 zBsNczW2IK+A==
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; d="scan'208";a="528494501"
Received: from kweisner-mobl.amr.corp.intel.com (HELO [10.212.230.16])
 ([10.212.230.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2020 06:31:18 -0700
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
To: Parav Pandit <parav@nvidia.com>,
 "Ertman, David M" <david.m.ertman@intel.com>,
 Leon Romanovsky <leon@kernel.org>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
 <20201006071821.GI1874917@unreal>
 <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal>
 <DM6PR11MB2841C531FC27DB41E078C52BDD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201007192610.GD3964015@unreal>
 <BY5PR12MB43221A308CE750FACEB0A806DC0A0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <DM6PR11MB28415A8E53B5FFC276D5A2C4DD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <c90316f5-a5a9-fe22-ec11-a30a54ff0a9d@linux.intel.com>
 <DM6PR11MB284147D4BC3FD081B9F0B8BBDD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <c88b0339-48c6-d804-6fbd-b2fc6fa826d6@linux.intel.com>
 <BY5PR12MB43222FD5959E490E331D680ADC0B0@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1e2a38ac-e259-f955-07ad-602431ad354b@linux.intel.com>
Date: Thu, 8 Oct 2020 08:29:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB43222FD5959E490E331D680ADC0B0@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "parav@mellanox.com" <parav@mellanox.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Saleem, Shiraz" <shiraz.saleem@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "Patil,
 Kiran" <kiran.patil@intel.com>
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


>>>>> But ... since the init() function is performing both device_init and
>>>>> device_add - it should probably be called ancillary_device_register,
>>>>> and we are back to a single exported API for both register and
>>>>> unregister.
>>>>
>>>> Kind reminder that we introduced the two functions to allow the
>>>> caller to know if it needed to free memory when initialize() fails,
>>>> and it didn't need to free memory when add() failed since
>>>> put_device() takes care of it. If you have a single init() function
>>>> it's impossible to know which behavior to select on error.
>>>>
>>>> I also have a case with SoundWire where it's nice to first
>>>> initialize, then set some data and then add.
>>>>
>>>
>>> The flow as outlined by Parav above does an initialize as the first
>>> step, so every error path out of the function has to do a
>>> put_device(), so you would never need to manually free the memory in
>> the setup function.
>>> It would be freed in the release call.
>>
>> err = ancillary_device_initialize();
>> if (err)
>> 	return ret;
>>
>> where is the put_device() here? if the release function does any sort of
>> kfree, then you'd need to do it manually in this case.
> Since device_initialize() failed, put_device() cannot be done here.
> So yes, pseudo code should have shown,
> if (err) {
> 	kfree(adev);
> 	return err;
> }

This doesn't work if the adev is part of a larger structure allocated by 
the parent, which is pretty much the intent to extent the basic bus and 
pass additional information which can be accessed with container_of().

Only the parent can do the kfree() explicitly in that case. If the 
parent relies on devm_kzalloc, this also can make the .release callback 
with no memory free required at all.

See e.g. the code I cooked for the transition of SoundWire away from 
platform devices at

https://github.com/thesofproject/linux/pull/2484/commits/d0540ae3744f3a748d49c5fe61469d82ed816981#diff-ac8eb3d3951c024f52b1d463b5317f70R305

The allocation is done on an 'ldev' which contains 'adev'.

I really don't seen how an ancillary_device_register() could model the 
different ways to allocate memory, for maximum flexibility across 
different domains it seems more relevant to keep the initialize() and 
add() APIs separate. I will accept the argument that this puts more 
responsibility on the parent, but it also provides more flexibility to 
the parent.

If we go with the suggested solution above, that already prevents 
SoundWire from using this bus. Not so good.
