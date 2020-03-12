Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656DC10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:10:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68E72067C
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fikNe51x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68E72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A06716EB;
	Thu, 12 Mar 2020 14:09:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A06716EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584018641;
	bh=orZpIQ4Pw3GsTUIWEYKlPTxlZgWerPNUyhIfN0dN0/c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fikNe51xPmRPjPbn8127EosSNDYvQCIZX8dKInLmOgdVLiqL6ezeNn8DJf4YxqyBI
	 plGPqucIl+qbocGXw4rwhvL2rwBQaXcrO9HJwpFYnpYIeTRgyYNELHJrocYMOTlfK9
	 1xcisPgDSMnWstKJLw8GZHnMaPJcT+FjZgOVxrEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A0CDF8020C;
	Thu, 12 Mar 2020 14:09:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D89CF8020C; Thu, 12 Mar 2020 14:09:46 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 179FCF80086;
 Thu, 12 Mar 2020 14:09:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 179FCF80086
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 06:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; d="scan'208";a="236826279"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.40.3])
 by orsmga008.jf.intel.com with ESMTP; 12 Mar 2020 06:09:36 -0700
Date: Thu, 12 Mar 2020 14:09:34 +0100
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] [RESEND] ASoC: SOF: preparatory patches
Message-ID: <20200312130933.GD15167@ubuntu>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <9cfc4182-1f22-9f28-52d8-f8aac1f7bc0b@linux.intel.com>
 <20200310125055.GF4106@sirena.org.uk>
 <20200312114536.GA15167@ubuntu>
 <20200312121549.GB4038@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312121549.GB4038@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

On Thu, Mar 12, 2020 at 12:15:49PM +0000, Mark Brown wrote:
> On Thu, Mar 12, 2020 at 12:45:37PM +0100, Guennadi Liakhovetski wrote:
> > On Tue, Mar 10, 2020 at 12:50:56PM +0000, Mark Brown wrote:
> 
> > > How does this relate to the virtio audio spec that's currently under
> > > review?
> 
> > The spec under discussion is only for simple audio virtualisation with fixed 
> > roles and topologies. With our approach guests get access to advanced DSP 
> > capabilities. The virtualisation approach under discussion can be a fallback 
> > for cases when no DSP has been detected on the host.
> 
> So they're orthogonal :/  Have you proposed your spec yet?
> 
> > > It looks to be doing something much lower level than that.
> > > I am concerned that this looks to be exposing DPCM as a virtio ABI,
> > > we're trying to replace it as an internal API never mind ABI.
> 
> > You mean that our approach works at the widget level, which is a part of the 
> > DPCM API? Well there is a translation layer between our ABI and DPCM. And by 
> > virtue of the same argument don't we already have DPCM as an ABI on the 
> > opposite side of SOF - in its IPC ABI? Largely this virtualisation approach 
> > doesn't add new interfaces, it re-uses the SOF IPC ABI, which is also one of 
> > its advantages.
> 
> Please bear in mind that the page you linked to is very high level and
> I've not seen the actual spec or anything.  The page and your mails both
> talk about DPCM so it sounds like that's a part of the interface.

Let me rebase my current stack and post it here, stay tuned :-)

Thanks
Guennadi
