Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A4C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 21:18:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4171C23B8C
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 21:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4171C23B8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FA7617AA;
	Fri, 18 Dec 2020 22:17:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FA7617AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608326288;
	bh=faaJzibtwA4OFlP2xNMdOtecp1dFmGGOzMYZGT0pQSE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GoaLJeu0SbSlmLYFpG/J454fhcFaZCoyK/U7jkmJIyqJsCk1RAWVAHYgw88BLT4vK
	 3af0kWWiSWZe48+utBOCtZcWi+1VSmZkyC1BzyDkyU6/ssydgAnmqBRfv15hZOj6m4
	 Jpk8mq7yI0D4GdtBR9oALQu4WQMpubgUn7LaLhlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9693EF80171;
	Fri, 18 Dec 2020 22:17:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BDD3F801F7; Fri, 18 Dec 2020 22:17:16 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B44DF80103
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 22:17:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B44DF80103
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EF20A60003;
 Fri, 18 Dec 2020 21:16:58 +0000 (UTC)
Date: Fri, 18 Dec 2020 22:16:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <20201218211658.GH3143569@piout.net>
References: <20201217211937.GA3177478@piout.net> <X9xV+8Mujo4dhfU4@kroah.com>
 <20201218131709.GA5333@sirena.org.uk>
 <20201218140854.GW552508@nvidia.com>
 <20201218155204.GC5333@sirena.org.uk>
 <20201218162817.GX552508@nvidia.com>
 <20201218180310.GD5333@sirena.org.uk>
 <20201218184150.GY552508@nvidia.com>
 <20201218203211.GE5333@sirena.org.uk>
 <20201218205856.GZ552508@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218205856.GZ552508@nvidia.com>
Cc: alsa-devel@alsa-project.org, lee.jones@linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kiran Patil <kiran.patil@intel.com>, David Miller <davem@davemloft.net>,
 linux-rdma <linux-rdma@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Martin Habets <mhabets@solarflare.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fred Oh <fred.oh@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Netdev <netdev@vger.kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Parav Pandit <parav@mellanox.com>
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

On 18/12/2020 16:58:56-0400, Jason Gunthorpe wrote:
> On Fri, Dec 18, 2020 at 08:32:11PM +0000, Mark Brown wrote:
> 
> > > So, I strongly suspect, MFD should create mfd devices on a MFD bus
> > > type.
> > 
> > Historically people did try to create custom bus types, as I have
> > pointed out before there was then pushback that these were duplicating
> > the platform bus so everything uses platform bus.
> 
> Yes, I vaugely remember..
> 
> I don't know what to say, it seems Greg doesn't share this view of
> platform devices as a universal device.
> 
> Reading between the lines, I suppose things would have been happier
> with some kind of inheritance scheme where platform device remained as
> only instantiated directly in board files, while drivers could bind to
> OF/DT/ACPI/FPGA/etc device instantiations with minimal duplication &
> boilerplate.
> 
> And maybe that is exactly what we have today with platform devices,
> though the name is now unfortunate.
> 
> > I can't tell the difference between what it's doing and what SOF is
> > doing, the code I've seen is just looking at the system it's running
> > on and registering a fixed set of client devices.  It looks slightly
> > different because it's registering a device at a time with some wrapper
> > functions involved but that's what the code actually does.
> 
> SOF's aux bus usage in general seems weird to me, but if you think
> it fits the mfd scheme of primarily describing HW to partition vs
> describing a SW API then maybe it should use mfd.
> 
> The only problem with mfd as far as SOF is concerned was Greg was not
> happy when he saw PCI stuff in the MFD subsystem.
> 

But then again, what about non-enumerable devices on the PCI device? I
feel this would exactly fit MFD. This is a collection of IPs that exist
as standalone but in this case are grouped in a single device.

Note that I then have another issue because the kernel doesn't support
irq controllers on PCI and this is exactly what my SoC has. But for now,
I can just duplicate the irqchip driver in the MFD driver.

> This whole thing started when Intel first proposed to directly create
> platform_device's in their ethernet driver and Greg had a quite strong
> NAK to that.

Let me point to drivers/net/ethernet/cadence/macb_pci.c which is a
fairly recent example. It does exactly that and I'm not sure you could
do it otherwise while still not having to duplicate most of macb_probe.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
