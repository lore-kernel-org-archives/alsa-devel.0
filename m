Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FF0C2D0A3
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:52:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1242B2222B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LDLTX7lP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Dp4TDRxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1242B2222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49B10169C;
	Wed,  4 Nov 2020 07:51:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49B10169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604472726;
	bh=UekoF2NkcIAbphiY/goCm0eSyGMBmiPCbvSp/O9/Sgw=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LDLTX7lP07uJCnk9XofdAQeO4NT1IkT7NuZuW8K7Zpr1WmM/kRx1ARRkiTlhraS8L
	 xNU8gJKUjEvicxxQXMA43KaWYf71VNeihqlYUh/oXp41/EFLuFLouxG6jgkBXVYYlY
	 1R5cUaJG38XOpQjV/NbwbetBgq1rcjkVNtKLwUHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB8C5F80229;
	Wed,  4 Nov 2020 07:51:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BED5F800EC; Wed,  4 Nov 2020 07:51:10 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id B4640F800EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 07:51:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4640F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="Dp4TDRxh"
X-UUID: ff8c1a4484ba4ef49b81fb8b463fc0b2-20201104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=UekoF2NkcIAbphiY/goCm0eSyGMBmiPCbvSp/O9/Sgw=; 
 b=Dp4TDRxhU/fzcpAEaw89Z9dlx5NRb3q9m7bI2bE8doxyEd7jrGM1Azh9lMRXgEFC30UHYovcTOCRUDkyTxdwc4pK0z+I5abMRSzwfkob7gtdAna57LM7TSRXmrjgrkoep25jHa0y0S4SWYbnhHCYoOjRj25HBgc3YenrMFf/nJk=;
X-UUID: ff8c1a4484ba4ef49b81fb8b463fc0b2-20201104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1151957997; Wed, 04 Nov 2020 14:50:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n2.mediatek.inc
 (172.21.101.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 4 Nov 2020 14:50:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Nov 2020 14:50:52 +0800
Message-ID: <1604472652.26523.14.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/9] ASoC: mediatek: mt8192: support i2s in platform
 driver
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Date: Wed, 4 Nov 2020 14:50:52 +0800
In-Reply-To: <20201030143729.GF4405@sirena.org.uk>
References: <1603526339-15005-1-git-send-email-jiaxin.yu@mediatek.com>
 <1603526339-15005-4-git-send-email-jiaxin.yu@mediatek.com>
 <20201030143729.GF4405@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Content-Transfer-Encoding: base64
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, shane.chien@mediatek.com,
 Bicycle.Tsai@mediatek.com, tiwai@suse.com, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, Trevor.Wu@mediatek.com,
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

T24gRnJpLCAyMDIwLTEwLTMwIGF0IDE0OjM3ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBTYXQsIE9jdCAyNCwgMjAyMCBhdCAwMzo1ODo1M1BNICswODAwLCBKaWF4aW4gWXUgd3JvdGU6
DQo+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNvY19lbnVtIG10ODE5Ml9pMnNfZW51bVtd
ID0gew0KPiA+ICsJU09DX0VOVU1fU0lOR0xFX0VYVChBUlJBWV9TSVpFKG10ODE5Ml9pMnNfaGRf
c3RyKSwNCj4gPiArCQkJICAgIG10ODE5Ml9pMnNfaGRfc3RyKSwNCj4gPiArfTsNCj4gDQo+IFdo
eSBpcyB0aGlzIGRlY2xhcmVkIGFzIGEgc2luZ2xlIGVsZW1lbnQgYXJyYXk/ICBJdCBqdXN0IG1h
a2VzIGFsbCB0aGUNCj4gdXNhZ2VzIGxvb2sgb2RkIGZvciBubyBvYnZpb3VzIGdhaW4uDQo+IA0K
PiA+ICtzdGF0aWMgaW50IG10a19pMnNfZW5fZXZlbnQoc3RydWN0IHNuZF9zb2NfZGFwbV93aWRn
ZXQgKncsDQo+ID4gKwkJCSAgICBzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwNCj4gPiAr
CQkJICAgIGludCBldmVudCkNCj4gDQo+ID4gKwlkZXZfaW5mbyhjbXBudC0+ZGV2LCAiJXMoKSwg
bmFtZSAlcywgZXZlbnQgMHgleFxuIiwNCj4gPiArCQkgX19mdW5jX18sIHctPm5hbWUsIGV2ZW50
KTsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGRldl9kYmcoKSBhdCBtb3N0LCBfaW5mbygpIHdpbGwg
YmUgdG9vIG5vaXN5IGluIHRoZSBsb2dzLg0KPiBTYW1lIGZvciBhIGxvdCBvZiBmdW5jdGlvbnMs
IGluY2x1ZGluZyB0aGUgc3RyZWFtIGNhbGxiYWNrcy4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbXRr
X2kyc19oZF9lbl9ldmVudChzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqdywNCj4gPiArCQkJ
ICAgICAgIHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLA0KPiA+ICsJCQkgICAgICAgaW50
IGV2ZW50KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNtcG50ID0g
c25kX3NvY19kYXBtX3RvX2NvbXBvbmVudCh3LT5kYXBtKTsNCj4gPiArDQo+ID4gKwlkZXZfaW5m
byhjbXBudC0+ZGV2LCAiJXMoKSwgbmFtZSAlcywgZXZlbnQgMHgleFxuIiwNCj4gPiArCQkgX19m
dW5jX18sIHctPm5hbWUsIGV2ZW50KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0K
PiANCj4gVGhpcyBzaG91bGQganVzdCBiZSByZW1vdmVkIGVudGlyZWx5LCB0aGVyZSdzIHRyYWNl
IGluIHRoZSBjb3JlIGlmIHlvdQ0KPiBuZWVkIGxvZ2dpbmcgaW4gcHJvZHVjdGlvbiBzeXN0ZW1z
IC0gdGhlIHRyYWNlcG9pbnRzIGluIHBhcnRpY3VsYXIgYXJlDQo+IGdvb2QgZm9yIGp1c3QgbGVh
dmluZyBvbiBhbGwgdGhlIHRpbWUgd2l0aG91dCBhZGRpbmcgb3ZlcmhlYWQuDQo+IA0KPiA+ICsJ
cmV0dXJuIChpMnNfbmVlZF9hcGxsID09IGN1cl9hcGxsKSA/IDEgOiAwOw0KPiANCj4gUGxlYXNl
IHdyaXRlIG5vcm1hbCBjb25kaXRpb25hbCBzdGF0ZW1lbnRzIHRvIGltcHJvdmUgbGVnaWJsaXR5
Lg0KPiANCj4gPiArCWlmIChyYXRlID09IDQ0MTAwKQ0KPiA+ICsJCXJlZ21hcF93cml0ZShhZmUt
PnJlZ21hcCwgQUZFX0FTUkNfMkNIX0NPTjMsIDB4MDAxQjkwMDApOw0KPiA+ICsJZWxzZSBpZiAo
cmF0ZSA9PSAzMjAwMCkNCj4gPiArCQlyZWdtYXBfd3JpdGUoYWZlLT5yZWdtYXAsIEFGRV9BU1JD
XzJDSF9DT04zLCAweDE0MDAwMCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmVnbWFwX3dyaXRlKGFm
ZS0+cmVnbWFwLCBBRkVfQVNSQ18yQ0hfQ09OMywgMHgwMDFFMDAwMCk7DQo+IA0KPiBUaGlzIHdv
dWxkIGJlIGJldHRlciB3cml0dGVuIGFzIGEgc3dpdGNoIHN0YXRlbWVudC4NCj4gDQo+ID4gKwkv
KiBDYWxpYnJhdGlvbiBzZXR0aW5nICovDQo+ID4gKwlyZWdtYXBfd3JpdGUoYWZlLT5yZWdtYXAs
IEFGRV9BU1JDXzJDSF9DT040LCAweDAwMTQwMDAwKTsNCj4gPiArCXJlZ21hcF93cml0ZShhZmUt
PnJlZ21hcCwgQUZFX0FTUkNfMkNIX0NPTjksIDB4MDAwMzYwMDApOw0KPiA+ICsJcmVnbWFwX3dy
aXRlKGFmZS0+cmVnbWFwLCBBRkVfQVNSQ18yQ0hfQ09OMTAsIDB4MDAwMkZDMDApOw0KPiA+ICsJ
cmVnbWFwX3dyaXRlKGFmZS0+cmVnbWFwLCBBRkVfQVNSQ18yQ0hfQ09ONiwgMHgwMDAwN0VGNCk7
DQo+ID4gKwlyZWdtYXBfd3JpdGUoYWZlLT5yZWdtYXAsIEFGRV9BU1JDXzJDSF9DT041LCAweDAw
RkY1OTg2KTsNCj4gDQo+IEFyZSB5b3Ugc3VyZSB0aGlzIGlzbid0IHN5c3RlbSBkZXBlbmRhbnQ/
DQpIaSBNYXJrLA0KWWVzLCB0aGlzIGlzIGEgc3lzdGVtIGluZGVwZW5kZW50IHNldHRpbmcuIEFu
ZCBJIGZpeGVkIG90aGVyIGNvbW1lbnRzDQp5b3UgcG9pbnRlZCBvdXQgdGhlbiBzZW5kICJQQVRD
SCB2NCIuDQoNCg0K

