Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD07C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:57:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6E02073E
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="usbRQLO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6E02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D681C179C;
	Tue, 23 Jun 2020 17:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D681C179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592927862;
	bh=g+n1WSfZ4qG7o8N3jm3SjrykTQmL+2nPMzr2pc98fwo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=usbRQLO9KyATZk6rbTwcSVQrG8p4M/4QCMZhAOGXCxMAUqkNidw/Ab8XFRX5IFWKI
	 ULDRF/PAFtvQnCRIRWThd3fwrH0hzVwMk8geMdafoBzl4CCYWhOiCA/rj+l24DFzzc
	 K5GuOivhOZnLPVbGId/0VTdk4+iglR1jhaQLD7Mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D9E9F80218;
	Tue, 23 Jun 2020 17:56:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E0E4F80234; Tue, 23 Jun 2020 17:56:50 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27B1CF8010E
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 17:56:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27B1CF8010E
IronPort-SDR: mJ5mvwMr57vnw/s2LoVG4Ssrgrd9RUoAz6iWO5cat7DDzoAqlR745eZUeV73sSHNRe4bNqoOKB
 r/a4xuQRt0yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205621079"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="205621079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 08:56:40 -0700
IronPort-SDR: 0PVf8oWguu0opVT1lGIwDJwdEJ/FJcvCuPCRLbtLPsBXLRFbRIzQzLBlDYE9zDAWp6dmL+GgGs
 BueNe13Meolg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="263367198"
Received: from meis-mobl1.amr.corp.intel.com (HELO [10.255.230.137])
 ([10.255.230.137])
 by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2020 08:56:38 -0700
Subject: Re: [PATCH 1/5] ASoC: soc-link: introduce exit() callback
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
 <20200622154241.29053-2-pierre-louis.bossart@linux.intel.com>
 <87imfi3bdd.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5c020775-94db-0371-9a07-a1e59759a158@linux.intel.com>
Date: Tue, 23 Jun 2020 09:50:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87imfi3bdd.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de,
 Curtis Malainey <curtis@malainey.com>, broonie@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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



On 6/22/20 6:54 PM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>> The exit() is invoked in soc_remove_pcm_runtime(), which is not
>> completely symmetric with the init() invoked in soc_init_pcm_runtime().
> (snip)
>> @@ -945,6 +945,9 @@ void snd_soc_remove_pcm_runtime(struct snd_soc_card *card,
>>   {
>>   	lockdep_assert_held(&client_mutex);
>>   
>> +	/* release machine specific resources */
>> +	snd_soc_link_exit(rtd);
> 
> I can understand that 100% symmetric calling init()/exit() is difficult.
> So we can't help it this time. But if so, it is easy to notice that
> this .exit() is the one of non-symmetric if it has such comment.

Sorry Morimoto-san, I don't understand your last sentence.
Were you suggesting to reword the "release machine specific resources" 
comment above, or add a comment in the snd_soc_link_exit() definition, 
or something else altogether?
I don't mind sending an update if you feel that makes the core more 
readable.
Thanks!
