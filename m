From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 00:06:49 +0800
Message-ID: <20140224160648.GC6132@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 59145261A22
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 17:18:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
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

T24gTW9uLCBGZWIgMjQsIDIwMTQgYXQgMDM6NTI6MjRQTSArMDAwMCwgQXVzdGluLCBCcmlhbiB3
cm90ZToKPiA+PiArCWlmICghSVNfRVJSKGNzNDI4ODgtPmNsaykpCj4gPj4gKwkJY2xrX2Rpc2Fi
bGVfdW5wcmVwYXJlKGNzNDI4ODgtPmNsayk7Cj4gPiAKPiA+IERvZXMgdGhlIGRldmljZSB3b3Jr
IHdpdGhvdXQgTUNMSz8KPiBZZXMsIE1DTEsgaXMgcmVxdWlyZWQuIElmIHlvdSBjYW7igJl0IGdl
dCB0aGUgY2xvY2sgeW91IHNob3VsZCBlcnJvciBvdXQuCgpXYWl0Li4uUmVnYXJkaW5nIHRoaXMg
Y2xvY2sgcGFydCwgSSBqdXN0IGZvcmdvdCB0aGUgcmVhc29uIEkgcHV0IHRoZSBjb2RlOgoKMzg1
ICAgICAgICAgY3M0Mjg4OC0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZpMmMtPmRldiwgIm1jbGsiKTsK
Mzg2ICAgICAgICAgaWYgKElTX0VSUihjczQyODg4LT5jbGspKQozODcgICAgICAgICAgICAgICAg
IGRldl93YXJuKCZpMmMtPmRldiwgImZhaWxlZCB0byBnZXQgdGhlIGNsb2NrOiAlbGRcbiIsCjM4
OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBUUl9FUlIoY3M0Mjg4OC0+Y2xrKSk7
Cgp3YXMgYmVjYXVzZSB0aGUgTUNMSyBtaWdodCBiZSBwcm92aWRlZCBmcm9tIFNvQyAoREFJIG1h
c3Rlcikgc28gaXQgY291bGQKYmUgdG90YWxseSBjb250cm9sbGVkIGJ5IENQVSBEQUkgZHJpdmVy
LCBFU0FJIGZvciBleGFtcGxlIGhhcyBpdHMgb3duCmRpdmlkZXJzIHRvIGRlcml2ZSB0aGUgSENL
VCBjbG9jayAoTUNMSyBmb3IgVHgpIGZyb20gYWhiIGNsb2NrIGluIFNvQwpjbG9jayB0cmVlLCBp
biB3aGljaCBjYXNlIHdlIG1pZ2h0IG5vdCBlYXNpbHkgcGFzcyBhIHZhbGlkIGNsb2NrIHBoYW5k
bGUKdmlhIERULiAoUkZDIHRvIHRoaXMgdGhvdWdodC4pCgpUaGFuayB5b3UsCk5pY29saW4gQ2hl
bgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
