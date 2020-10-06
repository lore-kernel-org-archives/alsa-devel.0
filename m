Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D63C41604
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C34216C4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fA/8JkR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C34216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8506916DD;
	Wed,  7 Oct 2020 17:57:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8506916DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602086296;
	bh=UGL43ykh1L81M3D/E7y0iUA/pZf9MxxBEMGtWHfxQHk=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fA/8JkR7gouMJja1A/jjhVVk8yCmH3C2MxfdqEPEis9yHQ1DdEPUG31QTvgXBU79Y
	 pWTs94SaAHGUYe0UZSdrUZrEWuwYSAuULXK056lQ6F0YPIMo/zIGWyll69vcrYvAed
	 8k3zbsVcsrBQjZ7p4EKHwwUsUx6n9NsL6nHiNAWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D814F8027B;
	Wed,  7 Oct 2020 17:54:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E68CF8012A; Tue,  6 Oct 2020 19:41:22 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BADCF80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 19:41:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BADCF80127
IronPort-SDR: wBc0vC0dp4tjCeXOVYXhfzvbri1g4r4geewYi6Z91PmGhemoCp0zKay+iG+mdTc1MGglM4I3kz
 7Q+VPKZgkdOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="182054271"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="182054271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 10:41:06 -0700
IronPort-SDR: FWN0gfMLLMz51mLTKEALP7ftdCXctRtuya3sTcK/sMbwxMslvkRoiJls0MMwb4ao5HliGzGh8F
 siSaW4uhguKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="354478830"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP; 06 Oct 2020 10:41:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 10:41:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 10:41:00 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 6 Oct 2020 10:41:00 -0700
From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
To: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2 1/6] Add ancillary bus support
Thread-Topic: [PATCH v2 1/6] Add ancillary bus support
Thread-Index: AQHWm0x+bCEx5k0iU0+RSRzmm941iKmKoH2AgACGDICAAB03gIAAAc6AgAAE8QD//4wBYA==
Date: Tue, 6 Oct 2020 17:41:00 +0000
Message-ID: <3ff1445d86564ef3aae28d1d1a9a19ea@intel.com>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
 <20201006071821.GI1874917@unreal>
 <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal>
 <BY5PR12MB43228E8DAA0B56BCF43AF3EFDC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201006172650.GO1874917@unreal>
In-Reply-To: <20201006172650.GO1874917@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 07 Oct 2020 17:54:46 +0200
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "parav@mellanox.com" <parav@mellanox.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Ertman, 
 David M" <david.m.ertman@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "Patil, Kiran" <kiran.patil@intel.com>
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

> Subject: Re: [PATCH v2 1/6] Add ancillary bus support
>=20
> On Tue, Oct 06, 2020 at 05:09:09PM +0000, Parav Pandit wrote:
> >
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, October 6, 2020 10:33 PM
> > >
> > > On Tue, Oct 06, 2020 at 10:18:07AM -0500, Pierre-Louis Bossart wrote:
> > > > Thanks for the review Leon.
> > > >
> > > > > > Add support for the Ancillary Bus, ancillary_device and ancilla=
ry_driver.
> > > > > > It enables drivers to create an ancillary_device and bind an
> > > > > > ancillary_driver to it.
> > > > >
> > > > > I was under impression that this name is going to be changed.
> > > >
> > > > It's part of the opens stated in the cover letter.
> > >
> > > ok, so what are the variants?
> > > system bus (sysbus), sbsystem bus (subbus), crossbus ?
> > Since the intended use of this bus is to
> > (a) create sub devices that represent 'functional separation' and
> > (b) second use case for subfunctions from a pci device,
> >
> > I proposed below names in v1 of this patchset.
> >
> > (a) subdev_bus
>=20
> It sounds good, just can we avoid "_" in the name and call it subdev?
>=20

What is wrong with naming the bus 'ancillary bus'? I feel it's a fitting na=
me.
An ancillary software bus for ancillary devices carved off a parent device =
registered on a primary bus.



