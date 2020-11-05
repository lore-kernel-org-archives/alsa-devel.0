Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC93EC388F7
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:11:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C105420728
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vfqlDPPt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SUx0ceXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C105420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1DB91670;
	Thu,  5 Nov 2020 22:10:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1DB91670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604610660;
	bh=6qUyDr8nVmUttFMPY95eca9Cpvw0MF3AfiKbR1WyVu0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vfqlDPPta9o5AEZ+zeYqpOqDR0ANrpLOMikOaWvZjCNLfM5vQYXELgQ5nXeldjHUL
	 zICIixbJGiXq3VEAY0W9d4khG7bjLUjhUo/pcL5W6Hl14f44L7TCpXUXs+zNX42Ezx
	 qVTaQAbsW1hNv3AEltGUeOjoD2rEBXxeDv105eig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D293F80162;
	Thu,  5 Nov 2020 22:10:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D37BF80171; Thu,  5 Nov 2020 22:10:07 +0100 (CET)
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A99D8F800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 22:10:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A99D8F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="SUx0ceXc"
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa46a220000>; Fri, 06 Nov 2020 05:09:54 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 21:09:52 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 21:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7Mm8rjmSxgUjiEKPG+2C2ztLxyMxJD8g4JqIscbI9IcVuiOymBJ9Zw2OceEa5XQcmqxs+FSZsHWqgUBBwM5NmaLj0t3siT/KUrqUrfWlj4ncLFilLUjo5ulfN3CSt/+/bcOJgIPF2PDsutbCCBDduc/WtiUCCwMx2tkYSG1QpGqFVw8NAkqZGkUMxUibgxLMJh5CwyvLZqtaRBb00fUMnOhiWCfQvwziAKDOGnhy5zGJUSQ98BWM9s8yJmuWHaD0ayVq8fc8lZa+BiR43rsjYo3jgmNoXY3hITse5wwB+nkxxIPRH6Hkoea/U5axI+YNYyxPbEHoUjwd5TsCEZVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTpSXDMNYpq/ZlPjrRPFdXrTNx19FUH06M+gwR9NKyc=;
 b=dslCMAGAOpYGxSqUDx40LVedgBfzDAWlXCqsEo4aE4mv6yMMl4yMhUaaoYI/wiuT1dCgckj6NIyVc6L/jp/GOPjrbs0fDkRx0BpT10MS9HLlDBbRHSFv8+W0F6fiDxvtxDPoN3G64CZCy9iWc/wF6USUwMazba1nc0ntippw44OPuBRkrnz2dmgbjkAoqs22UZtKIM9MEsyXNxLc+vPwu+4XDLr8VN7LFJBc4PbDX/PIIOyrtlVhUk496fg2JRWZszUrA4M7Lbog2/bbHaGxr5cK4DBkBVxULRzs+aYWOglE8xX4W5myAAipXwM6FHC22DG0vGaVz1zSWpQJRf8vnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 21:09:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 21:09:50 +0000
Date: Thu, 5 Nov 2020 17:09:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH mlx5-next v1 05/11] net/mlx5: Register mlx5 devices to
 auxiliary virtual bus
Message-ID: <20201105210948.GS2620339@nvidia.com>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-6-leon@kernel.org>
 <d10e7a08200458c1bddb72fc983a5917daebc8f1.camel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d10e7a08200458c1bddb72fc983a5917daebc8f1.camel@kernel.org>
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Thu, 5 Nov 2020 21:09:49 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kamVw-000OcU-51; Thu, 05 Nov 2020 17:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604610594; bh=UTpSXDMNYpq/ZlPjrRPFdXrTNx19FUH06M+gwR9NKyc=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=SUx0ceXcIW2zyJzHeYJoQGPTM/viv1DoGfTPcR0+or2v9digYGZK78iY9mTNpmef7
 eUtw7hgBMufh50UwcciJQ8V2m7eaCVfamyaldJ8oynQvlS2KpW3k6O42mi39+Tjz28
 EgfhLlS304zbVNNTXO4RlSkKNHCUCZLAmD9Wu7k3z8sHagGO2c0AyuUxtwgMGqg+Tv
 sDF6YnUQPt9cLhjFOB4x1uUNGN2qrHxOc9wiQzSsAI3U2RrNHywHlSUvRv12EAd5Y5
 MhrzRRKuj94zXBaNHtf1YY6rZP9GT6oOgpknv5oJu5B4Oda3hgFQlqRy9g18EgdqIH
 CNI51dBK3rr0w==
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 tiwai@suse.de, Jason Wang <jasowang@redhat.com>,
 ranjani.sridharan@linux.intel.com, Leon Romanovsky <leonro@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 Doug Ledford <dledford@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 kiran.patil@intel.com, broonie@kernel.org, Parav Pandit <parav@nvidia.com>,
 Roi Dayan <roid@nvidia.com>, dan.j.williams@intel.com,
 virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com,
 gregkh <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
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

On Thu, Nov 05, 2020 at 12:59:20PM -0800, Saeed Mahameed wrote:

> 2. you can always load a driver without its underlying device existed.
> for example, you can load a pci device driver/module and it will load
> and wait for pci devices to pop up, the subsysetem infrastructure will
> match between drivers and devices and probe them.

Yes, this works fine with this design

> struct aux_driver mlx5_vpda_aux_driver {
> 
>       .name = "vdpa",
>        /* match this driver with mlx5_core devices */
>       .id_table = {"mlx5_core"}, 
>       .ops {
>             /* called before probe on actual aux mlx5_core device */
>            .is_supported(struct aux_device); 

This means module auto loading is impossible, we can't tell to load
the module until we load the module to call the is_supported code ..

Jason
