Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915BDC10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:28:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4CD20873
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KLyyjsMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4CD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56D971657;
	Wed, 11 Mar 2020 14:27:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56D971657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583933284;
	bh=sU5Aq1uJKAhLWUiBxPtB0tqkwHwXyG5aC+rm9PpmtC0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KLyyjsMg7XDLj9V+avaybLVzB+j4AZSevH39ykBnL+VlqVnOg9yfOUfUYPY4wblbv
	 Um2FNW7PoMqWGywdCCk08vIsPPfO02zGBsjtmieVl+Bc/v9YY9KWGNOUD9H/nzPsnc
	 m1cIDqknK+BKhmGT7zso/vYkNjg+1TESHF7nHvCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A88DCF801F8;
	Wed, 11 Mar 2020 14:27:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B40CDF801EB; Wed, 11 Mar 2020 14:27:09 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 117B6F800BE;
 Wed, 11 Mar 2020 14:27:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 117B6F800BE
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 06:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="277373897"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.40.3])
 by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 06:27:00 -0700
Date: Wed, 11 Mar 2020 14:26:58 +0100
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: add function parameters to enable forced path
 pruning
Message-ID: <20200311132658.GB5347@ubuntu>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <20200309170749.32313-3-guennadi.liakhovetski@linux.intel.com>
 <20200310124544.GE4106@sirena.org.uk>
 <20200311074126.GA4149@ubuntu>
 <20200311122531.GD5411@sirena.org.uk>
 <20200311123617.GA5347@ubuntu>
 <20200311124102.GE5411@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311124102.GE5411@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
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

On Wed, Mar 11, 2020 at 12:41:02PM +0000, Mark Brown wrote:
> On Wed, Mar 11, 2020 at 01:36:17PM +0100, Guennadi Liakhovetski wrote:
> > On Wed, Mar 11, 2020 at 12:25:31PM +0000, Mark Brown wrote:
> 
> > > It's still not clear to me what the issue is here.  If something is
> > > making a modification to the graph which needs a recheck or update I'd
> > > expect that these things happen along with that modification.  I don't
> > > understand what you're saying about not being able to reproduce
> > > scenarios or adding things "on top".
> 
> > VirtIO support. That function currently exists in the kernel, but I don't 
> > have a test-case to verify its work, to see it called and actually perform 
> > the pruning. So I don't know how it is supposed to work. And because of 
> > that I cannot fix my VirtIO use case to use that function properly, without 
> > forcing it with an additional parameter.
> 
> I think you need to include this with your VirtIO series.

That was also my original intention, personally I also would find it difficult 
to review this kind of work without context.

So, would you prefer me to drop this series completely and re-send it with the 
whole series or should I just drop #2 and resend #1 and #3?

Thanks
Guennadi
