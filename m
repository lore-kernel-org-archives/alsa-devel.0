From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 12:04:03 +0300
Message-ID: <1504170243.25945.170.camel@linux.intel.com>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
 <alpine.DEB.2.20.1708311020340.3243@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E3031267256
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:04:11 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.20.1708311020340.3243@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, garsilva@embeddedor.com, kernel-janitors@vger.kernel.org, nicolas.ferre@microchip.com, tiwai@suse.com, broonie@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, arvind.yadav.cs@gmail.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAyMDE3LTA4LTMxIGF0IDEwOjIzICswMjAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4g
Cj4gT24gVGh1LCAzMSBBdWcgMjAxNywgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6Cj4gCj4gPiBP
biAzMS8wOC8yMDE3IGF0IDA2OjQwOjQyICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6
Cj4gPiA+IElmICdjbGtfcHJlcGFyZV9lbmFibGUoKScgZmFpbHMsIHdlIG11c3QgcmVsZWFzZSBz
b21lIHJlc291cmNlcwo+ID4gPiBiZWZvcmUKPiA+ID4gcmV0dXJuaW5nLiBBZGQgYSBuZXcgbGFi
ZWwgaW4gdGhlIGV4aXN0aW5nIGVycm9yIGhhbmRsaW5nIHBhdGggYW5kCj4gPiA+ICdnb3RvJwo+
ID4gPiB0aGVyZS4KPiA+ID4gCj4gPiA+IEZpeGVzOiAyNjBlYTk1Y2MwMjcgKCJBU29DOiBhdG1l
bDogYWM5N2M6IEhhbmRsZSByZXR1cm4gdmFsdWUgb2YKPiA+ID4gY2xrX3ByZXBhcmVfZW5hYmxl
LiIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5q
YWlsbGV0QHdhbmFkb28uZnI+Cj4gPiAKPiA+IEFuZCBoZXJlIGlzIHRoZSBmYWxsb3V0IG9mIHRo
ZSBzdHVwaWQsIGJyYWlubGVzcyAiZml4aW5nIiBvZiBpc3N1ZXMKPiA+IHJlcG9ydGVkIGJ5IHN0
YXRpYyBhbmFseXNpcyB0b29scy4KPiA+IAo+ID4gVGhpcyBjbGtfcHJlcGFyZV9lbmFibGUgd2ls
bCBuZXZlciBmYWlsLiBJZiBpdCB3YXMgZ29pbmcgdG8gZmFpbCwKPiA+IHRoZQo+ID4gcGxhdGZv
cm0gd291bGQgbmV2ZXIgYm9vdCB0byBhIHBvaW50IHdlcmUgaXQgaXMgYWJsZSB0byBleGVjdXRl
IHRoYXQKPiA+IGNvZGUuIEl0IGlzIHJlYWxseSBhbm5veWluZyB0byBoYXZlIHNvIG11Y2ggY2h1
cm4gZm9yIGFic29sdXRlbHkgMAo+ID4gYmVuZWZpdC4KPiAKPiBXb3VsZCBpdCBiZSBtb3JlIHBy
b2R1Y3RpdmUgdG8gcHV0IHRoZSBjb2RlIGJhY2sgbGlrZSBpdCB3YXMgYmVmb3JlLAo+IGllIG5v
Cj4gcmV0dXJuIHZhbHVlIGFuZCBubyBjaGVjaywgYW5kIGFkZCBhIGNvbW1lbnQgdG8gdGhlIGRl
ZmluaXRpb24gb2YKPiBjbGtfcHJlcGFyZV9lbmFibGUgaW5kaWNhdGluZyB0aGF0IHRoZXJlIGFy
ZSBtYW55IGNhc2Ugd2hlcmUgdGhlIGNhbGwKPiBjYW5ub3QgZmFpbD/CoMKgR3JlcHBpbmcgdGhy
b3VnaCB0aGUgY29kZSBzdWdnZXN0cyB0aGF0IGl0IGlzIGFib3V0IDUwLQo+IDUwIG9uCj4gY2hl
Y2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvciBub3QgZG9pbmcgc28sIHdoaWNoIG1pZ2h0IHN1Z2dl
c3QgdGhhdAo+IGNoZWNraW5nIHRoZSB2YWx1ZSBpcyBvZnRlbiBub3QgcmVxdWlyZWQuCgpJIGRp
ZG4ndCBsb29rIGludG8gdGhlIGNvZGUsIHRob3VnaCBzcGVjdWxhdGluZyBpdCBtaWdodCBiZSB0
aGUgY2FzZQp3aGVuIENMSyBmcmFtZXdvcmsgaXMgbm90IGVuYWJsZWQsIHRob3VnaCBtYW55IGRy
aXZlcnMgYXJlIGRlcGVuZGVudCB0bwppdCwgc28sIGl0IHdvdWxkIG5ldmVyIGZhaWwgaW4gc3Vj
aCBjYXNlcy4gTmV2ZXJ0aGVsZXNzIHRoZXJlIG1pZ2h0IGJlCm90aGVyIGNhc2VzIGZvciBDTEsg
QVBJIHRvIGZhaWwuCgotLSAKQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+CkludGVsIEZpbmxhbmQgT3kKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
