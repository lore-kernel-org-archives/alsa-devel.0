From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 00/10] ASoC: sta32x: Add device tree binding
Date: Thu, 22 Jan 2015 14:12:57 +0100
Message-ID: <54C0F759.9070301@zonque.org>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
 <54C0F5AE.7060702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 838E12651CE
 for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2015 14:12:59 +0100 (CET)
In-Reply-To: <54C0F5AE.7060702@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7w=?= =?UTF-8?B?bQ==?= <niederp@physik.uni-kl.de>, broonie@kernel.org, zonque@gmail.com, brandau@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDEvMjIvMjAxNSAwMjowNSBQTSwgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOgo+IE9uIDAx
LzIyLzIwMTUgMTI6MDEgQU0sIFRob21hcyBOaWVkZXJwcsO8bSB3cm90ZToKPj4gVGhpcyBwYXRj
aHNldCBpcyB0aGUgcmVzdWx0IG9mIGNvbXBhcmluZyB0aGUgc3RhMzJ4IGRyaXZlciB3aXRoIHRo
ZSBzdGEzNTAKPj4gZHJpdmVyIHdpdGggdGhlIGdvYWwgdG8gbWFrZSB0aGUgc3RhMzJ4IGRyaXZl
ciBkZXZpY2UgdHJlZSBjYXBhYmxlLiBJbiB0aGUKPj4gbWVyZ2luZyBwcm9jZXNzIHRoZSBjb2Rp
bmcgc3R5bGUgb2YgdGhlIHN0YTM1MCBkcml2ZXIgd2FzIGFkb3B0ZWQgc2luY2UgaXQKPj4gc2Vl
bWVkIG1vcmUgdXAgdG8gZGF0ZS4gSSBkaWQgbXkgYmVzdCB0byBicmVhayB1cCB0aGUgY2hhbmdl
cyBpbiBsb2dpY2FsCj4+IGNodW5rcy4gQWRkaXRpb25hbGx5IHNvbWUgc21hbGwgZml4ZXMgd2Vy
ZSBhZGRlZC4KPj4KPj4gVGhlIGNvbXBhcmlzb24gd2l0aCB0aGUgc3RhMzUwIGxlYWQgdG8gdGhl
IGZvbGxvd2luZyBjaGFuZ2VzOgo+PiAtIFN3aXRjaCB0byBkaXJlY3QgdXNhZ2Ugb2YgdGhlIHJl
Z21hcCBBUEkKPj4gLSBVc2UgdGhlIGtlcm5lbCBncGlvIGZyYW1ld29yayB0byBjb250cm9sIHRo
ZSByZXNldCBwaW4gb2YgdGhlIHN0YTMyeAo+PiAtIGFkb3B0IGNhbGN1bGF0aW9uIG9mIG1sY2sg
ZGl2aWRlciBhbmQgZXh0cmFwb2xhdGlvbiByYXRpbyBmcm9tIHN0YTM1MAo+PiAtIGFkZCBkZXZp
Y2UgdHJlZSBiaW5kaW5ncwo+PiAtIENoYW5nZSB0aGUgQ29kZWNzIERBSSBuYW1lIHRvIGJlIGNv
aGVyZW50IHdpdGggdGhlIHN0YTM1MCBkcml2ZXIKPj4KPj4gTW9yZW92ZXIgc29tZSBtaW5vciBm
aXhlcyB3ZXJlIGFkZGVkOgo+PiAtIEFkZCB0aGUgc3RhdHVzIHJlZ2lzdGVyCj4+IC0gRml4IGJp
dCBzaGlmdCB2YWx1ZSBmb3IgdGhlIElERSBiaXQgaW4gdGhlIENPTkZGIHJlZ2lzdGVyCj4+IC0g
QWRkIGRlc2NyaXB0aW9uIGZvciB0aGUgZHJpdmVyIGFuZCBJMkMgZGVwZW5kZW5jeSBpbiBLY29u
ZmlnCj4+Cj4gCj4gR29vZCBzdHVmZi4KCkp1cCwgbG9va3MgYWxsIGdvb2QgdG8gbWUsIHRvby4g
VGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMuCgo+IERvIHlvdSB0aGluayB3ZSBjYW4gYWN0dWFs
bHkgbWVyZ2UgdGhlIHRoZSB0d28gZHJpdmVycyBpbnRvIG9uZS4gVGhleSBzZWVtIAo+IHRvIGJl
IDkwJSBsaW5lLWJ5LWxpbmUgaWRlbnRpY2FsLgoKVGhhdCBjb3VsZCB3b3JrLCB5ZXMsIGJ1dCBp
dCdzIG5vdCBzdHJhaWdodCBmb3J3YXJkLiBXaGVuIEkgY29tcGFyZWQgdGhlCnJlZ2lzdGVyIHNl
dHMgc29tZSBtb250aHMgYWdvLCB0aGV5IHNlZW0gdG8gcmVzZW1ibGUgbGFyZ2VseSwgYnV0IHRo
ZXJlCndlcmUgbG90cyBvZiBzdWJ0bGUgZGlmZmVyZW5jZXMuIEFsbCBvZiB0aGVtIHdvdWxkIG5l
ZWQgdG8gYmUgaGFuZGxlZCBhdApydW50aW1lLgoKSSB0aGluayB0aGUgb25seSB3YXkgdG8gZmln
dXJlIHdoZXRoZXIgaXQncyB3b3J0aCBpdCBpcyB0byBkbyB0aGUgbWVyZ2UKYW5kIGhhdmUgYSBs
b29rIDopCgoKRGFuaWVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
