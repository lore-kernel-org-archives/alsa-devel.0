Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3122DC00140
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Aug 2022 12:17:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5462D163C;
	Wed, 24 Aug 2022 14:16:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5462D163C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661343457;
	bh=TmjGO0NVDRdFahzrHiU0FwMvgDTYbCalMoKFRGQZ6Bk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/LbwjxK692YpkExFv09eILztJPznfaH5fv6jBsrgJTEoOMjJ5z2prgAWMyg/Ou+B
	 bO6FjLw+q+quq5Ej/Gepu5awLgbaNkMGtaE/+hVCs7O0x5ogU2CT5gpv8sPgbqS0QO
	 MFawGDnAU53JHa2BEF65tvCOggcCFpk+9YA8eMoI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA451F8014E;
	Wed, 24 Aug 2022 14:16:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC1F4F804BD; Wed, 24 Aug 2022 14:16:45 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E64B8F8014B
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 14:16:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E64B8F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ZfzOShpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661343403; x=1692879403;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TmjGO0NVDRdFahzrHiU0FwMvgDTYbCalMoKFRGQZ6Bk=;
 b=ZfzOShpfY/uv9PilOFz5PXXJ2bRF2CqLL0LG7nKx+oJuwJV5KEeTBTeZ
 R6C4d4/zIxV0qd6yVyvbmHMTE/xv+z9CLm9svX69RKevnynCRmeOTIVDC
 VUh9Do1qrdDHyaEUcO8tn8ZxlwaBdGl6V2FjkLM1QhWaPxcmUWXMbiio/
 lTWHFlk3d2xA6xo6SMBBknmucx90lxtyzG2QOCCOx3UhQGNoB7lGR9nrZ
 Cwd+SBO39l+7Mflku1U69VBnJjMXeCUxWhpmdfF3INoSRBa3/CUJkj1pQ
 BBy7y9dg3T7DsTGsggJecqmiwpiWbc832WkmmN41s3QMAHsj6noIWfeiV g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294718973"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; d="scan'208";a="294718973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2022 03:53:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; d="scan'208";a="560554951"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.48])
 ([10.99.241.48])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2022 03:53:46 -0700
Message-ID: <7fbe5d7d-05ee-0616-ac85-8813c5755671@linux.intel.com>
Date: Wed, 24 Aug 2022 12:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] ALSA: hda: intel-nhlt: add intel_nhlt_ssp_mclk_mask()
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20220822185911.170440-1-pierre-louis.bossart@linux.intel.com>
 <20220822185911.170440-3-pierre-louis.bossart@linux.intel.com>
 <b112f824-631d-40d4-31bd-9bd56f31930e@linux.intel.com>
 <c7bd2799-3cbf-a984-8f48-5e069b88db51@linux.intel.com>
 <6ee7b704-fb40-a5b5-f5c0-a19096f8d1d4@linux.intel.com>
 <1b8dc49b-9a06-c842-5dee-1f44f771b5f0@linux.intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <1b8dc49b-9a06-c842-5dee-1f44f771b5f0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/23/2022 5:18 PM, Pierre-Louis Bossart wrote:
> 
>>>>> +
>>>>> +            fmt = (struct nhlt_fmt *)(epnt->config.caps +
>>>>> epnt->config.size);
>>>>> +            cfg = fmt->fmt_config;
>>>>> +
>>>>> +            /*
>>>>> +             * In theory all formats should use the same MCLK but it
>>>>> doesn't hurt to
>>>>> +             * double-check that the configuration is consistent
>>>>> +             */
>>>>> +            for (j = 0; j < fmt->fmt_count; j++) {
>>>>> +                u32 *blob;
>>>>> +                int mdivc_offset;
>>>>> +
>>>>> +                if (cfg->config.size >= SSP_BLOB_V1_0_SIZE) {
>>>>> +                    blob = (u32 *)cfg->config.caps;
>>>>> +
>>>>> +                    if (blob[1] == SSP_BLOB_VER_2_0)
>>>>> +                        mdivc_offset = SSP_BLOB_V2_0_MDIVC_OFFSET;
>>>>> +                    else if (blob[1] == SSP_BLOB_VER_1_5)
>>>>> +                        mdivc_offset = SSP_BLOB_V1_5_MDIVC_OFFSET;
>>>>> +                    else
>>>>> +                        mdivc_offset = SSP_BLOB_V1_0_MDIVC_OFFSET;
>>>>> +
>>>>> +                    mclk_mask |=  blob[mdivc_offset] & GENMASK(1, 0);
>>
>> One more thing, where does this GENMASK come from, as far as I can tell
>> HW specifies and FW uses one bit field to signal that MCLK is enabled?
>> (mdivc is simply a value written to HW register to configure it).
> 
> There are two MCLK signals, that's the point of this patch. We need to
> find which one is used. Platforms typically use MCLK0 except when they
> don't..
> 
> BIT(0) set in mdivc enables MCLK0
> BIT(1) set in mdivc enabled MCLK1
> 
> see
> https://github.com/thesofproject/sof/blob/44a5200c87625588f0028aa08d560e68f2b8dc82/src/drivers/intel/ssp/mn.c#L150
> 
>>>>> +                }
>>>>> +
>>>>> +                cfg = (struct nhlt_fmt_cfg *)(cfg->config.caps +
>>>>> cfg->config.size);
>>>>> +            }
>>>>> +        }
>>>>> +        epnt = (struct nhlt_endpoint *)((u8 *)epnt + epnt->length);
>>>>> +    }
>>>>> +
>>>>> +    return mclk_mask;
>>>>
>>>> Although I understand that it is relegated to the caller, but if both
>>>> mclk being set is considered an error maybe add some kind of check here
>>>> instead and free callers from having to remember about it?
>>>>
>>>> if (hweight_long(mclk_mask) != 1)
>>>>       return -EINVAL;
>>>>
>>>> return mclk_mask;
>>>
>>> I went back and forth multiple times on this one. I can't figure out if
>>> this would be a bug or a feature, it could be e.g. a test capability and
>>> it's supported in hardware. I decided to make the decision in the caller
>>> rather than a lower level in the library.
>>>
>>> If the tools used to generate NHLT don't support this multi-MCLK mode
>>> then we could indeed move the test here.
>>>
>>
>> Considering comment I added above I've asked Czarek to also check this
>> series. I'm not sure it even makes sense to name the field "_mask" when
>> it is one bit...
> 
> it's two bits, see above.

So I've spend a bit talking with FW team, and you are right, I got 
confused by one of the tables and some code that specified it as 1 bit 
field and rest as reserved, while other documents do specify it as a 
variable range of bits.

Going back to return value, the tool I have access to only has support 
for MCLK0. I guess we can make the assumption for now that everyone 
connects codec to one clock source and if someone later implements HW 
where somehow 2 different clocks are used (depending on format) we can 
refine the check later?
