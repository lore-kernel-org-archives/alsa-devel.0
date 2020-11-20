Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0AC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 15:41:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E773C22269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uNvuvrHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E773C22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B10116EC;
	Fri, 20 Nov 2020 16:40:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B10116EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605886886;
	bh=LuA7zB7wbxVwRHmQ7PMH5fKJUjyrCK0nq4A0yJ40T5A=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uNvuvrHHfpuSUrn7ZDR4yPCS1ID45LIxsO6zqP4rHKpocewBMGyoPjpSkx5OMXJx/
	 vD6MWFFfod+vre7E1RxRKM8eBUwR8nyHD2eEGdrj65yNAM+9KAqaloaj2CCDiYatnk
	 83fu3YSGJ+G9hoVFVJre12fFnEe0qmsQmSgqqi8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B60A0F80168;
	Fri, 20 Nov 2020 16:40:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19BF1F8016C; Fri, 20 Nov 2020 16:40:34 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A4D8F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 16:40:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A4D8F80166
IronPort-SDR: x0ivU7K/2EmqhSYiwWULSr6Fd0WP7bftU4HQf1bKFfki/5wNw7yRDTNjebtsdclSvJQ+0pRVvd
 EWkLLM+fpO0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="151337221"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; d="scan'208";a="151337221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 07:40:23 -0800
IronPort-SDR: kmqlJSRXq+UqX2RnZYUxYBPrnvXfwt3zf1CSx46/OLH22BO9NTbclONy1JXKmuV/3yem3qNSSM
 HQUoLZAWqnrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; d="scan'208";a="342071290"
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137])
 by orsmga002.jf.intel.com with ESMTP; 20 Nov 2020 07:40:22 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX604.ger.corp.intel.com (163.33.146.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 15:40:21 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Fri, 20 Nov 2020 15:40:21 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai
 <tiwai@suse.de>
Subject: RE: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Thread-Topic: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Thread-Index: AQHWuUTISKj33SVxVku5O7g0f1ygmanF+0XggABMLQCAAASUgIAEnFAQgAAmMgCAAVQSgIAAh8aQgAAL6wCAAWXZUIAAA0eAgALUmaA=
Date: Fri, 20 Nov 2020 15:40:21 +0000
Message-ID: <d94ccf9a3c61460db88f256df1fa3240@intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <0a0854d1ddaf4f9b81ef5569a7d501a5@intel.com>
 <20201113164946.GD4828@sirena.org.uk>
 <2cf7075b-bd51-21a5-2058-3a98e6c488a7@redhat.com>
 <d462c890495e4dda8698b5ba5eb50066@intel.com>
 <f62abcd8-b67f-774b-61b5-e08cfc3d2cc7@linux.intel.com>
 <s5h1rgst6z4.wl-tiwai@suse.de> <0286c6975f24432082f609d45adaa14c@intel.com>
 <0badb36f-3089-dc34-f7b0-75a73b856f0d@linux.intel.com>
 <d57fa3716a974eb9ba585ddd85dbe14c@intel.com>
 <cd8e5c2f-e1c2-7fbb-bee1-cc76ec14a801@linux.intel.com>
In-Reply-To: <cd8e5c2f-e1c2-7fbb-bee1-cc76ec14a801@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: Hans de Goede <hdegoede@redhat.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
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

T24gMjAyMC0xMS0xOCA5OjI1IFBNLCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToNCg0KLi4u
DQoNCj4+DQo+PiBIbW0sIHRoZW4gbWF5YmUgSSBtaXN1bmRlcnN0b29kIEhhbnMuIEdpdmVuIGhp
cyBmZWVkYmFjayBpdCBzZWVtZWQgbGlrZQ0KPj4gRmVkb3JhIGlzIGFib3V0IHRvIHN3aXRjaCB0
byBTT0YgcmlnaHQgbm93Lg0KPj4NCj4+IEluZGVlZCwgYmVmb3JlIEkndmUgc2VudCBwYXRjaGVz
IHJlbW92aW5nIEJheXRyYWlsLCBiYXNpY2FsbHkgZXZlcnkNCj4+IHN1cHBvcnQtdGVhbSBoYWQg
YmVlbiBhc2tlZCBhYm91dCBpdHMgdXNhZ2UgYW5kIHRoZSBhbnN3ZXJzIHdlcmUNCj4+IG5lZ2F0
aXZlLiAvYXRvbS8gd2FzIGNvdmVyaW5nIGJhc2ljYWxseSBldmVyeSBjYXNlIGFueXdheSBsaWtl
IHlvdQ0KPj4gcG9pbnRlZCBvdXQgc28gL2JheXRyYWlsLyBzb2x1dGlvbiBmZWx0IG1vcmUgbGlr
ZSBhIGR1cGxpY2F0aW9uLg0KPj4NCj4+IEFzIFNPRiBpcyB0aGUgZGVzaXJlZCBzb2x1dGlvbiBm
b3IgYXRvbS1iYXNlZCBwcm9kdWN0cywgSSBjYW4gc2VlIHRoZQ0KPj4gbmVlZCBmb3Igc29tZSBz
b3J0IG9mIHNlbGVjdGlvbiBtZWNoYW5pc20uIFRoZSBzYW1lIGNhbm5vdCBiZSBzYWlkIGZvcg0K
Pj4gaHN3L2JkdyB0aG91Z2guIExldCdzIGxlYXZlIGNhdHB0IG91dCB0aGlzLCBzaGFsbCB3ZT8N
Cj4gDQo+IEl0IGhlbHBzIGV2ZXJ5b25lIHRvIGhhdmUgYSBzaW5nbGUgYnVpbGQsIGUuZy4gJ21h
a2UgYWxsbW9kY29uZmlnJyBvciANCj4gJ21ha2UgYWxseWVzY29uZmlnJyB3b3VsZCBzZWxlY3Qg
YWxsIHBvc3NpYmxlIGRyaXZlcnMgYW5kIGJvdHMgY2FuIHJ1biANCj4gd2lsZC4NCj4gDQoNCldo
eSBzaG91bGQgYm90cyBjYXJlIGFib3V0IG5vdCByZWNvbW1lbmRlZCBjb2RlPw0KSSdtIGFnYWlu
c3QgYWRkaW5nIGV4dGVybmFsIGRlcGVuZGVuY3kgKGludGVsLWRzcC1jb25maWcpIGZvcg0KY2F0
cHQgZm9yIHJlYXNvbnMgSSdkIG1lbnRpb25lZCBzZXZlcmFsIHRpbWVzIGFscmVhZHkuDQoNCkN6
YXJlaw0KDQo=
