Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAADC4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:05:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC7724196
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D1obvy6C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DRNz6zE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC7724196
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03BD917B5;
	Thu, 22 Oct 2020 12:05:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03BD917B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603361153;
	bh=/pWlKbK+2FYWyyCxb4qgVtC6XtrPsrK8S8hX+HS2blI=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1obvy6CHXKr2aBqCUgoXwns8MsIMaVasZWPw25erZU2gMq+/G/2YEN+6wxEfGqAD
	 S9zhGij5vrR63HKQeeBC/B/PCiSoVLHCHh6PosH71S2+oy5MKzahmiCLSrEoGsctq2
	 JXMrg45uI0j2zaHrWdWa28nTQBysygRn21TdRDHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D40EF804A9;
	Thu, 22 Oct 2020 12:05:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B48AFF804AA; Thu, 22 Oct 2020 12:05:01 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id AD4DCF80247
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 12:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD4DCF80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="DRNz6zE2"
X-UUID: 4bcf5a71af7a4d519d267a17187997da-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=/pWlKbK+2FYWyyCxb4qgVtC6XtrPsrK8S8hX+HS2blI=; 
 b=DRNz6zE2WX6m1Uwwb9De5VQLqYfxkCYBVc6186fgeGBHZGIEP1Yd+GHq/nzqe2z25KcbVUaRwwcZL7cHEj1YVqCn6yR+J6ac2ElRaBHc+uksUmhB9dDv0t6Iiw4QyAcZsfsFQmfHwX3LqAu+1xPyCa8iPKk4sXUjdW1KTc50fRM=;
X-UUID: 4bcf5a71af7a4d519d267a17187997da-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 117150928; Thu, 22 Oct 2020 18:04:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n2.mediatek.inc
 (172.21.101.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 22 Oct 2020 18:04:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 18:04:45 +0800
Message-ID: <1603361084.8921.26.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/5] ASoC: mediatek: mt8192: add platform driver
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Oct 2020 18:04:44 +0800
In-Reply-To: <20201021132339.GF4497@sirena.org.uk>
References: <1603270435-3548-1-git-send-email-jiaxin.yu@mediatek.com>
 <1603270435-3548-3-git-send-email-jiaxin.yu@mediatek.com>
 <20201021132339.GF4497@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Content-Transfer-Encoding: base64
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, shane.chien@mediatek.com, tiwai@suse.com,
 tzungbi@google.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

T24gV2VkLCAyMDIwLTEwLTIxIGF0IDE0OjIzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIE9jdCAyMSwgMjAyMCBhdCAwNDo1Mzo1MlBNICswODAwLCBKaWF4aW4gWXUgd3JvdGU6
DQo+ID4gVGhpcyBwYXRjaCBhZGRzIG10ODE5MiBwbGF0Zm9ybSBhbmQgYWZmaWxpYXRlZCBkcml2
ZXJzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYXhpbiBZdSA8amlheGluLnl1QG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgc291bmQvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgIHwgICAxMCArDQo+ID4gIHNvdW5kL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvY29tbW9u
L210ay1hZmUtZmUtZGFpLmMgICAgfCAgIDEzICstDQo+ID4gIHNvdW5kL3NvYy9tZWRpYXRlay9j
b21tb24vbXRrLWJhc2UtYWZlLmggICAgICB8ICAgIDEgKw0KPiA+ICBzb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ4MTkyL01ha2VmaWxlICAgICAgICAgICAgfCAgIDE0ICsNCj4gPiAgc291bmQvc29jL21l
ZGlhdGVrL210ODE5Mi9tdDgxOTItYWZlLWNsay5jICAgIHwgIDY2OSArKysrDQo+ID4gIHNvdW5k
L3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWFmZS1jbGsuaCAgICB8ICAyNDQgKysNCj4gPiAg
c291bmQvc29jL21lZGlhdGVrL210ODE5Mi9tdDgxOTItYWZlLWNvbW1vbi5oIHwgIDE3MCArDQo+
ID4gIC4uLi9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1hZmUtY29udHJvbC5jICB8ICAxNjMg
Kw0KPiA+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1hZmUtZ3Bpby5jICAgfCAg
MzA2ICsrDQo+ID4gIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWFmZS1ncGlvLmgg
ICB8ICAgMTkgKw0KPiA+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1hZmUtcGNt
LmMgICAgfCAyMzg5ICsrKysrKysrKysrKysNCj4gPiAgc291bmQvc29jL21lZGlhdGVrL210ODE5
Mi9tdDgxOTItZGFpLWFkZGEuYyAgIHwgMTQ4OSArKysrKysrKw0KPiA+ICBzb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ4MTkyL210ODE5Mi1kYWktaTJzLmMgICAgfCAyMTM5ICsrKysrKysrKysrDQo+ID4g
IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWRhaS1wY20uYyAgICB8ICA0MDkgKysr
DQo+ID4gIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWRhaS10ZG0uYyAgICB8ICA3
NzggKysrKw0KPiA+ICAuLi4vbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1pbnRlcmNvbm5lY3Rpb24u
aCAgfCAgIDY1ICsNCj4gPiAgc291bmQvc29jL21lZGlhdGVrL210ODE5Mi9tdDgxOTItcmVnLmgg
ICAgICAgIHwgMzEzMSArKysrKysrKysrKysrKysrKw0KPiA+ICAxOCBmaWxlcyBjaGFuZ2VkLCAx
MjAwNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gVGhpcyBpcyAqd2F5KiB0
b28gYmlnIHRvIGJlIGEgc2luZ2xlIHBhdGNoLCBwbGVhc2Ugc3BsaXQgaXQgdXAgLSBpdCdzDQo+
IG92ZXIgNjAwSy4NCg0KSSB3aWxsIHNwbGl0IHRoZSBkYWkgZHJpdmVyIGZpbGVzIGFzIGEgc2Vw
ZXJhdGUgcGF0Y2hlcy4gU3VjaCBhczoNCkFTb0M6IG1lZGlhdGVrOiBtdDgxOTI6IHN1cHBvcnQg
YWRkYSBpbiBwbGF0Zm9ybSBkcml2ZXINCkFTb0M6IG1lZGlhdGVrOiBtdDgxOTI6IHN1cHBvcnQg
aTJzIGluIHBsYXRmb3JtIGRyaXZlcg0KQVNvQzogbWVkaWF0ZWs6IG10ODE5Mjogc3VwcG9ydCBw
Y20gaW4gcGxhdGZvcm0gZHJpdmVyDQpBU29DOiBtZWRpYXRlazogbXQ4MTkyOiBzdXBwb3J0IHRk
bSBpbiBwbGF0Zm9ybSBkcml2ZXINClRoZXkncmUgc3RpbGwgaW4gc2VyaWVzIG9mICJBU29DOiBt
ZWRpYXRlazogbXQ4MTkyOiBhZGQgcGxhdGZvcm0NCmRyaXZlciIuIA0KSXMgdGhpcyBhcHByb3By
aWF0ZT8gUGxlYXNlIGNvcnJlY3QgbWUgaWYgdGhlcmUgaXMgYW55IG1pc3VuZGVyc3RhbmRpbmcu
DQo=

