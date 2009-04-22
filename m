From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: OMAP: Add checking to
 detect	bufferless pcms
Date: Wed, 22 Apr 2009 18:48:00 +0900
Message-ID: <49EEE7D0.8070303@samsung.com>
References: <49EE7962.6080008@samsung.com>
	<bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 4168D2465C
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 11:48:13 +0200 (CEST)
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KIH00DONXW0M8@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 22 Apr 2009 18:48:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KIH00LZ6XW19Q@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 22 Apr 2009 18:48:01 +0900 (KST)
In-reply-to: <bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, kyungmin.park@samsung.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

T24gNC8yMi8yMDA5IDU6MzAgUE0sIEphcmtrbyBOaWt1bGEgd3JvdGU6Cj4gT24gV2VkLCBBcHIg
MjIsIDIwMDkgYXQgNDo1NiBBTSwgSm9vbnlvdW5nIFNoaW0gPGp5MDkyMi5zaGltQHNhbXN1bmcu
Y29tCj4gPG1haWx0bzpqeTA5MjIuc2hpbUBzYW1zdW5nLmNvbT4+IHdyb3RlOgo+IAo+ICAgICBB
ZGQgY2hlY2tpbmcgaW4gaHdfcGFyYW1zIGFuZCBwcmVwYXJlIHRvIGRldGVjdCBidWZmZXJsZXNz
IHBjbXMoaS5lLiBCVAo+ICAgICA8LS0+IGNvZGVjKS4KPiAKPiAgICAgU2lnbmVkLW9mZi1ieTog
Sm9vbnlvdW5nIFNoaW0gPGp5MDkyMi5zaGltQHNhbXN1bmcuY29tCj4gICAgIDxtYWlsdG86ankw
OTIyLnNoaW1Ac2Ftc3VuZy5jb20+Pgo+ICAgICAtLS0KPiAgICAg7J+zb3VuZC9zb2Mvb21hcC9v
bWFwLXBjbS5jIHwgICAgOSArKysrKysrKy0KPiAgICAgIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+IAo+ICAgICBkaWZmIC0tZ2l0IGEvc291bmQvc29j
L29tYXAvb21hcC1wY20uYyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtcGNtLmMKPiAgICAgaW5kZXgg
MDdjZjdmNC4uNjQ1NGUxNSAxMDA2NDQKPiAgICAgLS0tIGEvc291bmQvc29jL29tYXAvb21hcC1w
Y20uYwo+ICAgICArKysgYi9zb3VuZC9zb2Mvb21hcC9vbWFwLXBjbS5jCj4gICAgIEBAIC04Nyw4
ICs4NywxMCBAQCBzdGF0aWMgaW50IG9tYXBfcGNtX2h3X3BhcmFtcyhzdHJ1Y3QKPiAgICAgc25k
X3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKPiAgICAgICAgICAg7J+zdHJ1Y3Qgb21hcF9wY21f
ZG1hX2RhdGEgKmRtYV9kYXRhID0gcnRkLT5kYWktPmNwdV9kYWktPmRtYV9kYXRhOwo+ICAgICAg
ICAgICDsn6dudCBlcnIgPSAwOwo+IAo+ICAgICArICAgICAgIC8qIHJldHVybiBpZiB0aGlzIGlz
IGEgYnVmZmVybGVzcyB0cmFuc2ZlciBlLmcuCj4gICAgICsgICAgICAgICogY29kZWMgPC0tPiBC
VCBjb2RlYyBvciBHU00gbW9kZW0gLS0gbGcgRklYTUUgKi8KPiAgICAgICAgICAg7J+nZiAoIWRt
YV9kYXRhKQo+ICAgICAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7Cj4gICAgICsgICAg
ICAgICAgICAgICByZXR1cm4gMDsKPiAKPiAKPiBJIHNlZSBleGFjdGx5IHNpbWlsYXIgbGluZXMg
aW4gczNjMjR4eC1wY20uYyBidXQgZG9uJ3QgcG9pbnQgbm93IHRoZSB1c2UKPiBjYXNlIHdoZXJl
IHRoaXMgaXMgdXNlZCBhbmQgSSBkb24ndCBoYXZlIGlkZWEgd2hhdCBpcyB0aGlzIGFsbCBhYm91
dC4KPiAKPiBJcyB0aGlzIHNvbWV0aGluZyB3aGVyZSBEQUkgZHJpdmVyIG9yIGFub3RoZXIgZW5k
IG9mIGNvbm5lY3Rpb24gaXMgdXNlZAo+IHRvIHByb3ZpZGUgY2xvY2tpbmcgYW5kIHRoZSB3aG9s
ZSBzZXR1cCBpcyB0aGVuIGNvbnRyb2xsZWQgd2l0aCBBTFNBIFBDTQo+IEFQST8gU29tZWhvdyBJ
IGhhdmUgdGhlIGZlZWxpbmcgdGhhdCB3b3VsZCB0aGVyZSBiZSBhIGJldHRlciB3YXkgdG8KPiBh
Y2hpZXZlIGl0IHRoYW4gd2l0aCBkdW1teSBidWZmZXJsZXNzIHRyYW5zZmVyPwoKSSB0ZXN0ZWQg
dGhpcyBwYXRjaCB3aXRoIHRoZSBvbWFwMyB0YXJnZXQgaGF2aW5nIHRoZSB0d2w0MDMwIGNvZGVj
LiBUaGUKdHdsNDAzMCBjb2RlYyBkcml2ZXIgc3VwcG9ydHMgdGhlIHZvaWNlIERBSSB0byB0cmFu
c2ZlciBwY20gZGF0YSBiZXR3ZWVuCm1vZGVtIGFuZCBjb2RlYywgYW5kIGkgYWRkZWQgZm9yIHRl
c3QgdGhlIGR1bW15IHZvaWNlIERBSSBpbiBtYWNoaW5lCmRyaXZlci4gVG8gdHJhbnNmZXIgcGNt
IGRhdGEgYXQgbW9kZW0gPC0tPiBjb2RlYyBkb2Vzbid0IG5lZWQgRE1BLgoKPiAKPiAKPiAtLSAK
PiBKYXJra28KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
