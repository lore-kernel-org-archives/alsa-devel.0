Return-Path: <SRS0=zwJL=MF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A9C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 12:40:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3951E61289
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jul 2021 12:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3951E61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6623516D3;
	Tue, 13 Jul 2021 14:39:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6623516D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626180034;
	bh=EjpHeCmPVe9zGWbOawzFWTHINmWF7wRVl+MoXtdX5NY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oFpYFnk7MMbq4LYzP4HFNUd2wH+d2uv89z7MRdI0fKNOgIPhER9xOc4rXUU83FEGb
	 MokeedkBOSUCKQULHxBCeeOJS4JUqyyL5oX0EdSO02Myx0DJkopW3x3gdH5gq4zw/H
	 Sc/8S13KLZs2NCs46C+Ha5SSiPdedQMBG7Y2yxcE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E722EF8020C;
	Tue, 13 Jul 2021 14:39:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A8BEF80217; Tue, 13 Jul 2021 14:39:42 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1AC2F800ED
 for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2021 14:39:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1AC2F800ED
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190531961"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; d="scan'208";a="190531961"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 05:39:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; d="scan'208";a="649448840"
Received: from skrishn6-mobl.amr.corp.intel.com (HELO [10.213.170.159])
 ([10.213.170.159])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 05:39:27 -0700
Subject: Re: [PATCH 6/8] ALSA: pcm: conditionally avoid mmap of control data
To: Takashi Iwai <tiwai@suse.de>
References: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
 <20210610205326.1176400-7-pierre-louis.bossart@linux.intel.com>
 <s5h4ke25ill.wl-tiwai@suse.de>
 <15cdd983-e25b-a872-aa25-5086ec71756f@linux.intel.com>
 <s5h8s2a3fgh.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d7a3b3fd-eddf-000b-f9ed-711d3e3156f4@linux.intel.com>
Date: Tue, 13 Jul 2021 07:39:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5h8s2a3fgh.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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



On 7/13/21 1:17 AM, Takashi Iwai wrote:
> On Mon, 12 Jul 2021 22:56:07 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 6/13/21 2:28 AM, Takashi Iwai wrote:
>>> On Thu, 10 Jun 2021 22:53:24 +0200,
>>> Pierre-Louis Bossart wrote:
>>>>
>>>> In case of mmap, by default alsa-lib mmaps both control and status data.
>>>>
>>>> If driver subscribes for application pointer update, driver needs to get
>>>> notification whenever appl ptr changes. With the above case driver won't
>>>> get appl ptr notifications.
>>>>
>>>> This patch check on a hw info flag and returns error when user land asks
>>>> for mmaping control & status data, thus forcing user to issue
>>>> IOCTL_SYNC_PTR.
>>>>
>>>> This patch was originally submitted in 2017, c.f.
>>>> https://lore.kernel.org/alsa-devel/1494896518-23399-4-git-send-email-subhransu.s.prusty@intel.com/
>>>>
>>>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>>>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>>>
>>> This kind of flag itself was what I also introduced for another
>>> purpose, too.  There is a WIP patch that allows the use of
>>> non-coherent non-contiguous buffer pages, and this flag would fit for
>>> that.  FWIW, the patch is found at
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=topic/memalloc
>>
>> Sorry Takashi, I missed your feedback on this patch.
>>
>> Are you saying I should use the definition in that patch?
>>
>> +#define SNDRV_DMA_TYPE_NONCONTIG	8	/* non-coherent SG buffer */
>>
>> I am not quite sure if how this is related to the application using mmap or not?
> 
> Not about that, but rather meant that some flag for disabling the mmap
> of PCM control record would be needed for other purposes like the
> above, too.  That is, this patch could be out of series and applied
> beforehand in my side.

Thanks Takashi, I will resubmit this separately. I may also break the series in two, the two parts (pause/L1EN support and rewinds) are not really connected, they help reduce power but at different levels.
