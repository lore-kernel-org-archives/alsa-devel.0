From: =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Thu, 16 May 2019 13:46:53 +0000
Message-ID: <BC6F7617C38F3E4E8CA887E07B35B82805B15635@RTITMBSVM07.realtek.com.tw>
References: <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
 <20190508064537.GN14916@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
 <20190512080621.GH21483@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B13EE2@RTITMBSVM07.realtek.com.tw>
 <20190513145608.GA5168@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B14BFF@RTITMBSVM07.realtek.com.tw>
 <20190515161429.GH5613@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0B68F80C18
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 15:47:04 +0200 (CEST)
In-Reply-To: <20190515161429.GH5613@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBydDEzMDg6IEFkZCBSVDEzMDggYW1wbGlmaWVy
IGRyaXZlcg0KPiANCj4gT24gVHVlLCBNYXkgMTQsIDIwMTkgYXQgMTE6MTA6NThBTSArMDAwMCwg
RGVyZWsgW+aWueW+t+e+qV0gd3JvdGU6DQo+IA0KPiA+IEkgY291bGQgcmVtb3ZlIGNvbW1lbnQg
Zm9yIHRoZSBsaW1pdCBzZXR0aW5nIGluIHJlZ2lzdGVyIHBhdGNoL2luaXQgbGlzdA0KPiA+IHRv
IGF2b2lkIHVzZXJzIG9yIGludGVncmF0b3JzIGhhdmUgYW55IGV4cGVjdGF0aW9uLg0KPiA+IEFu
ZCBhbHNvIHRoZXJlIHdpbGwgbm90IGJlIGFueSBzdXBwb3J0IGF0IGFsbCB0aGUgZHJpdmVyIGFj
Y29yZGluZyB0byB0aGUNCj4gPiBsaW1pdCBzZXR0aW5nLg0KPiANCj4gSXQncyBiZXR0ZXIgdG8g
aGF2ZSBhIGNvbW1lbnQgdGhhbiBub3QgaGF2ZSBvbmUsIEkgdGhpbmsgSSdkIGJlIGhhcHBpZXIN
Cj4gaWYgSSB1bmRlcnN0b29kIHdoYXQgd2FzIGFjdHVhbGx5IGJlaW5nIGxpbWl0ZWQgaGVyZSAt
IHRoYXQgbWlnaHQgbWFrZQ0KPiBpdCBjbGVhciB3aHkgaXQncyBub3Qgc3lzdGVtIHNwZWNpZmlj
IHdoaWNoIGlzIHdoYXQncyBjb25jZXJuaW5nIG1lLg0KDQpJIHdpbGwgZ2l2ZSBhIGNvbW1lbnQg
dGhhdCBkZXNjcmliZXMgdGhlIGxpbWl0IHNldHRpbmcgcmVhc29uIGNsZWFybHkuDQoNCj4gLS0t
LS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBl
LW1haWwuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
