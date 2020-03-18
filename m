Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ECEC10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:23:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEE920663
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="skUP1DvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEE920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD2EB1723;
	Wed, 18 Mar 2020 17:23:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD2EB1723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584548630;
	bh=Tyqcm3xiiiT+cEf78Vev5jTW/skU9g1lOSzdAma3reU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=skUP1DvJ30HMFjhMH020CvxNunEE4krQF+XW/lpZSxFft4DAmoOTeAgFR79it1cfx
	 4jswLuNxlnONeYFuAP+uX1o0icsdRkpAQ2KsokbxyOLHTxqrLXsVcL2hXq+3HEhv4T
	 AqqgJ5PrNaUjvI9hWKG/kf4kbb7bAujPzf9cBR6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27FE7F80132;
	Wed, 18 Mar 2020 17:23:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75E44F80139; Wed, 18 Mar 2020 17:22:58 +0100 (CET)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 955EFF800C0
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 17:22:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 955EFF800C0
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
 by isilmar-4.linta.de (Postfix) with ESMTPSA id 65537200B32;
 Wed, 18 Mar 2020 16:22:50 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
 id 4EC3B20B1B; Wed, 18 Mar 2020 17:20:29 +0100 (CET)
Date: Wed, 18 Mar 2020 17:20:29 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318162029.GA3999@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
Cc: cezary.rojewski@intel.com, alsa-devel@alsa-project.org, curtis@malainey.com,
 Keyon Jie <yang.jie@linux.intel.com>, tiwai@suse.com,
 linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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

On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> > > > While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
> > > > some sound-related trouble: after boot, the sound works fine -- but once I
> > > > suspend and resume my broadwell-based XPS13, I need to switch to headphone
> > > > and back to speaker to hear something. But what I hear isn't music but
> > > > garbled output.
> 
> It's my understanding that the use of the haswell driver is opt-in for Dell
> XPS13 9343. When we run the SOF driver on this device, we have to explicitly
> bypass an ACPI quirk that forces HDAudio to be used:
> 
> https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd
> 
> Have you tried to run in plain vanilla HDAudio mode?

I had (see 18d78b64fddc), but not any more in years (and I'd like to keep
using I2S, which has worked flawlessly in these years).

Thanks,
	Dominik
