From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 11/25] ASoC: Samsung: Add common I2S driver
Date: Fri, 22 Oct 2010 16:39:05 +0900
Message-ID: <AANLkTim_TzmtZq1oPdu9tLvypB5PBdyPNE9Lx0L+d2BW@mail.gmail.com>
References: <1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
	<20101019093550.GA11371@opensource.wolfsonmicro.com>
	<AANLkTimaQ=7Ejgb1jZW4=VGj2-ZV-2wcX6esZwUXsC4a@mail.gmail.com>
	<20101020031333.GH3803@opensource.wolfsonmicro.com>
	<AANLkTi=5i=51=-m3ZhbTOWyQKz8H3oam6V=QfjL1DxhM@mail.gmail.com>
	<20101020040141.GA22078@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BA29103832
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 09:39:09 +0200 (CEST)
Received: by bwz9 with SMTP id 9so1050333bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2010 00:39:06 -0700 (PDT)
In-Reply-To: <20101020040141.GA22078@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBPY3QgMjAsIDIwMTAgYXQgMTowMSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgT2N0IDIwLCAyMDEwIGF0
IDEyOjI3OjQzUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4+IE9uIFdlZCwgT2N0IDIwLCAy
MDEwIGF0IDEyOjEzIFBNLCBNYXJrIEJyb3duCj4KPj4gPiBJZiB3ZSBoYXZlIHNvbWV0aGluZyBp
biB0aGUgZHJpdmVyIGRhdGEgc3RydWN0IHNwZWNpZnlpbmcgdGhlIG1hc2tzIHRvCj4+ID4gdXNl
IHRoZW4gc2V0IHRoZXNlIGF0IHByb2JlIHRpbWUgcmF0aGVyIHRoYW4gaGF2aW5nIHRoZSBpZiBz
dGF0ZW1lbnRzIC0KPj4gPiBwcm9iYWJseSB0aGUgc2FtZSBtYXNrIGNhbiBiZSB1c2VkIGZvciBw
bGF5YmFjayAmIHJlY29yZCBpZiB0aGUKPj4gPiBiaXRmaWVsZHMgYXJlIGxpbmVkIHVwIHNpbWls
YXJseS4gwqBUaGlzIHdvdWxkIHRoZW4gYmU6Cj4KPj4gPiDCoCDCoCDCoCDCoGNvbiB8PSBkYXRh
LT5hY3RpdmVfbWFzazsKPj4gPiDCoCDCoCDCoCDCoGNvbiAmPSB+ZGF0YS0+cGF1c2VfbWFzazsK
Pgo+PiA+IG9yIHNpbWlsYXIsIHBvc3NpYmx5IHdpdGggc29tZSBzaGlmdHMuCj4KPj4gTGV0IG1l
IHNlZSBpZiB0aGUgc3BhY2Ugc2F2ZWQgaXMgd29ydGggdGhlIGNvbXBsaWNhdGlvbi4KPgo+IEkg
d2FzIHRoaW5raW5nIGl0IHNob3VsZCBtYWtlIHNvbWV0aGluZyBzaW1pbGFyIGJ5IG1ha2luZyBp
dCBjbGVhciB0aGF0Cj4gd2UncmUganVzdCBkb2luZyB0aGUgc2FtZSB0aGluZyB0byBhIGRpZmZl
cmVudCBsb2NhdGlvbiByYXRoZXIgdGhhbiBsb3RzCj4gb2YgY29uZGl0aW9uYWwgY29kZSB0byBm
b2xsb3cuCgpJbiB0aGlzIGNhc2UgaXQgZG9lc24ndCBmaXQgdmVyeSBuZWF0bHkuIFNvIEkgYW0g
ZHJvcHBpbmcgdGhlIHN1Z2dlc3Rpb24sIHNvcnJ5LgoKCj4+ID4gSG93IHdvdWxkIHRoZSBpbmRl
eCBiZSB1c2VkIHdpdGggbXVsdGktY29tcG9uZW50Pwo+Cj4+IEZvciBleGFtcGxlLCBwbGVhc2Ug
bG9vayBhdCBbUGF0Y2ggMjMvMjVdCj4KPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBTZWNv
bmRhcnkgaXMgYXQgb2Zmc2V0IE1BWF9JMlMgZnJvbSBQcmltYXJ5ICovCj4+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RyID0gKGNoYXIgKilzbWRrX2RhaVtTRUNfUExBWUJBQ0tdLmNwdV9kYWlf
bmFtZTsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJbc3RybGVuKHN0cikgLSAxXSA9ICcw
JyArIE1BWF9JMlM7Cj4KPiBIcm0sIHNsaWdodGx5IGZpZGRseS4gwqBQZXJoYXBzIHdlIHdhbnQg
YSBmdW5jdGlvbiBwZW9wbGUgY2FuIGNhbGwgd2hpY2gKPiB3aWxsIGdlbmVyYXRlIHRoZSBzZWNv
bmRhcnkgREFJIG5hbWUgZm9yIHlvdT8gwqBNaWdodCBiZSBtb3JlIGRpcmVjdGx5Cj4gd2hhdCBw
ZW9wbGUgd2FudC4KCldlIGFscmVhZHkgaGF2ZSB0byBkZWNpZGUgb24gcGxhdGZvcm1fZGV2aWNl
J3MgaWQgaW4gcHJvYmUgd2hpbGUgY3JlYXRpbmcgdGhlCnNlY29uZGFyeSBkYWkgaW4gQ1BVIGRy
aXZlci4gU28gdGhlcmUgbXVzdCBleGlzdCBhbnkgc3VjaCBwcmVkZWZpbmVkIG9mZnNldCBpbgp0
aGUgY29tbW9uIGRyaXZlci4KU28sIEkgZGVjaWRlZCB0byByZXVzZSB0aGUgc3ltYm9sIGFuZCBz
YXZlIG9uZSBhZGRpdGlvbiB0byB0aGUgQVBJLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
