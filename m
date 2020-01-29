Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C784C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:27:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4492070E
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YKgaE5AB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4492070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FB5C82C;
	Wed, 29 Jan 2020 18:26:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FB5C82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580318858;
	bh=KUG7zeR4PfixaB6hq//ZykQ+OSJHK+us5Vshvw9fVpc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKgaE5AB/kP576UCnEE9wsQbd2yAQSPvwX0qJnBbBFBlGKFiD3j53zjMYpLoXvmW5
	 Czk0a14T0tOICwEzzx5srQvWJS8Da3jXRwH0TROW41AsCrw5tCF+BzNl0UBCam31I8
	 8new1v1l1ut5Z4rYmyP5xEAqh0KbYWuHB04o90H0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A3F9F80082;
	Wed, 29 Jan 2020 18:26:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EBD1F8021E; Wed, 29 Jan 2020 18:26:44 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F73CF80082
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 18:26:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F73CF80082
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 09:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; d="scan'208";a="222515543"
Received: from rnoffsin-mobl.amr.corp.intel.com (HELO [10.252.139.181])
 ([10.252.139.181])
 by orsmga008.jf.intel.com with ESMTP; 29 Jan 2020 09:26:37 -0800
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
 Takashi Iwai <tiwai@suse.de>
References: <CAFQqKeW5b5BEU1cXRzxqmmSNCQ8Qnifn3mivx4yVnrtk7Ho0Tg@mail.gmail.com>
 <s5hsgjyn1ci.wl-tiwai@suse.de>
 <aff5f7fd-13d2-b523-b3c6-a4529c4cf26e@linux.intel.com>
 <s5htv4edxf5.wl-tiwai@suse.de>
 <d143aa71-92c7-5ba7-4866-68eef82b99b0@linux.intel.com>
 <s5ho8umdwdz.wl-tiwai@suse.de> <s5hlfpqdw25.wl-tiwai@suse.de>
 <CAFQqKeVCKp1cSL+j_uf-dbG8y1BYCTzHdrJFQ7Vo4VAsA8dYzQ@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0cbc4d4a-c529-6b65-84bf-41df31009a64@linux.intel.com>
Date: Wed, 29 Jan 2020 11:26:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFQqKeVCKp1cSL+j_uf-dbG8y1BYCTzHdrJFQ7Vo4VAsA8dYzQ@mail.gmail.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Question about the right fix for a sparse warning
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



On 1/29/20 11:16 AM, Sridharan, Ranjani wrote:
>>
>>> Sorry, my bad, it seems that my sparse program was too old.  After
>>> upgrading to the latest version, I could see the warning, too.
>>
>> ... and the cause was what I suspected: it's a 64bit compat type that
>> defines the fields explicitly with __s32.  I overlooked that it's
>> always used for __KERNEL__.  The tentative fix is below.

Nice, thanks Takashi, Ranjani and I were lost on this one.

>>
>>
>> thanks,
>>
>> Takashi
>>
>>
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -564,13 +564,13 @@ typedef char __pad_after_uframe[sizeof(__u64) -
>> sizeof(snd_pcm_uframes_t)];
>>   #endif
>>
>>   struct __snd_pcm_mmap_status64 {
>> -       __s32 state;                    /* RO: state -
>> SNDRV_PCM_STATE_XXXX */
>> +       snd_pcm_state_t state;          /* RO: state -
>> SNDRV_PCM_STATE_XXXX */
>>          __u32 pad1;                     /* Needed for 64 bit alignment */
>>          __pad_before_uframe __pad1;
>>          snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */
>>          __pad_after_uframe __pad2;
>>          struct __snd_timespec64 tstamp; /* Timestamp */
>> -       __s32 suspended_state;          /* RO: suspended stream state */
>> +       snd_pcm_state_t suspended_state;        /* RO: suspended stream
>> state */
>>          __u32 pad3;                     /* Needed for 64 bit alignment */
>>          struct __snd_timespec64 audio_tstamp; /* sample counter or wall
>> clock */
>>   };
>>
> 
> Thanks, Takashi. I will prepare a patch with the fix.
> 
> Thanks,
> Ranjani
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
