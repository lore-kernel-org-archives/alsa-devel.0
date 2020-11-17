Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA24C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 13:58:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6715D20829
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JqjwZfoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6715D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DE28178B;
	Tue, 17 Nov 2020 14:57:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DE28178B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605621517;
	bh=YQPb8BVz1XMNvukEIZeXeKgtYIPKuYBeTdJUvLgRUqI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JqjwZfozxQqElXTCR2zWeeWwu5FuF0D6cG2XGN+jp0x0r+XuUm7K93rS4pNoZcJGT
	 mJeQABg2lfWvWed92LwtMAP5JTEW84jY6OHig6X/8k2QLoiC1I7cJO+fHvrw9vX77j
	 jaOgLj+9zkUPBRmL3mNo47kkN0Trz1tg1M30oJCg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5D2EF800E2;
	Tue, 17 Nov 2020 14:57:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39DDAF80247; Tue, 17 Nov 2020 14:57:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDA45F800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 14:57:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDA45F800E2
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C374206F1;
 Tue, 17 Nov 2020 13:57:28 +0000 (UTC)
Date: Tue, 17 Nov 2020 15:57:24 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] Add auxiliary bus support
Message-ID: <20201117135724.GA2160964@unreal>
References: <20201113161859.1775473-1-david.m.ertman@intel.com>
 <20201113161859.1775473-2-david.m.ertman@intel.com>
 <20201117053000.GM47002@unreal>
 <20201117134808.GC5142@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117134808.GC5142@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, kuba@kernel.org, parav@mellanox.com,
 tiwai@suse.de, gregkh@linuxfoundation.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@nvidia.com,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
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

On Tue, Nov 17, 2020 at 01:48:08PM +0000, Mark Brown wrote:
> On Tue, Nov 17, 2020 at 07:30:00AM +0200, Leon Romanovsky wrote:
> > On Fri, Nov 13, 2020 at 08:18:50AM -0800, Dave Ertman wrote:
>
> > > Add support for the Auxiliary Bus, auxiliary_device and auxiliary_driver.
> > > It enables drivers to create an auxiliary_device and bind an
> > > auxiliary_driver to it.
>
> > This horse was beaten to death, can we please progress with this patch?
> > Create special topic branch or ack so I'll prepare this branch.
>
> It's been about 2 working days since the patch was last posted.

There is no code changes between v3 and v4 except docs improvements.
The v3 was posted almost 3-4 weeks ago.

Thanks
