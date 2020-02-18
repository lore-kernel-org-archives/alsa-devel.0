Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62522C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:43:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D899921D56
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b3kUva9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D899921D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AC931687;
	Tue, 18 Feb 2020 19:42:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AC931687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582051416;
	bh=UEYwBF1dADz4xBezZ7vxVILKW1ZLaaBZHljDN3HGzTc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3kUva9xDHSZbCpJNN2Q8kpg0IQABPn2BCpTzcI0lbD1MmAPs/ll2/VKlhd0BFJrt
	 6M/hwVCXM9RE+KnGzmVKXQs4STMWD3GTeui6J6RAKLhdEOz7PfwxgUDN9b6SHa+cVF
	 X2zHj03uzBWNOShBX8520o5iEWxBVwKXaYkjNzSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 907B1F80148;
	Tue, 18 Feb 2020 19:42:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3920BF8014A; Tue, 18 Feb 2020 19:42:44 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62CD3F80145
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 19:42:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62CD3F80145
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 10:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; d="scan'208";a="268865804"
Received: from amholmes-mobl3.ger.corp.intel.com (HELO [10.251.87.78])
 ([10.251.87.78])
 by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2020 10:42:33 -0800
Subject: Re: [PATCH] ASoC: SOF: Intel: Fix stream cleanup on pcm close
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200218141013.7290-1-cezary.rojewski@intel.com>
 <63adf568-74f4-2c01-8257-955d5aa51420@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <95efa175-e72a-fe48-9c91-ec65d31ae130@intel.com>
Date: Tue, 18 Feb 2020 19:42:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <63adf568-74f4-2c01-8257-955d5aa51420@linux.intel.com>
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

On 2020-02-18 17:45, Pierre-Louis Bossart wrote:
> On 2/18/20 8:10 AM, Cezary Rojewski wrote:
>> Field "substream" gets assigned during stream setup in
>> hda_dsp_pcm_hw_params() but it is never cleared afterwards during
>> hda_dsp_pcm_close(). Now, any non-pcm operation e.g.: compress can
>> mistakenly make use of that pointer as it's bypassing all
>> "if (s->substream)" checks.
>>
>> Nulling the pointer during close operation ensures no wild pointers are
>> left behind.
>>
>> Fixes: cdae3b9a47aa ("ASoC: SOF: Intel: Add Intel specific HDA PCM 
>> operations")
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> ---
>>   sound/soc/sof/intel/hda-pcm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/sof/intel/hda-pcm.c 
>> b/sound/soc/sof/intel/hda-pcm.c
>> index a46a6baa1c3f..4b3a89cf20e7 100644
>> --- a/sound/soc/sof/intel/hda-pcm.c
>> +++ b/sound/soc/sof/intel/hda-pcm.c
>> @@ -246,5 +246,6 @@ int hda_dsp_pcm_close(struct snd_sof_dev *sdev,
>>       /* unbinding pcm substream to hda stream */
>>       substream->runtime->private_data = NULL;
>> +    hstream->substream = NULL;
>>       return 0;
>>   }
> 
> 
> Humm, yes we should clean this, but wondering if the close() operation 
> is the right place. Doing this is hda_dsp_stream_hw_free() sounds more 
> logical to me?

Ain't hda-pcm.c the best place for it as "hstream->substream = 
substream" happens there too? If the cleanup is to be done in 
_hw_free(), then I'd expect the same to happen to the original 
assignments. Doubt we want to do the later so.. _close() for the win?

In general the existing hstream->substream initialization looks kinda 
disconnected from the actual stream assignment code - _stream_get() - as 
if the duties of the state machine were shared.

Czarek
