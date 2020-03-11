Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E035C18E5A
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:55:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CE220650
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bb1LcxoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CE220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15DCC1671;
	Wed, 11 Mar 2020 15:54:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15DCC1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583938505;
	bh=FSRW3Kil8kEzINVyihS6mFj/AQWMAUt0FDqlB9L+2oU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bb1LcxoUUbIiF6ASK+Y+9o7NMl4Jj1HjvZlY7edVq6wWcTYhyOLBM7QC/DUeo3imd
	 842rnrKKYs1z+dJFB+qzLZa29HWALqxqJyltMQtDxEZcUj6cIrd+kczDZq19Q+bAWP
	 Q2wsLACYtc7qo3i6grIL8mja315LoKnLg4u/FifY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B312DF8028B;
	Wed, 11 Mar 2020 15:52:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B36EF801EB; Wed, 11 Mar 2020 15:52:32 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9A35F801A3
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 15:52:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9A35F801A3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 07:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="242703781"
Received: from psingh6-mobl.amr.corp.intel.com (HELO [10.251.23.209])
 ([10.251.23.209])
 by orsmga003.jf.intel.com with ESMTP; 11 Mar 2020 07:52:23 -0700
Subject: Re: [PATCH v2] topology: Add topology file for generic HDA DSP
 machine driver
To: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200309120944.15240-1-mateusz.gorski@linux.intel.com>
 <0d2fb996-2668-e53b-ec91-18bf9e27df31@linux.intel.com>
 <7334e7b6-c4d3-aac3-46d2-b4fbcb0e3957@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27e153ce-f94b-876a-32e7-66dd5842c07b@linux.intel.com>
Date: Wed, 11 Mar 2020 09:48:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7334e7b6-c4d3-aac3-46d2-b4fbcb0e3957@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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



On 3/11/20 4:13 AM, Gorski, Mateusz wrote:
> 
>>> +SectionPCMCapabilities."DMIC-Capture" {
>>> +    formats "S16_LE"
>>> +    rates "48000"
>>> +    channels_min "2"
>>> +    channels_max "2"
>>> +    sig_bits "16"
>>> +}
>>
>> NHLT reports 4 microphones on a number of devices, is there any 
>> specific reason to limit the capture to 2ch?
>>
>> I believe the generic Hdaudio card now reports the number of channels 
>> to pulseaudio, so it's possible that PulseAudio would open a 4ch 
>> stream but be told sorry no can do by topology.
>>
>> FWIW we ended-up selecting different topology files in SOF, depending 
>> on whether we had 0, 2 or 4 mics.
> 
> 
> This patch was prepared to address many issues regarding broken DMIC 
> configurations.
> 
> You are right - there are different DMIC configurations on different 
> devices, but, since path multi-configuration feature is not upstreamed 
> in cAVS driver, we are not able to include all of these in one topology 
> file.
> 
> This is a reference topology, and it was successfully validated on few 
> production laptops (including models on which DMIC capture was not 
> working).

Sorry, I don't understand what's missing in the cAVS driver?

All you need is to select a different topology based on the number of 
DMICs detected.
