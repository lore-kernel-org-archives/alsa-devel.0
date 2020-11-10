Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F670C388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 08:55:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E286207BC
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RzXsqvzL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KH2H+LIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E286207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4776D16DA;
	Tue, 10 Nov 2020 09:54:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4776D16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604998543;
	bh=busI8tzaIjOQfi9V2ZmeWHinzielzkKRRHvJYt8BzSk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzXsqvzLH9bB4hDI7kn0A5InImRQHY9HHIZqFe0f5c5cHnynZq/8i/U7hIW576x6f
	 rXYi7GBOsL4UZ//S+F/ixbPAVaL3x7PKNgWrEyT/It+iEv1umjuy6YuJZtjlfqjEwv
	 W1ouo4KEE0K6Y1fiNYZ14SmZaSg8GERfO9oaPVmY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDDB4F80161;
	Tue, 10 Nov 2020 09:54:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3545F801D5; Tue, 10 Nov 2020 09:54:50 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id 44A59F800EB
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 09:54:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44A59F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="KH2H+LIQ"
X-UUID: a18501082d5a479dacaa74d1972b3a74-20201110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=busI8tzaIjOQfi9V2ZmeWHinzielzkKRRHvJYt8BzSk=; 
 b=KH2H+LIQukKINWY+XXSHqBPD93HBiZy5h4WIjX0APcCqh1576xUKNyIYc8c3gBV5H8IVRlcDUrur21gBgUsIoRZuv8R3Nx8BSPyZtpB7QzrrCmvm1vtJZLjfaSSLzt0GsHqncLwxzJmT6Ns7oen/gKA3S0mLt7T+3VNDVXKud3I=;
X-UUID: a18501082d5a479dacaa74d1972b3a74-20201110
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1981452464; Tue, 10 Nov 2020 16:54:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 16:54:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Nov 2020 16:54:30 +0800
Message-ID: <1604998469.2817.3.camel@mtkswgap22>
Subject: Re: [PATCH v2] ALSA: usb-audio: disable 96khz support for HUAWEI
 USB-C HEADSET
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Greg KH <greg@kroah.com>
Date: Tue, 10 Nov 2020 16:54:29 +0800
In-Reply-To: <X6pUaatZ7aML4sKq@kroah.com>
References: <1604995443-30453-1-git-send-email-macpaul.lin@mediatek.com>
 <1604997774-13593-1-git-send-email-macpaul.lin@mediatek.com>
 <X6pUaatZ7aML4sKq@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6DB580D9FD98F3A3017B4D3065C7D004E39255AD44F7F8ECCD7CD23B23672D3B2000:8
X-MTK: N
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
 Christopher Swenson <swenson@swenson.io>, linux-kernel@vger.kernel.org,
 Macpaul Lin <macpaul@gmail.com>, Eddie Hung <eddie.hung@mediatek.com>,
 Takashi Iwai <tiwai@suse.com>, stable@vger.kernel.org,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Alexander Tsoy <alexander@tsoy.me>,
 linux-mediatek@lists.infradead.org, Nick Kossifidis <mickflemm@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Nicola Lunghi <nick83ola@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Ainge Hsu <ainge.hsu@mediatek.com>
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

T24gVHVlLCAyMDIwLTExLTEwIGF0IDA5OjUwICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBU
dWUsIE5vdiAxMCwgMjAyMCBhdCAwNDo0Mjo1NFBNICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToN
Cj4gPiBUaGUgSFVBV0VJIFVTQi1DIGhlYWRzZXQgKFZJRDoweDEyZDEsIFBJRDoweDNhMDcpIHJl
cG9ydGVkIGl0IHN1cHBvcnRzDQo+ID4gOTZraHouIEhvd2V2ZXIgdGhlcmUgd2lsbCBiZSBzb21l
IHJhbmRvbSBpc3N1ZSB1bmRlciA5Nmtoei4NCj4gPiBOb3Qgc3VyZSBpZiB0aGVyZSBpcyBhbnkg
YWx0ZXJuYXRlIHNldHRpbmcgY291bGQgYmUgYXBwbGllZC4NCj4gPiBIZW5jZSA0OGtoeiBpcyBz
dWdnZXN0ZWQgdG8gYmUgYXBwbGllZCBhdCB0aGlzIG1vbWVudC4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEVkZGllIEh1bmcgPGVkZGllLmh1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4g
ICAtIEZpeCBidWlsZCBlcnJvci4NCj4gPiAgIC0gQWRkIENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+ID4gDQo+ID4gIHNvdW5kL3VzYi9mb3JtYXQuYyB8ICAgIDYgKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc291
bmQvdXNiL2Zvcm1hdC5jIGIvc291bmQvdXNiL2Zvcm1hdC5jDQo+ID4gaW5kZXggMWIyOGQwMS4u
N2E0ODM3YiAxMDA2NDQNCj4gPiAtLS0gYS9zb3VuZC91c2IvZm9ybWF0LmMNCj4gPiArKysgYi9z
b3VuZC91c2IvZm9ybWF0LmMNCj4gPiBAQCAtMjAyLDYgKzIwMiw3IEBAIHN0YXRpYyBpbnQgcGFy
c2VfYXVkaW9fZm9ybWF0X3JhdGVzX3YxKHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLCBzdHJ1
Y3QgYXVkaW9mDQo+ID4gIAkJZnAtPnJhdGVfbWluID0gZnAtPnJhdGVfbWF4ID0gMDsNCj4gPiAg
CQlmb3IgKHIgPSAwLCBpZHggPSBvZmZzZXQgKyAxOyByIDwgbnJfcmF0ZXM7IHIrKywgaWR4ICs9
IDMpIHsNCj4gPiAgCQkJdW5zaWduZWQgaW50IHJhdGUgPSBjb21iaW5lX3RyaXBsZSgmZm10W2lk
eF0pOw0KPiA+ICsJCQlzdHJ1Y3QgdXNiX2RldmljZSAqdWRldiA9IGNoaXAtPmRldjsNCj4gPiAg
CQkJaWYgKCFyYXRlKQ0KPiA+ICAJCQkJY29udGludWU7DQo+ID4gIAkJCS8qIEMtTWVkaWEgQ002
NTAxIG1pc2xhYmVscyBpdHMgOTYga0h6IGFsdHNldHRpbmcgKi8NCj4gDQo+IERpZCB5b3UgcnVu
IHRoaXMgcGF0Y2ggdGhyb3VnaCBjaGVja3BhdGNoLnBsPw0KPiANCg0KSSd2ZSByYW4gY2hlY2tw
YXRjaCBmb3IgdGhpcyBwYXRjaCB2MiwgYW5kIGl0IHNob3duDQoidG90YWw6IDAgZXJyb3JzLCAw
IHdhcm5pbmdzIi4gV2UncmUgdXNpbmcgNS45LXJjMSBpbnRlcm5hbC4NCg0KSG93ZXZlciwgSSds
bCBzZW5kIHBhdGNoIHYzIGFjY29yZGluZyB0byBUYWthc2hpJ3Mgc3VnZ2VzdGlvbi4NCg0KVGhh
bmtzDQpNYWNwYXVsIExpbg0K

