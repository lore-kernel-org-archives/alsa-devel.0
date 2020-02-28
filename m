Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB4C3F2D1
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:24:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B876C246AC
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="knj1DoPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B876C246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E84B016D0;
	Fri, 28 Feb 2020 13:23:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E84B016D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582892671;
	bh=YZTHTS3ClPtLnPagiPqbznGOwsy1sDb5F4EqLNUQHOw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=knj1DoPhBSAuNiUHbfSb2fPTmZKOZ5gXDFwfXYt6XwleHird/mWZaZ+t9Wb+nUs++
	 t9jxaMCpoP8oZfPMEhi+f201IhThqgYC2TrO/1crS4F3fmPmFhugN1aTe66tx0YXFz
	 /Jm3VCCrGjA47QZ8X+DqxDbT9SZy/aP3T6QCxYJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55260F8014D;
	Fri, 28 Feb 2020 13:23:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0A5AF8014E; Fri, 28 Feb 2020 13:23:33 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F4122F80113
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 13:23:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F4122F80113
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 04:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; d="scan'208";a="257102425"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 28 Feb 2020 04:23:23 -0800
Date: Fri, 28 Feb 2020 14:23:22 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Revert "call snd_soc_component_open/close()
 once"
In-Reply-To: <87zhd35eko.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <alpine.DEB.2.21.2002281404580.2957@eliteleevi.tm.intel.com>
References: <20200219182650.1416-1-kai.vehmanen@linux.intel.com>
 <87blput7hh.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.21.2002201103060.2957@eliteleevi.tm.intel.com>
 <87mu9cspyf.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.21.2002211251280.2957@eliteleevi.tm.intel.com>
 <87mu978pob.wl-kuninori.morimoto.gx@renesas.com>
 <87ftey88wk.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.21.2002271110010.2957@eliteleevi.tm.intel.com>
 <874kvb7d38.wl-kuninori.morimoto.gx@renesas.com>
 <871rqf6xas.wl-kuninori.morimoto.gx@renesas.com>
 <87zhd35eko.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, digetx@gmail.com
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

Hey,

catching up with the thread :)

On Fri, 28 Feb 2020, Kuninori Morimoto wrote:

> > > 	start(substream-A); <=
> > > 	start(substream-B);
> > > 	start(substream-C);
> > >
> > > 	stop(substream-Z);  <=
> > > 	stop(substream-B);
> > > 	stop(substream-C);
[snip]
> I don't want to have substream list on each components,
> and keep simple code as much as possible.
[snip]
> My current idea is using ID. What do you think ?
> It is not super simple though...

Hmm, I think then we end up with new problems managing the IDs.
Specifically:

> 	int soc_pcm_open(...)
> 	{
> 		static u8 id;
> 
> 		/* update ID */
> 		id++;
> 		if (id == 0)
> 			id++;

... this really isn't solid. If you have a complex scenario and something 
goes wrong, debugging the ids is going to be painful if they are assigned 
this way.

I think in the end we should go back to this:

int snd_soc_component_open(struct snd_soc_component *component,
»       »       »          struct snd_pcm_substream *substream)

... this essentially creates new state by assigning a new substream to the 
component, and we should explicitly track it. I know you wanted to avoid 
this, but I think in the end it's the cleanest solution and aligned to 
rest of ALSA. Aside cleaning up implementation of close(), this will help 
also in other methods, like e.g.:

int snd_soc_component_prepare(struct snd_soc_component *component,
»       »       »             struct snd_pcm_substream *substream)
{
»       if (component->driver->prepare)
»       »       return component->driver->prepare(component, substream);
»       return 0;
}

.. if prepare() is called with a substream that is not opened for this 
component, we could catch it here if we were tracking substreams.

Br, Kai
