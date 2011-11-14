From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: alc5632: rename volume/switch
 contols for master and speaker volumes.
Date: Mon, 14 Nov 2011 23:50:05 +0200
Message-ID: <CALq1K=+gUXnt0q4TxpUOhZFmdnHd+jdnkMpbj0JpF7_BkpCiDg@mail.gmail.com>
References: <1321213993-27920-1-git-send-email-leon@leon.nu>
	<20111114213915.GH6528@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7ED8B24411
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:50:26 +0100 (CET)
Received: by wyg36 with SMTP id 36so4018384wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 13:50:26 -0800 (PST)
In-Reply-To: <20111114213915.GH6528@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBOb3YgMTQsIDIwMTEgYXQgMjM6MzksIE1hcmsgQnJvd24KPGJyb29uaWVAb3BlbnNv
dXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBTdW4sIE5vdiAxMywgMjAxMSBhdCAw
OTo1MzoxM1BNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6Cj4KPj4gLSDCoCDCoCBTT0Nf
RE9VQkxFX1RMVigiTGluZSBQbGF5YmFjayBWb2x1bWUiLAo+PiArIMKgIMKgIFNPQ19ET1VCTEVf
VExWKCJTcGVha2VyIFBsYXliYWNrIFZvbHVtZSIsCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIEFMQzU2MzJfU1BLX09VVF9WT0wsIDgsIDAsIDMxLCAxLCBocF90bHYpLAo+Cj4g
VGhpcyBsb29rcyByZWFsbHkgc3VzcGljaW91cywgd2h5IGFyZSB3ZSByZW5hbWluZyB0aGUgbGlu
ZSBvdXRwdXQgYXMgYQo+IHNwZWFrZXIgb3V0cHV0PyDCoFRoaXMgbWlnaHQgYmUgYXBwcm9wcmlh
dGUgb24geW91ciBib2FyZCBidXQgaWYgdGhlCj4gZHJpdmVycyBhcmVuJ3QgcGFydCBvZiB0aGUg
Q09ERUMgaXQgbWlnaHQgbm90IGJlIGFwcHJvcHJpYXRlIG9uIGFub3RoZXIKPiBib2FyZC4KVGhl
cmUgYXJlIHR3byBtYWluIHJlYXNvbnM6CjEpIFdlIGFyZSBjaGFuZ2luZyBTUEtfT1VUX1ZPTCB3
aGljaCBvbiB0aGUgc2NoZW1hdGljcyBtYXJrZWQgYXMgYQpzcGVha2VyLCBhbmQgd2Ugd2FudCB0
byBiZSBhcyBjbG9zZSBhcyBwb3NzaWJsZSB0byB0aGUgZGF0YXNoZWV0LgoyKSBXZSBhcmUgdGly
ZWQgdG8gZXhwbGFpbiB0byB1c2VycyB0aGF0IHRoZSBzcGVha2VyIHZvbHVtZSBjb250cm9sbGVk
CmJ5ICJMaW5lIFBsYXliYWNrIFZvbHVtZSIgaW4gYWxzYW1peGVyLgoKPgo+PiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBBTEM1NjMyX0xJTkVfSU5fVk9MLCA4LCAwLCAzMSwgMSwg
dm9sX3RsdiksCj4+IC0gwqAgwqAgU09DX0RPVUJMRV9UTFYoIlN0ZXJlbyBEQUMgUGxheWJhY2sg
Vm9sdW1lIiwKPj4gKyDCoCDCoCBTT0NfRE9VQkxFX1RMVigiTWFzdGVyIFBsYXliYWNrIFZvbHVt
ZSIsCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFMQzU2MzJfU1RFUkVPX0RB
Q19JTl9WT0wsIDgsIDAsIDYzLCAxLCB2ZGFjX3RsdiksCj4+IC0gwqAgwqAgU09DX0RPVUJMRSgi
U3RlcmVvIERBQyBQbGF5YmFjayBTd2l0Y2giLAo+PiArIMKgIMKgIFNPQ19ET1VCTEUoIk1hc3Rl
ciBQbGF5YmFjayBTd2l0Y2giLAo+Cj4gVGhpcyBsb29rcyBmaW5lLgo+CgoKCi0tIApMZW9uIFJv
bWFub3Zza3kgfCBJbmRlcGVuZGVudCBMaW51eCBDb25zdWx0YW50CsKgIMKgIMKgIMKgwqB3d3cu
bGVvbi5udcKgfCBsZW9uQGxlb24ubnUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
