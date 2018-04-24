From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: improve support for ancient
	firmware for DICE
Date: Tue, 24 Apr 2018 22:35:08 +0900
Message-ID: <a986a5f0-573b-4b87-baef-0d21dff36e6b@sakamocchi.jp>
References: <20180422120759.15579-1-o-takashi@sakamocchi.jp>
 <201804230032.0xnJM97d%fengguang.wu@intel.com> <s5hlgdcrfic.wl-tiwai@suse.de>
 <8c006d95-553e-be2f-ca54-b5663f0a0acc@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 516F32676A6
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:35:12 +0200 (CEST)
In-Reply-To: <8c006d95-553e-be2f-ca54-b5663f0a0acc@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, kbuild test robot <lkp@intel.com>, ffado-devel@lists.sf.net, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

T24gQXByIDI0IDIwMTggMjE6NTcsIFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4gSGksCj4gCj4g
T24gQXByIDI0IDIwMTggMjA6NDksIFRha2FzaGkgSXdhaSB3cm90ZToKPj4gT24gU3VuLCAyMiBB
cHIgMjAxOCAyMDoyNTozNiArMDIwMCwKPj4ga2J1aWxkIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4+Pgo+
Pj4gc3BhcnNlIHdhcm5pbmdzOiAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pCj4+Pgo+Pj4+PiBz
b3VuZC9maXJld2lyZS9kaWNlL2RpY2UtdHJhbnNhY3Rpb24uYzozMzQ6MjE6IHNwYXJzZTogcmVz
dHJpY3RlZCAKPj4+Pj4gX19iZTMyIGRlZ3JhZGVzIHRvIGludGVnZXIKPj4+IMKgwqDCoCBzb3Vu
ZC9maXJld2lyZS9kaWNlL2RpY2UtdHJhbnNhY3Rpb24uYzozMzY6MjE6IHNwYXJzZTogcmVzdHJp
Y3RlZCAKPj4+IF9fYmUzMiBkZWdyYWRlcyB0byBpbnRlZ2VyCj4+Pgo+Pj4gdmltICszMzQgc291
bmQvZmlyZXdpcmUvZGljZS9kaWNlLXRyYW5zYWN0aW9uLmMKPj4gKHNuaXApCj4+PiDCoMKgwqAg
MzMzwqDCoMKgwqDCoMKgwqAgLyogT2xkIGZpcm13YXJlIGRvZXNuJ3Qgc3VwcG9ydCB0aGVzZSBm
aWVsZHMuICovCj4+PiDCoCA+IDMzNMKgwqDCoMKgwqDCoMKgIGlmIChwb2ludGVyc1s3XSA+IDAp
Cj4+PiDCoMKgwqAgMzM1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkaWNlLT5zeW5jX29mZnNldCA9
IGJlMzJfdG9fY3B1KHBvaW50ZXJzWzZdKSAqIDQ7Cj4+PiDCoMKgwqAgMzM2wqDCoMKgwqDCoMKg
wqAgaWYgKHBvaW50ZXJzWzldID4gMCkKPj4+IMKgwqDCoCAzMzfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRpY2UtPnJzcnZfb2Zmc2V0ID0gYmUzMl90b19jcHUocG9pbnRlcnNbOF0pICogNDsKPj4K
Pj4gVGhlIHdhcm5pbmcgbG9va3MgcmVhc29uYWJsZS4KPiAKPiBZZXAuIFRoZSBpbnRlZ2VyIHZh
bHVlIGNhbiBiZSBuZWdhdGl2ZS4KPiAKPj4gQWx0ZXJuYXRpdmVseSwgeW91IGNhbiByZXdyaXRl
IGl0IGFzIGEgbm9uLXplcm8gY2hlY2s6Cj4+IMKgwqDCoMKgaWYgKHBvaW50ZXJzWzddKQo+PiDC
oMKgwqDCoMKgwqDCoCAuLi4uCj4+IFRoZW4gaXQgd291bGQgYmUgT0sgd2l0aG91dCBlbmRpYW4g
Y29udmVyc2lvbi4KPiAKPiBPSy4gSSdsbCByZXBvc3QuCgpJIHJlcG9zdGVkIGl0IG5vdyBhbmQg
aXQncyBibGFzdGVkWzFdLiBQbGVhc2UgZXZhbHVhdGUgYW5kIGFwcGx5IGl0IAppbnN0ZWFkIG9m
IHRoZSBvbmUgd2hpY2ggSSBtaXN0b29rIHRvIHNlbmQuCgoKWzFdIApodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIwMTgtQXByaWwvMTM0OTM2Lmh0
bWwKClRoYW5rcwoKVGFrYXNoaSBTYWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
