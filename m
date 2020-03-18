Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69573C10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:20:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E823320752
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W74TPYds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E823320752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C24F1706;
	Wed, 18 Mar 2020 18:19:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C24F1706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584552015;
	bh=6o8tgfF+rjp96+yq+NOnGjQYFISqbyrtkFSXaE9vVVs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W74TPYdsAY+wzPF4JaFwYCVDY/LrLJHVl5X8T5NtOtX2kWKKwyM/pVMOyKyjEXqGD
	 bFwAI6cvns3VJF+CMmhK3cZjAE2D6eSMY0rVOZy+i33JDKLJzEQ+kbjC7C/+GHLxWJ
	 1SWGPKqIjmDJ8F5qbpSk++Y7RO7PAKZMbHGzqcUo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A11DDF80132;
	Wed, 18 Mar 2020 18:19:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9ED55F80139; Wed, 18 Mar 2020 18:19:23 +0100 (CET)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C28FF800C0
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 18:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C28FF800C0
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
 by isilmar-4.linta.de (Postfix) with ESMTPSA id F10C02005E4;
 Wed, 18 Mar 2020 17:19:19 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
 id E36CD20B1B; Wed, 18 Mar 2020 18:19:12 +0100 (CET)
Date: Wed, 18 Mar 2020 18:19:12 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318171912.GA6203@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <d974b46b-2899-03c2-0e98-88237f23f1e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d974b46b-2899-03c2-0e98-88237f23f1e2@linux.intel.com>
Cc: cezary.rojewski@intel.com, alsa-devel@alsa-project.org, curtis@malainey.com,
 Keyon Jie <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org,
 tiwai@suse.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

On Wed, Mar 18, 2020 at 12:08:24PM -0500, Pierre-Louis Bossart wrote:
> On 3/18/20 11:20 AM, Dominik Brodowski wrote:
> > On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > > > > While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
> > > > > > some sound-related trouble: after boot, the sound works fine -- but once I
> > > > > > suspend and resume my broadwell-based XPS13, I need to switch to headphone
> > > > > > and back to speaker to hear something. But what I hear isn't music but
> > > > > > garbled output.
> > > 
> > > It's my understanding that the use of the haswell driver is opt-in for Dell
> > > XPS13 9343. When we run the SOF driver on this device, we have to explicitly
> > > bypass an ACPI quirk that forces HDAudio to be used:
> > > 
> > > https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd
> > > 
> > > Have you tried to run in plain vanilla HDAudio mode?
> > 
> > I had (see 18d78b64fddc), but not any more in years (and I'd like to keep
> > using I2S, which has worked flawlessly in these years).
> 
> ok. I don't think Intel folks have this device available, or it's used for
> other things, but if you want to bisect on you may want to use [1] to solve
> DRM issues. I used it to make Broadwell/Samus work again with SOF.
> 
> [1] https://gitlab.freedesktop.org/drm/intel/uploads/ef10c6c27fdc53d114f827bb72b078aa/0001-drm-i915-psr-Force-PSR-probe-only-after-full-initial.patch.txt
> 
> An alternate path would be to switch to SOF. It's still viewed as a
> developer option but Broadwell/Samus work reliably for me and we have a
> Broadwell-rt286 platform used for CI.

What do you mean with SOF? And no other ideas on the root cause than a
tedious bisect?

Thanks,
	Dominik
