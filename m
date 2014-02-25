From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 10:32:21 +0800
Message-ID: <20140225023219.GA7229@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
 <20140224160648.GC6132@MrMyself>
 <FF523989-CEF7-4A91-92A0-63D5FB90D897@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F4E026538C
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 03:49:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <FF523989-CEF7-4A91-92A0-63D5FB90D897@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBGZWIgMjQsIDIwMTQgYXQgMDQ6MzI6MDZQTSArMDAwMCwgQXVzdGluLCBCcmlhbiB3
cm90ZToKPiAKPiBPbiBGZWIgMjQsIDIwMTQsIGF0IDEwOjA2IEFNLCBOaWNvbGluIENoZW4gPEd1
YW5neXUuQ2hlbkBmcmVlc2NhbGUuY29tPiB3cm90ZToKPiAKPiA+IE9uIE1vbiwgRmViIDI0LCAy
MDE0IGF0IDAzOjUyOjI0UE0gKzAwMDAsIEF1c3RpbiwgQnJpYW4gd3JvdGU6Cj4gPj4+PiArCWlm
ICghSVNfRVJSKGNzNDI4ODgtPmNsaykpCj4gPj4+PiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUo
Y3M0Mjg4OC0+Y2xrKTsKPiA+Pj4gCj4gPj4+IERvZXMgdGhlIGRldmljZSB3b3JrIHdpdGhvdXQg
TUNMSz8KPiA+PiBZZXMsIE1DTEsgaXMgcmVxdWlyZWQuIElmIHlvdSBjYW7igJl0IGdldCB0aGUg
Y2xvY2sgeW91IHNob3VsZCBlcnJvciBvdXQuCj4gPiAKPiA+IFdhaXQuLi5SZWdhcmRpbmcgdGhp
cyBjbG9jayBwYXJ0LCBJIGp1c3QgZm9yZ290IHRoZSByZWFzb24gSSBwdXQgdGhlIGNvZGU6Cj4g
PiAKPiA+IDM4NSAgICAgICAgIGNzNDI4ODgtPmNsayA9IGRldm1fY2xrX2dldCgmaTJjLT5kZXYs
ICJtY2xrIik7Cj4gPiAzODYgICAgICAgICBpZiAoSVNfRVJSKGNzNDI4ODgtPmNsaykpCj4gPiAz
ODcgICAgICAgICAgICAgICAgIGRldl93YXJuKCZpMmMtPmRldiwgImZhaWxlZCB0byBnZXQgdGhl
IGNsb2NrOiAlbGRcbiIsCj4gPiAzODggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQ
VFJfRVJSKGNzNDI4ODgtPmNsaykpOwo+ID4gCj4gPiB3YXMgYmVjYXVzZSB0aGUgTUNMSyBtaWdo
dCBiZSBwcm92aWRlZCBmcm9tIFNvQyAoREFJIG1hc3Rlcikgc28gaXQgY291bGQKPiA+IGJlIHRv
dGFsbHkgY29udHJvbGxlZCBieSBDUFUgREFJIGRyaXZlciwgRVNBSSBmb3IgZXhhbXBsZSBoYXMg
aXRzIG93bgo+ID4gZGl2aWRlcnMgdG8gZGVyaXZlIHRoZSBIQ0tUIGNsb2NrIChNQ0xLIGZvciBU
eCkgZnJvbSBhaGIgY2xvY2sgaW4gU29DCj4gPiBjbG9jayB0cmVlLCBpbiB3aGljaCBjYXNlIHdl
IG1pZ2h0IG5vdCBlYXNpbHkgcGFzcyBhIHZhbGlkIGNsb2NrIHBoYW5kbGUKPiA+IHZpYSBEVC4g
KFJGQyB0byB0aGlzIHRob3VnaHQuKQo+IE9LLCBJdOKAmXMgYW4gZXh0ZXJuYWwgTUNMSyBzb3Vy
Y2UsIHNvIHdoeSBub3QganVzdCBoYW5kbGUgdGhhdCBpbiB0aGUgbWFjaGluZSBkcml2ZXI/IAo+
IFVzdWFsbHkgeW91IHdvdWxkIHdhbnQgdGhlIGNsb2NrIGVuYWJsZWQvZGlzYWJsZWQgaW4gdGhl
IG1hY2hpbmUgZHJpdmVyIHNvIGlmIHlvdSBkb27igJl0IGdldCBpdCwgeW91IGNhbiBiYWlsIG91
dCB0aGVyZS4gCj4gQXQgbGVhc3QgdGhhdCBpcyBob3cgSSBkbyBvdXIgTUNMS+KAmXMuIFNpbmNl
IHlvdSBhcmUgb25seSB1c2luZyB0aGUgZnJlcSBvZiB0aGUgY2xvY2sgdG8gZGVyaXZlIG1vZGVz
LCBqdXN0IHB1dCB0aGUgY2xvY2sgaW5pdGlhbGl6YXRpb24gb3V0c2lkZSBhbmQganVzdCBwYXNz
IGluIHRoZSBmcmVxIGxpa2UgeW91IGRvIGluIHNldF9zeXNjbGsKCkxldHRpbmcgY29kZWMgaGFu
ZGxlIHRoZSBjbG9jayBoZXJlIGlzIHRyeWluZyB0byBlbi9kaXNhYmxlIGl0IG9ubHkgd2hlbiB1
c2luZwppdCAtLSBwbV9ydW50aW1lX3Jlc3VtZS9zdXNwZW5kKCkgc28gdGhhdCB3ZSBjYW4gc2F2
ZSBwb3dlciBkdXJpbmcgaWRsZSBzdGF0ZXMsCndoaWxlIHB1dHRpbmcgaXQgaW50byBtYWNoaW5l
IGRyaXZlciwgcXVpdGUgY29tbW9uIGluIGxvdHMgb2YgbWFjaGluZSBkcml2ZXJzCnRob3VnaCwg
d291bGQgbmVlZCB1cyB0byBlbmFibGUgaXQgaW4gdGhlIHByb2JlKCksIG90aGVyd2lzZSBtYWNo
aW5lIGRyaXZlcgpjYW4ndCBmaW5pc2ggdGhlIGNsb2NrIGVuYWJsaW5nIGJlZm9yZSBjb2RlYyBk
cml2ZXIncyBwbV9ydW50aW1lX3Jlc3VtZSgpIGFzCnBtX3J1bnRpbWVfZ2V0X3N5bmMoY29kZWNf
ZGFpLT5kZXYpIGlzIGFsbW9zdCB0aGUgaGVhZCBvZiBzb2NfcGNtX29wZW4oKS4KCkF0IGZpcnN0
IHBsYWNlLCBJIGRpZCBsZXQgdGhpcyBjb2RlYyBkcml2ZXIgYmUgdG90YWxseSBleGVtcHQgZnJv
bSB0aGlzIGNsb2NrCmhhbmRsaW5nLiBBbmQgaXQncyBxdWl0ZSBmYWlyIGFuZCBuZWF0IHRvIGRv
IHRoYXQgaW4gdGhlIG1hY2hpbmUgZHJpdmVyIHRpbGwKdGhpcyBzZWNvbmQgdGhvdWdodCBjYW1l
IHRvIG1lLi4uLgoKVGhhbmsgeW91LApOaWNvbGluIENoZW4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
