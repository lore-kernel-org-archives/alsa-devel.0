Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D0C4361A
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 15:06:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95993207AB
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95993207AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C7D017D5;
	Thu,  3 Dec 2020 16:05:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C7D017D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607007983;
	bh=/J7gpUERaDM9moTEEEztSBOYPXPY+1XBfrGQKejOuvY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kD0zUANxlNvtLQHGJjkhv1tZdZ9ytPUiyqSKzjwZ8DN4Ywc8ikdsSpQQhOL6CR2ZC
	 2nOVCAKdwA1Z5XaYhqq5dWJZtjW5/HdONb19I6/UiSdoYdSvn9cKCxtxC7o+FOfdts
	 jHo44mzctu40mkVVRrRDf3E1kItQcQ/KnYNREn8U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D4CAF8012A;
	Thu,  3 Dec 2020 16:05:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 104A8F8016D; Thu,  3 Dec 2020 16:05:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 805A8F8012A
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 16:05:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 805A8F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="HX4owR3t"
Date: Thu, 3 Dec 2020 16:06:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1607007916;
 bh=/J7gpUERaDM9moTEEEztSBOYPXPY+1XBfrGQKejOuvY=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=HX4owR3tVP+i3f7QYdDhUhab7Q8N1/aR087nZ+T3r/vCFu1loWGADTevPSNLXw54N
 V29cV6+JhrNjwNbTM0z2MLR2nibX9loLE3RFShRdD97WvmNT13YpezMkpCTdCQGxZ8
 kZZQ2ISElcTQv4wS9gTDn+FvriQ+caA/hx+g5+7w=
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <X8j+8DRrPeXBaTA7@kroah.com>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
 Martin Habets <mhabets@solarflare.com>, lgirdwood@gmail.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org, jgg@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>, kuba@kernel.org,
 netdev@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
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

On Wed, Dec 02, 2020 at 04:54:24PM -0800, Dan Williams wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Add support for the Auxiliary Bus, auxiliary_device and auxiliary_driver.
> It enables drivers to create an auxiliary_device and bind an
> auxiliary_driver to it.
> 
> The bus supports probe/remove shutdown and suspend/resume callbacks.
> Each auxiliary_device has a unique string based id; driver binds to
> an auxiliary_device based on this id through the bus.
> 
> Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> Co-developed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Martin Habets <mhabets@solarflare.com>
> Link: https://lore.kernel.org/r/20201113161859.1775473-2-david.m.ertman@intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> This patch is "To:" the maintainers that have a pending backlog of
> driver updates dependent on this facility, and "Cc:" Greg. Greg, I
> understand you have asked for more time to fully review this and apply
> it to driver-core.git, likely for v5.12, but please consider Acking it
> for v5.11 instead. It looks good to me and several other stakeholders.
> Namely, stakeholders that have pressure building up behind this facility
> in particular Mellanox RDMA, but also SOF, Intel Ethernet, and later on
> Compute Express Link.
> 
> I will take the blame for the 2 months of silence that made this awkward
> to take through driver-core.git, but at the same time I do not want to
> see that communication mistake inconvenience other parties that
> reasonably thought this was shaping up to land in v5.11.
> 
> I am willing to host this version at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux tags/auxiliary-bus-for-5.11
> 
> ...for all the independent drivers to have a common commit baseline. It
> is not there yet pending Greg's Ack.

I have been trying to carve out some time to review this.  At my initial
glance, I still have objections, so please, give me a few more days to
get this done...

thanks,

greg k-h
