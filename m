Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C801C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 05:07:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53DE60E8C
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 05:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E53DE60E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9411F1695;
	Wed, 20 Oct 2021 07:06:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9411F1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634706446;
	bh=Vd5y8IQeOnerOycxHOKuBDRUsUkKC5Ng47Al+YO/RTo=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qcE5qZexVtocaJuSPq00AHrxl/Ym96Uo/KXl6nH3PKtpIzaoSI3KR4spgiRQi8oqL
	 Fz/cvvK1Zb+/Xns6hSur1sIM+w5f5GOFhJmvnwfa8xh0ZOGHOCedwYQrHtiXZwDI5v
	 yhXzZySzy2t0SXW5maDFVAl2Sa7GqkgBSj8kMo34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D92C9F80224;
	Wed, 20 Oct 2021 07:06:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55515F80229; Wed, 20 Oct 2021 07:06:33 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2105.outbound.protection.outlook.com [40.107.236.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 766BCF80082
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 07:06:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 766BCF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com
 header.i=@maximintegrated.onmicrosoft.com header.b="M3iYoo1W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxXamqWljq5NI5Ux0NTUs4XQDmXjoKUJFDHznCMhdyuV8mmttpSPsGBpkTEBR0heWn+i+AQqghvBnbVcBw7eLVd2DqhiXjtWCpftKEqbGH+s34h+SAfIauZJVaPy24fz0ZZY18CFFikuKhh52+s+cYNjifwa/vl2Hcl2j3c3/sh57+3jxlUP4NLup+srW6PARCn1CUTHfvR+IKZQ3kBTcKBv1V25oUUDnk3A7diSWQPeBkQV4z1DlIDJ5GrNyaQv0/JJxpol7RjqVPUXb2NWo6SiUfQRRkMW1njas0mWlATrPqQXNo88UySjVh/DtHU0ROtGns8TrCV8TOSn7NjC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyI1v6cIl0C0Tlw0tTyndqfb31EEyOPJHni4z5fbYAM=;
 b=hWogQx+7PYVa24+iDBptkUYAkIraXJBuHtMBThAjNLNIHFwojtKjkk1FftlFLIkhsJZdsE97PSZvn4wB5+jUUHsty60GT8Dwq02IKqL0STxMhoY4YJq+B+ROAHWnfkW51NawgmlPdX+MDCJarPhCRi/NttgFRRUpSpIKoHk62DPG+1BM2OX/yBSeLl0SRBp3eCtbp3YvsZwOCOlUaX4JjbIfQUiiejBF7aiSO/+6c3+xBhgkglKm1Sxc0HibNd7SmosZSrhdUfQAXJP1cxLdivCwOd1/bHwO1rjD+c4WI5562bXsyApNTuAeoBYWN8pTHIyPsuM2C3eCAwD18tbXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyI1v6cIl0C0Tlw0tTyndqfb31EEyOPJHni4z5fbYAM=;
 b=M3iYoo1We35NLd0qXsLuzqg221pvDFezXmZk0DZ4LT+pguqodUVI7wbjs4A0wJuHXMXeOIoANFAWWlx8eL1jDGQ5KPEfmz/l6F80jmeYOKucPqB15OKLfNNIqmhRhTRBHAE45MKshcuTLo6H/9euEryphZ5IFRqITzEBas50oaY=
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 05:06:18 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 05:06:18 +0000
From: George Song <George.Song@maximintegrated.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [EXTERNAL] Re: [v3 2/2] ASoC: max98520: add max98520 audio
 amplifier driver
Thread-Topic: [EXTERNAL] Re: [v3 2/2] ASoC: max98520: add max98520 audio
 amplifier driver
Thread-Index: AQHXw/s2x3A5X1ZlPEurKpXCb3FgFavYshcAgAFD2bCAAEOuAIABHtdg
Date: Wed, 20 Oct 2021 05:06:17 +0000
Message-ID: <BYAPR11MB367197EB4E103B53DBBAC6D0F4BE9@BYAPR11MB3671.namprd11.prod.outlook.com>
References: <20211018083554.5360-1-george.song@maximintegrated.com>
 <20211018083554.5360-2-george.song@maximintegrated.com>
 <YW1quluaCzsUpET0@sirena.org.uk>
 <BYAPR11MB367106FDD5394AA4F88A42D4F4BD9@BYAPR11MB3671.namprd11.prod.outlook.com>
 <YW6zKsiWPE+xGWTy@sirena.org.uk>
In-Reply-To: <YW6zKsiWPE+xGWTy@sirena.org.uk>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=maximintegrated.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d263ffb-f48f-44e0-71fe-08d99387597e
x-ms-traffictypediagnostic: SJ0PR11MB4911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49113FB65904698CA5A5567BF4BE9@SJ0PR11MB4911.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ITkzLzBv97Cs2Trj4vsmEsJNnWTu67hDb+RagycKYaN+w5Txsb4c26R+c9NbE6b/0UN8Ejw6dShTgCdQi3nEPyo6g6t+h6pm4H9W8iiMmrTlsyrvNcXGKlRd/T3hNLzvTM6oaU8w3AOJhQL+Fg01fnd0otgmo0ofqOJ5xKTsfeFaS7igBbpScytTzKv9l0vWou1CNnHwIei+7EgYnJGqqDfGKcwYvJbx0eAqig79zkqaKNKtotXh74PsoJOidkHqzPMVWwH+xQqhj3FFdiF9Wpo3sgs8UJVmrWr7onrGici0GEqlyGnMBWvzf8h451Uin3Jv9Z9pZM97jwN5Cgr82q06FA6+zTC3IEZtU7nRnvbl1O99IYtTnGhu/TURDNydICyeDsc4Io7C3CTDEKTT4tDV6wPN3tYpDSBHOxHklCBMUSfiN7LUh86Cw50RJ+m4/itpBZxetEalJEQD7q+Lp0oYvH0Hg1Z75M1/P7rQ1qni6Q6ItvshwEdeT6G2b9/1FkVNydX4r7zjPuiUWi+GS6uhuwOP8ddrQwkFtUYXp48bbjxkIHdgJNHusXOWEif4A1DNWYgopV5uigDRBMqqMQU7zVXl5JcAgHgt3J5LSH/u/VsTtnQLvVe0RefnTAicHMCiDo3KgItte4YROBZAh7vE7b8Jw7Oy3O9LjcRybWQ35QWk32F6hrslFBLxqjpEI3ObfsRvvhx/Jjix/VDxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3671.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(9686003)(6506007)(55016002)(122000001)(7696005)(38070700005)(316002)(6916009)(508600001)(54906003)(26005)(83380400001)(5660300002)(33656002)(4326008)(4744005)(76116006)(8936002)(2906002)(186003)(107886003)(66476007)(8676002)(66446008)(86362001)(64756008)(66556008)(66946007)(71200400001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/xqK/WrXcvEzWQDlbwyoHt9aBHTjHmCHby/RhYn0i0/M6wGV8WEYVriKH9f?=
 =?us-ascii?Q?hRsS8IDekp1or1SQd3WHVv1B4wJ1pn03KgXe2bBca+asfqvO+RZZbGV4xzsz?=
 =?us-ascii?Q?qz5WpKsl03RdlLMLNawqZCkZeh/FMBnawBvu2MI4zp/+i0V741WaCRoeATsn?=
 =?us-ascii?Q?j2ognmlPkGqYboL92ITiPjwKZAkTS65FWSROMgqC4qUIrPXesilovNNJMnRm?=
 =?us-ascii?Q?XOQSPuxtBKMnNHq1MLmS8H/Z/pOCWNGHHeN1ALG1IuQ9n2YgATFfgXF7XXdR?=
 =?us-ascii?Q?dDjW+a6I7e09C5ayfa1s1BT0rQGifIP7yEJXkdeQ0rZCbQifECE9ht8C3QbE?=
 =?us-ascii?Q?GRVON0hcm99+l/cKxTLBQ0cge9j6TK4USTk2J3ZJYKN3eg1fsbI3tTu6t+zI?=
 =?us-ascii?Q?fZfJwdAXsDU69d5+FMq1tievm3KZI2UKl9t7ryvWxRJBkYw71IR+nOjFLFt7?=
 =?us-ascii?Q?bS0Hj225xk5yyNNuXMvMjJAp7io+tb8NzfxQKff6wYyWv2AQybDyFxlh7ZKG?=
 =?us-ascii?Q?5VB/Zxef3YL1wtgTKbTgHGLLaGy7FaipFGpRENQKrs/vAKjqWXpKxZGhaF0I?=
 =?us-ascii?Q?P9/16ZNEz4Sui2NNJFNx0PSZd1GkGU7WKM9cR44LTHJRAEpEJwF6Z+KuPBmq?=
 =?us-ascii?Q?TvVLb5XfILRKFY6cG6t/FO1wXn5OjLRmRI4GfX3bgmQl15xsqqVh+MYSh7oz?=
 =?us-ascii?Q?ZftSW57S9vBcv4QvoJmvGicvK7DnXNdTgdWmix6kmwuI82TMMlkC8tUHQZF8?=
 =?us-ascii?Q?RCYtSgnSGzpt9zEWJMXbwJ4nYvFUgetwz0U8mWCrUyBnZyrj/CmlWus8+j95?=
 =?us-ascii?Q?dVEI64ce2bjEZDDqPkjNhm7e7ZZQ92zq2bhSx4rRidUJLQixWRI+1o4dNzpd?=
 =?us-ascii?Q?WC+/lYhBRkcAEc7vLIiw6NJshmBGxjYO7h7jJoONm+L4BWy0u9t6gt2QJ2EK?=
 =?us-ascii?Q?hXF1ZFwf77qEaRFvU9FGH2kyYiFo/jgtGAGgEm9ArfsacSdBdibxqS3EJ7WI?=
 =?us-ascii?Q?nlVeciYA5vurw8LlqYb3RuBmXLBzNvXiIZfeVn6aFolMiGpmaZfrp7F4S0jL?=
 =?us-ascii?Q?l9GWGiG9ZLpI3N98ifwYuZu9RXaZvBM2C55uZTClscFXIxceqAwVdkx403wO?=
 =?us-ascii?Q?L45HVt4yDv/BClfqTR1olUE2DDUEtdbx95OUmdoaYGknezfTPG/wd8l+qYqu?=
 =?us-ascii?Q?s50F4JvfKgklS3cEPVy4urTKR4SL2rt2Ubm4US+QtcjRRzKb5gpUdtwEV2yD?=
 =?us-ascii?Q?zKbBSknaTg7XT1Jk8xm7pHpGI3klqrIQhNQal23MoHI6BoYpgLGzT++UuE3K?=
 =?us-ascii?Q?9r7zawrnMNQZJ20dEXF/oLAn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d263ffb-f48f-44e0-71fe-08d99387597e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 05:06:17.9943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9RkHXvFcvuElbbckbQ079Fmby2ZaVtVBWilmr4gn3luwSckaLeJM2WXgHyANCWODhmPqIY9bFbgkWn7TsHKtJ/BeNNsPJQkKFZJMHpmlwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Steve Lee <SteveS.Lee@maximintegrated.com>,
 Ryan Lee <RyanS.Lee@maximintegrated.com>,
 "george.song@analog.com" <george.song@analog.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>
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

> On Tue, Oct 19, 2021 at 07:57:26AM +0000, George Song wrote:
>=20
> > > > +	/* L/R mix configuration */
> > > > +	regmap_write(max98520->regmap,
> MAX98520_R2043_PCM_RX_SRC1, 0x2);
> > > > +
> > > > +	regmap_write(max98520->regmap,
> MAX98520_R2044_PCM_RX_SRC2,
> > > > +0x10);
> > >
> > > These should be exposed to the user, not hard coded - different
> > > systems may need different configurations.
> > It`s already exposed for 2043 register which is regarding mono
> mixer for "DAI Sel Mux"
> > It will be exposed for 2044 register which is regarding pcm input
> channel selection to dapm mixer.
>=20
> Then leave the values at the defaults and let the user select what's
> sensible for their system.
It will be left the default value in probe function and=20
described mixer/widget comment
>=20
> Please fix your mail client to word wrap within paragraphs at
> something substantially less than 80 columns.  Doing this makes your
> messages much easier to read and reply to.
OK I see.
