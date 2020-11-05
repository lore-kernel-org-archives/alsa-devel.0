Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D47EC388F2
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 08:46:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E903208B3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 08:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NyKX3fHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E903208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4504A16AF;
	Fri,  6 Nov 2020 09:45:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4504A16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604652401;
	bh=3UWKx/oAnaQSweU9EMKzWECXjNhipq2T9rR1aL+BJHE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NyKX3fHZ0zLeWFQHn/H4cgwYZn518ucS0JiGzSBmCyCHeuHCoeSMx7373LITszdeW
	 1EDEOkIzNuaiyEBrGXJaA6KyTLId7vl2mL9A2VNXUndT1BzAoFkLfyHEdkYvgNAy6m
	 zIs6VQP1zHtvCmbe7xsnfNcFkePUL5U2TKWddX+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D646F804DF;
	Fri,  6 Nov 2020 09:43:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70972F80279; Thu,  5 Nov 2020 20:30:22 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68F7DF800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 20:30:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68F7DF800EC
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EB7A20728;
 Thu,  5 Nov 2020 19:30:12 +0000 (UTC)
Date: Thu, 5 Nov 2020 21:30:09 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 01/10] Add auxiliary bus support
Message-ID: <20201105193009.GA5475@unreal>
References: <20201023003338.1285642-1-david.m.ertman@intel.com>
 <20201023003338.1285642-2-david.m.ertman@intel.com>
 <CAPcyv4i9s=CsO5VJOhPnS77K=bD0LTQ8TUAbhLd+0OmyU8YQ3g@mail.gmail.com>
 <20201105094719.GQ5429@unreal>
 <CAPcyv4hmBhkFjSA2Q_p=Ss40CLFs86N7FugJOpq=sZ-NigoSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hmBhkFjSA2Q_p=Ss40CLFs86N7FugJOpq=sZ-NigoSRw@mail.gmail.com>
X-Mailman-Approved-At: Fri, 06 Nov 2020 09:43:15 +0100
Cc: alsa-devel@alsa-project.org, Parav Pandit <parav@mellanox.com>,
 Greg KH <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.de>,
 Netdev <netdev@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, linux-rdma <linux-rdma@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Mark Brown <broonie@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>, "Saleem,
 Shiraz" <shiraz.saleem@intel.com>, David Miller <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Patil,
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

On Thu, Nov 05, 2020 at 09:12:51AM -0800, Dan Williams wrote:
> On Thu, Nov 5, 2020 at 1:47 AM Leon Romanovsky <leonro@nvidia.com> wrote:
> >
> > On Thu, Nov 05, 2020 at 01:19:09AM -0800, Dan Williams wrote:
> > > Some doc fixups, and minor code feedback. Otherwise looks good to me.
> > >
> > > On Thu, Oct 22, 2020 at 5:35 PM Dave Ertman <david.m.ertman@intel.com> wrote:
> > > >
> >
> > <...>
> >
> > > >
> > > > +config AUXILIARY_BUS
> > > > +       bool
> > >
> > > tristate? Unless you need non-exported symbols, might as well let this
> > > be a module.
> >
> > I asked it to be "bool", because bus as a module is an invitation for
> > a disaster. For example if I compile-in mlx5 which is based on this bus,
> > and won't add auxiliary_bus as a module to initramfs, the system won't boot.
>
> Something is broken if module dependencies don't arrange for
> auxiliary_bus.ko to be added to the initramfs automatically, but yes,
> it is another degree of freedom for something to go wrong if you build
> the initramfs by hand.

And this is something that I would like to avoid for now.

>
> >
> > <...>
> >
> > >
> > > Per above SPDX is v2 only, so...
> >
> > Isn't it default for the Linux kernel?
>
> SPDX eliminated the need to guess a default, and MODULE_LICENSE("GPL")
> implies the "or later" language. The only default assumption is that
> the license is GPL v2 compatible, those possibilities are myriad, but
> v2-only is the first preference.

I mean that plain GPL == GPL v2 in the kernel.

Thanks
