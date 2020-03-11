Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A39FC10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:53:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917602072F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JPsno7cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917602072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0650D846;
	Wed, 11 Mar 2020 15:52:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0650D846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583938404;
	bh=wg8NrmVjhCmd4gTSsQqyrN/28Z7FcfYM0TUbC4KWzoM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JPsno7czq/U5GLqugtuuif4QXLJqHizkeq0EIQJ92d5Hq7N2//1E94VP9haf0t9RJ
	 KcAjSvw/u1SVcX0HJlGfhj12QuXN6/7Z9wq5dYnKMgYWUDCXT5wZZUh4sTf8PPEhCz
	 woiKU93EdCuLo+nKgZCsyJJSDJTuNdL84qccWlIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84602F801A3;
	Wed, 11 Mar 2020 15:52:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0055FF80217; Wed, 11 Mar 2020 15:52:29 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DFB6F801EB
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 15:52:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DFB6F801EB
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 07:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="242703777"
Received: from psingh6-mobl.amr.corp.intel.com (HELO [10.251.23.209])
 ([10.251.23.209])
 by orsmga003.jf.intel.com with ESMTP; 11 Mar 2020 07:52:22 -0700
Subject: Re: [alsa-devel] [PATCH 3/6] ASoC: Intel: common: add match tables
 for ICL w/ SoundWire
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>
References: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
 <20200110222530.30303-4-pierre-louis.bossart@linux.intel.com>
 <d5e15895-7d10-7255-692c-c5c89d3ae1be@perex.cz>
 <b49c010b-5b90-4ad6-58b8-9e43f9fc949f@linux.intel.com>
 <e8df8119-d88b-69b7-fd7a-890f1eb06dbf@perex.cz>
 <20200311090706.GJ4885@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5195f1e1-45c9-7b24-2f78-212093976dba@linux.intel.com>
Date: Wed, 11 Mar 2020 09:47:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311090706.GJ4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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



On 3/11/20 4:07 AM, Vinod Koul wrote:
> On 11-03-20, 07:39, Jaroslav Kysela wrote:
>> Dne 11. 03. 20 v 2:35 Pierre-Louis Bossart napsal(a):
>>>
>>>
>>> On 3/10/20 5:12 PM, Jaroslav Kysela wrote:
>>>> Dne 10. 01. 20 v 23:25 Pierre-Louis Bossart napsal(a):
>>>>> From: Bard Liao <yung-chuan.liao@linux.intel.com>
>>>>>
>>>>> The two configurations are with the Realtek 3-in-1 board requiring all
>>>>> 4 links to be enabled, or basic configuration with the on-board RT700
>>>>> using link0.
>>>>>
>>>>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>>>>> Signed-off-by: Pierre-Louis Bossart
>>>>> <pierre-louis.bossart@linux.intel.com>
>>>>
>>>> Hi,
>>>>
>>>>      I just looking to this code and I miss the Kconfig selection for RT
>>>> codecs in the SOF SDW driver. How we can enable this driver without
>>>> selecting SND_SOC_ALL_CODECS ?
>>>>
>>>>      I believe that those changes should be in sync with the machine
>>>> description.
>>>
>>> Sorry Jaroslav, I don't fully understand your question.
>>>
>>> These tables are just used to
>>> a) select a firmware file
>>> b) select a topology file
>>> c) select a machine driver.
>>>
>>> The codec selections are not made in this module but handled by the
>>> machine drivers in sound/soc/intel/boards/. It's the same mechanism as
>>> for all other machine drivers.
>>>
>>> One caveat is that the SOF parts and machine drivers for SoundWire have
>>> not been provided upstream just yet, since they would not build without
>>> patches in drivers/soundwire. GregKH mentioned the patches are 'sane'
>>> and provided his Reviewed-by tag. Vinod Koul still has objections to our
>>> proposals but has yet to make proposals that would work for Intel, so if
>>> you need SoundWire support in the near-term you will need to have a
>>> conversation with Vinod. The code is ready and fully-tested.
>>>
>>> If you want to look at the machine drivers for SOF+Realtek drivers, see
>>>
>>> https://github.com/thesofproject/linux/blob/topic/sof-dev/sound/soc/intel/boards/sdw_rt711_rt1308_rt715.c
>>>
>>> and the Kconfig that selects the relevant codec drivers is here:
>>>
>>> https://github.com/thesofproject/linux/blob/d05959d5021cefbbd841773ee25f6c7387e6bfd9/sound/soc/intel/boards/Kconfig#L556
>>
>> Ohh, it explains all. I was looking for the 'select SND_SOC_RT711_SDW' lines
>> in Kconfig. It's really bad to merge those pieces randomly to the ASoC tree,
>> because this code in the patch is dead without the machine driver code.
>>
>> Vinod, any ETA? It seems that the Intel's soundwire hardware is reaching the
>> market.
> 
> That would be question for Pierre, I no longer work for Intel.

We don't discuss product schedules or releases here.

The question was "any ETA to start merging Intel patches"...

