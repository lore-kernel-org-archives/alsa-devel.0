From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Fri, 9 Mar 2012 15:25:59 +0200
Message-ID: <CANOLnOM+9M2BTXasnAUqFyYAg03LE0TD266ArYDyxfRsY26QsQ@mail.gmail.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
	<4F59FA9D.8070009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 650AC10410D
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 14:26:01 +0100 (CET)
Received: by iakh37 with SMTP id h37so2593248iak.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 05:25:59 -0800 (PST)
In-Reply-To: <4F59FA9D.8070009@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXIgOSwgMjAxMiBhdCAyOjQyIFBNLCBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpm
YWx1c2lAdGkuY29tPiB3cm90ZToKPiBPbiAwMy8wOS8yMDEyIDAxOjE5IEFNLCBHcmF6dnlkYXMg
SWdub3RhcyB3cm90ZToKPj4gV2l0aCBhIHByb2dyYW0gb3BlcmF0aW5nIGluIG1pbmltdW0gc2l6
ZWQgcGVyaW9kcywgZmlyc3Qgd3JpdGUKPj4gd2lsbCBjYXVzZSBhIHRyYW5zZmVyIHRoYXQgd2ls
bCBmaWxsIG1jYnNwIEZJRk8gcXVpY2tseSwgYW5kIHRoZXJlCj4+IHdpbGwgYmUgbm8gbW9yZSBk
YXRhIHRvIERNQSBiZWZvcmUgcHJvZ3JhbSBtYW5hZ2VzIHRvIGRvIGFub3RoZXIKPj4gd3JpdGUu
IEFzIHRoZSBjb3JlIGNvbnNpZGVycyB0aGlzIGFzIHVuZGVyZmxvdyBjb25kaXRpb24sIHdlIG1h
eQo+PiBnZXQgbWFueSB1bmRlcmZsb3dzIGF0IHRoZSBzdGFydC4KPj4gSW5jcmVhc2UgbWluaW11
bSBwZXJpb2Qgc2l6ZSBieSBoYWxmIHRvIGRlYWwgd2l0aCB0aGlzIHByb2JsZW0uCj4KPiBOb3Qg
ZW50aXJlbHkgc3VyZSBhYm91dCB0aGUgbGFzdCB0d28gcGF0Y2guLi4KPiBUaGUgaW1wbGljYXRp
b25zIHdpbGwgYmUgYmlnIGZvciBleGlzdGluZyB1c2VyIHNwYWNlIHNpbmNlIHdlIGFyZSBnb2lu
Zwo+IHRvIGxpbWl0IHRoZSBwZXJpb2Qgc2l6ZSBpbiB0aGlzIHdheSAob24gT01BUDMgTWNCU1Ay
KToKPiA0OEsgc3RlcmVvOiAyMG1zIG1pbgo+IDQ0LjFLIHN0ZXJlbzogMjEuNzY4bXMgbWluCj4g
OEsgc3RlcmVvOiAxMjBtcyBtaW4KPiA4SyBtb25vOiAyNDBtcyBtaW4KPgo+IEFzIEkgcmVjYWxs
IG45MDAgKCsgTWVlR28pIHVzZXMgNW1zIHBlcmlvZCBzaXplcyBpbiBjYWxsIGNhc2VzIG9uIE1j
QlNQMi4KCkkgd291bGQgZ3Vlc3MgdGhleSBhcmUgdXNpbmcgc29tZXRoaW5nIGxhcmdlciwgYXQg
bGVhc3QgbGFyZ2VyIHdyaXRlCnF1YW50aXRpZXMgd2l0aCB0aGlzIGtpbmQgb2YgcGVyaW9kLCBv
dGhlcndpc2UgaXQgd291bGQga2VlcApvdmVyZmxvd2luZyB0aGVyZSB0b28uCgo+IFNvIEknbSBh
IGJpdCByZWx1Y3RhbnQgdG8gYWNrIHRoZXNlIChpdCBpcyBub3QgYW4gaXNzdWUgb24gb3RoZXIg
TWNCU1AKPiBwb3J0cywgYW5kIG9uIE9NQVA0LCBidXQgT01BUDMgTWNCU1AyIGlzIHByb2JsZW1h
dGljIElNSE8pLgoKTWF5YmUgd2UgY291bGQgdXNlIE1DQlNQTFBfVEhSU0gyX1JFRyBYVEhSRVNI
T0xEIHRvIGFydGlmaWNpYWxseSBsaW1pdApNQ0JTUDIgZmlmbyBkZXB0aD8KCj4gSmFya2tvOiBX
aGF0IGRvIHlvdSB0aGluaz8KPgo+IElmIHRoaXMgaXMgYSByZWFsIGlzc3VlIGluIFBhbmRvcmEs
IGNvdWxkIGl0IGJlIHNvbHZlZCB3aXRoIGFkZGluZwo+IC9ldGMvYXNvdW5kLmNvbmYgdG8gdGhl
IGZpbGVzeXN0ZW0sIGFuZCBsaW1pdCB0aGUgcGVyaW9kIHNpemUgdmlhIHRoYXQ/CgpXZSBhcmUg
YWxyZWFkeSBkb2luZyB0aGF0LCBob3dldmVyIHdlIGVuY291cmFnZSBwZW9wbGUgdG8gaW5zdGFs
bAp0aGVpciBvd24gZGlzdHJvcyBvbiBwYW5kb3JhLCBhbmQgbm93IHRoZXkgaGF2ZSB0byBkcmFn
IHdob2xlIEFMU0EKY29uZmlndXJhdGlvbiBmb3IgdGhpbmdzIHRvIHdvcmsuIElNSE8gZGV2aWNl
IGRyaXZlciBsaWtlIHRoaXMgbXVzdCBiZQphYmxlIHRvIHdvcmsgd2l0aG91dCBhbnkgc3BlY2lh
bCB1c2Vyc3BhY2UgY29uZmlndXJhdGlvbi4KCgotLSAKR3Jhxb52eWRhcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
