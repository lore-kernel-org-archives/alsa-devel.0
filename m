Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893A8C4361B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 15:33:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF5E23730
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 15:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF5E23730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD8DA1740;
	Mon,  7 Dec 2020 16:32:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD8DA1740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607355191;
	bh=SbPFtWKQwYIHQ3PctVnm25eve4iT+Rwo4bczYCoYXek=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gb69OFPq1E4EXiXG7DuyqyiaTxA7sH2dz1i/kgjrqcu4leRrMl6jqfomBUc2XE/dY
	 nBpqmNXPpC+DiC5M4tTeBiLmQM+TTMlyapqi0D8iSPzaRirQoUpb7P6ch0DibO3k2l
	 Fow72MKq0UHsZ/fVup547h3L5fpF0SxQskH63BIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 256D0F801D8;
	Mon,  7 Dec 2020 16:32:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18B88F8020D; Mon,  7 Dec 2020 16:32:19 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3634F800E1
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 16:32:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3634F800E1
IronPort-SDR: 44WRMHQmtM+9TAH6VcyDMEr293bqFKk9XZNSPfk8NDIUggRD2yKZ97Txvo6z0LL09KU3DrfunC
 KJs9nLreqvqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="235318577"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; d="scan'208";a="235318577"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 07:31:52 -0800
IronPort-SDR: KbTnrTTSS8jKBpjcxMVefEXDoYDTPU/AOAd+FkIDApCygwxT5ouyQYva6f++U2HTAUPogyYROn
 WtD076O+oLsw==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; d="scan'208";a="541531614"
Received: from singhyax-mobl2.amr.corp.intel.com (HELO [10.255.229.103])
 ([10.255.229.103])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 07:31:50 -0800
Subject: Re: [PATCH 1/7] soundwire: bus: use sdw_update_no_pm when
 initializing a device
To: Vinod Koul <vkoul@kernel.org>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
 <20201205074508.GQ8403@vkoul-mobl>
 <1db93c2e-3c87-bc5e-ddeb-56424870b897@linux.intel.com>
 <20201207044334.GA8403@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <668b4d5c-d9eb-0256-ce26-df38e32cc520@linux.intel.com>
Date: Mon, 7 Dec 2020 09:31:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207044334.GA8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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



On 12/6/20 10:43 PM, Vinod Koul wrote:
> On 05-12-20, 08:59, Pierre-Louis Bossart wrote:
>> Thanks for the review Vinod.
>>
>> On 12/5/20 1:45 AM, Vinod Koul wrote:
>>> On 03-12-20, 04:46, Bard Liao wrote:
>>>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>>
>>>> When a Slave device is resumed, it may resume the bus and restart the
>>>> enumeration. During that process, we absolutely don't want to call
>>>> regular read/write routines which will wait for the resume to
>>>> complete, otherwise a deadlock occurs.
>>>>
>>>> Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')
>>>
>>> Change looks okay, but not sure why this is a fix for adding no pm
>>> version?
>>
>> when we added the no_pm version, we missed the two cases below where
>> sdw_update() was used and that creates a deadlock. To me that's a conceptual
>> bug, we didn't fully use the no_pm versions, hence the Fixes tag.
> 
> Documentation says:
> "A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
> is used to make it easy to determine where a bug originated, which can help
> review a bug fix. This tag also assists the stable kernel team in determining
> which stable kernel versions should receive your fix. This is the preferred
> method for indicating a bug fixed by the patch. See :ref:`describe_changes`
> for more details."
> 
> I do not this this helps here as this does not help distros etc
> I would say this is incremental development which improved a case not
> done properly earlier, unless you would like this to be backported.. In
> that case it helps folks...

IMHO the changes in the series are absolutely required to have a 
reliable suspend-resume operation and will need to be back-ported. When 
I said 'conceptual bug', I didn't mean a hypothetical case, I really 
meant that a proven race condition and timeouts will occur. That's not 
good... We will provide the list of this patches to distros that are 
known to support SoundWire as a 'must apply'.

If you look at the series, we provided Fixes tags for all patches except 
'cosmetic' ones which don't fundamentally change the behavior (Patch 3, 
patch 7) or when the code has not reached Linus' tree (patch 5).

That said, 5.10 was the first release where SoundWire started to be 
functional so there's no need to apply these patches to earlier versions 
of the stable tree.

Does this help?
