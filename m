Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E236AC4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:16:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47CE207DE
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pLaDjb0t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU7lAFmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CE207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32DF21844;
	Thu,  1 Oct 2020 14:15:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32DF21844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601554600;
	bh=A3zAqcFob3BK/9azkBGlVgYS2yBoCE+79WKQTQN5ACk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pLaDjb0tYo0X7Ip+tS5rO2bVQgWQg+SGyOw0nA0kWCHily/qoWoidzU8SOqLuv/eh
	 e7cID03U4aTKyEM5d+QbV/tesT2+bXpcoAWnGi+Mc9I09++uNE7Rm1KjgCZk3/Vfih
	 KR8D+pdFH827LQk2VpYItdy+WA+KuGXhTUtKSubg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EA64F8020C;
	Thu,  1 Oct 2020 14:15:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 610BCF8022B; Thu,  1 Oct 2020 14:15:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A976AF801D8
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 14:15:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A976AF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MU7lAFmb"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B9D9207DE;
 Thu,  1 Oct 2020 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601554539;
 bh=A3zAqcFob3BK/9azkBGlVgYS2yBoCE+79WKQTQN5ACk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MU7lAFmbE6cFND2ABsxPRj2GAHMSdqdCc3oqsWR39ZJyJ0k2HBRnyapgQdR3wlT2G
 kIwuZRErM5q6bU62jFAZUeC6V7MxzPxtggA3yN9CpHFdEI8LZENjQl5kQlBwK2Nv3d
 miYjCi723C1I2FQFSTRI0WAKU70bo5hr6/nEw7gw=
Date: Thu, 1 Oct 2020 14:15:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/6] Add ancillary bus support
Message-ID: <20201001121541.GB2375307@kroah.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20200930225051.889607-2-david.m.ertman@intel.com>
 <20201001110120.GB1939744@kroah.com>
 <20201001114608.GX816047@nvidia.com>
 <20201001115402.GA2372306@kroah.com>
 <20201001120212.GZ816047@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001120212.GZ816047@nvidia.com>
Cc: alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 tiwai@suse.de, ranjani.sridharan@intel.com,
 pierre-louis.bossart@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org, parav@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Parav Pandit <parav@mellanox.com>
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

On Thu, Oct 01, 2020 at 09:02:12AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 01, 2020 at 01:54:02PM +0200, Greg KH wrote:
> > On Thu, Oct 01, 2020 at 08:46:08AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 01, 2020 at 01:01:20PM +0200, Greg KH wrote:
> > > > On Wed, Sep 30, 2020 at 03:50:46PM -0700, Dave Ertman wrote:
> > > > > +int ancillary_device_initialize(struct ancillary_device *ancildev)
> > > > > +{
> > > > > +	struct device *dev = &ancildev->dev;
> > > > > +
> > > > > +	dev->bus = &ancillary_bus_type;
> > > > > +
> > > > > +	if (WARN_ON(!dev->parent) || WARN_ON(!ancildev->name) ||
> > > > > +	    WARN_ON(!(dev->type && dev->type->release) && !dev->release))
> > > > > +		return -EINVAL;
> > > > 
> > > > You have a lot of WARN_ON() calls in this patch.  That blows up anyone
> > > > who runs with panic-on-warn, right?
> > > 
> > > AFAIK this is the standard pattern to code a "can't happen"
> > > assertion. Linus has been clear not to use BUG_ON, but to try and
> > > recover. The WARN_ON directly points to the faulty driver so it can be
> > > fixed. 
> > 
> > Printing an error and returning an error value also does the same exact
> > thing, the developer will not have a working system.
> > 
> > Please don't abuse WARN_ON() for things that should just be normal error
> > checking logic of api calls.
> 
> This is not normal error checking, it is precondition
> assertion. Something has gone badly wrong if it ever triggers.
> 
> If you don't want to use WARN_ON for assertions then when should it be
> used?
> 
> pr_err is not the same thing, it doesn't trigger reports from fuzzers.

fuzzers shouldn't be messing with device registration functions :)

just do a normal pr_err() and all is fine, again, this is like any other
in-kernel api that is trying to check for valid values being passed to
it.

thanks,

grteg k-h
