Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA803C54EAA
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 15:01:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EC93827;
	Wed, 25 Jan 2023 16:00:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EC93827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674658897;
	bh=S+Am6BVg0+FCGGCeOsty0UhhHPpQeXV2heQLstI67T0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pPce5D1o7FBEmrN3CubKMYOgfsF7S0xYrm6sTq3l0Un3XGlqzwX38JrDwTknQBYMy
	 MAJlDgcbYGP16CBrKYsfi+hQAFUNr9CC1W7SsQ1l1lgBcFK+CDWDIeTjEx4pySudv9
	 nXSaIRAmtiRSQzzv2jQfReGZtqqpZDJ335SN3L3c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36A55F802E8;
	Wed, 25 Jan 2023 16:00:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FAC6F80424; Wed, 25 Jan 2023 16:00:46 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED9C7F800AE
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 16:00:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED9C7F800AE
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=htNwi3aw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674658841; x=1706194841;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=S+Am6BVg0+FCGGCeOsty0UhhHPpQeXV2heQLstI67T0=;
 b=htNwi3aw+3KOc6jf335Scvg8C5k9OYXV2ZlyKeIATI7AF922G/SMY3yP
 O0Qbbbz0Uheot4Da/DgcGaq3kFsm42lYg4SHWb4ca8Tz9R6o83iTNLOFr
 mCh/jxqRuMiSLD/pmg/Zst6cCWqnuI2APOWAsg/bIxj8P+vOMKOlKR4XT
 togKAXJrLqGwLgzLUvbv413nW/yw11wPbdsM6rq8wC9hgFCPnNzNythT3
 ti1dPnd6GQIFOX+JyY1NBB14uxwWB8d5v59AnzpcNBLI9DiSgjvwDGlSR
 cAXwT80fauSWf3wjhzxBEo7yqCYHpTjwJ/hUQMWGKDKi8p3ueR4rIhsXt Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326601088"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="326601088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 07:00:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="655824428"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="655824428"
Received: from bshunt-mobl.amr.corp.intel.com (HELO [10.212.37.80])
 ([10.212.37.80])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 07:00:34 -0800
Message-ID: <53e3919e-48cc-81a0-365e-015235d10c9b@linux.intel.com>
Date: Wed, 25 Jan 2023 09:00:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: struct snd_pcm_ops callbacks
To: Muni Sekhar <munisekharrms@gmail.com>,
 alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org
References: <CAHhAz+gxrjB04c-GHa1YzahyKDQcW3+xoDt9iUnkj9THKvG_TA@mail.gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAHhAz+gxrjB04c-GHa1YzahyKDQcW3+xoDt9iUnkj9THKvG_TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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



On 1/25/23 05:21, Muni Sekhar wrote:
> Hi,
> 
> struct snd_pcm_ops callbacks can be used for sending\receiving PDM
> audio data to and from a sound card? Or is it only designed for PCM
> audio data?

It depends what side of the sound card you are looking at, the physical
interface with external devices or the userspace interface.

PDM can be supported at the physical interface level as long as there is
a conversion to PCM somewhere in the hardware. Userspace will
play/record PCM. See examples in many codecs and SOCs.

There is also the possibility of packing PDM (aka DSD) as pseudo-PCM,
that's a trick used by several USB cards. In that case of course the
sound card cannot apply any processing to the data and is just a
pass-through module.


