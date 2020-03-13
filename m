Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F9C2BB1D
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:09:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E5B20749
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rWnkUjar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E5B20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74F0C1785;
	Fri, 13 Mar 2020 08:08:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74F0C1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584083381;
	bh=gDwwcHQWQG6EFXhmssdykmhTl7qxvkaKNxbnk0cVpYk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rWnkUjarnIdQjlu39pEfgeRzucOY5RZbEAIxZVF0/ogYKedlzRi8whi7InRWXThoj
	 UL9QPu+uhaNZRAAK+cFEEzhnhYhqZXTt1NEs6HtJsURCJfAreMISbok1xAkf/0uGRv
	 6o4PEfj04a6r7JZaAQH9lo2l6idNnSM4vKEG7ceE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FBC4F801A3;
	Fri, 13 Mar 2020 08:08:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62BD6F801EB; Fri, 13 Mar 2020 08:08:47 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 430B4F8013E
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 08:08:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 430B4F8013E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 00:08:37 -0700
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; d="scan'208";a="237123087"
Received: from xweng-mobl.amr.corp.intel.com (HELO [10.251.242.215])
 ([10.251.242.215])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Mar 2020 00:08:36 -0700
Subject: Re: [PATCH v2] topology: Add topology file for generic HDA DSP
 machine driver
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200309120944.15240-1-mateusz.gorski@linux.intel.com>
 <0d2fb996-2668-e53b-ec91-18bf9e27df31@linux.intel.com>
 <7334e7b6-c4d3-aac3-46d2-b4fbcb0e3957@linux.intel.com>
 <27e153ce-f94b-876a-32e7-66dd5842c07b@linux.intel.com>
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <0efdc802-eb82-2137-19a1-9a7e71fa62d8@linux.intel.com>
Date: Fri, 13 Mar 2020 08:08:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <27e153ce-f94b-876a-32e7-66dd5842c07b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Cc: cezary.rojewski@intel.com, tiwai@suse.com
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


>>>> +SectionPCMCapabilities."DMIC-Capture" {
>>>> +    formats "S16_LE"
>>>> +    rates "48000"
>>>> +    channels_min "2"
>>>> +    channels_max "2"
>>>> +    sig_bits "16"
>>>> +}
>>>
>>> NHLT reports 4 microphones on a number of devices, is there any 
>>> specific reason to limit the capture to 2ch?
>>>
>>> I believe the generic Hdaudio card now reports the number of 
>>> channels to pulseaudio, so it's possible that PulseAudio would open 
>>> a 4ch stream but be told sorry no can do by topology.
>>>
>>> FWIW we ended-up selecting different topology files in SOF, 
>>> depending on whether we had 0, 2 or 4 mics.
>>
>>
>> This patch was prepared to address many issues regarding broken DMIC 
>> configurations.
>>
>> You are right - there are different DMIC configurations on different 
>> devices, but, since path multi-configuration feature is not 
>> upstreamed in cAVS driver, we are not able to include all of these in 
>> one topology file.
>>
>> This is a reference topology, and it was successfully validated on 
>> few production laptops (including models on which DMIC capture was 
>> not working).
>
> Sorry, I don't understand what's missing in the cAVS driver?
>
> All you need is to select a different topology based on the number of 
> DMICs detected.


We have a mechanism to choose the PCM configuration of given topology 
path via amixer control. That way we can include both 2ch and 4ch DMIC 
configurations in one topology file and simply change DMIC pipeline 
configuration on runtime.

Unfortunately this mechanism is not currently available on upstream.

As said before, this is a reference topology, if needed I can also 
upload modified version with 4ch DMIC path.

