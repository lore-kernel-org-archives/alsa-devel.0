Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BAEC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:31:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7AA21582
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YKvAatGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7AA21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E91E5165E;
	Tue, 17 Dec 2019 16:30:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E91E5165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576596661;
	bh=TYhhB0lvWSUluD9H11bMQnkkvYrHk3PSjVDceYEYOmw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKvAatGiLF07d7HSkWbevUpi2R0ecBza/WkHq83VQcrUbUAqINfOCoy9oucXp1mn6
	 BYTmVjESgQmX4h/sVxrebC4zo0K5Mm9m7bwUh0KuOky8sAPNGi/zIOGaAE6nrzoQif
	 +LBS8r/q8uP76HJEWPpBAnKVGiMeGUFwFV+arXmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B48BF8025A;
	Tue, 17 Dec 2019 16:29:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59CE2F8023F; Tue, 17 Dec 2019 16:29:31 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2774F8023F
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 16:29:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2774F8023F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 07:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="212605846"
Received: from pbossart-mac02.an.intel.com ([10.122.138.72])
 by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2019 07:29:24 -0800
To: Takashi Iwai <tiwai@suse.de>, Cezary Rojewski <cezary.rojewski@intel.com>
References: <20191217095851.19629-1-cezary.rojewski@intel.com>
 <20191217095851.19629-6-cezary.rojewski@intel.com>
 <s5hzhfr1c8u.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <503799c4-b9cd-4128-5d5c-91f0fb25a009@linux.intel.com>
Date: Tue, 17 Dec 2019 08:06:32 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <s5hzhfr1c8u.wl-tiwai@suse.de>
Content-Language: en-US
Cc: Divya Prakash <divya1.prakash@intel.com>, alsa-devel@alsa-project.org,
 broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH 5/7] ALSA: core: Implement compress page
 allocation and free routines
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

On 12/17/19 4:24 AM, Takashi Iwai wrote:
> On Tue, 17 Dec 2019 10:58:49 +0100,
> Cezary Rojewski wrote:
>>
>> Add simple malloc and free methods for memory management for compress
>> streams. Based on snd_pcm_lib_malloc_pages and snd_pcm_lib_free_pages
>> implementation.
> 
> I see no user of these functions in the series.  How these are
> supposed to be used?

I asked Cezary to post those patches on alsa-devel to make sure there is 
no disagreement on the initial solution.

The next steps would be probes (data injection/extraction in the DSP 
firmware) and compressed audio support for i.MX and Intel platforms.
Both would be coming in early Q1 next year.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
