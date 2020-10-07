Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC163C4363C
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:18:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17ECC206F7
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rAi+Mx7w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MKicJRS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ECC206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 316C716AC;
	Wed,  7 Oct 2020 22:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 316C716AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602101907;
	bh=2NGOR8jTCYhUEISrrkXWN9EDPHhzNdQWjtkAAcRhmzQ=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAi+Mx7w8R1Jbi894gIxVyol4TZCsmr9Fw6BPzDXd90PDkHyChjXukflkcUBdG7Ju
	 Mk/uRVxglHeMciVq6tNY71QyNQpVCTX3ZM78OFNLXpEoKF+JhqLff5+yT2k867Vu5J
	 jhGRN6A8vZuEhu9YPOwZ2m5sqxhrj9UaLT6Pvkso=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0C4CF80127;
	Wed,  7 Oct 2020 22:17:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58F5EF80128; Wed,  7 Oct 2020 22:17:32 +0200 (CEST)
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB81DF80090
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2020 22:17:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB81DF80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="MKicJRS1"
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7e22520000>; Thu, 08 Oct 2020 04:17:22 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 20:17:17 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 7 Oct 2020 20:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4cFI6Uzp9gex/PO5YlSTExL8li5aKgzh6o9S0H0z0GoPMGSg7kQn5eGTgoE88kUz1Wuz35Av/7JR12CDdAXhxqe1t8r8WWjuTkkmFO1jqdjuoXMjs7DzWQ/8wn76qpVKHYpctxPiFfPqM16RSSNbwbt8YESGu+wfbaNsA/ljr2yu83rPlzRgZaC7lqCqreBhuVOUcj+trtprfwxyUaBD6swRK1rHPPDBbh1oCz5R5kJ4A+UPIQqDzH8zn6r53fxCgWK49Pp3Nyj9ukQcx+JXCi73wO99cHH4eqq8UFrmWOU2MPy/HZD1J43zKNhHGkDI+NhleMKJpJJpIbHmnTXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MK640GGZBHXfCR5L0OLNRbzOvQF1nc3cHwexbpmBF4=;
 b=Y2FKRFSu2VrFIlg0DlIkj3vjdVoJf6mJC3ZZvGBqwpLQpM5AJdnkVwIMTFNFEdu4PUluckVdsegv+G4SAjj09Ch9bMP3otgS19txLUEAEVjmrgCMouUn93Uw2xNlQyAKQ8/6VS0n4DyxoIrORnLmlfZMG7XIwQiE2zHBhTXe31B20sZGW7hqO6P02YMM7pM3UEYGblTrRdNKfg16X7C++6dhIUurlDAM+qIInqeaQKKd05bOZKZ4eWehUOeF7j8cURyaSxP6T+Av7E3nnW7DRW8x9fraFdfWOz7ta/b/WWV54P/z+shBkhpxAq1GZjNCB4JcsipOEicWVH+x+1qExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 7 Oct
 2020 20:17:15 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 20:17:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, "Ertman, David M"
 <david.m.ertman@intel.com>
Subject: RE: [PATCH v2 1/6] Add ancillary bus support
Thread-Topic: [PATCH v2 1/6] Add ancillary bus support
Thread-Index: AQHWm05cPW7H51WMukmCocLPE63Nf6mKKyGAgACGC4CAAB03gIABpCoAgAAWQgCAAAuCMA==
Date: Wed, 7 Oct 2020 20:17:15 +0000
Message-ID: <BY5PR12MB43221A308CE750FACEB0A806DC0A0@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
 <20201006071821.GI1874917@unreal>
 <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal>
 <DM6PR11MB2841C531FC27DB41E078C52BDD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201007192610.GD3964015@unreal>
In-Reply-To: <20201007192610.GD3964015@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.195.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32718ed-06ba-4d3a-0398-08d86afdfba2
x-ms-traffictypediagnostic: BY5PR12MB4936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49360E91CC27CBDD58FF39EEDC0A0@BY5PR12MB4936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6jrqhDx8J9ylR2aJKYuSWkkhavqNY9/pVyhOL8wDRdOMypgtc+oe4c+Ekug9RPHF8XFg42Xw/sOZHaxjugNPmj3LEzNLHzBLaLF+BLjhtMLNh7XLkaHCWIqrcqlSGT6bcbB7e7+Zwxqhx7QirEGiM1xIf4PGf/Em0IidJ+0Thd0qHzNulxnjLD7B/5ZXx0VlkFf7Ria99SW/7I7g2ZAcLyMCU9bcfpP/z86CPpAbP6Z1FWxF8hCJILdvZRqU989hVvoDlOBK77ACIo3tpHJQosIHqTgfvKpwyvvdnQknseCsxRaVG25DPM20ER/RHrHOpghxvXVJ6qthDrsew5zNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(478600001)(7416002)(55016002)(83380400001)(33656002)(186003)(2906002)(4326008)(55236004)(7696005)(6506007)(71200400001)(66446008)(66476007)(66556008)(64756008)(76116006)(9686003)(52536014)(8676002)(54906003)(66946007)(5660300002)(316002)(8936002)(110136005)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VNJJHQ97NPpD6ePpjIE9VYxBOvjXAv33PpJziJgQILMqAzRQtdfpgeV/pUrxM/SyfQfxZbIXLy9+TGZIV+ahcP6cq21iJRS6rj9pXCp9SMsBXs6mD/WGsrYJeug24BXMDxnsYW/WoQK1TLCHvdQSJenbqc93IfsDjWL9oCHdSzQ4YZILvpk/VW2G9C4fyY/+ze8hjmKvuCrQQZ9Z4a/Uqf1CHx8n5aiaozwhn/WVMtwhKvyNhEe+RShjBtf9ziUk6doZGd1avtsilxOpi4AcUYMjphBHQpIfbq+iglWacjlOtNYm4blV7kSwfbVy086DSoBjJJVARJPtJ9BpfiHpNcse3g4auln4widvUJHzuypttSrAgpmiiDJRwEqlCusI1+YbG5f9yFG+MioOiquUnTbB/rb5TdXTbXyQvP4B2c8S9UhxN6U3R47wgfNdM4M55ENclMAtSz+Z9j9iusQIC1NjqnyahAY8Ual+jCMi+GMML956/Bym7OGNWUAyP6KXmYwdYipA3mFz+xrTvD3Xynh07DQiBTAN49YdP9xqgyPCWUe+2sNQPf9w5Hcy3jXOXy02adKbBR3AHtkb3Y3RwYndtO64NrGM3y3FRFCG8XB61PB0+FPh3sOVkmSQW6MH+AQJVXh2tz+exoGz/7ikWw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32718ed-06ba-4d3a-0398-08d86afdfba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 20:17:15.1863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVIZgTRMBLlFIhoUn+NzU9TyasTxrDvnu0BBw6Wz5dfu8u2dgR1gGln0fGP7r8yMj9m/a1jIazE8TBYnZJJSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602101842; bh=9MK640GGZBHXfCR5L0OLNRbzOvQF1nc3cHwexbpmBF4=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=MKicJRS1csXMyk844FzF84C3BJk2IGIPHWsbr8DN/XXbybSS+qNMAZtyEMb7p2vga
 4YZrPvekgnqQxSqxd5KPDSt4xZzdquNTfKG7bygJOJSK0V0rVforNbim3dIe8sFjtG
 PjaJDJ+TUkbIohq/Q2wE0ERFtO6fRMlJIEGItHx6sthZn2XHqs1jZ6DfgBUW3HZyWS
 5sZ/dmLXbJBYaXeMGL/MSLiaHWMqg0oajb1FjDvqCMRWcU6uUQT/KSpQ3rZsyftAv/
 Rj5B+LWg80p101VnoSK9HzWzKLXdS3QcfZGi2FT3a2AlaA2Ze0PApHJha15/ntTqcj
 WElyUiyonjiVw==
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "parav@mellanox.com" <parav@mellanox.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Saleem, 
 Shiraz" <shiraz.saleem@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
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


> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, October 8, 2020 12:56 AM
>=20
> > > This API is partially obscures low level driver-core code and needs
> > > to provide clear and proper abstractions without need to remember
> > > about put_device. There is already _add() interface why don't you do
> > > put_device() in it?
> > >
> >
> > The pushback Pierre is referring to was during our mid-tier internal
> > review.  It was primarily a concern of Parav as I recall, so he can spe=
ak to his
> reasoning.
> >
> > What we originally had was a single API call
> > (ancillary_device_register) that started with a call to
> > device_initialize(), and every error path out of the function performed=
 a
> put_device().
> >
> > Is this the model you have in mind?
>=20
> I don't like this flow:
> ancillary_device_initialize()
> if (ancillary_ancillary_device_add()) {
>   put_device(....)
>   ancillary_device_unregister()
Calling device_unregister() is incorrect, because add() wasn't successful.
Only put_device() or a wrapper ancillary_device_put() is necessary.

>   return err;
> }
>=20
> And prefer this flow:
> ancillary_device_initialize()
> if (ancillary_device_add()) {
>   ancillary_device_unregister()
This is incorrect and a clear deviation from the current core APIs that add=
s the confusion.

>   return err;
> }
>=20
> In this way, the ancillary users won't need to do non-intuitive put_devic=
e();

Below is most simple, intuitive and matching with core APIs for name and de=
sign pattern wise.
init()
{
	err =3D ancillary_device_initialize();
	if (err)
		return ret;

	err =3D ancillary_device_add();
	if (ret)
		goto err_unwind;

	err =3D some_foo();
	if (err)
		goto err_foo;
	return 0;

err_foo:
	ancillary_device_del(adev);
err_unwind:
	ancillary_device_put(adev->dev);
	return err;
}

cleanup()
{
	ancillary_device_de(adev);
	ancillary_device_put(adev);
	/* It is common to have a one wrapper for this as ancillary_device_unregis=
ter().
	 * This will match with core device_unregister() that has precise document=
ation.
	 * but given fact that init() code need proper error unwinding, like above=
,
	 * it make sense to have two APIs, and no need to export another symbol fo=
r unregister().
	 * This pattern is very easy to audit and code.
	 */
}
