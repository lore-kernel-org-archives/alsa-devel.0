From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Remove NEO1973(GTA01) audio
	driver
Date: Fri, 7 Jan 2011 09:50:54 +0900
Message-ID: <AANLkTi=wb9LtpUYkNmvn8H9L-pOcoZzU8eMq9P0XyYiZ@mail.gmail.com>
References: <1294273308-25124-1-git-send-email-sw.youn@samsung.com>
	<AANLkTik9u5ETmdbd3MrbJfdqEYguCdVvhA2225Uks2_4@mail.gmail.com>
	<20110106112055.GF746@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D3D243B1
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 01:50:54 +0100 (CET)
Received: by wwe15 with SMTP id 15so16898111wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 16:50:54 -0800 (PST)
In-Reply-To: <20110106112055.GF746@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, jassi.brar@samsung.com, graeme.gregory@wolfsonmicro.com, Jassi Brar <jassisinghbrar@gmail.com>, lrg@slimlogic.co.uk, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKYW4gNiwgMjAxMSBhdCA4OjIwIFBNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBKYW4gMDYsIDIwMTEgYXQg
MTA6MjM6MjBBTSArMDkwMCwgSmFzc2kgQnJhciB3cm90ZToKPj4gT24gVGh1LCBKYW4gNiwgMjAx
MSBhdCA5OjIxIEFNLCBTZXVuZ3doYW4gWW91biA8c3cueW91bkBzYW1zdW5nLmNvbT4gd3JvdGU6
Cj4+ID4gVGhpcyBwYXRjaCByZW1vdmUgdG8gc3VwcG9ydCBORU8xOTczKEdUQTAxKSBhdWRpbyBk
cml2ZXIsIGJlY2F1c2Ugd2UKPj4gPiBkb24ndCBuZWVkIHRvIHN1cHBvcnQgYXVkaW8gZHJpdmVy
IHRoYXQgaXMgbm90IHN1cHBvcnRlZCBpbiBsaW51eCBrZXJuZWwuCj4KPj4gU2VlbXMgdGhlIGJv
YXJkIHN1cHBvcnQgbmV2ZXIgZ290IHN1Ym1pdHRlZCwgdGhvdWdoIEkgc2VlIGEgZmV3IGhpbnRz
IGluIHRoZQo+PiBNTCBhcmNoaXZlcy4gQXNzdW1pbmcgbm8gc3VjaCBjaGFuY2VzIGVpdGhlciBp
biBuZWFyIGZ1dHVyZSwgSSBhbSBmb3IgaXQuCj4KPj4gJ0lmIGFueWJvZHkgaGFzIGFueSBvYmpl
Y3Rpb25zIHNwZWFrIG5vdyBvciBmb3JldmVyIGhvbGQgeW91ciBwZWFjZScgOikKPgo+IEknZCBy
YXRoZXIgaG9sZCBvZmYgb24gdGhpcyAtIHRoZSBPcGVuTW9rbyBndXlzIGFyZSBhY3RpdmVseSB3
b3JraW5nIG9uCj4gdGhpcyAodGhlcmUncyBqdXN0IGEgY291cGxlIG9mIHBlb3BsZSBkb2luZyBp
dCBhcyBhIGhvYmJ5IHByb2plY3QpIGFuZAo+IEknZCByYXRoZXIgbm90IG1ha2UgdGhlaXIgbGl2
ZXMgYW55IGhhcmRlci4gwqBUaGUgbGFzdCB0aW1lIEkgY2hlY2tlZAo+IHRoZXkgaGFkIHJlb3Jn
YW5pc2VkIHRoaW5ncyB0byBtZXJnZSB0aGUgR1RBMDEgYW5kIEdUQTAyIGludG8gYSBzaW5nbGUK
PiBtYWNoaW5lIGRyaXZlci4gwqBQbHVzIEkgaGF2ZSBhIEdUQTAxIChub3QgdGhhdCBJJ3ZlIGFj
dHVhbGx5IHVzZWQgaXQgZm9yCj4geWVhcnMpLgoKT2gsIEkgc2VlLiA6KQoKPgo+IElmIHRoZXJl
J3Mgbm90aGluZyBhcHBlYXJlZCB1cHN0cmVhbSBieSB0aGUgZW5kIG9mIHRoaXMgcmVsZWFzZSBj
eWNsZQo+IHRoYXQgbWlnaHQgYmUgYSBnb29kIHRpbWUgdG8gbG9vayBhdCB0aGlzLgoKT2theSwg
bm8gcHJvYmxlbS4KClRoYW5rcywKQ2xhdWRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
