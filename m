Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFBC4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 07:11:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CDD23A62
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 07:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CDD23A62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEE4C173D;
	Fri, 18 Dec 2020 08:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEE4C173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608275513;
	bh=WoCbTvI1JoQUbfKVXDl1rGZDoThbBAh8ju3cl9AbMs8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HSMo8uSjmmL8u0OcVn0Wz/H1eX8VS7RklbB2DbGSMQ7KSOZdJP+5O7oxNuvZjQbAy
	 +IqK2NORISCp0YS6JXX5kfFhhvtxtrWPatgjd63k18FJFCaQdh+IjRVl0sJnu39+mI
	 z5zwX3ZBGWbOzWuY9IVDtfDTBapqRvOSPTaAo8+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A1B5F80171;
	Fri, 18 Dec 2020 08:11:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3E01F801F7; Fri, 18 Dec 2020 08:11:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AEE2F8014B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 08:10:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AEE2F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="p0eV3itq"
Date: Fri, 18 Dec 2020 08:10:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1608275455;
 bh=WoCbTvI1JoQUbfKVXDl1rGZDoThbBAh8ju3cl9AbMs8=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=p0eV3itq7B0JE2tPEfmKLKMQdHJX+EzH3vsTS33F1/pMV7DbYhFzntdD9GS08cocT
 Zlfyb0i3i0SLP8nMIMMP6g3JPFC2W7UG8B8zCvOStI8a5Bn++07L00/bwHAPfzAsO4
 V0+UN2s971KPNO8oivHNaM/wP3eLm4rRUNvj81Lg=
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <X9xV+8Mujo4dhfU4@kroah.com>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <X8ogtmrm7tOzZo+N@kroah.com>
 <CAPcyv4iLG7V9JT34La5PYfyM9378acbLnkShx=6pOmpPK7yg3A@mail.gmail.com>
 <X8usiKhLCU3PGL9J@kroah.com> <20201217211937.GA3177478@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217211937.GA3177478@piout.net>
Cc: alsa-devel@alsa-project.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kiran Patil <kiran.patil@intel.com>, linux-rdma <linux-rdma@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, Martin Habets <mhabets@solarflare.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fred Oh <fred.oh@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, David Miller <davem@davemloft.net>,
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

On Thu, Dec 17, 2020 at 10:19:37PM +0100, Alexandre Belloni wrote:
> Hello,
> 
> On 05/12/2020 16:51:36+0100, Greg KH wrote:
> > > To me, the documentation was written, and reviewed, more from the
> > > perspective of "why not open code a custom bus instead". So I can see
> > > after the fact how that is a bit too much theory and justification and
> > > not enough practical application. Before the fact though this was a
> > > bold mechanism to propose and it was not clear that everyone was
> > > grokking the "why" and the tradeoffs.
> > 
> > Understood, I guess I read this from the "of course you should do this,
> > now how do I use it?" point of view.  Which still needs to be addressed
> > I feel.
> > 
> > > I also think it was a bit early to identify consistent design patterns
> > > across the implementations and codify those. I expect this to evolve
> > > convenience macros just like other parts of the driver-core gained
> > > over time. Now that it is in though, another pass through the
> > > documentation to pull in more examples seems warranted.
> > 
> > A real, working, example would be great to have, so that people can know
> > how to use this.  Trying to dig through the sound or IB patches to view
> > how it is being used is not a trivial thing to do, which is why
> > reviewing this took so much work.  Having a simple example test module,
> > that creates a number of devices on a bus, ideally tied into the ktest
> > framework, would be great.  I'll attach below a .c file that I used for
> > some basic local testing to verify some of this working, but it does not
> > implement a aux bus driver, which needs to be also tested.
> > 
> 
> There is something I don't get from the documentation and it is what is
> this introducing that couldn't already be done using platform drivers
> and platform devices?

Because platform drivers and devices should ONLY be for actual platform
devices.  Do NOT use that interface to fake up a non-platform device
(i.e. something that is NOT connected to a cpu through a memory-mapped
or direct-firmware interface).

Do not abuse the platform code anymore than it currently is, it's bad
enough what has been done to it over time, let's not make it any worse.

thanks,

greg k-h
