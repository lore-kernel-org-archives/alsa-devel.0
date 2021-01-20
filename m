Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD4BC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 10:12:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2295B2332B
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 10:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2295B2332B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D30581884;
	Wed, 20 Jan 2021 11:11:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D30581884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611137511;
	bh=9AMGkg3kio8YHx5boWSmIAOxgqW8LgWEBkXZykNsZ+o=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLm1pspM1xSdK8upiUgctbFeMCiOnbwkuf0LWcihzkdCjm3uuYc3xUgYVbvdGdtiu
	 DERUpjZVQ0z3rg+MrzzqMCIcQ4eMEBxklJgVcWElbI1Di4QCtmXUgxUcMYkLgp5gxT
	 2kjzpjJo3VACgRCwW4IWQEW5Cv49aG5gSOGCe538=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63A0DF80166;
	Wed, 20 Jan 2021 11:11:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD5CCF8016E; Wed, 20 Jan 2021 11:10:59 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEA88F80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 11:10:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEA88F80164
IronPort-SDR: mHUDBICkKm3ThUG3gjLQTxd1j1WaknV7xzO/NvqUeSFPS6ck6jQmnAYuyOObsy1J5q62f32DP6
 IuYOlUqOjsIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179228309"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; d="scan'208";a="179228309"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 02:10:50 -0800
IronPort-SDR: Y3q4iHQ39GKdIRFZJuHQUZndvahXpGhqws8lMBncjHvIY87iG83soE++lcwWFCbYh4Sg5tKHWb
 mAaau6gwipwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; d="scan'208";a="355996544"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
 by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2021 02:10:48 -0800
Received: from irsmsx602.ger.corp.intel.com (163.33.146.8) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 10:10:47 +0000
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8]) by
 irsmsx602.ger.corp.intel.com ([163.33.146.8]) with mapi id 15.01.1713.004;
 Wed, 20 Jan 2021 10:10:47 +0000
From: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
To: "anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 0/7] ALSA: add virtio sound driver
Thread-Topic: [PATCH 0/7] ALSA: add virtio sound driver
Thread-Index: AQHW7xSF5+25jD6v60GKV9bYQ1UsAw==
Date: Wed, 20 Jan 2021 10:10:47 +0000
Message-ID: <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8799E9B4388B3499FBC9D607BD6246A@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

SGkgQW50b24sDQoNCk9uIFdlZCwgMjAyMS0wMS0yMCBhdCAwMTozNiArMDEwMCwgQW50b24gWWFr
b3ZsZXYgd3JvdGU6DQo+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgYSBkcml2ZXIgcGFydCBvZiB0
aGUgdmlydGlvIHNvdW5kIGRldmljZQ0KPiBzcGVjaWZpY2F0aW9uIHY4IFsxXS4NCj4gDQo+IFRo
ZSBkcml2ZXIgc3VwcG9ydHMgUENNIHBsYXliYWNrIGFuZCBjYXB0dXJlIHN1YnN0cmVhbXMsIGph
Y2sgYW5kDQo+IGNoYW5uZWwgbWFwIGNvbnRyb2xzLiBBIG1lc3NhZ2UtYmFzZWQgdHJhbnNwb3J0
IGlzIHVzZWQgdG8gd3JpdGUvcmVhZA0KPiBQQ00gZnJhbWVzIHRvL2Zyb20gYSBkZXZpY2UuDQo+
IA0KPiBUaGUgc2VyaWVzIGlzIGJhc2VkIChhbmQgd2FzIGFjdHVhbGx5IHRlc3RlZCkgb24gTGlu
dXMncyBtYXN0ZXINCj4gYnJhbmNoIFsyXSwgb24gdG9wIG9mDQo+IA0KPiBjb21taXQgMWUyYTE5
OWY2Y2NkICgiTWVyZ2UgdGFnICdzcGktZml4LXY1LjExLXJjNCcgb2YgLi4uIikNCj4gDQo+IEFz
IGEgZGV2aWNlIHBhcnQgd2FzIHVzZWQgT3BlblN5bmVyZ3kgcHJvcHJpZXRhcnkgaW1wbGVtZW50
YXRpb24uDQo+IA0KPiBBbnkgY29tbWVudHMgYXJlIHZlcnkgd2VsY29tZS4NCj4gDQoNClRoaXMg
anVzdCBsb29rcyBsaWtlIHRoZSBndWVzdCBmcm9udCBlbmQgaGVyZSwgZG8geW91IGhhdmUgYSBm
b2xsb3cgdXANCnNlcmllcyBmb3IgdGhlIGhvc3QgYmFja2VuZCA/DQoNClRoYW5rcw0KDQpMaWFt
ICANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBDb3Jwb3JhdGlvbiAoVUspIExpbWl0ZWQKUmVnaXN0ZXJl
ZCBOby4gMTEzNDk0NSAoRW5nbGFuZCkKUmVnaXN0ZXJlZCBPZmZpY2U6IFBpcGVycyBXYXksIFN3
aW5kb24gU04zIDFSSgpWQVQgTm86IDg2MCAyMTczIDQ3CgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUg
dXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0
aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUg
YWxsIGNvcGllcy4K

