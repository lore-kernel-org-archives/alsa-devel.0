Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4ADC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:07:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1412176D
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tOEk+TaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1412176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3617950;
	Tue, 17 Dec 2019 13:06:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3617950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576584451;
	bh=DAqx8ffnFN28AZKLtRW2na7xjieaFGLm1o404sxuAGM=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tOEk+TaLPkbe/pW79bj4a8m6599dPPaZDEspzFjZI/F2uoWTIOYTxMCuOOOzO6rVl
	 EEnRbT0h5KdaKFBQwr7SYpz9vX1soqfh2RdqjF63Kf3PQEZRkECUInrlEziT9qgEqW
	 UiFewzkhV+ycuIXnR6wnG81FJSMtYBukU5dbXilQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89056F80218;
	Tue, 17 Dec 2019 13:06:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73CA9F80234; Tue, 17 Dec 2019 13:06:38 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCB8FF8020B
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 13:06:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCB8FF8020B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 04:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="298029846"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by orsmga001.jf.intel.com with ESMTP; 17 Dec 2019 04:06:30 -0800
To: Takashi Iwai <tiwai@suse.de>
References: <20191217095851.19629-1-cezary.rojewski@intel.com>
 <20191217095851.19629-2-cezary.rojewski@intel.com>
 <s5h36dj2r0y.wl-tiwai@suse.de>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <8d796ef4-e6d2-ade3-25c3-756599c44348@intel.com>
Date: Tue, 17 Dec 2019 13:06:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <s5h36dj2r0y.wl-tiwai@suse.de>
Content-Language: en-US
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Subject: Re: [alsa-devel] [PATCH 1/7] ALSA: hda: Allow for compress stream
 to hdac_ext_stream assignment
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 2019-12-17 11:19, Takashi Iwai wrote:
> On Tue, 17 Dec 2019 10:58:45 +0100,
> Cezary Rojewski wrote:
>>
>> Currently only PCM streams can enlist hdac_stream for their data
>> transfer. Add cstream field to hdac_ext_stream to expose possibility of
>> compress stream assignment in place of PCM one.
>> Limited to HOST-type only.
>>
>> Rather than copying entire hdac_ext_host_stream_assign, declare separate
>> PCM and compress wrappers and reuse it for both cases.
>>
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> ---
>>   include/sound/hdaudio.h         |  1 +
>>   include/sound/hdaudio_ext.h     |  2 ++
>>   sound/hda/ext/hdac_ext_stream.c | 46 +++++++++++++++++++++++++++++----
>>   3 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
>> index e05b95e83d5a..9a8bf1eb7d69 100644
>> --- a/include/sound/hdaudio.h
>> +++ b/include/sound/hdaudio.h
>> @@ -481,6 +481,7 @@ struct hdac_stream {
>>   	struct snd_pcm_substream *substream;	/* assigned substream,
>>   						 * set in PCM open
>>   						 */
>> +	struct snd_compr_stream *cstream;
>>   	unsigned int format_val;	/* format value to be set in the
>>   					 * controller and the codec
>>   					 */
> 
> One might use union for pointing to either PCM or compr stream and
> identify the type with some flag.
> 
> 	struct hdac_stream {
> 		union {
> 			struct snd_pcm_substream *substream;
> 			struct snd_compr_stream *cstream;
> 		};
> 		bool is_compr;
> 		....
> 
> But, I'm not advocating for this.  Although this makes the stream
> assignment more handy, it might lead to refer to a wrong object if you
> don't check the flag properly, too.  It really depends on the code.
> 

I'm happy with both - existing - and your variant. In essence, this 
causes simply: s/if (hstream->cstream)/if (hstream->is_compr)/g to occur.

In general, I'm strong supporter of a "PCM-compr marriage" idea - both 
being combined in sense of having similar base in the future so one 
could make use of "snd_base_stream", checkout the is_compr field and 
cast into actual type (_pcm_ -or- _compr_) via container_of macro.

This is more of a wish or song of the future for now, though. Compress 
and PCM ops streamlining is not within the scope of probes and requires 
much more work : )

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
