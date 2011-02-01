From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] ASoC: CX20442: fix NULL pointer dereference
Date: Tue, 1 Feb 2011 14:18:02 +0100
Message-ID: <201102011418.03028.jkrzyszt@tis.icnet.pl>
References: <201102011301.17699.jkrzyszt@tis.icnet.pl>
	<1296562070.4120.3.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id EC290244B5
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 14:19:09 +0100 (CET)
In-Reply-To: <1296562070.4120.3.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

RG5pYSB3dG9yZWsgMDEgbHV0eSAyMDExIG8gMTM6MDc6NTAgRGltaXRyaXMgUGFwYXN0YW1vcyBu
YXBpc2HFgihhKToKPiBPbiBUdWUsIDIwMTEtMDItMDEgYXQgMTM6MDEgKzAxMDAsIEphbnVzeiBL
cnp5c3p0b2ZpayB3cm90ZToKPiA+IFRoZSBDWDIwNDQyIGNvZGVjIGRyaXZlciBuZXZlciBwcm92
aWRlZCB0aGUgc25kX3NvY19jb2RlY19kcml2ZXIncwo+ID4gLnJlZ19jYWNoZV9kZWZhdWx0IG1l
bWJlci4gV2l0aCB0aGUgbGF0ZXN0IEFTb0MgZnJhbWV3b3JrIGNoYW5nZXMsCj4gPiBpdCBzZWVt
cyB0byBiZSByZWZlcnJlZCB1bmNvbmRpdGlvbmFsbHksIHJlc3VsdGluZyBpbiBhIE5VTEwKPiA+
IHBvaW50ZXIgZGVyZWZlcmVuY2UgaWYgbWlzc2luZy4gUHJvdmlkZSBpdC4KPiAKPiBUaGlzIHNo
b3VsZG4ndCBoYXBwZW4gd2l0aCB0aGUgbGF0ZXN0IEFTb0MgYXMgdGhlcmUgaXMgc3VwcG9ydCBm
b3IKPiBOVUxMIGRlZmF1bHQgY2FjaGVzLiAgSW4gcGFydGljdWxhciB0aGUgZm9sbG93aW5nIGNv
ZGUgc2hvdWxkIGJlCj4gdGFraW5nIGNhcmUgb2YgdGhlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZQo+IAo+IGlmIChjb2RlY19kcnYtPnJlZ19jYWNoZV9kZWZhdWx0KSB7Cj4gCWNvZGVjLT5yZWdf
ZGVmX2NvcHkgPSBrbWVtZHVwKC4uLik7Cj4gCWlmICghY29kZWMtPnJlZ19kZWZfY29weSkgewo+
IAkJcmV0ID0gLUVOT01FTTsKPiAJCWdvdG8gZmFpbDsKPiAJfQo+IH0KPiAKPiBJZiB0aGlzIGlz
IG5vdCB3aGF0IHNvYy1jb3JlIGxvb2tzIGxpa2UgZm9yIHlvdSBwbGVhc2UgcHVsbCBicm9vbmll
J3MKPiBsYXRlc3QgZGV2ZWxvcG1lbnQgdHJlZS4KCkZpbmUsIGJ1dCB5b3VyIGZpeCBpcyBzaXR0
aW5nIGluIE1hcmsncyAnZm9yLTIuNi4zOScgYnJhbmNoLCB3aGlsZSB0aGUgCkNYMjA0NDIgY29k
ZWMgZHJpdmVyIChwZXJoYXBzIG5vdCBvbmx5IHRoaXMgb25lKSBoYXMgYmVlbiBicm9rZW4gZm9y
IAoyLjYuMzguCgpNYXJrLCBhcmUgeW91IGdvaW5nIHRvIGNoZXJyeS1waWNrIERpbWl0cmlzJyBm
aXggdG8geW91ciAnZm9yLTIuNi4zOCc/CgpUaGFua3MsCkphbnVzegpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
