Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C540C4CEC4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 19:51:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731902242D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KEzuhMzt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+fH8zRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731902242D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8891A166F;
	Wed, 18 Sep 2019 21:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8891A166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568836307;
	bh=3N/MI1WK7UKJvTbBRnaD8vU/RenAqcPHWpgISHPNKl0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KEzuhMztXWPi9K7Mj20ArPzYF1v6+UeVppW31cCHtaOLeaoC5vPN0ki5leA89DGgx
	 frmpt5yRperjLjWYinCR8uIRwDKSqzTIbpfes5krVsINdKFTObSD58sT5v4bQt9qJx
	 1x3EJEgcfa+RuHXa37FB/M5Q0n76P78T/MVChtaI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9EA4F804FF;
	Wed, 18 Sep 2019 21:50:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD6ECF80506; Wed, 18 Sep 2019 21:50:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DB93F80146
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 21:50:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DB93F80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j+fH8zRN"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B342D207FC;
 Wed, 18 Sep 2019 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568836249;
 bh=L3nHUsrfa6UXv3Wh18UBzqltAVEsOn65UXCWC291020=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j+fH8zRN+Dq/kuopHk/1kdq2G/lrFdnvWpchuRslixgNUL4q7xwFAWvSpxsfuPLcQ
 1rJpK/aiII9pzo/P9xbk95fkcgyvFn1ppHpOG+wkGW5B1z9zUaEqa2a+yNOGFHwdCV
 LqPV8O8vCdPfe2gIfSnRmmJOHRZuIgqFiK+9yZ+Q=
Date: Wed, 18 Sep 2019 21:50:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20190918195045.GB2020317@kroah.com>
References: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
 <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
 <20190917055512.GE2058532@kroah.com>
 <ab06c0c9-6224-a7b8-51c2-01226f763b98@linux.intel.com>
 <20190918120629.GD1901208@kroah.com>
 <c8f21078-1462-5463-ef12-957ebd9ba085@linux.intel.com>
 <20190918135302.GA1919118@kroah.com>
 <20190918135431.GA1919350@kroah.com>
 <e5516659-c6ab-86ad-e856-958d71fde818@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5516659-c6ab-86ad-e856-958d71fde818@linux.intel.com>
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

On Wed, Sep 18, 2019 at 10:14:51AM -0500, Pierre-Louis Bossart wrote:
> On 9/18/19 8:54 AM, Greg KH wrote:
> > On Wed, Sep 18, 2019 at 03:53:02PM +0200, Greg KH wrote:
> > > On Wed, Sep 18, 2019 at 08:48:33AM -0500, Pierre-Louis Bossart wrote:
> > > > On 9/18/19 7:06 AM, Greg KH wrote:
> > > > > On Tue, Sep 17, 2019 at 09:29:52AM -0500, Pierre-Louis Bossart wrote:
> > > > > > On 9/17/19 12:55 AM, Greg KH wrote:
> > > > > > > On Mon, Sep 16, 2019 at 04:23:41PM -0500, Pierre-Louis Bossart wrote:
> > > > > > > > +/**
> > > > > > > > + * sdw_intel_probe() - SoundWire Intel probe routine
> > > > > > > > + * @parent_handle: ACPI parent handle
> > > > > > > > + * @res: resource data
> > > > > > > > + *
> > > > > > > > + * This creates SoundWire Master and Slave devices below the controller.
> > > > > > > > + * All the information necessary is stored in the context, and the res
> > > > > > > > + * argument pointer can be freed after this step.
> > > > > > > > + */
> > > > > > > > +struct sdw_intel_ctx
> > > > > > > > +*sdw_intel_probe(struct sdw_intel_res *res)
> > > > > > > > +{
> > > > > > > > +	return sdw_intel_probe_controller(res);
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL(sdw_intel_probe);
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * sdw_intel_startup() - SoundWire Intel startup
> > > > > > > > + * @ctx: SoundWire context allocated in the probe
> > > > > > > > + *
> > > > > > > > + */
> > > > > > > > +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> > > > > > > > +{
> > > > > > > > +	return sdw_intel_startup_controller(ctx);
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL(sdw_intel_startup);
> > > > > > > 
> > > > > > > Why are you exporting these functions if no one calls them?
> > > > > > 
> > > > > > They are used in the next series, see '[RFC PATCH 04/12] ASoC: SOF: Intel:
> > > > > > add SoundWire configuration interface'
> > > > > 
> > > > > That wasn't obvious :)
> > > > > 
> > > > > Also, why not EXPORT_SYMBOL_GPL()?  :)
> > > > 
> > > > Since the beginning of this SoundWire work, the intent what that the code
> > > > could be reused in non-GPL open-source circles, hence the dual license and
> > > > EXPORT_SYMBOL.
> > > 
> > > Hah, you _have_ talked to your lawyers about this, right?
> > > 
> > > You have a chance to do something like this for header files, for .c
> > > files, good luck.  That's going to be a hard road to go down.  Many have
> > > tried in the past, all but 1 have failed.
> > 
> > Also note, the last I checked, the _default_ license for Linux kernel
> > code from Intel was GPLv2.  If you got an exception for this, please
> > work with your legal council on how to do this "properly" as that was
> > part of getting that exception, right?
> > 
> > If you didn't get the exception, um, you have some people to go talk to,
> > and how come I am the one asking you about this?  :(
> 
> All the legal due-diligence was done when SoundWire was initially
> contributed in 2018. You asked that question at the time and I will point
> you to the email exchange Alan Cox and you had on this topic [1].
> 
> [1] https://patchwork.kernel.org/patch/10015813/

Yes, that is fine, what I am saying here is that you are now asking the
community to do this for you.  You said in this thread:

> For this series I added a disclaimer in the cover letter that those
> parts need to be reviewed further to make sure there are no conflicts
> with GPL.

Why are you sending code out that you think might have conflicts before
your lawyers have reviewed it?  That's just screaming for problems in
the future (hint, you distributed something in the previous emails...)

Again, go and get this sorted out before dumping that kind of work on
the community as this is something that you are having to deal with
(i.e. it is self-inflicted).  Don't make others do this for you here in
public.

Otherwise I will probably just purposefully tell you the wrong thing,
and then watch what kind of fun your lawyers will have :)

thanks,

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
