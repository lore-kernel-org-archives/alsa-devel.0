Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D49FC41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 19:21:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D105B206B5
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 19:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h8uKi4a3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0YmRzaEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D105B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D78316D0;
	Tue,  6 Oct 2020 21:20:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D78316D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602012099;
	bh=gTi6TGQ5uGxOAlj1bghUBAh7jPkrXH4Z6wm41afuJzI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8uKi4a3XvNBG/alaXai/vazqI1ZN7QdZ5bLLj6kMMSCZ3sTwaG7WuGKjrj7pM/6t
	 F3kFhOvRJqfeL/qNlzZFLWFYhd/Y/nNGPZRNlMD/cbmgHyEqNZr7Mx0oDOOj5+7eto
	 EQAfapTdBEeVGr4r6VcRSO5xv+eJDU9FI51fpGTQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A04A2F80129;
	Tue,  6 Oct 2020 21:20:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B274FF80128; Tue,  6 Oct 2020 21:20:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED7B0F80128
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 21:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED7B0F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0YmRzaEw"
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91BE4206B5;
 Tue,  6 Oct 2020 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602012040;
 bh=gTi6TGQ5uGxOAlj1bghUBAh7jPkrXH4Z6wm41afuJzI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0YmRzaEwDk60OeBAZemGG0lHKcBt/TDRMOeymj0dVaYr1u1Pv4BPjlkrBKLhMjfDm
 vxpyhRvnLGoBIBG4iprzsUPAoCSF52TsNVJ/Oq+mZG9LkyYVv21QEMUchasaxFSvpy
 R2cjN4J2qumXijg7yszKmCXmcTbFuEdlH5xozb1Y=
Date: Tue, 6 Oct 2020 22:20:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
Message-ID: <20201006192036.GQ1874917@unreal>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
 <20201006071821.GI1874917@unreal>
 <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal>
 <BY5PR12MB43228E8DAA0B56BCF43AF3EFDC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201006172650.GO1874917@unreal>
 <3ff1445d86564ef3aae28d1d1a9a19ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff1445d86564ef3aae28d1d1a9a19ea@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "parav@mellanox.com" <parav@mellanox.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Ertman,
 David M" <david.m.ertman@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "Patil, Kiran" <kiran.patil@intel.com>
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

On Tue, Oct 06, 2020 at 05:41:00PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH v2 1/6] Add ancillary bus support
> >
> > On Tue, Oct 06, 2020 at 05:09:09PM +0000, Parav Pandit wrote:
> > >
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Tuesday, October 6, 2020 10:33 PM
> > > >
> > > > On Tue, Oct 06, 2020 at 10:18:07AM -0500, Pierre-Louis Bossart wrote:
> > > > > Thanks for the review Leon.
> > > > >
> > > > > > > Add support for the Ancillary Bus, ancillary_device and ancillary_driver.
> > > > > > > It enables drivers to create an ancillary_device and bind an
> > > > > > > ancillary_driver to it.
> > > > > >
> > > > > > I was under impression that this name is going to be changed.
> > > > >
> > > > > It's part of the opens stated in the cover letter.
> > > >
> > > > ok, so what are the variants?
> > > > system bus (sysbus), sbsystem bus (subbus), crossbus ?
> > > Since the intended use of this bus is to
> > > (a) create sub devices that represent 'functional separation' and
> > > (b) second use case for subfunctions from a pci device,
> > >
> > > I proposed below names in v1 of this patchset.
> > >
> > > (a) subdev_bus
> >
> > It sounds good, just can we avoid "_" in the name and call it subdev?
> >
>
> What is wrong with naming the bus 'ancillary bus'? I feel it's a fitting name.
> An ancillary software bus for ancillary devices carved off a parent device registered on a primary bus.

Greg summarized it very well, every internal conversation about this patch
with my colleagues (non-english speakers) starts with the question:
"What does ancillary mean?"
https://lore.kernel.org/alsa-devel/20201001071403.GC31191@kroah.com/

"For non-native english speakers this is going to be rough,
given that I as a native english speaker had to go look up
the word in a dictionary to fully understand what you are
trying to do with that name."

Thanks

>
>
>
