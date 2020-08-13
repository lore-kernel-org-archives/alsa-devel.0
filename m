Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8952FC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:59:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D4C20838
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l8Fgmlb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D4C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7214C1663;
	Thu, 13 Aug 2020 21:58:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7214C1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597348739;
	bh=IUM6PZPntEE0q8D78DvAzds6/X3hiiY3Jss9ae/s3/U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l8Fgmlb8SVhO7m8cWoVefhRIKXL0p/b5qLFNlVEptM0GzYPlwTnfvKUz4CFzXhdqb
	 gnjN9D7U+hXiCJcTceeGd7pPk77bpzZOzpRs1OoeTxRi+LxqQgIECxOyiOGuEFfpes
	 hDJZSodW34hdnvmG2jLFIHRno+lrI6Kqa+tOF8QQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0892CF8014C;
	Thu, 13 Aug 2020 21:58:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFEEFF8015B; Thu, 13 Aug 2020 21:58:07 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5209F800F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 21:58:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5209F800F4
IronPort-SDR: FXMVLp69Gi9oEBIKx2UEiYbdG6Q+snr08VqToxBXTAXpoqfjaZ885cKZg+eg4KKhbUEpfgQGfy
 86IiJ6hyQCAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="151729397"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="151729397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 12:58:01 -0700
IronPort-SDR: yTVYSjPYvjuJYFH755sgpPq9ISKccRVz5eat1DMtwgrTBWWfmQE0HtO6MLdo+AwLs/4tXOoV7v
 FoH04L2HS5MQ==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="333201256"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO [10.251.137.200])
 ([10.251.137.200])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 12:58:00 -0700
Subject: Re: [PATCH 5/5] ASoC: Intel: sof_sdw: clarify operator precedence
To: Mark Brown <broonie@kernel.org>
References: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
 <20200813175839.59422-6-pierre-louis.bossart@linux.intel.com>
 <20200813184541.GD5541@sirena.org.uk>
 <0b8b306f-f9b7-bb62-2fd2-9b396b862f6f@linux.intel.com>
 <20200813194948.GF5541@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <13611ca2-f4c4-8ac5-896b-db89adcf524c@linux.intel.com>
Date: Thu, 13 Aug 2020 14:57:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813194948.GF5541@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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



On 8/13/20 2:49 PM, Mark Brown wrote:
> On Thu, Aug 13, 2020 at 02:43:50PM -0500, Pierre-Louis Bossart wrote:
>> On 8/13/20 1:45 PM, Mark Brown wrote:
>>> On Thu, Aug 13, 2020 at 12:58:39PM -0500, Pierre-Louis Bossart wrote:
> 
>>>> -	hdmi_num = sof_sdw_quirk & SOF_SDW_TGL_HDMI ?
>>>> +	hdmi_num = (sof_sdw_quirk & SOF_SDW_TGL_HDMI) ?
>>>>    				SOF_TGL_HDMI_COUNT : SOF_PRE_TGL_HDMI_COUNT;
> 
>>> Or better yet, just don't abuse the ternery operator like this and write
>>> normal conditional statements.
> 
>> I count 795 uses of the ternary operator in sound/soc and 68776 in my local
>> kernel branch.
>> Can you clarify in what way this is an abuse? I don't mind changing this, I
>> wasn't aware this is frowned upon.
> 
> If you write a normal conditional statement then not only is the
> precedence clear but it's just generally easier to read.  There are
> cases where it can help make things clearer (eg, avoiding the use of
> scratch variables to hold results) but this is most definitely not one
> of them and I don't understand everyone's enthusiasm for trying to put
> them in.

That's fair, I am not a big fan either.
Please drop this patch and we'll rework this machine driver. There's a 
set of updates planned anyways and we can add this cleanup in a separate 
set. Thanks!
