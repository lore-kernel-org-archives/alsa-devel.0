From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Fri, 19 Jun 2009 07:05:48 -0400
Message-ID: <8bd0f97a0906190405k33503d8ekd74ec9ddbb2fde12@mail.gmail.com>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	<20090619104738.GF5270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f185.google.com (mail-yx0-f185.google.com
	[209.85.210.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 08771244DD
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:06:08 +0200 (CEST)
Received: by yxe15 with SMTP id 15so1703098yxe.16
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 04:06:08 -0700 (PDT)
In-Reply-To: <20090619104738.GF5270@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdW4gMTksIDIwMDkgYXQgMDY6NDcsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gRnJp
LCBKdW4gMTksIDIwMDkgYXQgMDU6Mjg6MTVQTSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToKPj4g
MS4gYWRkIEFEMTkzOCBjb2RlYyBkcml2ZXIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKGNv
ZGVjKQo+PiAyLiBhZGQgYmxhY2tmaW4gU1BPUlQtVERNIERBSSBhbmQgUENNIGRyaXZlciAocGxh
dGZvcm0pCj4+IDMuIGFkZCBiZjV4eCBib2FyZCB3aXRoIEFEMTkzOCBkcml2ZXIgwqAgwqAgwqAg
wqAobWFjaGluZSkKPgo+IEFzIExpYW0gc2FpZCB5b3UgcmVhbGx5IG5lZWQgdG8gc3VibWl0IHRo
aXMgYXMgYSBwYXRjaCBzZXJpZXMgcmF0aGVyCj4gdGhhbiBhcyBhIHNpbmdsZSBiaWcgcGF0Y2gg
LSBhcyB5b3VyIGNvbW1pdCBsb2cgaGVyZSBpbmRpY2F0ZXMgeW91J3ZlCj4gZ290IHNldmVyYWwg
ZGlmZmVyZW50IHRoaW5ncyBnb2luZyBvbiBoZXJlLgoKYmxhaCwgaSBoYWQgdGhpcyBxdWV1ZWQg
bG9jYWxseSB3aXRoIGEgInRvZG86c3BsaXQiLiAgd2FudGVkIHRvIHdhaXQKZm9yIEJhcnJ5IHRv
IGZpbmlzaCBkZXZlbG9waW5nIHRoZSBkcml2ZXIgZmlyc3QgdGhvdWdoLgoKYXQgYW55IHJhdGUs
IGkgaGF0ZSB0byBzb3VuZCBsaWtlIGEgYnJva2VuIHJlY29yZCB3cnQgbXkgYWxzYQppZ25vcmFu
Y2UsIGJ1dCBpJ20gdGhpbmtpbmcgdGhlIGxvZ2ljYWwgc3BsaXQgd291bGQgYmUgbGlrZSBCYXJy
eQpudW1iZXJlZCBpdCAtLSBvbmUgcGF0Y2ggZm9yIHNvdW5kL2NvZGVjLywgb25lIHBhdGNoIGZv
ciB0aGUgVERNCnRyYW5zcG9ydCwgYW5kIG9uZSBwYXRjaCBmb3IgaG9va2luZyB1cCB0aGUgQUQx
OTM4IHRvIFRETS4KCj4+ICtzdGF0aWMgaW50IF9fZGV2aW5pdCBhZDE5Mzhfc3BpX3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4+ICt7Cj4+ICsgwqAgwqAgc3BpLT5kZXYucG93ZXIucG93
ZXJfc3RhdGUgPSBQTVNHX09OOwo+PiArIMKgIMKgIGFkMTkzOF9zb2NkZXYtPmNhcmQtPmNvZGVj
LT5jb250cm9sX2RhdGEgPSBzcGk7Cj4+ICsKPj4gKyDCoCDCoCByZXR1cm4gMDsKPj4gK30KPj4g
Kwo+PiArc3RhdGljIGludCBfX2RldmV4aXQgYWQxOTM4X3NwaV9yZW1vdmUoc3RydWN0IHNwaV9k
ZXZpY2UgKnNwaSkKPj4gK3sKPj4gKyDCoCDCoCByZXR1cm4gMDsKPj4gK30KPgo+IFlvdXIgZGV2
aWNlIHByb2Jpbmcgc2hvdWxkIGFsbCBiZSByZXN0cnVjdHVyZWQgc28gdGhhdCB0aGUgU1BJIGRl
dmljZQo+IGZvciB0aGUgQ09ERUMgaXMgcmVnaXN0ZXJlZCBhcyBhbnkgb3RoZXIgU1BJIGRldmlj
ZSByYXRoZXIgdGhhbiBiZWluZwo+IHNldCB1cCBhcyBwYXJ0IG9mIHByb2JpbmcgdGhlIEFTb0Mg
ZGV2aWNlLiDCoFNlZSB0aGUgd204NzMxIGRyaXZlciBmb3IKPiBhbiBleGFtcGxlIG9mIGRvaW5n
IHRoaXMgZm9yIGEgU1BJIGRldmljZS4KPgo+IFRoaXMgd2lsbCByZXF1aXJlIHRoYXQgdGhlIGFy
Y2ggY29kZSBmb3IgYW55IHN5c3RlbXMgd2l0aCB0aGUgYWQxOTM4Cj4gZG8gdGhlIHNldHVwIG9m
IHRoZSBkZXZpY2UuCgpzbyBzaG91bGQgc291bmQvc29jL2JsYWNrZmluL2JmNXh4LWFkMTkzOC5j
IGV2ZW4gZXhpc3QgaW4gdGhlIGZpcnN0IHBsYWNlID8KLW1pa2UKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
