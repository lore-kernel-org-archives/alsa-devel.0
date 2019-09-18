Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2C4C4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:54:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2445B2067B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b/JYDmws";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzdEEvJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2445B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45C951683;
	Wed, 18 Sep 2019 15:53:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45C951683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568814841;
	bh=OUT3Jt1yiIvfDfrpa18YT7+cezgpx16ApA9GAyjSnZU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/JYDmwsTno7rIzFVHEQZKCcvbWGXAfj52l3HNk4uOd7FBbv6z8IkrjHmDKybLRLI
	 /vUEPgzSUcpQTJwHfFDjbHbHU7LhzZC1jxhXuSKXu5fK32ahymNRkRsKd6DaFQvdx6
	 08TyuVzROh0qb0i1ompy67qA7m79UCpcRZcsAoQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF08FF804FF;
	Wed, 18 Sep 2019 15:53:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95172F80534; Wed, 18 Sep 2019 15:53:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8D9AF80146
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 15:53:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8D9AF80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SzdEEvJE"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E62852067B;
 Wed, 18 Sep 2019 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568814784;
 bh=tOUTIuyO3zD8mv1/MtmP0yO9cQ9wXjNOnusI3yuBdHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SzdEEvJEDs9IGneM+AQQk5PuVrIMlKoFeNT24elLCLvjtqmIynpAdH//B2PwS3BS3
 2CvOr5oQAZKf61ntvu9rRoWkhJlAHIcv6W5H9nd1JaTUaHeJ7ZMmEl6iDwkVSDTbvn
 g7bsaeokbrUeneI8Lgkrmdh6IB3iAS4UNwPcSM0s=
Date: Wed, 18 Sep 2019 15:53:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20190918135302.GA1919118@kroah.com>
References: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
 <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
 <20190917055512.GE2058532@kroah.com>
 <ab06c0c9-6224-a7b8-51c2-01226f763b98@linux.intel.com>
 <20190918120629.GD1901208@kroah.com>
 <c8f21078-1462-5463-ef12-957ebd9ba085@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c8f21078-1462-5463-ef12-957ebd9ba085@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 8/9] soundwire: intel: remove platform
 devices and provide new interface
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

On Wed, Sep 18, 2019 at 08:48:33AM -0500, Pierre-Louis Bossart wrote:
> On 9/18/19 7:06 AM, Greg KH wrote:
> > On Tue, Sep 17, 2019 at 09:29:52AM -0500, Pierre-Louis Bossart wrote:
> > > On 9/17/19 12:55 AM, Greg KH wrote:
> > > > On Mon, Sep 16, 2019 at 04:23:41PM -0500, Pierre-Louis Bossart wrote:
> > > > > +/**
> > > > > + * sdw_intel_probe() - SoundWire Intel probe routine
> > > > > + * @parent_handle: ACPI parent handle
> > > > > + * @res: resource data
> > > > > + *
> > > > > + * This creates SoundWire Master and Slave devices below the controller.
> > > > > + * All the information necessary is stored in the context, and the res
> > > > > + * argument pointer can be freed after this step.
> > > > > + */
> > > > > +struct sdw_intel_ctx
> > > > > +*sdw_intel_probe(struct sdw_intel_res *res)
> > > > > +{
> > > > > +	return sdw_intel_probe_controller(res);
> > > > > +}
> > > > > +EXPORT_SYMBOL(sdw_intel_probe);
> > > > > +
> > > > > +/**
> > > > > + * sdw_intel_startup() - SoundWire Intel startup
> > > > > + * @ctx: SoundWire context allocated in the probe
> > > > > + *
> > > > > + */
> > > > > +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> > > > > +{
> > > > > +	return sdw_intel_startup_controller(ctx);
> > > > > +}
> > > > > +EXPORT_SYMBOL(sdw_intel_startup);
> > > > 
> > > > Why are you exporting these functions if no one calls them?
> > > 
> > > They are used in the next series, see '[RFC PATCH 04/12] ASoC: SOF: Intel:
> > > add SoundWire configuration interface'
> > 
> > That wasn't obvious :)
> > 
> > Also, why not EXPORT_SYMBOL_GPL()?  :)
> 
> Since the beginning of this SoundWire work, the intent what that the code
> could be reused in non-GPL open-source circles, hence the dual license and
> EXPORT_SYMBOL.

Hah, you _have_ talked to your lawyers about this, right?

You have a chance to do something like this for header files, for .c
files, good luck.  That's going to be a hard road to go down.  Many have
tried in the past, all but 1 have failed.

> That said, there are cases where the code only makes sense for Linux, or
> relies on symbols that are exported with EXPORT_SYMBOL_GPL, in those cases
> we rely on GPLv2 and EXPORT_SYMBOL_GPL. For this series I added a disclaimer
> in the cover letter that those parts need to be reviewed further to make
> sure there are no conflicts with GPL.

Please do that with your lawyers, do not require developers to do legal
work for you, that's just mean :(

thanks,

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
