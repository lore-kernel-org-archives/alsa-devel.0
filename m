Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AC0C4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:15:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECC421481
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kPd5HQuA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GweRh6p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECC421481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63CF4183F;
	Thu,  1 Oct 2020 09:14:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63CF4183F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601536514;
	bh=kw9k1yEbN19JLf9SrNF/sv4qQxrzmg5DPi18bsJv82c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPd5HQuAwEVtsTYeC4f2VnPW+UF3XvasCiVsb0O2Ad7yK+J47B6q5RooswoDoSwl/
	 R+2zzwXvxTMojZnXv2va1QjIvE6vivuJLveWBps5rKpOuLjr1SRLgHU/cpixlFMJ7D
	 fdIDFmAlRGMjbg8fOOFUObMUYH+qrraNY8yczOg8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4BBBF801DB;
	Thu,  1 Oct 2020 09:14:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 584F2F801F5; Thu,  1 Oct 2020 09:14:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A891FF80105
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 09:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A891FF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GweRh6p7"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C284F21481;
 Thu,  1 Oct 2020 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601536446;
 bh=kw9k1yEbN19JLf9SrNF/sv4qQxrzmg5DPi18bsJv82c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GweRh6p73MlgOjEYsoN2CZoR0MSV338I7mdczXvIcKm2dSGH3pdHvxTFYrSdxGanX
 ETguQRmDrvdcmndrJOlMQ6452m2+5STcNydieYkKpj9r+cxciINpzp+35KvlNg0MiP
 FC83SoaHx/DP080CK6c/iy8+VJUFG501kEs2xnSk=
Date: Thu, 1 Oct 2020 09:14:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001071403.GC31191@kroah.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930225051.889607-1-david.m.ertman@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, ranjani.sridharan@intel.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org, parav@nvidia.com,
 jgg@nvidia.com
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

On Wed, Sep 30, 2020 at 03:50:45PM -0700, Dave Ertman wrote:
> The ancillary bus (then known as virtual bus) was originally submitted
> along with implementation code for the ice driver and irdma drive,
> causing the complication of also having dependencies in the rdma tree.
> This new submission is utilizing an ancillary bus consumer in only the
> sound driver tree to create the initial implementation and a single
> user. 

So this will not work for the ice driver and/or irdma drivers?  It would
be great to see how they work for this as well as getting those
maintainers to review and sign off on this implementation as well.
Don't ignore those developers, that's a bit "odd", don't you think?

To drop them from the review process is actually kind of rude, what
happens if this gets merged without their input?

And the name, why was it changed and what does it mean?  For non-native
english speakers this is going to be rough, given that I as a native
english speaker had to go look up the word in a dictionary to fully
understand what you are trying to do with that name.

Naming is hard, but I think this name is really hard to explain and
understand, don't you think?

thanks,

greg k-h
