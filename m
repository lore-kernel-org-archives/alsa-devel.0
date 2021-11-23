Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A804C433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 09:51:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9372A82E;
	Tue, 23 Nov 2021 10:50:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9372A82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637661075;
	bh=eK8cNyw7sAT+aeXPMqxaBd/3F94Dku6ahUx4FSXj9aE=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFxanmQKhA+ce02VIBZvtepY7BPveC9CzvVIxM864KeubT9JGxETwNIFAZfGYZ/Wp
	 55cX1rv7vCamHGfI2DetSV10xEHQzQ2V8/oK6GG4/44QlIQYnc6eWZKt4LZ41YtxGi
	 /C0g31NYgmtLFVZnKJA8Ce9A4FFRuwjpEfyCivAA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1391EF8049E;
	Tue, 23 Nov 2021 10:50:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99687F804AB; Tue, 23 Nov 2021 10:50:19 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38631F80087
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 10:50:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38631F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="rGK3uz95"
X-UUID: fd855079537643c4b9462606bf4cdca8-20211123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=eK8cNyw7sAT+aeXPMqxaBd/3F94Dku6ahUx4FSXj9aE=; 
 b=rGK3uz95OVIl5bMVczCheemocfss6rK5W3/FpyrEYRG4CYAQqx1mr1s+noPBZ71YDT/sdC3hfBpr0JWcWvwBBE9SAJ8+/q+JenX82uF02nBjBJBNCzTld7r4kOvA3Q677JVjJ0eIW0YtLCLs3rfDeDgNpRozlcwMHupiEv/nHuE=;
X-UUID: fd855079537643c4b9462606bf4cdca8-20211123
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1528247596; Tue, 23 Nov 2021 17:49:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 23 Nov 2021 17:49:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Nov 2021 17:49:57 +0800
Message-ID: <a0eddcc82cf4fc28eb96d7cb37cf1ad4252d39c3.camel@mediatek.com>
Subject: Re: [PATCH] ASoC: mt8192: remove unnecessary CONFIG_PM
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 23 Nov 2021 17:49:57 +0800
In-Reply-To: <CA+Px+wWeV=9DF7wdSyjaZKS=XCJjri1Dmpf-kfNVZOqm5fV33w@mail.gmail.com>
References: <20211122164644.19442-1-jiaxin.yu@mediatek.com>
 <20211122164644.19442-2-jiaxin.yu@mediatek.com>
 <CA+Px+wWeV=9DF7wdSyjaZKS=XCJjri1Dmpf-kfNVZOqm5fV33w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
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

T24gVHVlLCAyMDIxLTExLTIzIGF0IDExOjEyICswODAwLCBUenVuZy1CaSBTaGloIHdyb3RlOg0K
PiBPbiBUdWUsIE5vdiAyMywgMjAyMSBhdCAxMjo0OCBBTSBKaWF4aW4gWXUgPGppYXhpbi55dUBt
ZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYXhpbiBZdSA8amlh
eGluLnl1QG1lZGlhdGVrLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQo+IA0KPiBBY2tlZC1ieTogVHp1bmctQmkgU2hpaCA8dHp1bmdiaUBn
b29nbGUuY29tPg0KPiANCj4gQ291bGQgeW91IGFsc28gc3VibWl0IGFub3RoZXIgc2VyaWVzIGZv
ciB0aGUgY2xlYW51cD8NCj4gDQo+IEF0IGxlYXN0IGZvciBzb3VuZC9zb2MvbWVkaWF0ZWsvOg0K
PiAkIHJnIC0tZmlsZXMtd2l0aC1tYXRjaGVzIENPTkZJR19QTSBzb3VuZC9zb2MvbWVkaWF0ZWsv
DQo+IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxNzMvbXQ4MTczLXJ0NTY1MC1ydDU2NzYuYw0KPiBz
b3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTczL210ODE3My1ydDU2NTAuYw0KPiBzb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ4MTczL210ODE3My1tYXg5ODA5MC5jDQo+IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgx
NzMvbXQ4MTczLXJ0NTY1MC1ydDU1MTQuYw0KPiBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ2Nzk3L210
Njc5Ny1hZmUtcGNtLmMNCj4gc291bmQvc29jL21lZGlhdGVrL210MjcwMS9tdDI3MDEtYWZlLXBj
bS5jDQo+IHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWFmZS1wY20uYw0KPiBzb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTgzL210ODE4My1hZmUtcGNtLmMNCg0KSGkgVHp1bmctQmksDQoN
Ck9rLCBJIHdpbGwgcmVtb3ZlIHRoZW0gZnJvbSBzb3VuZC9zb2MvbWVkaWF0ZWsgZm9sZGVyIGlu
IFBBVENIIHYyLg0KVGhhbmsgeW91IGZvciByZW1pbmRpbmcuDQo=

