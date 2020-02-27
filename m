Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E1C4BA24
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:24:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246E824650
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EczjdY/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246E824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A5051657;
	Thu, 27 Feb 2020 02:23:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A5051657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582766674;
	bh=EUFsqGuN8X1VnLpGNmfm5LMGEbGvUTan6oIe0Q+rJ1A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EczjdY/GIcCo5Hirp/V+zw/dNKdFjPZSUMfOhTgNPCl+QyBTObQcypH6OSYjdxif6
	 rgZeTVqiGrIGX0yPa4g6Gu9C3sD6XZUO29LLBMU5kYVvFa1VhUvjn3Up+NzMRbRYR6
	 l31SuQoKHsGSO4kEEoDWAdmsooTHnEpLlUji8hcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFB5DF800E8;
	Thu, 27 Feb 2020 02:23:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4143F8014E; Thu, 27 Feb 2020 02:23:41 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2A4CF800E8
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 02:23:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2A4CF800E8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2020 17:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; d="scan'208";a="232005327"
Received: from jianmao-mobl1.amr.corp.intel.com (HELO [10.255.69.58])
 ([10.255.69.58])
 by fmsmga008.fm.intel.com with ESMTP; 26 Feb 2020 17:23:34 -0800
Subject: Re: [PATCH 6/8] ASoC: soc-pcm: check DAI's activity more simply
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87eeuh97k4.wl-kuninori.morimoto.gx@renesas.com>
 <875zft97i4.wl-kuninori.morimoto.gx@renesas.com>
 <704a2cb1-ebcd-d433-0b8a-0f8d97d72fa5@linux.intel.com>
 <87v9ns7tpk.wl-kuninori.morimoto.gx@renesas.com>
 <f99bfbaa-c1a3-3545-aef9-dcb6ad9bd77f@linux.intel.com>
 <87tv3c7tc5.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d2638e3f-37f4-a347-f5c8-c76d49e2bb8c@linux.intel.com>
Date: Wed, 26 Feb 2020 19:23:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv3c7tc5.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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



>>>>> -		if ((playback && playback_active == 1) ||
>>>>> -		    (!playback && capture_active == 1))
>>>>> +		if (codec_dai->active == 1)
>>>>
>>>> nit-pick: we have two tests in soc-pcm.c
>>>>
>>>> if (codec_dai->active)
>>>> if (codec_dai->active == 1)
>>>>
>>>> The two are functionality equivalent but it'd be good to choose one
>>>> version - or possibly use 'active' as a boolean.
>>>
>>> In my understanding, dai->active can be 0/1/2.
>>
>> I see, I guess I missed this completely. Thanks Morimoto-san for the
>> precision.
> 
> But, we want to use "if (codec_dai->active)" anyway.
> Your review indicated my mistake.

Not in this case though, the initial idea was to do the mute when only 
playback or capture were enabled? If you mute when both are enabled then 
that's a real change.

