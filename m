Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7E9C2BB55
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:35:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D932064A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U27aozDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D932064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8ABBB15E4;
	Thu, 16 Apr 2020 19:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8ABBB15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587058557;
	bh=Vx+R81V/ANg+2IrKvkniPastvxxyAk2gaKomdRZ53lk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U27aozDGO5bp+76pjk2RXqXGtjrif7PmVEXlWpHm/06Qi2S6GW8OTEQmKMLvhjsxG
	 opfpahhCsEz1yUqo8xhlFPeoruU9KiYHFEfXDjcG4vWMDg+tIoO7tgHBzzLX38sK32
	 +vYETAB9ccv/D+x0qxNBBGLgIuyKc6LkS9hsi3tQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1257EF8012E;
	Thu, 16 Apr 2020 19:35:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFBB6F8014E; Thu, 16 Apr 2020 19:35:04 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6BC4F8012E
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 19:34:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6BC4F8012E
IronPort-SDR: 56PSqmMubWUOnxK5q9tEfgEou2rbPcUqlcUQiADy04EqoaZfcUFEUnaYHfVP+mNVbkx0NPpkJZ
 qYybp1GO33/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 10:34:52 -0700
IronPort-SDR: YI2gP+om0El3J2LjnTZ2QnQb4wolXjkvyBwwgjM6ygMvHwEJ/+0WLM0Hq0r7p8Thyy1D0p1KLx
 Rf0w/jgjR40A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; d="scan'208";a="253938263"
Received: from suem-mobl1.amr.corp.intel.com ([10.251.128.210])
 by orsmga003.jf.intel.com with ESMTP; 16 Apr 2020 10:34:52 -0700
Message-ID: <0557d9630b96b4111d294017dc621f672fef7fc5.camel@linux.intel.com>
Subject: Re: Question about snd_soc_card_register()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>, "Sridharan, Ranjani"
 <ranjani.sridharan@intel.com>
Date: Thu, 16 Apr 2020 10:34:50 -0700
In-Reply-To: <1799db6034f66d3c3e65e2cb4dd7a0f158c41047.camel@linux.intel.com>
References: <DM6PR11MB29052BDEDBB872123FE6410FE8D80@DM6PR11MB2905.namprd11.prod.outlook.com>
 <s5ho8rrewrq.wl-tiwai@suse.de>
 <1799db6034f66d3c3e65e2cb4dd7a0f158c41047.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
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

On Thu, 2020-04-16 at 06:18 -0700, Ranjani Sridharan wrote:
> On Thu, 2020-04-16 at 09:04 +0200, Takashi Iwai wrote:
> > On Thu, 16 Apr 2020 07:52:45 +0200,
> > Sridharan, Ranjani wrote:
> > > 
> > > Hi Takashi,
> > > 
> > > While working on implementing the probes features in SOF using a
> > > separate card
> > > for the probe DAI links, I noticed that calling
> > > snd_soc_register_card() 
> > > results in
> > > incrementing the usage_count for the device that registers the
> > > card
> > > by 2 and
> > > it is not decremented until the card is freed.
> > > 
> > > Is this the expected behaviour? Typically, we register a separate
> > > platform
> > > device for the Intel machines which in turn register the card and
> > > none of them
> > > ever enable runtime PM. So this has no impact on the parent
> > > device's runtime
> > > PM status. 
> > > 
> > > I'd like to avoid creating a separate platform device just to
> > > register the
> > > card if possible while also enabling runtime PM . But when I do
> > > this today,
> > > the device cannot enter runtime suspend at all. Could you please
> > > shed some
> > > light on this?
> > 
> > It's not clear how you see the things.  Which device are you
> > looking
> > at?  Typically a card object points to two different devices, one
> > is 
> > the real device that the chip belongs to (card->dev), and another
> > the
> > own device object for managing the device files (card.card_dev).
> > And in general, snd_soc_card_register() or snd_card_register()
> > don't
> > manipulate the runtime PM stuff by itself at all.
> 
> Its the card->dev that I am looking at. This is the device that calls
> devm_snd_soc_register_card(). 
> In my tests, the usage_count for this device is 0 before calling
> devm_snd_soc_register_card and it is 2 after the card registration is
> complete.

I dug a bit deeper and found that this happens only if the card-
>dapm.idle_bias_off is not set to true.

To be honest, I dont quite understand what the idle_bas_off setting is
meant for exactly but it does prevent card->dev 's being runtime
resumed in dapm_pre_sequence_async() and solves my issue.

I dont see this being set for most of the cards in the Intel machine
drivers and they all manifest the same symptom I was seeing. But, it
hasnt really caused any real problems because runtime PM for these
platform devices is never enabled.

Thanks,
Ranjani


