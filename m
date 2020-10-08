Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2BCC433E7
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:22:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C982076E
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BfirfpiI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksgfa9NU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C982076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40BAE1667;
	Thu,  8 Oct 2020 19:21:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40BAE1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602177739;
	bh=r/KkSkcvl53CX08vt3Y25ViL49a+viUGbLz4eACO1Ls=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BfirfpiIfG1d1Ri0nxfpWyWsZ+kSVn/inJnww1h7X8s+rC79bUx1D/09MWfwrCzd6
	 NxKxYBRKiZq1iSoUdFidMQLWxdxfNOUd/awskNTyTbSIaWaNK2pvAh+6WNlYO1uRfk
	 XfsuQZt/dWrNI27L6o5ZfqnlMbL4IV9ks4/KWjjY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5247F80090;
	Thu,  8 Oct 2020 19:21:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7D10F80168; Thu,  8 Oct 2020 19:21:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BD61F80090
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2020 19:21:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BD61F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ksgfa9NU"
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 87664204EF;
 Thu,  8 Oct 2020 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602177679;
 bh=r/KkSkcvl53CX08vt3Y25ViL49a+viUGbLz4eACO1Ls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ksgfa9NUqyj68Pu9HFy/hcUX3Q+81kAbQHK+Upql6RAIZo1B9Lh6zD0utgGWByKf7
 pEUIcsQWgiA//JRpMhgwWUG0C1okBG1Q2mYlY3zwAnWyi13FQEaLdwcz4r/MWO5608
 qKWQCC80yiheruenmrfSyNuaPr7k86ULkEz2Nv5Y=
Date: Thu, 8 Oct 2020 20:21:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Ertman, David M" <david.m.ertman@intel.com>
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
Message-ID: <20201008172115.GP13580@unreal>
References: <DM6PR11MB2841C531FC27DB41E078C52BDD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201007192610.GD3964015@unreal>
 <BY5PR12MB43221A308CE750FACEB0A806DC0A0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <DM6PR11MB28415A8E53B5FFC276D5A2C4DD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201008052137.GA13580@unreal>
 <CAPcyv4gz=mMTfLO4mAa34MEEXgg77o1AWrT6aguLYODAWxbQDQ@mail.gmail.com>
 <20201008070032.GG13580@unreal>
 <CAPcyv4jUbNaR6zoHdSNf1Rsq7MUp2RvdUtDGrmi5Be6hK_oybg@mail.gmail.com>
 <20201008080010.GK13580@unreal>
 <DM6PR11MB284123995577294BE3E0C36EDD0B0@DM6PR11MB2841.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB284123995577294BE3E0C36EDD0B0@DM6PR11MB2841.namprd11.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "parav@mellanox.com" <parav@mellanox.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Saleem, Shiraz" <shiraz.saleem@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "Patil,
 Kiran" <kiran.patil@intel.com>
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

On Thu, Oct 08, 2020 at 04:42:48PM +0000, Ertman, David M wrote:
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, October 8, 2020 1:00 AM
> > To: Williams, Dan J <dan.j.williams@intel.com>
> > Cc: Ertman, David M <david.m.ertman@intel.com>; Parav Pandit
> > <parav@nvidia.com>; Pierre-Louis Bossart <pierre-
> > louis.bossart@linux.intel.com>; alsa-devel@alsa-project.org;
> > parav@mellanox.com; tiwai@suse.de; netdev@vger.kernel.org;
> > ranjani.sridharan@linux.intel.com; fred.oh@linux.intel.com; linux-
> > rdma@vger.kernel.org; dledford@redhat.com; broonie@kernel.org; Jason
> > Gunthorpe <jgg@nvidia.com>; gregkh@linuxfoundation.org;
> > kuba@kernel.org; Saleem, Shiraz <shiraz.saleem@intel.com>;
> > davem@davemloft.net; Patil, Kiran <kiran.patil@intel.com>
> > Subject: Re: [PATCH v2 1/6] Add ancillary bus support
> >
> > On Thu, Oct 08, 2020 at 12:38:00AM -0700, Dan Williams wrote:
> > > On Thu, Oct 8, 2020 at 12:01 AM Leon Romanovsky <leon@kernel.org>
> > wrote:
> > > [..]
> > > > All stated above is my opinion, it can be different from yours.
> > >
> > > Yes, but we need to converge to move this forward. Jason was involved
> > > in the current organization for registration, Greg was angling for
> > > this to be core functionality. I have use cases outside of RDMA and
> > > netdev. Parav was ok with the current organization. The SOF folks
> > > already have a proposed incorporation of it. The argument I am hearing
> > > is that "this registration api seems hard for driver writers" when we
> > > have several driver writers who have already taken a look and can make
> > > it work. If you want to follow on with a simpler wrappers for your use
> > > case, great, but I do not yet see anyone concurring with your opinion
> > > that the current organization is irretrievably broken or too obscure
> > > to use.
> >
> > Can it be that I'm first one to use this bus for very large driver (>120K LOC)
> > that has 5 different ->probe() flows?
> >
> > For example, this https://lore.kernel.org/linux-
> > rdma/20201006172317.GN1874917@unreal/
> > hints to me that this bus wasn't used with anything complex as it was initially
> > intended.
> >
> > And regarding registration, I said many times that init()/add() scheme is ok,
> > the inability
> > to call to uninit() after add() failure is not ok from my point of view.
>
> So, to address your concern of not being able to call an uninit after a add failure
> I can break the unregister flow into two steps also.  An uninit and a delete to mirror
> the registration process's init and add.
>
> Would this make the registration and un-registration flow acceptable?

Yes, sure.

>
> -DaveE
>
>
>
> >
> > Thanks
