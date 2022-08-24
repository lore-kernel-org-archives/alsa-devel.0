Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA53C00140
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Aug 2022 11:18:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0EB51636;
	Wed, 24 Aug 2022 13:17:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0EB51636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661339924;
	bh=s8nlvbrh01ypOpAR2zebx7amZdaSTRTfeTaPl/FnEkw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HB+9vtdqETv1lshChbHo3CSJeMF0ACSle4jXhwRldS1hSHL6Eh+V+ZsGOvLz3y/pw
	 vWVTArIFGjXcTkKTv0pNrU4EfAE8ehr9arkZMnF1qjaoK/QruaBTCofH/XjKv7ANJu
	 fL30zQBnxhp/9GQsam2DeH47GB9zsov5i9/KLLXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8628CF8014E;
	Wed, 24 Aug 2022 13:17:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E24CF804BD; Wed, 24 Aug 2022 13:17:53 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A68E2F800A7
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 13:17:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A68E2F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="NXOZcGif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661339870; x=1692875870;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=s8nlvbrh01ypOpAR2zebx7amZdaSTRTfeTaPl/FnEkw=;
 b=NXOZcGifkFqFzCrjXc5AO6kip9NIgePKEXw0AWGGNG9QraPdTcddNq6n
 uCjtdfWVXO+JQFrmUxLFaF4q1fz+FHFvWxxwCycFpWCmlj4xGIaQvKUG2
 SSezpnkXRsiPrTTHIROYf2EMdgByaJMGXWnRMzRAoT40DoFtUbrYn5MFQ
 +kFbzipk5l1jl9HjTKW2mrgDYo+hTjdgHKDxOjMuj7g1VEZLVbyyIdZdh
 Z3nYQrolGfTlyUlsAmVbUC22oC1eBeso8dNIZeJH6rhR5ZvKSk0HF5HBL
 VN0HPWS2d7VDjQfQU/9ygotxdarPYkCsHpVhQdAhfCODWqHeTvH7aW+pe w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295219164"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; d="scan'208";a="295219164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2022 04:17:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; d="scan'208";a="670460307"
Received: from tleistix-mobl2.ger.corp.intel.com (HELO [10.249.43.72])
 ([10.249.43.72])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2022 04:17:43 -0700
Message-ID: <2d60c71f-a48a-48be-49be-16c2fb597eda@linux.intel.com>
Date: Wed, 24 Aug 2022 13:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] ALSA: hda: intel-nhlt: add intel_nhlt_ssp_mclk_mask()
Content-Language: en-US
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
References: <20220822185911.170440-1-pierre-louis.bossart@linux.intel.com>
 <20220822185911.170440-3-pierre-louis.bossart@linux.intel.com>
 <b112f824-631d-40d4-31bd-9bd56f31930e@linux.intel.com>
 <c7bd2799-3cbf-a984-8f48-5e069b88db51@linux.intel.com>
 <6ee7b704-fb40-a5b5-f5c0-a19096f8d1d4@linux.intel.com>
 <1b8dc49b-9a06-c842-5dee-1f44f771b5f0@linux.intel.com>
 <7fbe5d7d-05ee-0616-ac85-8813c5755671@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7fbe5d7d-05ee-0616-ac85-8813c5755671@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
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




>>>>>> +                }
>>>>>> +
>>>>>> +                cfg = (struct nhlt_fmt_cfg *)(cfg->config.caps +
>>>>>> cfg->config.size);
>>>>>> +            }
>>>>>> +        }
>>>>>> +        epnt = (struct nhlt_endpoint *)((u8 *)epnt + epnt->length);
>>>>>> +    }
>>>>>> +
>>>>>> +    return mclk_mask;
>>>>>
>>>>> Although I understand that it is relegated to the caller, but if both
>>>>> mclk being set is considered an error maybe add some kind of check
>>>>> here
>>>>> instead and free callers from having to remember about it?
>>>>>
>>>>> if (hweight_long(mclk_mask) != 1)
>>>>>       return -EINVAL;
>>>>>
>>>>> return mclk_mask;
>>>>
>>>> I went back and forth multiple times on this one. I can't figure out if
>>>> this would be a bug or a feature, it could be e.g. a test capability
>>>> and
>>>> it's supported in hardware. I decided to make the decision in the
>>>> caller
>>>> rather than a lower level in the library.
>>>>
>>>> If the tools used to generate NHLT don't support this multi-MCLK mode
>>>> then we could indeed move the test here.
>>>>
>>>
>>> Considering comment I added above I've asked Czarek to also check this
>>> series. I'm not sure it even makes sense to name the field "_mask" when
>>> it is one bit...
>>
>> it's two bits, see above.
> 
> So I've spend a bit talking with FW team, and you are right, I got
> confused by one of the tables and some code that specified it as 1 bit
> field and rest as reserved, while other documents do specify it as a
> variable range of bits.

Yeah, I had to ask multiple times as well. It's far from
self-explanatory and all the findings were based on NHLT shared with me.

See
https://github.com/thesofproject/linux/issues/3336#issuecomment-1206176141
for two examples with MCLK0 and MCLK1 used.

> Going back to return value, the tool I have access to only has support
> for MCLK0. I guess we can make the assumption for now that everyone
> connects codec to one clock source and if someone later implements HW
> where somehow 2 different clocks are used (depending on format) we can
> refine the check later?

Indeed it seems that depending on tools versions and targeted silicon,
MCLK1 may or may not be supported.

I guess it'd be fine to throw a big fat error in case this two-MCLK
configuration ever shows-up. That way we'll know for sure what was deployed.

Thanks for the feedback, I'll update this shortly.
