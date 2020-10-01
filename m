Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1349BC4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:49:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A49C2087D
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MQ8YmYbN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I6TRSXIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A49C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D294D18D8;
	Thu,  1 Oct 2020 15:48:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D294D18D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601560187;
	bh=kXDvLGixX32JLPuWh6+y1kmRI0qfdQnDhjvEUDmP+SY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MQ8YmYbNXFz/LSlPnz6lFyCNVOKI0is1NOi+mnv3so4hiwil5kMnn7YCgj87/9KZl
	 MhpTnPAfKQ5mx6X0n9ek3P+/fHYF4HkdnnAJPAF6/d2CPROdiglAKiFozTRmHCh4c2
	 jJD5Pp4d0rr+/Ccz3bo/xMR0tUKfuIefX6NGdUic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 701F2F8034B;
	Thu,  1 Oct 2020 15:40:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18D37F801F5; Thu,  1 Oct 2020 14:49:22 +0200 (CEST)
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B18DF800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 14:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B18DF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="I6TRSXIr"
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f75d0410000>; Thu, 01 Oct 2020 20:49:05 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 12:49:04 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 1 Oct 2020 12:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aeh1YzPyN7M1WtoUphkOk5Xiuk8mV7nU+hVtc5KSr/eD+yR4kKb1Dx/YWMn7O3RPAXh+rp20Yqpkp4kfk4V8vA5fhkX0FkdJ9DOPGFVHiUHXgLUogZkKfhcm7uUPbeX7CLMnrLkdQIRusZMi8M5xZp2JFUC9O3TADHYqAjQR1YRcnL+GYaKE8YppY8AV2oJhUm90s8wzHiBDuTzvGkgdnbVscGbTiRh0kjiSPgHWaladITDK22akBCgjJJ1A5akrtL6CyK5dV4SDxvd8pBc6VAsk8C48emEOZ7Z1yBhLGH+Lh0BpsvU/q4zxRuZbIE1e85h9yslafS7dqwkTxfCKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2obTMouDpM+u6l3AbFIcdW8bS3h1zIbQuXIMEwnfFY=;
 b=gOYl/BpbtDATzhXzTmJbtex2fohygwGEHpye44p51RTxwQn/6RCnlZTLmQD+E23eqYGoa861OaWcJvb/n3wt6Xmt2IdUT+ZbLMxTzTIuX/B91tMGqfDKK/S7AkEN/lfCPXvYCex4fqwva/3fY2R8smevuEE9S3jcTD6Rw+xOQbVZCMHa6p47roeGZL7KeebmKnV0y+7xuYqjhrba9MHjW65WpyuuddaQrXOpdg/jk7PWs0kPRiGYo+DP5RWhLAXejb+yqNbf+AAEAUWyQj95vchuHjacBq0on5sR61+rVbi3HZXfa/nl0qP42Wi1f4ta+cgcy5kqPlRNVkunWCR/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 12:49:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 12:49:02 +0000
Date: Thu, 1 Oct 2020 09:49:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001124900.GA816047@nvidia.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <8f34ae733db0447d93736f4f3f7524f9@intel.com>
 <20201001105925.GA1939744@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001105925.GA1939744@kroah.com>
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:208:178::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Thu, 1 Oct 2020 12:49:01 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kNy16-004dzj-G6; Thu, 01 Oct 2020 09:49:00 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601556545; bh=o2obTMouDpM+u6l3AbFIcdW8bS3h1zIbQuXIMEwnfFY=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=I6TRSXIreY8dhj3zU0IEhK0b3Yaxjc4sAObHXJJQAfYlzIGEymVsGqdCkE51SOihg
 ZwKhpwHe6deDfFdwrHQ+BTnIR0/StcKR7tivGnZOXfNLBajb3sw3YcaSD3P/H42Ow3
 J67s9FGbFU+e6DS7GrNuhNij6G1dHs4KVhJuRsLFH1YE0gVTXNsoUTLpvW40NgL1uh
 vLGGnmd558ZD0PrsGkx7naobZA4hMOOPID9h/4tfGF/KF2E6SVYyDYNt6kNyt6l3A5
 slAYcXc/UD4C5ZuCADgQfZGr5YnKz6U89g9hdzqS9FGGSrQsduMd0nLrp56uyeaLlZ
 soIFT1pNbd4/A==
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

On Thu, Oct 01, 2020 at 12:59:25PM +0200, gregkh@linuxfoundation.org wrote:
> We don't add infrastructure without users.  And the normal rule of thumb
> of "if we have 3 users, then it is a semi-sane api" really applies here.

Based on recent discussions I'm expecting:
 - Intel SOF
 - New Intel RDMA driver
 - mlx5 RDMA driver conversion
 - mlx4 RDMA driver conversion
 - mlx5 subdevice feature for netdev
 - Intel IDXD vfio-mdev
 - Habana Labs Gaudi netdev driver

Will use this in the short term.

I would like, but don't expect too see, the other RDMA RoCE drivers
converted - cxgb3/4, i40iw, hns, ocrdma, and qedr. It solves an
annoying module loading problem we have.

We've seen the New Intel RDMA driver many months ago, if patch 1 is
going to stay the same we should post some of the mlx items next week.

It is hard to co-ordinate all of this already, having some general
agreement that there is nothing fundamentally objectionable about
ancillary bus will help alot.

Jason
