From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH] ASoC: dwc: disallow building
	designware_pcm as a module
Date: Wed, 19 Apr 2017 17:48:15 +0100
Message-ID: <03a3fbbb-7221-f4ee-5b1b-8fff518ea82c@synopsys.com>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
 <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
 <1492618461.28092.18.camel@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay2.synopsys.com
 [198.182.60.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 982CD266B24
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 18:48:21 +0200 (CEST)
In-Reply-To: <1492618461.28092.18.camel@v3.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lubomir Rintel <lkundrak@v3.sk>, Jose Abreu <Jose.Abreu@synopsys.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

CgpPbiAxOS0wNC0yMDE3IDE3OjE0LCBMdWJvbWlyIFJpbnRlbCB3cm90ZToKPiBPbiBXZWQsIDIw
MTctMDQtMTkgYXQgMTc6MTIgKzAxMDAsIEpvc2UgQWJyZXUgd3JvdGU6Cj4+IEhpIEx1Ym9taXIs
Cj4+Cj4+Cj4+IE9uIDE4LTA0LTIwMTcgMTg6MTUsIE1hcmsgQnJvd24gd3JvdGU6Cj4+PiBPbiBU
dWUsIEFwciAxOCwgMjAxNyBhdCAwNjoxMzozMFBNICswMjAwLCBMdWJvbWlyIFJpbnRlbCB3cm90
ZToKPj4+Cj4+Pj4gSSBkb24ndCB0aGluayBkZXNpZ253YXJlX3BjbSBpcyBhIHNlcGFyYXRlIGRy
aXZlci4gSXQgbG9va3MKPj4+PiB0aWdodGx5Cj4+Pj4gY291cGxlZCB3aXRoIGRlc2lnbndhcmVf
aTJzOiB5b3UgY2FuIGVpdGhlciBkaXNhYmxlCj4+Pj4gZGVzaWdud2FyZV9wY20KPj4+PiBhbHRv
Z2V0aGVyIGF0IGJ1aWxkIHRpbWUgb3IgYWx3YXlzIGxvYWQgaXQgdG9nZXRoZXIgd2l0aAo+Pj4+
IGRlc2lnbndhcmVfaTJzLgo+Pj4gWWVzLCB0aGV5J3JlIGNsb3NlbHkgY291cGxlZCBidXQgd2Ug
bWlnaHQgc3RpbGwgd2FudCB0aGVtIGJvdGggYXMgYQo+Pj4gbW9kdWxlLgo+PiBUaGFua3MgZm9y
IHRoZSBwYXRjaCBidXQgSSBhZ3JlZSB3aXRoIE1hcmsuCj4+Cj4+IEZvciB0aGUgcmVjb3JkIHlv
dSBjYW4gYWRkICJNT0RVTEVfTElDRU5TRSjigJxEdWFsIE1JVC9HUEzigJ0pIi4KPiBTb3JyeSBp
ZiBJJ20gbWlzc2luZyBzb21ldGhpbmc7IGJ1dCBJIHN0aWxsIGZhaWwgdG8gdW5kZXJzdGFuZCB3
aHkgaXMKPiB0aGF0IGEgZ29vZCBpZGVhLgo+Cj4gV2hhdCBpcyB0aGUgcG9pbnQgb2YgaGF2aW5n
IGEgcGFpciBvZiBtb2R1bGVzIHRoYXQgZGVwZW5kIG9uIGVhY2ggb3RoZXIKPiBhbmQgY2FuIG9u
bHkgYmUgbG9hZGVkIHRvZ2V0aGVyPwoKU29ycnksIEkgZG9uJ3Qga25vdyB3aHkgYnV0IEkgd2Fz
IHRoaW5raW5nIHRoYXQgUENNIG1vZHVsZSB3aWxsCm5vdCBsb2FkIHdoZW4gd2UgaGF2ZSBhIERN
QSBwbGF0Zm9ybSBidXQgaW5kZWVkIGl0IHdpbGwgbG9hZCB0aGUKbW9kdWxlIGJlY2F1c2Ugb2Yg
dGhlIGRlcGVuZGVuY2llcywgZXZlbiB0aG91Z2ggdGhlIHJlZ2lzdGVyCmZ1bmN0aW9uIHdpbGwg
bmV2ZXIgYmUgY2FsbGVkLiBXaXRob3V0IHRoaXMgSSBkb24ndCByZWFsbHkgaGF2ZQphbnl0aGlu
ZyBhZ2FpbnN0IHRoZSBwYXRjaC4KCldoYXQgZG8geW91IHRoaW5rIE1hcms/IElmIHlvdSB3YW50
IHRvIGtlZXAgdGhlIFBDTSBhcyBhIG1vZHVsZQp0aGVuIHdlIHdpbGwgbmVlZCB0byBhYnN0cmFj
dCB0aGlzIG1vcmUsIGJ5IHJlZHVjaW5nIHRoZQpkZXBlbmRlbmNpZXMuCgpCZXN0IHJlZ2FyZHMs
Ckpvc2UgTWlndWVsIEFicmV1Cgo+Cj4+IEJlc3QgcmVnYXJkcywKPj4gSm9zZSBNaWd1ZWwgQWJy
ZXUKPiBMdWJvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
