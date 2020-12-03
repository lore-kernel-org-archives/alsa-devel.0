Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9867C433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 15:07:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE1520838
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 15:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F5C41832;
	Thu,  3 Dec 2020 16:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F5C41832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607008051;
	bh=va1RiIcGrtGAwqbASYW0M6+mbOZHmFTt3mNNh9Ch5iQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y5iOIoeaI3L2coYccLBXFGUsO4cmpYeMkRvmUrZoeAq6H8U57x/BUlctUJ5NnHEc6
	 cTY2T6BCFULpK8gROD1aonk8cPVsFnQWepmaCM/ZxooWVZHuLsyccqQjmCJhnWTXRH
	 0ApNwi6fwio4JT7HKH9CiD3JEeaW34dR2cLCIgFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 921A4F80158;
	Thu,  3 Dec 2020 16:06:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E0B2F8025F; Thu,  3 Dec 2020 16:06:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE556F80158
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 16:06:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE556F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="QdVrPJNw"
Date: Thu, 3 Dec 2020 16:07:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1607007995;
 bh=va1RiIcGrtGAwqbASYW0M6+mbOZHmFTt3mNNh9Ch5iQ=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=QdVrPJNwIfDHYEwriD9hcsbD4TLQXPHf6uVHdig0bwu1AfgCqBZ6I7ABUVUSQ9x5D
 GjYr/rdjl0XI9Q7aiTiXSNQPGEJ5fcBgDAReWYV5p4YOWKpDs85c5WPCg1LWMblHp8
 pAnYnBY8MS4kKW9YncbPVUrsDJ3sme6Ura+E6jTU=
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <X8j/PgVDii3Jthzx@kroah.com>
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
> PS: Greg I know I promised some review on newcomer patches to help with
> your queue, unfortunately Intel-internal review is keeping my plate
> full. Again, I do not want other stakeholder to be waiting on me to
> resolve that backlog.

Ah, but it's not only you that should be helping out here.  Why isn't
anyone else who is wanting this patch merged willing to also help out
with patch review and bug fixes that have higher priority than adding
new features like this one?

It's not your fault by any means, but the lack of anyone else willing to
do this is quite sad :(

greg k-h
