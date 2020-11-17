Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E85C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 05:31:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7340B20888
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 05:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ie3qEo7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7340B20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 183DB174E;
	Tue, 17 Nov 2020 06:30:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 183DB174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605591082;
	bh=weviRFlwQDW0hFKgVUAUlO774tcmW2E1+Umn8QGxTJY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ie3qEo7YtYNAK3FWGGw9aP5pWIJ3RqYX6q4rpDplqomXp57pZt+JuK4vSzDh0op2h
	 Lwqz7KkiqHtquOeVH9vaMbI75Q2UXZsx2C4xxNi4w6igsA5skCSNeLYrJQLZpZINbx
	 8CMptkBRUMtAFRgrxUFldpMb65+XFXwWmr5tGMiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71FE5F800E2;
	Tue, 17 Nov 2020 06:30:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB99CF801F5; Tue, 17 Nov 2020 06:30:18 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63603F800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 06:30:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63603F800E2
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A3B9246AE;
 Tue, 17 Nov 2020 05:30:04 +0000 (UTC)
Date: Tue, 17 Nov 2020 07:30:00 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Dave Ertman <david.m.ertman@intel.com>, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 01/10] Add auxiliary bus support
Message-ID: <20201117053000.GM47002@unreal>
References: <20201113161859.1775473-1-david.m.ertman@intel.com>
 <20201113161859.1775473-2-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113161859.1775473-2-david.m.ertman@intel.com>
Cc: alsa-devel@alsa-project.org, parav@mellanox.com, tiwai@suse.de,
 netdev@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com, broonie@kernel.org,
 jgg@nvidia.com, kuba@kernel.org, dan.j.williams@intel.com,
 shiraz.saleem@intel.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 kiran.patil@intel.com
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

On Fri, Nov 13, 2020 at 08:18:50AM -0800, Dave Ertman wrote:
> Add support for the Auxiliary Bus, auxiliary_device and auxiliary_driver.
> It enables drivers to create an auxiliary_device and bind an
> auxiliary_driver to it.
>
> The bus supports probe/remove shutdown and suspend/resume callbacks.
> Each auxiliary_device has a unique string based id; driver binds to
> an auxiliary_device based on this id through the bus.
>
> Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> Co-developed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---

Greg,

This horse was beaten to death, can we please progress with this patch?
Create special topic branch or ack so I'll prepare this branch.

We are in -rc4 now and we (Mellanox) can't hold our submissions anymore.
My mlx5_core probe patches [1] were too intrusive and they are ready to
be merged, Parav's patches got positive review as well [2] and will be
taken next.

We delayed and have in our internal queues the patches for VDPA, eswitch
and followup for mlx5_core probe rework, but trapped due to this AUX bus
patch.

Thanks

[1] https://lore.kernel.org/linux-rdma/20201101201542.2027568-1-leon@kernel.org/
[2] https://lore.kernel.org/linux-rdma/BY5PR12MB43229F23C101AFBCD2971534DCE20@BY5PR12MB4322.namprd12.prod.outlook.com/T/#md25b9a2feb4c60d3fef5d57da41db559af1062d8
