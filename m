Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D39CA9EAF
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 00:18:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE6B20882
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 00:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="prbHJ5+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE6B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69AC99F6;
	Tue, 22 Oct 2019 02:17:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69AC99F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571703516;
	bh=/Ibqp0R3h8qpwUBgZzWdO26BGzkhau+4bdFcTN6LamE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prbHJ5+em+xAgNyKoqpTBj5H4s1PlF9WjaHN1yFmrwbfyIWzMsolJ1TmD2bEDbvtv
	 fXkrIEJ6pgx6jYLLDjZYzqv+EILMiD6c4AtB2qNxZCznI1jZL3HNR1ElkgSAL2OkOC
	 yV+qPQ3HHNHQ6fVr65+rPDFbHNR6g+sX0Qkf/bNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3964F80321;
	Tue, 22 Oct 2019 02:17:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A44BBF80368; Tue, 22 Oct 2019 02:17:44 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48BA5F801EB
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 02:17:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48BA5F801EB
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Oct 2019 17:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; d="scan'208";a="203486793"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2019 17:17:36 -0700
To: Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>
References: <201910110016.g5AIyc2E%lkp@intel.com>
 <f6f9a0a1-2a24-300d-ef15-eb3f678f2f63@ti.com>
 <20191021191913.GI4691@sirena.co.uk>
From: Rong Chen <rong.a.chen@intel.com>
Message-ID: <3e34bbfa-10b5-a051-9ff0-b1e9ea1fc4b8@intel.com>
Date: Tue, 22 Oct 2019 08:17:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191021191913.GI4691@sirena.co.uk>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>,
 kbuild-all@01.org
Subject: Re: [alsa-devel] [kbuild-all] Re: [asoc:for-5.5 122/122]
 sound/soc/codecs/tas2562.c:195:14: sparse: sparse: restricted
 snd_pcm_format_t degrades to integer
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 10/22/19 3:19 AM, Mark Brown wrote:
> On Fri, Oct 11, 2019 at 07:13:38AM -0500, Dan Murphy wrote:
>> On 10/10/19 11:41 AM, kbuild test robot wrote:
>>>      190	static int tas2562_set_bitwidth(struct tas2562_data *tas2562, =
int bitwidth)
>> The only fix I can see here is to change bitwidth to snd_pcm_format_t as
>> But that still gives this sparse warning.=A0 The way the code below is
>> written=A0 to be consistent throughout the drivers so are these warnings=
 false
>> positives?
> I think so, yes.  Or at least I can't see any sensible way to stop this
> anyway.
>

Hi,

Sorry for the inconvenience, we'll take a look at it asap.

Best Regards,
Rong Chen
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
