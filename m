From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH][alsa-lib] topology: fix
	unused-const-variable warning
Date: Fri, 23 Dec 2016 08:49:24 +0000
Message-ID: <1482482964.24233.51.camel@loki>
References: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
 <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9410D2606F7
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 09:49:32 +0100 (CET)
In-Reply-To: <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "mengdong.lin" <mengdong.lin@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBsb29rcyBmaW5lIGJ5IG1lLCBNZW5nZG9uZyBpcyB0aGlzIHN0aWxsIHVudXNlZCBvciBp
cyBpdCBuZWVkZWQgYnkKYSBmdXR1cmUgcGF0Y2ggPwoKT24gU2F0LCAyMDE2LTEyLTE3IGF0IDA5
OjM5ICswOTAwLCBUYWthc2hpIFNha2Ftb3RvIHdyb3RlOgo+IFBpbmcgdG8gTGlhbS4gSSB3aXNo
IHRoaXMgcGF0Y2ggd291bGQgYmUgaW5jbHVkZWQgdG8gbmV4dCByZWxlYXNlIG9mCj4gdGhpcyBs
aWJyYXJ5Lgo+IAo+IE9uIDIwMTblubQxMeaciDMw5pelIDAwOjQ0LCBUYWthc2hpIFNha2Ftb3Rv
IHdyb3RlOgo+ID4gTGFzdCB5ZWFyLCB1bnVzZWQgc3RhdGljIGNvbnN0IHZhcmlhYmxlIHdhcyBh
ZGRlZCwgdGhlbiBjb21waWxlciBnZW5lcmF0ZXMKPiA+IGEgYmVsb3cgd2FybmluZy4KPiA+IAo+
ID4gZGFwbS5jOjQzOjMwOiB3YXJuaW5nOiDigJh3aWRnZXRfY29udHJvbF9tYXDigJkgZGVmaW5l
ZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiA+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG1hcF9lbGVtIHdpZGdldF9jb250cm9sX21hcFtdID0gewo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAKPiA+IFRoaXMgY29t
bWl0IHJlbW92ZXMgaXQuCj4gPiAKPiA+IEZpeGVzOiAwMWEwZTFhMWMyMTkgKCJ0b3BvbG9neTog
QWRkIERBUE0gb2JqZWN0IHBhcnNlciIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFNha2Ft
b3RvIDxvLXRha2FzaGlAc2FrYW1vY2NoaS5qcD4KPiA+IC0tLQo+ID4gIHNyYy90b3BvbG9neS9k
YXBtLmMgfCA4IC0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggZGVsZXRpb25zKC0pCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS9zcmMvdG9wb2xvZ3kvZGFwbS5jIGIvc3JjL3RvcG9sb2d5L2Rh
cG0uYwo+ID4gaW5kZXggZTgzMDc1MS4uOGM1ODVhNyAxMDA2NDQKPiA+IC0tLSBhL3NyYy90b3Bv
bG9neS9kYXBtLmMKPiA+ICsrKyBiL3NyYy90b3BvbG9neS9kYXBtLmMKPiA+IEBAIC0zOSwxNCAr
MzksNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1hcF9lbGVtIHdpZGdldF9tYXBbXSA9IHsKPiA+
ICAJeyJkYWlfbGluayIsIFNORF9TT0NfVFBMR19EQVBNX0RBSV9MSU5LfSwKPiA+ICB9Owo+ID4g
IAo+ID4gLS8qIG1hcHBpbmcgb2Ygd2lkZ2V0IGtjb250cm9sIHRleHQgbmFtZXMgdG8gdHlwZXMg
Ki8KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG1hcF9lbGVtIHdpZGdldF9jb250cm9sX21hcFtd
ID0gewo+ID4gLQl7InZvbHN3IiwgU05EX1NPQ19UUExHX0RBUE1fQ1RMX1ZPTFNXfSwKPiA+IC0J
eyJlbnVtX2RvdWJsZSIsIFNORF9TT0NfVFBMR19EQVBNX0NUTF9FTlVNX0RPVUJMRX0sCj4gPiAt
CXsiZW51bV92aXJ0IiwgU05EX1NPQ19UUExHX0RBUE1fQ1RMX0VOVU1fVklSVH0sCj4gPiAtCXsi
ZW51bV92YWx1ZSIsIFNORF9TT0NfVFBMR19EQVBNX0NUTF9FTlVNX1ZBTFVFfSwKPiA+IC19Owo+
ID4gLQo+ID4gIHN0YXRpYyBpbnQgbG9va3VwX3dpZGdldChjb25zdCBjaGFyICp3KQo+ID4gIHsK
PiA+ICAJdW5zaWduZWQgaW50IGk7Cj4gPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
