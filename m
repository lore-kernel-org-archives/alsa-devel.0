Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF76C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:24:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2A72071E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jlUZYIJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2A72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7EC883D;
	Tue, 25 Aug 2020 20:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7EC883D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598379858;
	bh=P1LYkIOa+GEbbQv3g48icaoiJ7x9/o5Z4GgUc7NLP5E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jlUZYIJo6QW4VfMSe2kJofwHdEmyFKeDxv+ewZi/nvZzmXVE8zZ6YtNVGUMkb2QfD
	 fsztRDGT42psscOfJbV1GVuAggnhP4tqqDisPFBpcUdaZDaaYhMopLtWswnbFO9pQ7
	 krWXZmebZX9ZFk0/Z2++TstYz207t+CcP9DyPdfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C61AF80245;
	Tue, 25 Aug 2020 20:23:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C836AF8025A; Tue, 25 Aug 2020 20:23:26 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8C20F800D1
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 20:23:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8C20F800D1
IronPort-SDR: VEn8copQSUP6m3xqjV5bn0eqHCO4sZ7le/R4ql1Ozie+CpMofDgbLLqCALzNbUKHjys5bo0z2B
 4voLRfWNS+qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240992448"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; d="scan'208";a="240992448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:23:12 -0700
IronPort-SDR: 6uFrrKJJHqE56JBmYESW1/RMeeImJH0mFYuy4DMrHk5XMpjVLQ1e42+DbBBsm2AePmheguR8aa
 lSPEYrsoH9kw==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; d="scan'208";a="322858576"
Received: from rbarriga-desk.amr.corp.intel.com (HELO [10.251.128.175])
 ([10.251.128.175])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:23:12 -0700
Subject: Re: [bug report] ASoC: Intel: KMB: Enable TDM audio capture
To: "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>
References: <20200825132102.GA306074@mwanda>
 <CE6D3DA0-65A3-42BA-8341-13A3C6E80A55@intel.com>
 <20200825135800.GS5493@kadam>
 <2B5A2EFF-7391-4565-9B35-DCE395C7DD80@intel.com>
 <5789a393-d2b7-4127-4875-2dbcb5a19bfc@linux.intel.com>
 <EDE660AC-9B3C-4FBB-88F9-464A0D953EA7@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <68c77e0e-564f-6b41-26e5-b5db8b36a7f7@linux.intel.com>
Date: Tue, 25 Aug 2020 13:23:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <EDE660AC-9B3C-4FBB-88F9-464A0D953EA7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sia,
 Jee Heng" <jee.heng.sia@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
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


>>>>>>   506          switch (config->chan_nr) {
>>>>>>   507          case 8:
>>>>>>   508          case 4:
>>>>>>   509                  /*
>>>>>>   510                   * Platform is not capable of providing clocks for
>>>>>>   511                   * multi channel audio
>>>>>>   512                   */
>>>>>>   513                  if (kmb_i2s->master)
>>>>>>   514                          return -EINVAL;
>>>>>>   515
>>>>>>   516                  write_val = ((config->chan_nr / 2) << TDM_CHANNEL_CONFIG_BIT) |
>>>>>>   517                                  (config->data_width << DATA_WIDTH_CONFIG_BIT) |
>>>>>>   518                                  !MASTER_MODE | TDM_OPERATION;
>>>>>>                                        ^^^^^^^^^^^^
>>>>>> MASTER_MODE is BIT(13).  It's unclear what this is supposed to be.  My
>>>>>> best guess is that the ! should just be deleted.
>>>>>
>>>>> This ! is intentional because it is meant to be Slave mode. Would a better approach be to create another #define for slave mode?
>>>>
>>>> In my opinion, it's better to just leave it out.  ORing with zero causes
>>>> a different static checker warning on my unreleased checks...  Is it
>>>> 0 << 13?  I feel like ORing with zero just makes things more confusing.
>>>>
>>> It is 0<<13, in the event it was previously configured to Master I would need to unset the bit
>>
>> You are assigning the result to write_val, so there's no memory of what was configured before?
> 
> Yea you are right, would leaving this !MASTER_MODE out the best solution?

Sounds good to me. Thanks Dan for the report!
