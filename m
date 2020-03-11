Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F707C10F25
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:42:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFBB20578
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UsT9a1cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFBB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5278A1666;
	Wed, 11 Mar 2020 08:42:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5278A1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583912575;
	bh=QWiFCM1Cr/lS0PWr6uZih8Yy5BtLnlT8WorjZ0xfLcw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UsT9a1crTbmZhHhsadNMkrt0VPXQ01LGSXNAj0z16+3j6+OQQTdwG+C/byiOdMmEp
	 +QygjyoIqdB7R83JgBeiRDhvOL35AVPWUiTEWx+/xlQWvNOf8sIPUHl9rY1XHRoZmd
	 ukUwgCRJu53GisHiwni0M0+6JAFy2wUd8TVxHjJM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0069F8028C;
	Wed, 11 Mar 2020 08:41:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA451F8028D; Wed, 11 Mar 2020 08:41:46 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 843BDF8026F;
 Wed, 11 Mar 2020 08:41:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 843BDF8026F
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 00:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; d="scan'208";a="245957901"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.40.3])
 by orsmga006.jf.intel.com with ESMTP; 11 Mar 2020 00:41:28 -0700
Date: Wed, 11 Mar 2020 08:41:27 +0100
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: add function parameters to enable forced path
 pruning
Message-ID: <20200311074126.GA4149@ubuntu>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <20200309170749.32313-3-guennadi.liakhovetski@linux.intel.com>
 <20200310124544.GE4106@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310124544.GE4106@sirena.org.uk>
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

Hi Mark,

On Tue, Mar 10, 2020 at 12:45:44PM +0000, Mark Brown wrote:
> On Mon, Mar 09, 2020 at 06:07:48PM +0100, Guennadi Liakhovetski wrote:
> 
> > soc_dpcm_runtime_update() to activate an audio path and update audio
> > routing. When streaming is stopped, the vhost driver calls
> > soc_dpcm_runtime_update() and snd_soc_runtime_deactivate(). The latter
> > doesn't work at the moment, because the DPCM doesn't recognise the
> > path as inactive. We address this by adding a "mode" parameter to
> > soc_dpcm_runtime_update(). If virtualisation isn't used, the current
> > behaviour isn't affected.
> 
> So why doesn't DPCM recognize that the path is inactive and why is it
> better to do this than fix whatever the issue is there?

Of course that would be better abd I'd much prefer that. Unfortunately I 
haven't been able to find a single scenario in which those paths would be 
exercised. As far as I understand path pruning should take place e.g. 
when a mixer modifies audio routing and as a result disables a certain 
pipeline, which is then pruned. If I could reproduce such a scenario I 
would be able to first check whether it's working, then see exactly how 
it is working and then see how best to add my use case to it. Since I 
wasn't able to find such a scenario, my only option was to preserve 
the current state and add my own path "on top." I'd be happy to try the 
other path too, I just need a use case, that I can reproduce.

Thanks
Guennadi
