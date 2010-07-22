From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Fix
	compile error when registering a DAI
Date: Thu, 22 Jul 2010 19:43:10 +0900
Message-ID: <AANLkTikm9zVF-eiPZAkAsjcSo-6u_BRYKCROjX3lQUCK@mail.gmail.com>
References: <4C47D3A3.9000102@samsung.com>
	<AANLkTiluZwni88uY6WtwKkB9Qpm2ECz_37z5_bUY1jII@mail.gmail.com>
	<4C47F723.4090506@samsung.com>
	<AANLkTiksuBsdZ7LslGhRqxoDyLry579OxNMJ7X3bhrAb@mail.gmail.com>
	<4C47FBAE.5040106@samsung.com>
	<AANLkTin660THXzF3MXTEMbscB84Axd-roKgZnIfcK1O3@mail.gmail.com>
	<1279793752.3083.40.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E222103992
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 12:43:10 +0200 (CEST)
Received: by wyb42 with SMTP id 42so427356wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 03:43:10 -0700 (PDT)
In-Reply-To: <1279793752.3083.40.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdWwgMjIsIDIwMTAgYXQgNzoxNSBQTSwgTGlhbSBHaXJkd29vZCA8bHJnQHNsaW1s
b2dpYy5jby51az4gd3JvdGU6Cj4gT24gVGh1LCAyMDEwLTA3LTIyIGF0IDE3OjI2ICswOTAwLCBT
ZXVuZ3doYW4gWW91biB3cm90ZToKPj4gPj4+Pj4gKyDCoCDCoCDCoCByZXR1cm4gc25kX3NvY19y
ZWdpc3Rlcl9kYWkoZGV2LCBkcnYpOwo+PiA+Pj4+IEhvdyBhYm91dCBzM2M2NHh4LWkycz8gSSB0
aGluaywgaWYgdGhpcyBwYXRjaCBmaXhlcyBhbGwgZXJyb3JzIGluCj4+ID4+PiBTb3JyeSwgSSBj
b25mdXNlZCB5b3VyIGNvbW1lbnQuCj4+ID4+PiBXaGF0IGRvIHlvdSBtZWFuICJIb3cgYWJvdXQg
czNjNjR4eC1pMnMiID8KPj4gPj4KPj4gPj4gQWN0dWFsbHkgJ3NvdW5kL3NvYy9zM2MyNHh4L3Mz
YzY0eHgtaTJzLmMnIGhhcyBzYW1lIGVycm9yLgo+PiA+Pgo+PiA+PiBTbywgSWYgdGhpcyBwYXRj
aCdzIHB1cnBvc2UgaXMgdG8gZml4IGNvbXBpbGUgZXJyb3IsIG15IG9waW5pb24gaXMKPj4gPj4g
dGhhdCB0aGlzIHBhdGNoIGZpeCBhbGwgdGhlIHNhbWUgZXJyb3JzIGluICdzb3VuZC9zb2MvczNj
MjR4eC8nLgo+PiA+Cj4+ID4gVGhlICdzb3VuZC9zb2MvczNjMjR4eC9zM2M2NHh4LWkycy5jJyBo
YXZlbid0IGRpcmVjdGx5IGNhbGxlZAo+PiA+ICdzbmRfc29jX3JlZ2lzdGVyX2RhaSgpJyBmdW5j
dGlvbi4KPj4gPiBJdCBpcyBjYWxsICdzM2NfaTJzdjJfcmVnaXN0ZXJfZGFpKCknIGluICdzb3Vu
ZC9zb2MvczNjMjR4eC9zM2MtaTJzLXYyLmMnCj4+ID4gdG8gcmVnaXN0ZXIgYSBEQUkuCj4+ID4K
Pj4KPj4gT2gsIEkgd2FzIGNvbmZ1c2VkIGFib3V0IHRoaXMgZXZlbiBJIG1vZGlmeSB0aGlzIGZl
dyBkYXlzIGFnby4KPj4gSSdtIHNvcnJ5IHRoYXQgSSBtYWtlIHlvdSB0byBiZSBjb25mdXNlZC4K
Pj4KPgo+IEknbSBjb25mdXNlZCB0b28gOykKPgo+IElzIHRoaXMgdG8gYmUgYXBwbGllZCBvciBu
b3QgPwoKSSB0aGluayB0aGlzIG9rYXkuIDopCgo+Cj4gTGlhbQo+IC0tCj4gRnJlZWxhbmNlIERl
dmVsb3BlciwgU2xpbUxvZ2ljIEx0ZAo+IEFTb0MgYW5kIFZvbHRhZ2UgUmVndWxhdG9yIE1haW50
YWluZXIuCj4gaHR0cDovL3d3dy5zbGltbG9naWMuY28udWsKPgo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
