Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFFC4361A
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 09:04:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B2D22DBF
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 09:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B2D22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7BE418B5;
	Sat,  5 Dec 2020 10:03:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7BE418B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607159044;
	bh=T5Cy5S4whTm2De325zOYyTTOScgEl0eEOxiRme4fAt4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gSvIMP/WweoqqkcKzxkxxFYK3Xyw5hV36LNc+vmGlQn0FxkdJNYZ4MvGtS4Yim+H8
	 y+BHNwwIaJDVsLOuQGqzks9xLeR1nH1uQjGslWP2BOyBslWWfS7ABMl4w7AhvwLIil
	 c8eHXYU6e/KlHOsVPn7qE7pFCBQL+GvMyfvgIfC8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E901CF8010A;
	Sat,  5 Dec 2020 10:03:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60EB2F8016D; Sat,  5 Dec 2020 10:03:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E15F6F8010A
 for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2020 10:03:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E15F6F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="ThqA6ZHs"
Date: Sat, 5 Dec 2020 10:02:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1607158981;
 bh=T5Cy5S4whTm2De325zOYyTTOScgEl0eEOxiRme4fAt4=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=ThqA6ZHs93cJhMXVhm6lP/UVNH1bEFBeiauWQWCLZDHo+ztT2v6xyko9bTObCSj9L
 tFQhFd9SHvy+zEKSTHRPdE/Di18QjTlnhPhtfMnPDV44l4I309A3OUVGmK0Qwe+Yoh
 tpPIepcKOSD37oM42KwfNC4MpJu5Kt78/VAc/x54=
From: Greg KH <gregkh@linuxfoundation.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <X8tMweitgZDaYU0a@kroah.com>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <X8ogtmrm7tOzZo+N@kroah.com> <20201204123207.GH16543@unreal>
 <X8oyqpxDQ4JV31tj@kroah.com>
 <f8371c36608084144fe6e8ca089901d330a7191f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8371c36608084144fe6e8ca089901d330a7191f.camel@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Martin Habets <mhabets@solarflare.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 lgirdwood@gmail.com, Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org,
 Shiraz Saleem <shiraz.saleem@intel.com>, jgg@nvidia.com, kuba@kernel.org,
 Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 Parav Pandit <parav@mellanox.com>
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

On Fri, Dec 04, 2020 at 09:10:34AM -0800, Ranjani Sridharan wrote:
> On Fri, 2020-12-04 at 13:59 +0100, Greg KH wrote:
> > On Fri, Dec 04, 2020 at 02:32:07PM +0200, Leon Romanovsky wrote:
> > > On Fri, Dec 04, 2020 at 12:42:46PM +0100, Greg KH wrote:
> > > > On Wed, Dec 02, 2020 at 04:54:24PM -0800, Dan Williams wrote:
> > > > > From: Dave Ertman <david.m.ertman@intel.com>
> > > > > 
> > > > > Add support for the Auxiliary Bus, auxiliary_device and
> > > > > auxiliary_driver.
> > > > > It enables drivers to create an auxiliary_device and bind an
> > > > > auxiliary_driver to it.
> > > > > 
> > > > > The bus supports probe/remove shutdown and suspend/resume
> > > > > callbacks.
> > > > > Each auxiliary_device has a unique string based id; driver
> > > > > binds to
> > > > > an auxiliary_device based on this id through the bus.
> > > > > 
> > > > > Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> > > > > Co-developed-by: Ranjani Sridharan <
> > > > > ranjani.sridharan@linux.intel.com>
> > > > > Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> > > > > Co-developed-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > > > > Signed-off-by: Ranjani Sridharan <
> > > > > ranjani.sridharan@linux.intel.com>
> > > > > Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > > > Reviewed-by: Pierre-Louis Bossart <
> > > > > pierre-louis.bossart@linux.intel.com>
> > > > > Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > > > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > > Reviewed-by: Martin Habets <mhabets@solarflare.com>
> > > > > Link: 
> > > > > https://lore.kernel.org/r/20201113161859.1775473-2-david.m.ertman@intel.com
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > > ---
> > > > > This patch is "To:" the maintainers that have a pending backlog
> > > > > of
> > > > > driver updates dependent on this facility, and "Cc:" Greg.
> > > > > Greg, I
> > > > > understand you have asked for more time to fully review this
> > > > > and apply
> > > > > it to driver-core.git, likely for v5.12, but please consider
> > > > > Acking it
> > > > > for v5.11 instead. It looks good to me and several other
> > > > > stakeholders.
> > > > > Namely, stakeholders that have pressure building up behind this
> > > > > facility
> > > > > in particular Mellanox RDMA, but also SOF, Intel Ethernet, and
> > > > > later on
> > > > > Compute Express Link.
> > > > > 
> > > > > I will take the blame for the 2 months of silence that made
> > > > > this awkward
> > > > > to take through driver-core.git, but at the same time I do not
> > > > > want to
> > > > > see that communication mistake inconvenience other parties that
> > > > > reasonably thought this was shaping up to land in v5.11.
> > > > > 
> > > > > I am willing to host this version at:
> > > > > 
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux
> > > > > tags/auxiliary-bus-for-5.11
> > > > > 
> > > > > ...for all the independent drivers to have a common commit
> > > > > baseline. It
> > > > > is not there yet pending Greg's Ack.
> > > > > 
> > > > > For example implementations incorporating this patch, see Dave
> > > > > Ertman's
> > > > > SOF series:
> > > > > 
> > > > > https://lore.kernel.org/r/20201113161859.1775473-2-david.m.ertman@intel.com
> > > > > 
> > > > > ...and Leon's mlx5 series:
> > > > > 
> > > > > http://lore.kernel.org/r/20201026111849.1035786-1-leon@kernel.org
> > > > > 
> > > > > PS: Greg I know I promised some review on newcomer patches to
> > > > > help with
> > > > > your queue, unfortunately Intel-internal review is keeping my
> > > > > plate
> > > > > full. Again, I do not want other stakeholder to be waiting on
> > > > > me to
> > > > > resolve that backlog.
> > > > 
> > > > Ok, I spent some hours today playing around with this.  I wrote
> > > > up a
> > > > small test-patch for this (how did anyone test this thing???).
> > > 
> > > We are running all verifications tests that we have over our
> > > mlx5 driver. It includes devices reloads, power failures, FW
> > > reconfiguration to emulate different devices with and without error
> > > injections and many more. Up till now, no new bugs that are not
> > > known
> > > to us were found.
> > 
> > Yes, sorry, I was implying that the authors here had to create _some_
> > code to test this with, it would have been nice to include that as
> > well
> > here.  We are collecting more and more in-kernel tests, having one
> > for
> > this code would be nice to also have so we make sure not to break any
> > functionality in the future.
> 
> Hi Greg,
> 
> Thanks for your patience with this series. The v4 version submitted by
> Dave included the SOF usage code to demonstrate the usage. We have run
> all tests for device registration, module reload, PM etc and have not
> observed any regressions in the SOF audio driver.

Yes, that works great if you have that specific hardware to test with.
If you don't, then it's kind of impossible to test this code :(

thanks,

greg k-h
