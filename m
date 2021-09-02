Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6335DC432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 02:36:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12EA61058
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 02:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B12EA61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D4F71772;
	Thu,  2 Sep 2021 04:35:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D4F71772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630550196;
	bh=QOTKsLIYJE11qFg8eBBPd7FPd11PtcpPDGYrw9m8oEE=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B5wWaZizp/LbgqrqSB1yQEwH1q757gqhoDJ0HF/F9mGSNaHCN05ASdWY8fujWR1yF
	 qQTg07VYamvEe5RYt4n86EhRXlQrWsKWMp70msitNTaiW41P/uMArZbukfx5Wnk2Zx
	 hGEYdk7cu0fIx+QpZubViNgDWG18/kPOO6Tm3J+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5536EF80125;
	Thu,  2 Sep 2021 04:35:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3307F80269; Thu,  2 Sep 2021 04:35:41 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FF0EF80125
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 04:35:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FF0EF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="GwcTVptj"
X-UUID: 32d966e8fe2746a49b5d40d11e4f32d7-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=QOTKsLIYJE11qFg8eBBPd7FPd11PtcpPDGYrw9m8oEE=; 
 b=GwcTVptjejg36Z/KVINTC6/shtkZ9NiWyRYC8gUw8fQr7DJJCpIcMpeCrjBbJ8aMBWiSmgVAbYm7ZaC3AmL/fgjhZXstnnX0EKqs6eQQSGVkGTpe5jXR8N59kUj6ioLucI0pCo2sGw715fYwn6tfQ6hJedXHGh6lVHdx0yDO66o=;
X-UUID: 32d966e8fe2746a49b5d40d11e4f32d7-20210902
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2102975702; Thu, 02 Sep 2021 10:35:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 10:35:23 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 10:35:22 +0800
Message-ID: <299c7f0a7b1dede1e2f704a0133f4045e85641b5.camel@mediatek.com>
Subject: Re: linux-next: Tree for Sep 1
 [sound/soc/mediatek/mt8195/snd-soc-mt8195-afe.ko]
From: Trevor Wu <trevor.wu@mediatek.com>
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Date: Thu, 2 Sep 2021 10:35:22 +0800
In-Reply-To: <3ee0b878-b78c-2483-1a0b-7570bda0132b@infradead.org>
References: <20210901181740.3a0a69f2@canb.auug.org.au>
 <3ee0b878-b78c-2483-1a0b-7570bda0132b@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Content-Transfer-Encoding: base64
Cc: Bicycle Tsai <bicycle.tsai@mediatek.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

T24gV2VkLCAyMDIxLTA5LTAxIGF0IDEzOjU1IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IE9uIDkvMS8yMSAxOjE3IEFNLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3RlOg0KPiA+IEhpIGFsbCwN
Cj4gPiANCj4gPiBQbGVhc2UgZG8gbm90IGFkZCBhbnkgdjUuMTYgcmVsYXRlZCBjb2RlIHRvIHlv
dXIgbGludXgtbmV4dA0KPiA+IGluY2x1ZGVkDQo+ID4gYnJhbmNoZXMgdW50aWwgYWZ0ZXIgdjUu
MTUtcmMxIGhhcyBiZWVuIHJlbGVhc2VkLg0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgMjAyMTA4
MzE6DQo+ID4gDQo+IA0KPiANCj4gb24geDg2XzY0Og0KPiANCj4gRVJST1I6IG1vZHBvc3Q6ICJj
bGtkZXZfYWRkIiBbc291bmQvc29jL21lZGlhdGVrL210ODE5NS9zbmQtc29jLQ0KPiBtdDgxOTUt
YWZlLmtvXSB1bmRlZmluZWQhDQo+IEVSUk9SOiBtb2Rwb3N0OiAiY2xrZGV2X2Ryb3AiIFtzb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1L3NuZC1zb2MtDQo+IG10ODE5NS1hZmUua29dIHVuZGVmaW5l
ZCENCj4gRVJST1I6IG1vZHBvc3Q6ICJjbGtfdW5yZWdpc3Rlcl9nYXRlIiBbc291bmQvc29jL21l
ZGlhdGVrL210ODE5NS9zbmQtDQo+IHNvYy1tdDgxOTUtYWZlLmtvXSB1bmRlZmluZWQhDQo+IEVS
Uk9SOiBtb2Rwb3N0OiAiY2xrX3JlZ2lzdGVyX2dhdGUiIFtzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4
MTk1L3NuZC0NCj4gc29jLW10ODE5NS1hZmUua29dIHVuZGVmaW5lZCENCj4gDQo+IEZ1bGwgcmFu
ZGNvbmZpZyBmaWxlIGlzIGF0dGFjaGVkLg0KPiANCg0KSGkgUmFuZHksDQoNClRoZSBwcm9ibGVt
IGlzIGNhdXNlZCBieSB0aGUgZGVwZW5kZW5jeSBkZWNsYXJhdGlvbiwgYmVjYXVzZSBpdCdzIG5v
dCBhDQpkcml2ZXIgZm9yIHg4Nl82NC4NClRoZSBkZXBlbmRlbmN5IGRlY2xhcmF0aW9uIGhhcyBi
ZWVuIGFkZGVkIGluIHRoZSBmb2xsb3dpbmcgcGF0Y2guDQoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2Fsc2EtZGV2ZWwvcGF0Y2gvN2U2MjhlMzU5YmRlMDRjZWI5ZGRk
NzRhNDU5MzEwNTliNGE0NjIzYy4xNjMwNDE1ODYwLmdpdC5nZWVydCtyZW5lc2FzQGdsaWRlci5i
ZS8NCg0KVGhhbmtzLA0KVHJldm9yDQoNCg0K

