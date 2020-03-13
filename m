Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF3C2BAEE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:58:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA402072F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o1tl7cbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA402072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94C801784;
	Fri, 13 Mar 2020 04:57:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94C801784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584071879;
	bh=0wPNGmoEr8gU6kNRAYFbTtL0thyfZJAgEU+oc6PLqhk=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1tl7cbPoh/75QSa1kN4UV/gqYTdOfL1Xro3OyvIi4t5VwdN4vdSZlNF84H4ePbvS
	 id7frsbccB8PlYeZIkNYzJf8smZFyHq1/MwiD2T89+DJsc1VOLWaDutHWqmH/1muNM
	 n4EUXKMKSrEjVZjRLERyvlf6iXvLysamiCSajk3c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBC8BF801A3;
	Fri, 13 Mar 2020 04:57:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B4A0F801EB; Fri, 13 Mar 2020 04:57:04 +0100 (CET)
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F8ABF80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 04:56:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F8ABF80086
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41]
 helo=[192.168.1.51])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>)
 id 1jCbRB-0005AE-1e; Fri, 13 Mar 2020 14:56:47 +1100
Subject: Re: ASoc: soc_core.c stream direction from snd_soc_dai
From: Matt Flax <flatmax@flatmax.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <5598a2fc-9b49-ad5e-2265-fbc0593ead1b@flatmax.org>
 <0d9a9459-9cd7-d384-b1ff-72860895ad13@linux.intel.com>
 <73148789-58f7-2228-ae42-465cdafcff4c@flatmax.org>
Message-ID: <52e1a640-b46f-b494-2047-849c1999eb28@flatmax.org>
Date: Fri, 13 Mar 2020 14:56:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <73148789-58f7-2228-ae42-465cdafcff4c@flatmax.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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


On 13/3/20 10:19 am, Matt Flax wrote:
>
> On 13/3/20 9:55 am, Pierre-Louis Bossart wrote:
>>
>>
>> On 3/11/20 5:54 PM, Matt Flax wrote:
>>> Hi there,
>>>
>>> A large number of audio codecs allow different formats for playback 
>>> and capture. This becomes very useful when there are different 
>>> latencies between playback and capture hardware data lines. For 
>>> example digital isolation chips typically have a 1 bit delay in 
>>> propagation as the bit clock rate gets faster for higher sample 
>>> rates. By setting the capture and playback formats to differ by one 
>>> or two bit clock cycles, the delay problem is solved.
>>>
>>> There doesn't seem to be a simple way to detect stream direction in 
>>> the codec driver's set_fmt function.
>>>
>>> The snd_soc_runtime_set_dai_fmt function :
>>>
>>> https://github.com/torvalds/linux/blob/master/sound/soc/soc-core.c#L1480 
>>>
>>>
>>> calls the snd_soc_dai_set_fmt function :
>>>
>>> https://github.com/torvalds/linux/blob/master/sound/soc/soc-dai.c#L101
>>>
>>> which calls the set_fmt function :
>>>
>>> https://github.com/torvalds/linux/blob/master/include/sound/soc-dai.h#L189 
>>>
>>>
>>>
>>> The snd_soc_dai_ops set_fmt function is defined as :
>>>
>>>      int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
>>>
>>>
>>> Is there a simple way to find the stream direction from a snd_soc_dai ?
>>>
>>> If the stream direction can be detected then the playback and 
>>> capture formats can be set independently for the codec.
>>>
>>> It there a different way to set the playback and capture formats for 
>>> the codec independently at runtime, depending on the sample rate ?
>>
>> FWIW I remember a discussion in the past on how to deal with 
>> interfaces that may have different clocks sources for capture and 
>> playback (typically with the 6-pin version of I2S/TDM), and the 
>> answer was: use two dais, with one dealing with capture and the other 
>> with playback.
>>
>> I would bet this applies for the format as well. If you use a DAI 
>> that can do both directions, then indeed there's no obvious way to 
>> specify that formats or clock ownership could be different between 
>> the two directions.
>>
>> It would probably make sense anyway to have a representation with two 
>> dais, e.g. the codec capture dai receives data from somewhere and the 
>> codec playback dai forwards it to another destination.
>>
> I think I get it ...
>
> This approach would keep extra stream selective functionality out of 
> soc-dai.c. That is probably a good thing for the simplicity of the core.
>
> A machine driver could then call snd_soc_dai_set_fmt passing in the 
> correct codec_dai from the codec_dais array for the stream they want 
> to operate on.
>
In an example case, cs4271 ... how do we enforce symmetric rates ?

static struct snd_soc_dai_driver cs4271_dai[] = {
     {
         .name = "cs4271-hifi-p",
         .playback = {
             .stream_name    = "Playback",
             .channels_min    = 2,
             .channels_max    = 2,
             .rates        = CS4271_PCM_RATES,
             .formats    = CS4271_PCM_FORMATS,
         },
         .ops = &cs4271_dai_ops,
         .symmetric_rates = 1,
     },
     {
         .name = "cs4271-hifi-c",
         .capture = {
             .stream_name    = "Capture",
             .channels_min    = 2,
             .channels_max    = 2,
             .rates        = CS4271_PCM_RATES,
             .formats    = CS4271_PCM_FORMATS,
         },
         .ops = &cs4271_dai_ops,
         .symmetric_rates = 1,
     }
};



> Matt
>
>
>> My 2 cents
>> -Pierre
