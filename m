Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6304CC54FD0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:04:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE1920736
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nW0RPcKC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="J/FZKiMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE1920736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21A1D16A9;
	Fri, 24 Apr 2020 21:03:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21A1D16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587755083;
	bh=k3mZdwnN73p9O3Q5RmtFz6KiJUEAkkEsKLS3C6mKF2o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nW0RPcKC40YGFLtNC/rIsCYsoX9BM9uvIn4DJI1GdzVBeOqiwpcGZYCApjdNkz3hf
	 JvBeljthqTaSE38RdoF7mvQB5cwkXS01OnWOf0tb+edpwFP/BBLvKG461aFuPGw3cS
	 V9Q0OUXAm+/ijuH986EazIn4TWnmg19LT3wP/ICE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A9AAF80121;
	Fri, 24 Apr 2020 21:03:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A78BDF80142; Fri, 24 Apr 2020 21:03:50 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A01CDF80116
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 21:03:43 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 530F7A0040;
 Fri, 24 Apr 2020 21:03:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 530F7A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1587755022; bh=7jB3ujQg1srHW2oarIigfXcU55Jlb7aKqyXPqiWySMY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=J/FZKiMrs8sAMAprQcEzopI045UC8tG9Aq6nk/JhMe1Hfah21oFDn05G6YW3c3s92
 /PNd6FlYGK+bh37nWltALIWgeDzcwwuc+XTcAUkEQUX2rHtRSO6+++4T2B/EzxV/fg
 VWw/n2f6J3WOK4HaLjWe/bBp1RLl4mR5tvZYzV1Q=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 24 Apr 2020 21:03:37 +0200 (CEST)
Subject: Re: ASoC driver names
To: Mark Brown <broonie@kernel.org>
References: <c57f21dc-412d-3057-6150-b96d96a20727@perex.cz>
 <20200423110437.GF4808@sirena.org.uk>
 <e31a20e6-91ab-2f30-f496-064bea07762a@perex.cz>
 <7b44a625-fe88-5eac-280f-daa15a7c83dc@linux.intel.com>
 <20200423184056.GS4808@sirena.org.uk>
 <aaff591f-9f3a-257b-4fba-71c39b3bf3ea@perex.cz>
 <20200424164944.GI5850@sirena.org.uk>
 <0a1b7396-f7d9-b6a9-2e85-70517b5dc718@perex.cz>
 <20200424181510.GJ5850@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <27f25fd6-c41f-22d4-57de-b3788677ba54@perex.cz>
Date: Fri, 24 Apr 2020 21:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424181510.GJ5850@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Dne 24. 04. 20 v 20:15 Mark Brown napsal(a):
> On Fri, Apr 24, 2020 at 07:11:46PM +0200, Jaroslav Kysela wrote:
>> Dne 24. 04. 20 v 18:49 Mark Brown napsal(a):
> 
>>> So if it's not really going to be used for anything particularly
>>> concrete then I'm having a hard time summoning the enthusiasm for a
>>> change.
> 
>> The driver name is used as the directory name in UCM / UCM2. For DT, it
>> means thousands possible directories (one per board / board + codec variant
>> and so on..). The generic simple asoc card is a good example.
> 
> Sure, then you end up with a few directories with huge numbers of files
> which seems similar?

We can add more levels on demand (when the configs will grow) using the 
conditions in UCM2. For example:

ucm2/ASoC\ Simple/ASoC\ Simple.conf
- which can point to (based on other sound driver / sysfs strings):
   - ucm2/ASoC Simple/platform1/rt999/board1.conf
   - ucm2/ASoC Simple/platform1/rt999/board2.conf

etc...

The conditions may also shrink the number of configuration files, because the 
cards might be different only slightly.

The current scheme is "too flat" and constrained.

>  TBH if UCM weren't doing the directory thing it'd
> be easier to see fixing the neatness issue, what UCM is doing means that
> it's much more likely that people will notice a problem.
 >
> 
>>>   It feels more like a neatness thing than anything else and the
>>> postitive case just isn't jumping out at me, certainly not as a thing to
>>> force for everything.  New stuff, sure.  I guess I'm not bothered enough
>>> to block any platform that has a burning desire to convert either though
>>> if users start coming and complaining about kernel upgrades breaking
>>> things we'd have to revert.
> 
>> :-( I don't propose to force one way. We can conditionally change the driver
>> names using a well documented CONFIG_ option to keep compatibility with the
>> older user space code. The new driver names may be selected manually in the
>> kernel config.
> 
> That does provide some mitigation, though there's some potential for
> confusion too.  We could try it and see I guess.

Thanks.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
