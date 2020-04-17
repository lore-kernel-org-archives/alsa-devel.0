Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8C5C2D0EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:51:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEAC2223C
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o8uK8fVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEAC2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 438C61665;
	Fri, 17 Apr 2020 17:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 438C61665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587138698;
	bh=+1X6e1Ue2Ua+AIBBlY4glumRj9YSHQw1O5yE+owvPX0=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8uK8fVksm3xaVhAu1fnRfuqgWUjADxiPGGm0xVUhx+qyjpaC8pHwvHN4Iowsd1R/
	 KerIirpka2TXSuGyNVCLuKyP92DhmZF/a+qzp13X60v5MGGlXNEKP8+OLE1bMP0R4k
	 roFY1Tk2aY5YSn9CfEvolpE/8XyshCztfIwNAGvI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC3E6F80229;
	Fri, 17 Apr 2020 17:50:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B80FF80245; Fri, 17 Apr 2020 17:50:45 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 547CCF8012E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 17:50:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 547CCF8012E
IronPort-SDR: XYMAa6XTDKoTW7zpun19OYvtXgQKT07ns0eRV45MHZBZTxBEO8K5Cp60q4B6rcxrE+iDQgBFLU
 0/KkTksDX9lA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 08:50:39 -0700
IronPort-SDR: EzrDw1oBE0PEh4YcjVY+GCa4Dt66pnIHJimDNlSxXFLMdiyoW0fj5LHLajwuCp32SYet24adRR
 DF3sIDLInKlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; d="scan'208";a="244738840"
Received: from ccnelson-mobl.amr.corp.intel.com ([10.254.185.99])
 by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2020 08:50:39 -0700
Message-ID: <ea5c2287a9e6f2fa45e5f5332fc30664f482aebd.camel@linux.intel.com>
Subject: Re: Question about snd_soc_card_register()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Date: Fri, 17 Apr 2020 08:50:39 -0700
In-Reply-To: <s5hmu7abhnk.wl-tiwai@suse.de>
References: <DM6PR11MB29052BDEDBB872123FE6410FE8D80@DM6PR11MB2905.namprd11.prod.outlook.com>
 <s5ho8rrewrq.wl-tiwai@suse.de>
 <1799db6034f66d3c3e65e2cb4dd7a0f158c41047.camel@linux.intel.com>
 <0557d9630b96b4111d294017dc621f672fef7fc5.camel@linux.intel.com>
 <s5hmu7abhnk.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Takashi Iwai <tiwai@suse.com>,
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

On Fri, 2020-04-17 at 11:11 +0200, Takashi Iwai wrote:
> On Thu, 16 Apr 2020 19:34:50 +0200,
> Ranjani Sridharan wrote:
> > 
> > On Thu, 2020-04-16 at 06:18 -0700, Ranjani Sridharan wrote:
> > > On Thu, 2020-04-16 at 09:04 +0200, Takashi Iwai wrote:
> > > > On Thu, 16 Apr 2020 07:52:45 +0200,
> > > > Sridharan, Ranjani wrote:
> > > > > 
> > > > > Hi Takashi,
> > > > > 
> > > > > While working on implementing the probes features in SOF
> > > > > using a
> > > > > separate card
> > > > > for the probe DAI links, I noticed that calling
> > > > > snd_soc_register_card() 
> > > > > results in
> > > > > incrementing the usage_count for the device that registers
> > > > > the
> > > > > card
> > > > > by 2 and
> > > > > it is not decremented until the card is freed.
> > > > > 
> > > > > Is this the expected behaviour? Typically, we register a
> > > > > separate
> > > > > platform
> > > > > device for the Intel machines which in turn register the card
> > > > > and
> > > > > none of them
> > > > > ever enable runtime PM. So this has no impact on the parent
> > > > > device's runtime
> > > > > PM status. 
> > > > > 
> > > > > I'd like to avoid creating a separate platform device just to
> > > > > register the
> > > > > card if possible while also enabling runtime PM . But when I
> > > > > do
> > > > > this today,
> > > > > the device cannot enter runtime suspend at all. Could you
> > > > > please
> > > > > shed some
> > > > > light on this?
> > > > 
> > > > It's not clear how you see the things.  Which device are you
> > > > looking
> > > > at?  Typically a card object points to two different devices,
> > > > one
> > > > is 
> > > > the real device that the chip belongs to (card->dev), and
> > > > another
> > > > the
> > > > own device object for managing the device files
> > > > (card.card_dev).
> > > > And in general, snd_soc_card_register() or snd_card_register()
> > > > don't
> > > > manipulate the runtime PM stuff by itself at all.
> > > 
> > > Its the card->dev that I am looking at. This is the device that
> > > calls
> > > devm_snd_soc_register_card(). 
> > > In my tests, the usage_count for this device is 0 before calling
> > > devm_snd_soc_register_card and it is 2 after the card
> > > registration is
> > > complete.
> > 
> > I dug a bit deeper and found that this happens only if the card-
> > > dapm.idle_bias_off is not set to true.
> > 
> > To be honest, I dont quite understand what the idle_bas_off setting
> > is
> > meant for exactly but it does prevent card->dev 's being runtime
> > resumed in dapm_pre_sequence_async() and solves my issue.
> > 
> > I dont see this being set for most of the cards in the Intel
> > machine
> > drivers and they all manifest the same symptom I was seeing. But,
> > it
> > hasnt really caused any real problems because runtime PM for these
> > platform devices is never enabled.
> 
> Hrm, that's puzzling behavior indeed.
> 
> And it seems that Intel byt drivers are the only machine drivers that
> set idle_bias_off.  I guess those set the flag for some workaround?

I have two theories about this:
1. Some of the BYT machine drivers that set this, do it in their codec
init functions. My guess is this is likely to prevent the codec from
being permanently runtime active.
2. Others are simply copy/paste's and probably not needed.

I can investigate further and confirm my thoeries. But do you foresee
any issues with setting the idle_bias_off for the card's DAPM context?

Thanks,
Ranjani

