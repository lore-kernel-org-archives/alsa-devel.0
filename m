Return-Path: <SRS0=QmEo=5X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6AC2BB1D
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:45:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A024B2074B
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LFbywYzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A024B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D63E9950;
	Tue,  7 Apr 2020 14:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D63E9950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586263522;
	bh=GlNYPcJ8GDNn+WF7JeZdHvbRN7prKbmWlOD0HWWdsRk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFbywYzQ9wrBtMJOJCeuPGgaMopnfokMgxgQA6N01RQfV6AfFV0PIMYa0AL5OFbf6
	 n0FamA7l2eO0fyWQ+q3irCTQtxvG8/0ckNJUP6mKZ/+da733YIjK31S6j1WwE1CJK6
	 5c8HGP9ojVhIsXrrW6KTUGZgBZ70uHuozXD8MHCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74FE4F80213;
	Tue,  7 Apr 2020 14:44:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51E40F801DA; Tue,  7 Apr 2020 14:44:22 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73BD1F800F0;
 Tue,  7 Apr 2020 14:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73BD1F800F0
IronPort-SDR: tNHavdjTeFJH5DhEXc9erYnEqjIQCgTPLsyhbhAYzT2tKkRrLUzy6C5PgaQAJqEt/G9aeAOsQ7
 mYVS/nhvZlrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 05:44:12 -0700
IronPort-SDR: sd+dw2Ek7xCAx7VEvM1L7C5rW865Wet2ZaU4wL+Z15o98iwErmLGmSJ1KS/RwDfxMn8pYsrabz
 rkwa6ymjxjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,354,1580803200"; d="scan'208";a="249515559"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.249.40.132])
 by orsmga008.jf.intel.com with ESMTP; 07 Apr 2020 05:44:10 -0700
Date: Tue, 7 Apr 2020 14:44:09 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v2 00/12] [RESEND] ASoC: SOF DSP
 virtualisation
Message-ID: <20200407124409.GA26007@ubuntu>
References: <20200403091406.22381-1-guennadi.liakhovetski@linux.intel.com>
 <20200403092842.GB4286@sirena.org.uk>
 <20200403110404.GA23734@ubuntu>
 <29be8be8d9b8700588da693d93b9f10adbb10016.camel@linux.intel.com>
 <20200403180918.GA25646@ubuntu> <20200407112411.GA10133@ubuntu>
 <20200407113026.GB5247@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407113026.GB5247@sirena.org.uk>
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

Hi Mark,

On Tue, Apr 07, 2020 at 12:30:26PM +0100, Mark Brown wrote:
> On Tue, Apr 07, 2020 at 01:24:11PM +0200, Guennadi Liakhovetski wrote:
> 
> > After a discussion we agreed, that we shall try to port SOF VirtIO support on 
> > top of RPMSG, even though this would be the first ever such use of RPMSG. And 
> > since this likely will take a while and be a big change we suspend this 
> > review process for now. 
> 
> OK...  the generic patches (IIRC it was about the list that Liam
> identified) looked OK so if you want to send them by themselves then I
> can apply them and it's less diff for you to carry.

Ok, I'll route them via Pierre then, because they include a new SOF IPC, which 
probably requires an ABI version update, even though it will never be sent to 
the DSP.

Thanks
Guennadi
