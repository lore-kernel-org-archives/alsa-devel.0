Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC87C4332B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 21:53:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F622076C
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WPs8wul8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F622076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 296C01699;
	Wed, 18 Mar 2020 22:52:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 296C01699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584568401;
	bh=Cg5wnj0VeMDM9Y3YICtJiwjRFOgxptBE95iyZUSfu1k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WPs8wul8aw7mQrc8uj+JXfLvsKk6PmHRks7e5VqZgJdwfGJ2HqjNsfR1vcWRVFrqu
	 myI096a6gfFbJvM/c/u5weWP+jFAFL+xmyh4N2/p2UNzL0xxq4/vMV/lFCJa6MDPEj
	 1H5YUOkrsa/7vlfOEolxwVAmrnKjqLqtFCg3Bw80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D02DF80058;
	Wed, 18 Mar 2020 22:52:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18A4CF80139; Wed, 18 Mar 2020 22:52:29 +0100 (CET)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8221F80058
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 22:52:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8221F80058
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
 by isilmar-4.linta.de (Postfix) with ESMTPSA id 756462005E4;
 Wed, 18 Mar 2020 21:52:25 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
 id 91F5B20B1B; Wed, 18 Mar 2020 22:52:18 +0100 (CET)
Date: Wed, 18 Mar 2020 22:52:18 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318215218.GA2439@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
Cc: alsa-devel@alsa-project.org, curtis@malainey.com,
 linux-kernel@vger.kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 tiwai@suse.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

On Wed, Mar 18, 2020 at 09:43:54PM +0100, Cezary Rojewski wrote:
> On 2020-03-18 20:22, Dominik Brodowski wrote:
> > On Wed, Mar 18, 2020 at 07:27:58PM +0100, Cezary Rojewski wrote:
> 
> > > 
> > > Due to pandemic I'm working remotely and right now won't be able to test
> > > audio quality so focusing on the stream==NULL issue. And thus we got to help
> > > each other out : )
> > 
> > Sure, and thanks for taking a look at this!
> > 
> > > Could you verify issue reproduces on 5.6.0-rc1 on your machine?
> > 
> > It reproduces on 5.6.0-rc1 + i915-bugfix. I'm trying to bisect it further in
> > the background, but that may take quite some time.
> > 
> 
> Could you checkout v5.6-rc1 with following commit reverted:
> 	ASoC: Intel: broadwell: change cpu_dai and platform components for SOF
> 
> For my working v5.6-rc1 commit id is:
> 64df6afa0dab5eda95cc4cc2269e3d4e83b6b6ce.

Hm, no joy -- after suspend/resume, no sound at first, and if I twiggle some
options with pulseaudio, I get garbled output (even when using

	aplay -f S16_LE -r 44100 -c 2 --device="sysdefault:CARD=broadwellrt286"

). Will try to bisect further the next days.

Thanks,
	Dominik
