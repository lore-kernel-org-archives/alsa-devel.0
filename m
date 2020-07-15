Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF3C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:38:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB622065D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RTF+AVFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB622065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 602ED15E5;
	Wed, 15 Jul 2020 16:37:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 602ED15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594823918;
	bh=avh7Uf54T24WUm4PKM5o3fq5vAKlVbyY8OHgid+eiz0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RTF+AVFcAcBI+WkZW+wW5HoD0+rSxU1HaLpBGwDX+SeaVfypP8ZClcNmRIKtt5nPh
	 Ptg25/74dOxQxexmVcMuekksEq1ubnuDf/kxYTzd6IqmpPomI5ytW5lhjEaaG+rI84
	 QwIhu823G73DQPNW83r7UYpJrc9nEuf9mFTr4eLs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7E02F80217;
	Wed, 15 Jul 2020 16:37:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CF19F8021D; Wed, 15 Jul 2020 16:37:40 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19515F8014E
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 16:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19515F8014E
IronPort-SDR: qTVKKhr6q26KwT/BQymLYDAB+dY9im/2sCQsSdxXGuS8/sQrSXpy95wuAPq7cLwaIv9DowxD2+
 wzrbbLwtTwSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="213919366"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; d="scan'208";a="213919366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 07:37:29 -0700
IronPort-SDR: +C9YKXqlvTKFdBEZR8pGhcN2lSbYen7TvLEXLnbQctvAR/iIVWP4MCZQcyOjwoDrLaQdGPZ95n
 YdO+JBqVlPmQ==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; d="scan'208";a="460111555"
Received: from sjeong-mobl.amr.corp.intel.com (HELO [10.255.231.101])
 ([10.255.231.101])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 07:37:28 -0700
Subject: Re: [PATCH v3 07/10] topology: decode: Fix decoding PCM formats and
 rates
To: Piotr Maziarz <piotrx.maziarz@linux.intel.com>, alsa-devel@alsa-project.org
References: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1594725911-14308-8-git-send-email-piotrx.maziarz@linux.intel.com>
 <bca4e102-f734-df31-17aa-686bc1463819@linux.intel.com>
 <37b724ff-e485-8b7a-f16d-8cf8f8ac7c9b@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <13ec204b-78f3-2d5d-30bc-c099a58fd789@linux.intel.com>
Date: Wed, 15 Jul 2020 09:37:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <37b724ff-e485-8b7a-f16d-8cf8f8ac7c9b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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



On 7/15/20 4:37 AM, Piotr Maziarz wrote:
> On 2020-07-14 17:40, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/14/20 6:25 AM, Piotr Maziarz wrote:
>>> Not checking _LAST format and rate, which are valid indexes in arrays,
>>> makes data loss while converting binary to standard ALSA configuration
>>> file.
>>
>> I must be really thick on this one.
>>
>> alsatplg converts from alsa-conf format to binary topology file.
>> The binary topology file is used by drivers.
>>
>> In which cases would you convert from binary to alsa-conf files? And 
>> what tool would you use?
>>
> ./alsatplg --decode topology.bin --output decoded_topology.conf,
> This feature was added around the end of 2019. And why to use it? For 
> binary topologies to which conf files are lost for example. It's easier 
> to analyze and edit it in conf than directly in binary.

I must admit I completely missed this feature, thanks for the clarification.
