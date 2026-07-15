Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B078C4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:40:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 967B760236;
	Sat, 18 Jul 2026 11:40:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 967B760236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367625;
	bh=eKlGkqhmpFf2wi23f6LPaCp/Iog7NyhC8v93y/zOVhI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nusndUpIfvU2zVumQPnY2X4Pu0R1WsbVKsRNa5+d3QJ63vryCxGTYHcLxDs3aeI9/
	 uwG9zI/4LxEOBF10ChQZRdQ2zcAcX3TfUOwRl3SSJ3rsRPIJNk3iT4dw/I2B6lByuV
	 lxVnT+3Ofy4L++y6ZlqMNMPLHMlNMSlGSJuwXQLE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B75ECF805FD; Sat, 18 Jul 2026 11:39:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13B3AF805ED;
	Sat, 18 Jul 2026 11:39:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EBB1F8057F; Wed, 15 Jul 2026 10:53:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.14
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784105608;
	b=YzZOmfErmqgUhSOqD0tFQn3qeB7/2hyjtDiAW5VW6jdvQQylPIC9J3OTQeh73vVV9R9e
	 DzGB3Hz6rFctCumUh3MIN9rPPBytM2ygs94fT+e715q/+BZHHSePN+xK1bDs0Z42jZyBA
	 ZY26Ni/3rQ4BCg2MrQEA5sP9YpfUo3sSRkMNJq7ZQY5tWg6W7tDS4VOlH/uVzK+pn0V28
	 otOLlwTD0S9wpoXya3L9vR/iFJW4tpPczJ2WW1+aCH8hEFKPCjAdtwgv/B/lQ6CbIEM3G
	 ikAVfaqUSOz3LNCkglZIQsuEGg0xSREdpIwq7pRMbOKHR0OTiSy5KMRqI8/36+00C5w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784105608;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UPzpa5I5VBsfnMuMt+cxo+BV5z24GR46nSGbcwYteOY=;
	b=BU4TnPHDpJaM8hlj+ECvpi1f7FzDy3jqacFryL3V3V1RzYjI+0HchfZjxNY2hBvRlNga
	 Fyr4m59Lfcg8/aFh/WHEnO8AthX0EfknOTWyAuQbWqKhPs13O2hZExy9thIaHfUjwjKTO
	 BizGoEv5aJctAl6ONKGXL9iCNHqmM0Nhr6+OyTCVIsDW88pJecOX0N+TQpEoXp+Xqoa6j
	 LrlzfsmkINRMW468pxXDGTkhjVrf6QafIm+v1/qZNp4FapTBwmv0izhgNu3rZEhn8/rLz
	 /hfqUKT5IFCv3CbPHpUzWH1bImd+pxQRZG1lZghLYrhCA7GXMrERGZkFW6Asc+FSt2g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=keViz1y+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.14
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29D6FF800EE
	for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2026 10:53:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29D6FF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=keViz1y+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLH43NUEhT9H3hHlpxRjTShEWbafJBTcAz/ejLm3TLA2TCEsm028QrjUQFcGsQJOPAceEZZ7TunDbDmwhBtZPha5lqJKkRIdI9+ZIRHF3GBp+7I6njYh4NDyYOiUCgW5DaEpf2laqzNt4R86TRbFNNSg5htKo4MyrVlZb26r8qOdqts++BjuRRYbIyWYfDj+r1PGvouagoS3clCn/SWeeAgjPFdzNrLAmyTtbkQSWNVBIfj0eCDiYmvFDgrY2/j0rRPQr1S2dn+pq6/b8/W8ysfDdXBnbzz/oAvFgxJf4ao6iBVcprtk3dV1RcJpwwEzIAg2o5Cp77q3mtNfCgqDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPzpa5I5VBsfnMuMt+cxo+BV5z24GR46nSGbcwYteOY=;
 b=LhnllDm58WOzwxtZlAvd/bMcoIR6Zeok1K2K50OQXmB/t4+PtML9IwgsnD99ul7JP2JiAM/kfTiUsIeuO8BjAcOeqmVjqtF+nC++TGKEiinoqdTFpxcbld0jmQdS2cLRb14dxFyMgUbdyor1YM7d5FLLNK9aX3xcV/1/MpGBQPjWINOnOdLLZ0zUSQYGSH320NQLdFOoahUipaMQqxyBvt1DvbT6CTTl/9p7KMEFAm4JU15p6f8MkIob8dHGJgUJo1JIPJ43QSZ6S4eAFkd+mEibtwMMP7DfRt2oWHrK43nfSlZUlnzx7+kXXpG3fZNJr98+7c5N0lvzt1rOsBke0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPzpa5I5VBsfnMuMt+cxo+BV5z24GR46nSGbcwYteOY=;
 b=keViz1y+AYraHYzvm6/j3g3H6/PY9VyLNmvqud6gCD/sSTNehe64Z1IK1D0bLO3642DADriqwEqw8c2kK+8Ae7H4ME5OG0P4ddo5MeF+iER4S3v/YQWU1n54cxdzafMJfeGjEAGDgSFVfMjI21CphYENxC5SvuDA6rbXuJfm8gnZ/AAqboNQB2UnNNVPELLDDIwLu+o49dH2uv/Pai+ybez9c//sDcM3QOz+gkX2wxJQQrUjNnqOMV8r9WsFQ8ATkifMuOGBxnUaaoBrDcMkGQ6kbYbAiaig19phLD4vsRlEowYC7hzS3hV3PdDXG+qYw4mJhRpI4u2/5WYWLKDX9A==
Received: from DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 08:53:14 +0000
Received: from DSSPR12MB999212.namprd12.prod.outlook.com
 ([fe80::5e39:8f96:935a:87ba]) by DSSPR12MB999212.namprd12.prod.outlook.com
 ([fe80::5e39:8f96:935a:87ba%5]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 08:53:14 +0000
From: "Sheetal ." <sheetal@nvidia.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Mohan kumar <mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>, Jon
 Hunter <jonathanh@nvidia.com>
Subject: [alsa-devel] alsactl restore fails for INTEGER64 control
Thread-Topic: [alsa-devel] alsactl restore fails for INTEGER64 control
Thread-Index: AQHdFCWGWqLZ5Xxck0ODvhZKigbtew==
Date: Wed, 15 Jul 2026 08:53:14 +0000
Message-ID: 
 <DSSPR12MB999212CD0AF414E51769382046CAF82@DSSPR12MB999212.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSSPR12MB999212:EE_|IA1PR12MB6284:EE_
x-ms-office365-filtering-correlation-id: 665b56d3-4960-4f8a-3ff5-08dee24e81bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|8096899003|13003099007|38070700021|18002099003;
x-microsoft-antispam-message-info: 
 Foo2dzxeHRqLag3AOXIEbAWEFZjeGMRkDUwnHI6QGem8SI3pmETMO14OcyADF3Dnr/vkClpO55PlpSeat7VNgqRFnOCEMOyAw+s/WAe/M7fIKW8zvuPKqo1ge0Tk2hxnHu9iUHmYht3TVSm3k51sjMiZn9ibSNMDQJk1+zoHidmdnvAvQyHGW/8MJdPhMBCzYasuiiXk122gGHLDJmW0BFlhYpb6oBd8zrTHqujdzkBpzJemNPB3C2M+m/+VE5cEMubWdk/rY6Wi1ro1s2zFBGZfoHriEb/eoTuWwzQ+vOmAW7Z6BW++GOKBkqIWxZfX5cnNCD+CVPhkWSQIiCvrLUFxH2kxLbeit9SYcV65aBWN6L5bxBxIVffPTecgAKnuZq+2/feroFJ3d/YkLR308GZP09op7FpOz+7EFgW/vm82CwFIaIuSAHIlaCAbmF0TsuMHCwABT6uezqsSpczM6i3P2YzZTVIiwFBJmUdA7LUGwaJFxRWaIBH6vjgkb+txHZVyAsa62WU3by2ICHx3cxmwN7/ir2WN2eQwAjXSbM123ryPsSgXVzHi+qsPIE2p8l2RZOCpq6RjK1E24C3DJG1Vg7ZhGgzH11akSFnaKtSY53/by2fkRp9sAULNz5GisLa+j6HSCi4jQxlnS040/ZLkMDSc+rscHa0lgl4zVKe+i5MM0cHFQYGQ15hOPNYy
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999212.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(8096899003)(13003099007)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnBnOXpmMkVPTnJJZDJZOUZpTVNsYm1mZk02Wi85ckxiWVoxbU5EaEJDTFBD?=
 =?utf-8?B?QzdRbTZlZmlZOW1mYkc3cHNsTlJJdkxIbG5lK3c4Q3VWbXFRUEg2c1Z0Z3pF?=
 =?utf-8?B?T1FHWndMeFA2SEVDRUZ0dWZLM0tRZjF0eDVRekJQR1I5bG04T3JBNmt6cE15?=
 =?utf-8?B?K2dSQmRRQUhhYXMzUm5hb3N5TFhVbUlYdXA5eFR2LzZVWjVXcmdpMzZOTXRT?=
 =?utf-8?B?d0ZTYks4eVV6K0JndW5DRUlxa2ttZ2g3N2JyNlpxbytZcHppOWVjUEJnczRM?=
 =?utf-8?B?MjhLLzNMNUtXZXJyRC9yM1lpVXZPeTZNbzc0U0dyVTJMK1Q3UC9iT05LLzNk?=
 =?utf-8?B?ZDIzM3ZVM3ArRTNSczFwb1krR0lhZEZMMG1SQmwrSFREczR4NkdBRklNcjRl?=
 =?utf-8?B?TjhTVUlpRzFGb1I0MlllRUNPWnJzODdObXp6bkpGQ2hwanVUZnd1ZHdGSURv?=
 =?utf-8?B?QVNLdjhLMDJwSmVURGlxZmVJalB5V3UrM1V4VFpvVHRLSkpySGNYNTlDbzRk?=
 =?utf-8?B?YjRyYkNXU2RBYkhzaDBqSmg0Mm1wbFBMd0YydWl4a1NYNklZcDRpZUdjcXpo?=
 =?utf-8?B?eERxeXZiQ2tiSFZQbkp2U3N6cjZWUU5VVW9ROWd2ZzBGT1RSRm9adWlNbkFr?=
 =?utf-8?B?SW9yMU5aVE5SaGJWTDdxT1lSRndOQUQxakpqUWlXUW5FRTYvQ0RuRFE2aENC?=
 =?utf-8?B?QUI1UTZUNXdKeEx5TEtmYllzOXVoa2RuRHd4QVBDU0JWMTF6WWxpTmFUNTdl?=
 =?utf-8?B?a2lwaHVZeFQ5MHA1ZE84V0FZcmpuV1kwSFU4WDhkb21DZjJPSlhpZnE4a3c0?=
 =?utf-8?B?a2ovbHhXUUxtZDdDSlA1UG9HU082NVhOUVkzdElGWkd4U2toRU9SRU10Vjd2?=
 =?utf-8?B?ODhVU09UUnAzYW56UTR2QTh3dEl1Q2VlNkx6bEl6YkFrdkdLeVA4dkgwT2Zq?=
 =?utf-8?B?d25xdTEwYUxSTnRsQ0Y0dCtxV1Z6NktteEhNT3NmU29iRGpPc0wxb2Y5bzI5?=
 =?utf-8?B?UFA1NmZHYlBzZTZzdVd1THJVT0dqV1JDTjFBYnN2MUpRczBpbEU0cFNQZ2ZN?=
 =?utf-8?B?MnRTRzNTeksvWEpjVmN6L1BwZnRrd2NvUk1wNzRzb3RTd3YrWG43UkVXbG14?=
 =?utf-8?B?ZTA2UmkyZDdHZC9OQzJTZHdIcUJCUG96MDB0L0ZkQWthdmtSZVd0ZkVMbWNm?=
 =?utf-8?B?SmRlQWJuNW9STUdsZVUyZkdkVFQzZFZjUjZ1K05ldGVjSVVnUVVrWXJqYy96?=
 =?utf-8?B?UzdDeUFzL1NpblJkU08wbmRxTFdqVjlVcHhZck5RTUZJVzd0ZXVXV0p5RGh4?=
 =?utf-8?B?VGZSaVNhUHd5K1Y1Z085ZXFXT1FXTTBBYW50OGhQT25iY0JzMFVhdHNqSC9i?=
 =?utf-8?B?UHpXQzNKaXFhbGVGSTlDMHZZQ0NhUm5aOWQzU0U5YURNL25JR3dOQXovNXZ2?=
 =?utf-8?B?UGpjN2ZsM09MOHJrSHE2MFNXdkVpRXd3TERsZUJucGdlbFF3OGRhem03VVlM?=
 =?utf-8?B?RndtNmtUMktidXgzWnU5d3ljemJHVjJRdjVNa0xJZWZxbytKUFU4d0VFQlBp?=
 =?utf-8?B?NG0rTVZMeVYyNGtncERzNVZxanZCZE8reVdMMTdicGJQMFNiVUdvcDNaT2ZN?=
 =?utf-8?B?OGVMbVM5RjU5Wkg5bjhJTDFhUVllSGlzdkhlaWM5TUdHNFpvWlJzTVpMcGl2?=
 =?utf-8?B?LzVURE90UkpVbUVHbVRXOFFscTdjQTkvRndrTGpFL1dOYzNrdS9sZllaNG1Y?=
 =?utf-8?B?eS9FMUZmNnQyeURUaEFzMllZME4zbEU2VjBMVlU0a2k2U05zTXh1UzdDK1Mz?=
 =?utf-8?B?OWdKRS9wdEdYcUY3WC95TlUyTHlVU21aTVhuRGxtdzkwQ3VVeVNSWVlsQUkv?=
 =?utf-8?B?dm5CUUlyZHN1QWJleXpmTU1ZNitwQmZBOVZoMklyRlpiQ2dVaDRUSUtTNDBo?=
 =?utf-8?B?MHB4QkxOL3l2dWFDWUhCSFFtWjJxV3VOYmp5cUViWnpwbC9TY2NQQ3FSWWR6?=
 =?utf-8?B?Q0t4MFVGYTFNZXV2QlhCZ29kRmtyNVRGQ1NtelM2MWF5NTYveUM1amdBc2E3?=
 =?utf-8?B?dkk5ZkoyRzhzbk56SVozL3dRZTVnRHUrK0dKRHlaRnkwc1ZYNUdrcnBhdDl6?=
 =?utf-8?B?SUV5YS9jWXI5K3VBaTUxVWFyRCt6aklYeEZIdFJqSVgvRzB1ZHB2Z3lQZTdH?=
 =?utf-8?B?NlNJcm8rRis5dEU4NWd0N1VnL1hnUVhGaUNadlVTUG9VYUNleldhSEZLZU43?=
 =?utf-8?B?VHJwWCtna3Z2RWhwaks1TWhqUGVLeC9DajkwZ2RBMGxNSkV2ZkdiTkNTZzdu?=
 =?utf-8?Q?UlynyVbUi1/Ua4irw2?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 DSSPR12MB999212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 665b56d3-4960-4f8a-3ff5-08dee24e81bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 08:53:14.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 i1RVXbJK1UsmLopaHcidQ2BN5yTfKarqPNwOfRq2kQ9K/8pbERLW+bNsC/ti2Oaj8fbwchRyxEcROImcDDAGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
X-MailFrom: sheetal@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FQ4DI3EGAS3AK2453VES2H74OF6P3GAM
X-Message-ID-Hash: FQ4DI3EGAS3AK2453VES2H74OF6P3GAM
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:39:41 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JVMMP5EC2DNMKYZNWFGNYVK5YSIKWGNE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgQWxzYSB0ZWFtLA0KDQpXZSBoYXZlIGEgbWl4ZXIgY29udHJvbCB3aXRoIGEgcmFuZ2Ugb2Yg
MCAuLiAweGZmZmZmZmZmIGFuZCBhcmUgY29uc2lkZXJpbmcgZXhwb3NpbmcgaXQgYXMgU05EX0NU
TF9FTEVNX1RZUEVfSU5URUdFUjY0Lg0KSG93ZXZlciwgYWxzYWN0bCByZXN0b3JlIGFwcGVhcnMg
dG8gZmFpbCB3aGVuIHRoZSBzYXZlZCB2YWx1ZSBpcyBzbWFsbCBlbm91Z2ggdG8gYmUgcGFyc2Vk
IGFzIGEgY29uZmlnIElOVEVHRVIgcmF0aGVyIHRoYW4gSU5URUdFUjY0Lg0KRXhhbXBsZSBzdGF0
ZSBzbmlwcGV0Og0KDQpjb250cm9sLk4gew0K4oCC4oCC4oCC4oCCaWZhY2UgTUlYRVINCuKAguKA
guKAguKAgm5hbWUgJ0FCQyBjb250cm9sJw0K4oCC4oCC4oCC4oCCdmFsdWUgWw0K4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCCMQ0K4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCMA0K4oCC4oCC4oCC4oCC
XQ0KfQ0KDQpUaGUgcmVzdG9yZSB0aGVuIGZhaWxzIHdpdGg6DQphbHNhY3RsOiBzZXRfY29udHJv
bDo8bGluZT46IENhbm5vdCB3cml0ZSBjb250cm9sICc8Y2FyZD46MDowOkFCQyBjb250cm9sIDE6
MCcgOiBJbnZhbGlkIGFyZ3VtZW50DQoNCkZyb20gYWxzYWN0bC9zdGF0ZS5jLCBJTlRFR0VSNjQg
cmVzdG9yZSBnb2VzIHRocm91Z2ggY29uZmlnX2ludGVnZXI2NCgpLCB3aGljaCBjYWxscyBzbmRf
Y29uZmlnX2dldF9pbnRlZ2VyNjQoKToNCmh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3Qv
YWxzYS11dGlscy9ibG9iL21hc3Rlci9hbHNhY3RsL3N0YXRlLmMNCkl0IGRvZXMgbm90IGFwcGVh
ciB0aGF0IHNuZF9jb25maWdfZ2V0X2ludGVnZXI2NCgpIGFjY2VwdHMgYSBwbGFpbiBJTlRFR0VS
IG5vZGUgZm9yIGFuIElOVEVHRVI2NCBjb250cm9sOg0KaHR0cHM6Ly9naXRodWIuY29tL2Fsc2Et
cHJvamVjdC9hbHNhLWxpYi9ibG9iL21hc3Rlci9zcmMvY29uZi5jI0wzMjAzDQoNCklmIHRoaXMg
aXMgYSBrbm93biBpc3N1ZSwgd2hhdCBpcyB0aGUgcmVjb21tZW5kZWQgd2F5IHRvIGhhbmRsZSBp
dD8NCkkgd291bGQgYXBwcmVjaWF0ZSBhbnkgZ3VpZGFuY2Ugb3IgcmVjb21tZW5kYXRpb25zIGFu
ZCBsb29rIGZvcndhcmQgdG8geW91ciByZXNwb25zZS4NCg0KUmVnYXJkcywNClNoZWV0YWwNCg==
