Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B83C55185
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 01:51:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA222071C
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 01:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r00jfLsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA222071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E855516D1;
	Thu, 23 Apr 2020 03:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E855516D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587606669;
	bh=wJay2t370f/zJUCaoIKhNY8NZlMcnoCfHtfvD9aZNzM=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r00jfLsA0BrC+h5e8eX7Q+xkFvqfLJVh9g1f8sSi2iwkVvX8/RAFeQD58UKNQ3Fjs
	 dcqTxiqzROXnIVFEEBLXPxNuisj9HFq/LwP3s5TLrEsR1l9uyTSRwrC37fvF6KHSPf
	 SmlzMk7tItg+gWBH9rxb6HzlDvRF37uWqEcp+pMk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61C62F8014A;
	Thu, 23 Apr 2020 03:50:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21F8BF801EC; Thu, 23 Apr 2020 03:50:17 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9098AF800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 03:50:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9098AF800FF
IronPort-SDR: r5Ni6mOEGlolEGG2aTKym+Ise/MaoF477BBbamyFqn86Cr3ko76ThX0x+RHpJFBlBMz4jIGB5R
 gzFqkMb0x0Hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 18:50:06 -0700
IronPort-SDR: fEPqHODMoXL/gd1d0nVBrGXc9d44sgdHEzu232OWzdPbKyRO0bmzn0XSJlw2sMhq4wORWsTS4s
 q0TzInekWFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; d="scan'208";a="291030812"
Received: from aacostaz-mobl.amr.corp.intel.com ([10.255.74.8])
 by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 18:50:05 -0700
Message-ID: <f46655c0f1f376eadb757bde471129f2c442b195.camel@linux.intel.com>
Subject: Re: [PATCH 10/17] ASoC: soc-dai: add snd_soc_dai_compr_shutdown()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 22 Apr 2020 18:50:05 -0700
In-Reply-To: <877dy7t1ne.wl-kuninori.morimoto.gx@renesas.com>
References: <871rofunaq.wl-kuninori.morimoto.gx@renesas.com>
 <87mu73t8mu.wl-kuninori.morimoto.gx@renesas.com>
 <263fb934bf4808c0ddcc024df32ef1f385dad45b.camel@linux.intel.com>
 <877dy7t1ne.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On Thu, 2020-04-23 at 10:46 +0900, Kuninori Morimoto wrote:
> Hi Ranjani
> 
> Thank you for reviwing
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > dai related function should be implemented at soc-dai.c.
> > > This patch adds snd_soc_dai_compr_shutdown().
> > > 
> > > Signed-off-by: Kuninori Morimoto <
> > > kuninori.morimoto.gx@renesas.com>
> > > ---
> 
> (snip)
> > > +void snd_soc_dai_compr_shutdown(struct snd_soc_dai *dai,
> > > +				struct snd_compr_stream *cstream)
> > > +{
> > > +	if (dai->driver->cops &&
> > > +	    dai->driver->cops->shutdown)
> > > +		dai->driver->cops->shutdown(cstream, dai);
> > 
> > I see the original code doesnt check the return value. But I think
> > we
> > should here, no?
> 
> Yes, indeed.
> But it is shutdown function.
> Just reporting dev_err() is enough I think.
> What do you think ?
Yes, but now that you mention it, maybe we dont even need to report it.
The actual driver shutdown op would probably report it anyway.

Thanks,
Ranjani

