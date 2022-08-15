Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26759C00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 09:56:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01062851;
	Mon, 15 Aug 2022 11:55:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01062851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660557409;
	bh=Lgia/ExrcNngMVUh6T4nl4yf7qmKsnQhjOvZkyys1II=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nkAvzCrwis/zAmFZYegNSxuuMeQ8j/Y8FSSSi6bylv5wEvsHUQZFKMTADJ8tFG+AW
	 tfF4f5jsAd3HIiWjL8gl+4BiOAC77DkYaT6wi/GRBYqN+SOkWu6ul5hVVOzM21G6lx
	 Ayu8Y4IN/QMReHls1H/uLG3chWEzoXvGYGyGskCY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EDCDF80245;
	Mon, 15 Aug 2022 11:55:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD3D7F80125; Mon, 15 Aug 2022 11:55:56 +0200 (CEST)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B8BAF80125
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 11:55:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B8BAF80125
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-101-4cQNWSDENwOhApAiFPs4uQ-1; Mon, 15 Aug 2022 10:55:51 +0100
X-MC-Unique: 4cQNWSDENwOhApAiFPs4uQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Mon, 15 Aug 2022 10:55:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Mon, 15 Aug 2022 10:55:50 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nick Desaulniers' <ndesaulniers@google.com>, Nathan Chancellor
 <nathan@kernel.org>
Subject: RE: [PATCH] ASoC: mchp-spdiftx: Fix clang
 -Wbitfield-constant-conversion
Thread-Topic: [PATCH] ASoC: mchp-spdiftx: Fix clang
 -Wbitfield-constant-conversion
Thread-Index: AQHYrP4xySyJ4QyXg0+0Vu0cOV8HAa2vv+Uw
Date: Mon, 15 Aug 2022 09:55:50 +0000
Message-ID: <24087aa311e84df3a3df3c0e15151580@AcuMS.aculab.com>
References: <20220810010809.2024482-1-nathan@kernel.org>
 <CAKwvOdmZvB_=JTeLg08uMFhEMpWga4FJey50QHjzCv_jMVpwkg@mail.gmail.com>
In-Reply-To: <CAKwvOdmZvB_=JTeLg08uMFhEMpWga4FJey50QHjzCv_jMVpwkg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Tom Rix <trix@redhat.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxMCBBdWd1c3QgMjAyMiAyMjoxNA0KPiAN
Cj4gT24gVHVlLCBBdWcgOSwgMjAyMiBhdCA2OjA4IFBNIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRo
YW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBBIHJlY2VudCBjaGFuZ2UgaW4gY2xhbmcg
c3RyZW5ndGhlbmVkIGl0cyAtV2JpdGZpZWxkLWNvbnN0YW50LWNvbnZlcnNpb24NCj4gPiB0byB3
YXJuIHdoZW4gMSBpcyBhc3NpZ25lZCB0byBhIDEtYml0IHNpZ25lZCBpbnRlZ2VyIGJpdGZpZWxk
LCBhcyBpdCBjYW4NCj4gPiBvbmx5IGJlIDAgb3IgLTEsIG5vdCAxOg0KDQpJcyB0aGVyZSBhIC1X
c2lnbmVkLWJpdGZpZWxkID8NCllvdSBwcm9iYWJseSBkb24ndCBldmVyIHdhbnQgdGhlIGNvbXBp
bGVyIHRvIGJlIGdlbmVyYXRpbmcNCnRoZSBjb2RlIHRvIHNpZ24tcHJvcGFnYXRlIGEgYml0Zmll
bGQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

