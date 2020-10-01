Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20721C4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:03:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767F52137B
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eKVHd3Z2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLkbCjOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767F52137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3674181F;
	Thu,  1 Oct 2020 13:02:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3674181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601550200;
	bh=WkBk8Vi40JBynoZBeUsuVJJtNDUSqaPZkhlhsut6cSs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eKVHd3Z2pjT//6PtgCLSDgc7Wi/6+gsP6aDRYKRXyL6d19SmMCHnO1giakzdTGf0p
	 BH2o7ChOi4pnLOoKrpBYdOd5EDbwbGQq+g1RQky9/7Ji7QTzpxhR+8fcbQPdrUhD5e
	 s/XZE9JqKXNyJxY/71dWIf5ubt8/tmuaz6royhh8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56E99F8020C;
	Thu,  1 Oct 2020 13:02:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C342F8022B; Thu,  1 Oct 2020 13:02:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA1F5F800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 13:02:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA1F5F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sLkbCjOC"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 256912087D;
 Thu,  1 Oct 2020 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601550144;
 bh=WkBk8Vi40JBynoZBeUsuVJJtNDUSqaPZkhlhsut6cSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sLkbCjOCPSbjJRJsp5tnpndaaHXcLxQBFFCUB1DjAqwB3vCMoAgBUT8KYifA8nmiw
 KzaaBPmg9M5z6lr7mA3J5XutSmOlndnmuvQEfCotiXxpeN/9bsDTUJzVmMSbnyBq4E
 rAV49i1ftCN3yS6b8zdv0dNwAIceWV80TchrmP2A=
Date: Thu, 1 Oct 2020 13:02:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH 1/6] Add ancillary bus support
Message-ID: <20201001110226.GC1939744@kroah.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20200930225051.889607-2-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930225051.889607-2-david.m.ertman@intel.com>
Cc: alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 tiwai@suse.de, ranjani.sridharan@intel.com,
 pierre-louis.bossart@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org, parav@nvidia.com,
 jgg@nvidia.com, Dan Williams <dan.j.williams@intel.com>,
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

On Wed, Sep 30, 2020 at 03:50:46PM -0700, Dave Ertman wrote:
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index 397e35392bff..1fd238094543 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -3,6 +3,9 @@
>  # Makefile for the bus drivers.
>  #
>  
> +#Ancillary bus driver

Nit, you need a space :)

> +obj-$(CONFIG_ANCILLARY_BUS)	+= ancillary.o

And why not put this in drivers/base/?  Why way over here in
drivers/bus?

thanks,

greg k-h
