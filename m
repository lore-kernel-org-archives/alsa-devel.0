Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4115C61DA4
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 18:26:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B195F86F;
	Thu,  9 Feb 2023 19:25:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B195F86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675967169;
	bh=eMqFJ7oEmEOMllyFxzTKk3m3PKmx25kcttt/uJcv9ic=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Svy3dcaZeVDtFkPeyx7h62fvDel7FJAvkksMGfwz9Rw0PBhJCZkKflo8WSAr5t7Pe
	 OD3pE9YrZ6Ii1q7hso9RiygUJq7UWNe3VbK8hrCYjgfcHTivlm8Nr9MH6Mw8KrbwHU
	 TRJiM94R+sfH1IWNNZ9xaJiA06PJtZ3+a5EfRMp4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 576A8F800E4;
	Thu,  9 Feb 2023 19:24:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44290F800E4; Thu,  9 Feb 2023 19:24:50 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5ED6F80094
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 19:24:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5ED6F80094
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hwm7uOSP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675967088; x=1707503088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMqFJ7oEmEOMllyFxzTKk3m3PKmx25kcttt/uJcv9ic=;
  b=hwm7uOSPASWWtjWYx6ZEohfPYNCR491h79nkh/vgqAPD3gMOJ//pG1ZO
   ei0VhQ145L1T+be/el1x/3G4xS03bqfNZoDDKeUCnBKLzAg3zbqoF8KMJ
   Np5t7DIOYo2RYavepnKx7EkpL/pJHg39U/BJzUiPmA1VP2pRAW5gAwyLv
   byxUsFhNM9IRnbgQi1WViViPaS27wSP4AMspiOJ2dNCDdphlCR97Tlwk7
   46remYfT92YlX0n+bre4/rQ9qfLV7zOWJw6/Phm0uY/cRDpKfReyWIuYy
   DREZDMNBt0wGDEBWQKr/Fz9k/Xrxrneg4aCDhHGn/w6ME5+n4hxE8uu2I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="357604459"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000";
   d="scan'208";a="357604459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2023 10:24:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="776579097"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000";
   d="scan'208";a="776579097"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130])
 ([10.212.74.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2023 10:24:41 -0800
Message-ID: <b198c88a-7735-1d27-4086-97e9cc38ae8d@linux.intel.com>
Date: Thu, 9 Feb 2023 12:24:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] soundwire: qcom: wait for fifo to be empty before
 suspend
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-4-srinivas.kandagatla@linaro.org>
 <dbec6aab-6456-72b3-39b6-3490dfdf083c@linux.intel.com>
 <a1d79008-3ec4-d7b5-12b5-ea5c6c5a8370@linaro.org>
 <f956351e-de37-062b-c02e-5cbdf9a3bdfd@linux.intel.com>
 <8fb08ac8-13ae-cd87-869e-34af894407e8@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <8fb08ac8-13ae-cd87-869e-34af894407e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: COX4TD3OC2Z73FTOFQL6N4XLA3TOPKW4
X-Message-ID-Hash: COX4TD3OC2Z73FTOFQL6N4XLA3TOPKW4
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, steev@kali.org, johan+linaro@kernel.org,
 quic_bjorande@quicinc.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/COX4TD3OC2Z73FTOFQL6N4XLA3TOPKW4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>




>>>>> Wait for Fifo to be empty before going to suspend or before bank
>>>>> switch happens. Just to make sure that all the reads/writes are done.
>>>>
>>>> For the suspend case that seems like a valid approach, but for bank
>>>> switch don't we already have a bus->msg_lock mutex that will prevent
>>>> the
>>>> bank switch command from being sent before the other commands are
>>>> handled?
>>>
>>> All read/writes are fifo based, so writes could be still pending.
>>
>> I am not following. The bank switch happens with this function, where a
>> mutex is taken.
>>
>> int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>> {
>>     int ret;
>>
>>     mutex_lock(&bus->msg_lock);
>>
>>     ret = sdw_transfer_unlocked(bus, msg);
> 
> Qualcomm controller uses fifo to read/write, so return after writing to
> fifo might not always indicate that write is completed.
> 
> Qcom Soundwire controller do not have any synchronous interrupt
> mechanism to indicate write complete.

Ack, I forgot that one. Might be worth a comment or reworded commit message?
