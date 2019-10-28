Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28927CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:25:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DF3214E0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZFp5qgxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DF3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 139AB16D3;
	Mon, 28 Oct 2019 18:24:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 139AB16D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572283548;
	bh=JSFXJxaMpGRVKCHYknOgMMq7++kBLhhPyJW1V1GK/OA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZFp5qgxYzsawgJlvs0MvJXGRKIRRomT5cUbClOTXpjuZK2xIPxQFMs59PQbP0JPUn
	 1MKbl6USnf6GB+aYPW4BpJH6bcjUChwmRZD/qkz4iux1hIavbBHVKW9klN4C38OFaQ
	 H/GNSrbnTkNSofnr9svAfOaZAYJOJLfKrToyiycA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83DE7F802BD;
	Mon, 28 Oct 2019 18:24:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84275F80361; Mon, 28 Oct 2019 18:24:55 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFFAEF80145
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 18:24:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFFAEF80145
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 10:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; d="scan'208";a="229762177"
Received: from jshaw2-mobl2.amr.corp.intel.com (HELO [10.252.142.88])
 ([10.252.142.88])
 by fmsmga002.fm.intel.com with ESMTP; 28 Oct 2019 10:24:48 -0700
To: Takashi Iwai <tiwai@suse.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20191023090331.10531-1-kai.vehmanen@linux.intel.com>
 <20191023090331.10531-7-kai.vehmanen@linux.intel.com>
 <s5hpnigu7rs.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e84f1b69-3d62-e708-1f28-c7c62b50435f@linux.intel.com>
Date: Mon, 28 Oct 2019 12:24:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <s5hpnigu7rs.wl-tiwai@suse.de>
Content-Language: en-US
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH v7 6/9] ASoC: Intel: bxt-da7219-max98357a:
 common hdmi codec support
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



On 10/28/19 11:58 AM, Takashi Iwai wrote:
> On Wed, 23 Oct 2019 11:03:28 +0200,
> Kai Vehmanen wrote:
>>
>> @@ -4,7 +4,7 @@ snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
>>   snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
>>   snd-soc-sst-bdw-rt5677-mach-objs := bdw-rt5677.o
>>   snd-soc-sst-broadwell-objs := broadwell.o
>> -snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o
>> +snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o hda_dsp_common.o
> 
> Hrm, this can be a problem.  I see there are multiple drivers that are
> built with this object.  When they are built as modules and more than
> one module get loaded on a system, it'll lead to a conflict because
> both modules try to put the same stuff.
> 
> So, hda_dsp_common.o should be in the common helper module that is
> used by both drivers, or we need other trick.
> 
> But I'm not entirely sure whether this is true on the recent kernel
> build.  At least it *was* a problem in the past.
> 
> In anyway, please try to load the two modules on your system and check
> whether the module loading works.

along the same lines, we have a Kconfig issue that I didn't see earlier.
These bxt parts will only compile with the Skylake driver with the 
upstream code, the following test applies:

if SND_SOC_INTEL_APL

In the SOF tree, we have a different test:

if SND_SOC_INTEL_APL || (SND_SOC_SOF_APOLLOLAKE && SND_SOC_SOF_HDA_LINK)

I kept this change back on purpose since we can only use APL+SOF on 
chromebooks with an experimental CoreBoot and only on pre-production 
hardware, but what this means is that GLK devices wouldn't work with 
SOF...I'll add this fix to my Kconfig update series.

Also I wonder if anyone tested bxt_rt298 with SOF? I see a topology for 
it but I've never seen any test results from anyone.


> 
> 
> thanks,
> 
> Takashi
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
