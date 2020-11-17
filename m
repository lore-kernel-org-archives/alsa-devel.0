Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F20C56202
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 16:10:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F82824655
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qKcCFrq1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6mnx5J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F82824655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC4F01734;
	Tue, 17 Nov 2020 17:09:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC4F01734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605629425;
	bh=g4vB3mdu+chdNCAjY+sz6l9E1Ab2sYs0J3DRDQUTmw8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qKcCFrq1zBbWpiXVWaZaBk61HT9mV3doUHWoBhQTxBEhcDhi6SdWAkAmAoV/TErXo
	 aQCtqa6vORK9mFYoEGuBTl6k7u/mH+rwejhSAH4IjytJ5kfvVtwWok0XHztXVMjB/k
	 NEt4NGy+dzcKEletfvwtOGvOdvdi+4RRdLSvDCJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DE75F801ED;
	Tue, 17 Nov 2020 17:09:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D04B7F801ED; Tue, 17 Nov 2020 17:09:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8C0FF8010A
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 17:08:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8C0FF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N6mnx5J1"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4726924655;
 Tue, 17 Nov 2020 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605629324;
 bh=g4vB3mdu+chdNCAjY+sz6l9E1Ab2sYs0J3DRDQUTmw8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N6mnx5J1ajFlk7nf3GPVAtAaEeGioyhfHPcOpXrf0e/MQ3hIKdhv4Yv/4fPKKT0uV
 Ch3fWm6duvtgpVxRBepEVXCzH79fbvDkQidB7nXk/L5+S6QW5ryytTFy0s1Sgk+kOL
 MV8BJOxmCISOyFxQGhTTS08EQ/hyYbRFeL+XRLds=
Date: Tue, 17 Nov 2020 16:48:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v4 01/10] Add auxiliary bus support
Message-ID: <X7Pw3GQr80BAE1L1@kroah.com>
References: <20201113161859.1775473-1-david.m.ertman@intel.com>
 <20201113161859.1775473-2-david.m.ertman@intel.com>
 <20201117053000.GM47002@unreal>
 <20201117134808.GC5142@sirena.org.uk>
 <20201117135724.GA2160964@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117135724.GA2160964@unreal>
Cc: alsa-devel@alsa-project.org, parav@mellanox.com, tiwai@suse.de,
 netdev@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com,
 Mark Brown <broonie@kernel.org>, jgg@nvidia.com, kuba@kernel.org,
 Dave Ertman <david.m.ertman@intel.com>, dan.j.williams@intel.com,
 shiraz.saleem@intel.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 kiran.patil@intel.com
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

On Tue, Nov 17, 2020 at 03:57:24PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 17, 2020 at 01:48:08PM +0000, Mark Brown wrote:
> > On Tue, Nov 17, 2020 at 07:30:00AM +0200, Leon Romanovsky wrote:
> > > On Fri, Nov 13, 2020 at 08:18:50AM -0800, Dave Ertman wrote:
> >
> > > > Add support for the Auxiliary Bus, auxiliary_device and auxiliary_driver.
> > > > It enables drivers to create an auxiliary_device and bind an
> > > > auxiliary_driver to it.
> >
> > > This horse was beaten to death, can we please progress with this patch?
> > > Create special topic branch or ack so I'll prepare this branch.
> >
> > It's been about 2 working days since the patch was last posted.
> 
> There is no code changes between v3 and v4 except docs improvements.
> The v3 was posted almost 3-4 weeks ago.

But everything else that came in since then needs to be reviewed first,
right?  It's a fifo queue, no jumping the line.  And, to be frank, if
people complain, that's a sure way for it to get dumped to the end of
the line, as you know.

thanks,

greg k-h
