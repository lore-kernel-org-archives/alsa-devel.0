Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD37C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8BE2465D
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CVvQk9hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8BE2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E15981689;
	Tue, 18 Feb 2020 20:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E15981689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582052798;
	bh=qlpXZ52m2pYD8JDtKYh+8GNIDyCrRAsNcCOCum32xiI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CVvQk9hCL8pXJncvLC+WW5FRseNsKq/CF/sExhvrr2UW025LpVv59Fq5WbiOyjE0/
	 7al2wyLbbcjXnhOuEFrrtI6AuziW1IEPbcbxy5mnEZvkTMfV+JFlaP7rzy///Iv4yC
	 G2+qNAZDLyXp+Pl8VJ8/74yTYH5j3TgEZK96FSfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77A78F80145;
	Tue, 18 Feb 2020 20:05:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 839D8F80148; Tue, 18 Feb 2020 20:05:46 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 126A1F800C4
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 20:05:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 126A1F800C4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 11:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,457,1574150400"; d="scan'208";a="408174834"
Received: from bmerugul-mobl1.amr.corp.intel.com (HELO [10.251.159.61])
 ([10.251.159.61])
 by orsmga005.jf.intel.com with ESMTP; 18 Feb 2020 11:05:39 -0800
Subject: Re: [PATCH] ASoC: SOF: Intel: Fix stream cleanup on pcm close
To: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200218141013.7290-1-cezary.rojewski@intel.com>
 <63adf568-74f4-2c01-8257-955d5aa51420@linux.intel.com>
 <95efa175-e72a-fe48-9c91-ec65d31ae130@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <446b11ad-648f-1add-e827-06088e13ee2f@linux.intel.com>
Date: Tue, 18 Feb 2020 13:05:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <95efa175-e72a-fe48-9c91-ec65d31ae130@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com,
 tiwai@suse.com
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

Hi Cezary,

>>> diff --git a/sound/soc/sof/intel/hda-pcm.c 
>>> b/sound/soc/sof/intel/hda-pcm.c
>>> index a46a6baa1c3f..4b3a89cf20e7 100644
>>> --- a/sound/soc/sof/intel/hda-pcm.c
>>> +++ b/sound/soc/sof/intel/hda-pcm.c
>>> @@ -246,5 +246,6 @@ int hda_dsp_pcm_close(struct snd_sof_dev *sdev,
>>>       /* unbinding pcm substream to hda stream */
>>>       substream->runtime->private_data = NULL;
>>> +    hstream->substream = NULL;
>>>       return 0;
>>>   }
>>
>>
>> Humm, yes we should clean this, but wondering if the close() operation 
>> is the right place. Doing this is hda_dsp_stream_hw_free() sounds more 
>> logical to me?
> 
> Ain't hda-pcm.c the best place for it as "hstream->substream = 
> substream" happens there too? If the cleanup is to be done in 
> _hw_free(), then I'd expect the same to happen to the original 
> assignments. Doubt we want to do the later so.. _close() for the win?
> 
> In general the existing hstream->substream initialization looks kinda 
> disconnected from the actual stream assignment code - _stream_get() - as 
> if the duties of the state machine were shared.

I am having difficulties interpreting your answer, i.e. I don't know 
what the last sentence refers to.

Currently open() and close() are perfectly symmetrical, I don't really 
see why you'd want to change and add an imbalanced set of operations, 
unless you moved

hstream->substream = substream;

to the open() instead of hw_params().

Or alternatively add a hw_free() in hda-pcm.c to mirror what's done in 
hw_params.
