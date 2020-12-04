Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9534C4361A
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 18:06:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA28822BEF
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 18:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA28822BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ED7618A1;
	Fri,  4 Dec 2020 19:05:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ED7618A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607105194;
	bh=bnFWgHMXB2yfUR+2+mZHR9g6UlF1+bOHUfd2767Urko=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vn8bfZxIZMZSFAjV1MEaLwlhA+92jHXbmcQEXohLaGnk2knYKNpc7LRHEETbaZKx7
	 n63bMM44J384F2G+JjpnYiwoXqNW9SQa2QDpcTXC8xuv9is7JaO9rkb4Pc2w1lDZsb
	 VKhOcyX++PWT8zC7SCZWZrH0qNeA8bMTusmd8NUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82A69F800E8;
	Fri,  4 Dec 2020 19:05:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B25BF80278; Fri,  4 Dec 2020 19:05:41 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2198F8012A
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 19:05:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2198F8012A
IronPort-SDR: Ju6XrPmBkmumQm8+Ql3b7HdX3SrrFFXfN1tR0G4s67aToj0g1NS3rMf9WB6DZ+ppM0ycCXtkvo
 eeOydHvEEgfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="173570733"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; d="scan'208";a="173570733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2020 10:05:26 -0800
IronPort-SDR: dB024BUUc2ReToxwwk3+yKJCSCqnipy75nu4pzMRAIE5pt6J+sn7ZQBbU7PN+58EiiSEtvtyS2
 1zERCTqPYUXQ==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; d="scan'208";a="482476089"
Received: from mwalsh7-mobl1.amr.corp.intel.com ([10.212.248.252])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2020 10:05:25 -0800
Message-ID: <2b6a928aadc8c49070aa184e6f41cf2377a22721.camel@linux.intel.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, broonie@kernel.org
Date: Fri, 04 Dec 2020 10:05:24 -0800
In-Reply-To: <X8os+X515fxeqefg@kroah.com>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <X8os+X515fxeqefg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
 Martin Habets <mhabets@solarflare.com>, lgirdwood@gmail.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, netdev@vger.kernel.org, jgg@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>, kuba@kernel.org,
 Leon Romanovsky <leonro@nvidia.com>, davem@davemloft.net,
 linux-kernel@vger.kernel.org, Parav Pandit <parav@mellanox.com>
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

On Fri, 2020-12-04 at 13:35 +0100, Greg KH wrote:
> On Wed, Dec 02, 2020 at 04:54:24PM -0800, Dan Williams wrote:
> > From: Dave Ertman <david.m.ertman@intel.com>
> > 
> > Add support for the Auxiliary Bus, auxiliary_device and
> > auxiliary_driver.
> > It enables drivers to create an auxiliary_device and bind an
> > auxiliary_driver to it.
> > 
> > The bus supports probe/remove shutdown and suspend/resume
> > callbacks.
> > Each auxiliary_device has a unique string based id; driver binds to
> > an auxiliary_device based on this id through the bus.
> > 
> > Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> > Co-developed-by: Ranjani Sridharan <
> > ranjani.sridharan@linux.intel.com>
> > Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> > Co-developed-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> > >
> > Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > Reviewed-by: Pierre-Louis Bossart <
> > pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Martin Habets <mhabets@solarflare.com>
> > Link: 
> > https://lore.kernel.org/r/20201113161859.1775473-2-david.m.ertman@intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > This patch is "To:" the maintainers that have a pending backlog of
> > driver updates dependent on this facility, and "Cc:" Greg. Greg, I
> > understand you have asked for more time to fully review this and
> > apply
> > it to driver-core.git, likely for v5.12, but please consider Acking
> > it
> > for v5.11 instead. It looks good to me and several other
> > stakeholders.
> > Namely, stakeholders that have pressure building up behind this
> > facility
> > in particular Mellanox RDMA, but also SOF, Intel Ethernet, and
> > later on
> > Compute Express Link.
> > 
> > I will take the blame for the 2 months of silence that made this
> > awkward
> > to take through driver-core.git, but at the same time I do not want
> > to
> > see that communication mistake inconvenience other parties that
> > reasonably thought this was shaping up to land in v5.11.
> > 
> > I am willing to host this version at:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux
> > tags/auxiliary-bus-for-5.11
> > 
> > ...for all the independent drivers to have a common commit
> > baseline. It
> > is not there yet pending Greg's Ack.
> 
> Here is now a signed tag for everyone else to pull from and build on
> top
> of, for 5.11-rc1, that includes this patch, and the 3 others I sent
> in
> this series.
> 
> Please let me know if anyone has any problems with this tag.  I'll
> keep
> it around until 5.11-rc1 is released, after which it doesn't make any
> sense to be there.
> thanks,
> 
> greg k-h

Hi Mark,

Could I request you to please pull from this tag and will we re-submit
the SOF changes soon after.

Thanks,
Ranjani

