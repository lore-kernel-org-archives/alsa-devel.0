Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E7C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 07:18:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C75A246BE
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 07:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rUP/cDxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C75A246BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D37ED1742;
	Tue, 17 Nov 2020 08:17:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D37ED1742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605597478;
	bh=UdxH+HtZ3JhgnzkEgHEvKvsvTwa2VMJVg+xpoNk6kBU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rUP/cDxdKc/FciNjaXdBybMba0X0TyYl1KxFHO9xS0DoAPkXvbNP+z5uov4Jme0Vp
	 UVC/O1DcOlB+VkeOINy2OMx4Dft61ZtE4eb3Bcp+48bqHebl2b6QSH8f0VeZRNdOHg
	 MDuJ16kXVGn0WMZ7C267vMfH3dhom2siA7by8Zt4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B18AF800E2;
	Tue, 17 Nov 2020 08:17:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03858F801F5; Tue, 17 Nov 2020 08:17:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 108ABF800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 08:16:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 108ABF800E2
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 668112463B;
 Tue, 17 Nov 2020 07:16:45 +0000 (UTC)
Date: Tue, 17 Nov 2020 09:16:41 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 01/10] Add auxiliary bus support
Message-ID: <20201117071641.GN47002@unreal>
References: <20201113161859.1775473-1-david.m.ertman@intel.com>
 <20201113161859.1775473-2-david.m.ertman@intel.com>
 <20201117053000.GM47002@unreal> <X7N1naYOXodPsP/I@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7N1naYOXodPsP/I@kroah.com>
Cc: alsa-devel@alsa-project.org, parav@mellanox.com, tiwai@suse.de,
 netdev@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com, broonie@kernel.org,
 jgg@nvidia.com, kuba@kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 dan.j.williams@intel.com, shiraz.saleem@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, kiran.patil@intel.com
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

On Tue, Nov 17, 2020 at 08:02:53AM +0100, Greg KH wrote:
> On Tue, Nov 17, 2020 at 07:30:00AM +0200, Leon Romanovsky wrote:
> > On Fri, Nov 13, 2020 at 08:18:50AM -0800, Dave Ertman wrote:
> > > Add support for the Auxiliary Bus, auxiliary_device and auxiliary_driver.
> > > It enables drivers to create an auxiliary_device and bind an
> > > auxiliary_driver to it.
> > >
> > > The bus supports probe/remove shutdown and suspend/resume callbacks.
> > > Each auxiliary_device has a unique string based id; driver binds to
> > > an auxiliary_device based on this id through the bus.
> > >
> > > Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> > > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > > Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> > > Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> > > Co-developed-by: Leon Romanovsky <leonro@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > ---
> >
> > Greg,
> >
> > This horse was beaten to death, can we please progress with this patch?
> > Create special topic branch or ack so I'll prepare this branch.
> >
> > We are in -rc4 now and we (Mellanox) can't hold our submissions anymore.
> > My mlx5_core probe patches [1] were too intrusive and they are ready to
> > be merged, Parav's patches got positive review as well [2] and will be
> > taken next.
> >
> > We delayed and have in our internal queues the patches for VDPA, eswitch
> > and followup for mlx5_core probe rework, but trapped due to this AUX bus
> > patch.
>
> There are no deadlines for kernel patches here, sorry.  Give me some
> time to properly review this, core kernel changes should not be rushed.

And here comes the difference between our views, from my POV it is not
core kernel change that must to be done perfectly from the beginning,
but change that will need to be improved/extended over time once more
users will come.

>
> Also, if you really want to blame someone for the delay, look at the
> patch submitters, not the reviewers, as they are the ones that took a
> very long time with this over the lifecycle of this patchset, not me.  I
> have provided many "instant" reviews of this patchset, and then months
> went by between updates from them.

I'm not blaming anyone and especially you. It is just unfair that I
found myself in the middle of this disaster while care enough to remind
about the series.

Thanks

>
> greg k-h
