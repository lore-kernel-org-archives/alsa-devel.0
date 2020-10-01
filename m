Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D6C4727F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:50:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC8B20B1F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k2qwHAqX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k7xbN/04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC8B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE70E18FD;
	Thu,  1 Oct 2020 15:49:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE70E18FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601560228;
	bh=+KpkVbM7SFAEOOOMuxos8DlGJ85sN0dILVLhbjNGGuo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k2qwHAqXf93Ut1kc459ZK74MULLvFAG8fnDsBtXf/fSxMIHX4ClK8a648U1mNCQDT
	 lM4W8qF/0TVvH+MiSFZvhzWKuR0L2FDbJ3KNUC1Vzk8O6vyJgGr+bCeFVJLF3c0MVn
	 Z3kDeM0CRouBBiJF1xw0OOLhuUWaybwQ4S95czMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B634F8034C;
	Thu,  1 Oct 2020 15:40:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8374F801D8; Thu,  1 Oct 2020 15:27:17 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6661FF801D8
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 15:27:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6661FF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="k7xbN/04"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f75d91a0005>; Thu, 01 Oct 2020 06:26:50 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 13:27:02 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 1 Oct 2020 13:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3ZXD11jtOR50KeP+TZ+3jjy9kEVSSWlV1S+7j8oAw/Z2P6mHfbQ+nGihwXkXWp/NvFkpX6eO8uc2sULeanTYwYKMsV8o74+LHkOOIZGHtFjdG1pVdiJHEdnI2z6s+rwmx+CXMCqvjZEAPOUQZmaRcmQnwUfmsbkpBdEz0Bz5KDLWjRUhcVq3kkLL8GOVXFezwrDmSTkzNooWUhqnbVe3NsreDV77WPjofVLCiNHy7wyCsSzFqQoyPDdlGHtvnOu99eJPlqP3omoOD9OnYJ9kHR+10aeQJHIqnAkreHzE7nkUTcr9g828m/HPROu8vF4bpdPu8funUv0kC2Ld7V/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rrHcm8WDSycyhvM48nzdkUFv4UhWZyNrLC3Wyr8zQE=;
 b=DmFQK6XcNyyQylDxayPHvr+Q0of7caJjCf0n9cjX+wsBW+Inbep1hsSjPHexpbhZ2jZCtEz6j8OOy+dWPGPy06nOW4C4gI95yXkWo9waMbn1FFnW+FtGJR4yM6439V85fkNKC5sGmUXo1aXkfM8I/rGj9BYxtzBQ8fTZnOWBI4QUVg9jMUZMTvhqTx10tJ4HRG3X2NqFiE7iOET1dIds/zhjlOClUgpdSqhTr1Hjh4sT9QwkGxDLLUxWB0SuCnJJRnAp25KelMwtcsWX1oO+Np1urX2QNG3eEQPyi6l8MpIDyzpxSgANjil5dyzMsSMBum66yqGPR6puTzdV/v0zKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2437.namprd12.prod.outlook.com (2603:10b6:4:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 13:27:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 13:27:00 +0000
Date: Thu, 1 Oct 2020 10:26:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001132659.GA1107577@nvidia.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <8f34ae733db0447d93736f4f3f7524f9@intel.com>
 <20201001105925.GA1939744@kroah.com> <20201001124900.GA816047@nvidia.com>
 <20201001125526.GA2378679@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001125526.GA2378679@kroah.com>
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Thu, 1 Oct 2020 13:27:00 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kNybr-004egx-4u; Thu, 01 Oct 2020 10:26:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601558810; bh=0rrHcm8WDSycyhvM48nzdkUFv4UhWZyNrLC3Wyr8zQE=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=k7xbN/04KdLO9nQ7BodYv9MwVo5ahXcgVlC/qF8wHFQ4LNmw1WZ4QeafNnxJi8Y1T
 kLLM6kvc0Qqqgxe0QHHQBSAhqGWkHt+oTtTliyrTYgXeQeFLezb3MLBjYhcLYdIxoe
 JvVzo8JYeBa9XDyqGMisMUs0RoQ679ahlC/bCvPw992nHSM67rdS1J7rro+LOnGsoU
 ku4MIAa5FkHH/QJ6fdxl4uQHeNRtqjH/3hImHY8PVv9v0sVEOQcgbU7caqUDtUoVtK
 iV3m6SpAfUr6r5KZiTp4ldg5fn5x211au+ks3Wg1QjzR4zuiBxaqOttQtSRIZsGVrK
 16HqUbNi6hmsg==
X-Mailman-Approved-At: Thu, 01 Oct 2020 15:40:08 +0200
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 "tiwai@suse.de" <tiwai@suse.de>, "Sridharan, 
 Ranjani" <ranjani.sridharan@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "parav@nvidia.com" <parav@nvidia.com>, "Ertman,
 David M" <david.m.ertman@intel.com>
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

On Thu, Oct 01, 2020 at 02:55:26PM +0200, gregkh@linuxfoundation.org wrote:
> I agree, but with just one user (in a very odd way I do have to say,
> more on that on the review of that specific patch), it's hard to judge
> if this is useful are not, right?

I agree with you completely, this SOF usage is quite weird and not
what I think is representative. I never imagined this stuff would be
used inside a single driver in a single subsystem. It was imagined for
cross-subsystem sharing.

> So, what happened to at least the Intel SOF driver usage?  That was the
> original user of this bus (before it was renamed), surely that patchset
> should be floating around somewhere in Intel, right?

The first user was irdma (the New Intel RDMA driver):

https://lore.kernel.org/linux-rdma/20200520070415.3392210-1-jeffrey.t.kirsher@intel.com/

(look at patch 1, search for virtbus)

I kicked it off when I said I was sick of RDMA RoCE drivers
re-implementing the driver core register/unregister and module
management to share a PCI device between netdev and RDMA.

This has been going on for almost two years now. I did not think it
would be so hard.

Jason
