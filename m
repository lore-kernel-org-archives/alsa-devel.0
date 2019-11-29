Return-Path: <SRS0=Vfj9=ZV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B7FC432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:37:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19052176D
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q21g7PGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19052176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9655F16A0;
	Fri, 29 Nov 2019 17:36:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9655F16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575045425;
	bh=xvUSrs4SH+NAQDGM0kKzZCX23218oK/v2DTHtYgy5d8=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q21g7PGarCPePISUtRKOWVlDvjYDW5o9nqbGcVVmgobLm8B5xAtu1QtI5/56C9hUW
	 H46oiWKci9Y34yKZH/LCMxfp30rtKza4dOc9kxL6tW0Dfjeu+T5PRSbWtSeD5IeUY3
	 udaorIp8S452WBfiOVIvp9lnwmrnJ9E54q3go0x4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B560F800C2;
	Fri, 29 Nov 2019 17:36:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED159F8016F; Fri, 29 Nov 2019 17:36:12 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67ECAF80141
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2019 17:36:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67ECAF80141
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2019 08:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; d="scan'208";a="409677905"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2019 08:36:04 -0800
Date: Fri, 29 Nov 2019 18:36:04 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hsgm6ra98.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.1911291803050.16459@zeliteleevi>
References: <20191129143756.23941-1-kai.vehmanen@linux.intel.com>
 <20191129143756.23941-2-kai.vehmanen@linux.intel.com>
 <alpine.DEB.2.21.1911291638430.16459@zeliteleevi>
 <s5hsgm6ra98.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Nikhil Mahale <nmahale@nvidia.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/2] [RFC] ALSA: hda: hdmi - preserve
 non-MST PCM routing for Intel platforms
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hey,

On Fri, 29 Nov 2019, Takashi Iwai wrote:

> On Fri, 29 Nov 2019 15:47:11 +0100, Kai Vehmanen wrote:
> > This second patch is however trickier. Nikhil your patch changed the 
> > default allocation a bit, so the routing might be difference also with 
> > snd-hda-intel (i.e. not SOF) for existing platforms and this may surprise 
> > users.
> 
> Well, but the allocation itself is dynamic for DP-MST, even on Intel,
> so user can't expect the completely persistent index assignment.
> That's the reason I took Nikhil's patch (even I suggested to simplify
> in that way).
[...]
> We had a trick to assign the primary index.  It still works, right?
> That should be the only concern.
[...]
> This is a platform-specific part, and on Intel, the assumption has
> been that pipe is equivalent with dev_id.  If this changed, of course,
> we must reconsider the whole picture.

hmm, the pipe equivalency should actually still hold. Looking at the code 
more, this could also be a lurking bug on graphics driver that had 
new side-effects with the recent ALSA side changes. E.g. I've received
logs where dev_id=1 is for a single connected HDMI monitor. I need to
investigate more whether this is an expected behaviour or a bug. :)

>> PS I did not have time to fully test the RFC patch, so this is just
>>    for discussion now...
> Since the assignment should work with your patch somehow, I already
> applied it.  Let's do fine tune-up during 5.5 rc cycles, if any.

Ack, ok. My commit message is a bit confusing (the wording about MST is 
not correct) but the actual code restores original behaviour so this 
should be good to apply. I'll continue testing and also dig a bit deeper 
into the bugreports w.r.t. what happens in the problematic non-MST cases. 
Thanks for the quick reviews!

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
