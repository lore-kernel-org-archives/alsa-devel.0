Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A04AC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 14:43:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDA860F58
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 14:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDDA860F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61A681685;
	Fri,  8 Oct 2021 16:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61A681685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633704184;
	bh=plZ+VocAF3cHD0Ye1bGK+4p32y9RfPlSXoiEZvvYOA4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGP0Diubjamyp3GXrntYHOxW1x3IjPerhnyyJbb/MUNIcodTHN1iPDCsK91np9rsd
	 evsq/WGWeMvPLFL0HkNAqTWv/f1d3REucPHpn52YpoOW0505XTnxcTl6r8cMHLvbwG
	 tt3DuNrX94e+qZBbXO5ySAgHicg+aEogMbios6X8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7C5AF80229;
	Fri,  8 Oct 2021 16:42:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AD9CF80246; Fri,  8 Oct 2021 16:42:11 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12849F80229
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 16:42:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12849F80229
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213466703"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; d="scan'208";a="213466703"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2021 07:42:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; d="scan'208";a="440664428"
Received: from vgopala1-mobl.amr.corp.intel.com (HELO [10.212.34.202])
 ([10.212.34.202])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2021 07:42:02 -0700
Subject: Re: [RFC PATCH v2 0/5] ASoC: soc-pcm: fix trigger race conditions
 with shared BE
To: Takashi Iwai <tiwai@suse.de>
References: <20211004225441.233375-1-pierre-louis.bossart@linux.intel.com>
 <cce82420-d744-ee43-d514-b77ac4905ffa@nvidia.com>
 <1efa1c31-7342-05f8-5f73-95e2462d4179@linux.intel.com>
 <3683cf39-632b-50df-c65d-63779c464850@nvidia.com>
 <11257d77-9975-3b00-94da-5dc1b5c95fc6@linux.intel.com>
 <s5hk0ip9js7.wl-tiwai@suse.de>
 <ff43fede-aa66-3cb7-6365-e1f279cd135f@linux.intel.com>
 <s5hzgrk98y9.wl-tiwai@suse.de>
 <80882fe6-ea30-43f6-8d83-8995dd28c748@linux.intel.com>
 <s5hwnmo96vh.wl-tiwai@suse.de>
 <60c6a90b-290d-368c-ce61-4d86e70eaa78@linux.intel.com>
 <s5hily88rri.wl-tiwai@suse.de>
 <75894aba-ca1a-51d6-df7d-ad53fcd89f79@linux.intel.com>
 <s5hee8w82ng.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e9340874-320a-8fc6-f3a4-9cf77f85db25@linux.intel.com>
Date: Fri, 8 Oct 2021 09:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hee8w82ng.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sameer Pujar <spujar@nvidia.com>, vkoul@kernel.org, broonie@kernel.org,
 Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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



>>>> I think the only solution is to follow the example of the PCM case,
>>>> where the type of lock depends on the FE types, with the assumption that
>>>> there are no mixed atomic/non-atomic FE configurations.
>>>
>>> Yes, and I guess we can simply replace those all card->dpcm_lock with
>>> FE's stream lock.  It'll solve the atomicity problem, too, and the FE
>>> stream lock can be applied outside the loop of dpcm_be_disconnect()
>>> gracefully.
>>>
>>> And, this should solve the race with dpcm_be_dai_trigger() as well,
>>> because it's called from dpcm_fe_dai_trigger() that is called already
>>> inside the FE's stream lock held by PCM core.  A PoC is something like
>>> below.  (I replaced the superfluous *_irqsave with *_irq there)
>>
>> No I don't think so. The code starts from an FE and loops for all the
>> BEs connected to that FE, but we want to serialize at the BE level! we
>> really need a dpcm lock at the card level, not the FE/stream level.
> 
> The FE lock prevents the race between dpcm_be_dai_trigger() and
> dpcm_be_disconnect(), i.e. the problem Gyeongtaek showed.
> 
> The race among concurrent dpcm_be_dai_trigger() calls itself can be
> addressed by BE stream locks as suggested earlier.

I am not following your line of thought Takashi.

dpcm_be_disconnect already uses a spin_lock around

list_del(&dpcm->list_be);
list_del(&dpcm->list_fe);

and in some other places, are you suggesting we change those to the FE lock?

Otherwise, I understood your proposal as using three locks (existing
spinlock, FE lock, BE lock) to deal with DPCM. If the existing spinlock
and FE lock are combined, we'd still have two locks.

I was suggesting we use only one ;-)

