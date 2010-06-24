From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: uda134x: replace a macro with a
	value in platform struct.
Date: Thu, 24 Jun 2010 20:21:50 +0400
Message-ID: <AANLkTikoYKDxeTlsD3TL7SgJnPnWGmBQF29phfcuCfDb@mail.gmail.com>
References: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
	<1277387370.3100.214.camel@odin>
	<AANLkTikquGAdo2gnKeIjF-KqJGoaLWTVEcG0peGiTZh3@mail.gmail.com>
	<1277395558.3100.224.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BB2BD10382E
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 18:21:50 +0200 (CEST)
Received: by wyb38 with SMTP id 38so2167042wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 09:21:50 -0700 (PDT)
In-Reply-To: <1277395558.3100.224.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdW4gMjQsIDIwMTAgYXQgODowNSBQTSwgTGlhbSBHaXJkd29vZCA8bHJnQHNsaW1s
b2dpYy5jby51az4gd3JvdGU6Cj4gT24gVGh1LCAyMDEwLTA2LTI0IGF0IDE5OjU0ICswNDAwLCBW
bGFkaW1pciBaYXBvbHNraXkgd3JvdGU6Cj4+IEhpLAo+Pgo+PiBPbiBUaHUsIEp1biAyNCwgMjAx
MCBhdCA1OjQ5IFBNLCBMaWFtIEdpcmR3b29kIDxscmdAc2xpbWxvZ2ljLmNvLnVrPiB3cm90ZToK
Pj4gPiBPbiBUaHUsIDIwMTAtMDYtMjQgYXQgMTc6MzggKzA0MDAsIFZsYWRpbWlyIFphcG9sc2tp
eSB3cm90ZToKPgo+PiA+PiBAQCAtNTU5LDkgKzU0NiwxMSBAQCBzdGF0aWMgaW50IHVkYTEzNHhf
c29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+ID4+IMKgIMKgIMKgIGNv
ZGVjLT5udW1fZGFpID0gMTsKPj4gPj4gwqAgwqAgwqAgY29kZWMtPnJlYWQgPSB1ZGExMzR4X3Jl
YWRfcmVnX2NhY2hlOwo+PiA+PiDCoCDCoCDCoCBjb2RlYy0+d3JpdGUgPSB1ZGExMzR4X3dyaXRl
Owo+PiA+PiAtI2lmZGVmIFBPV0VSX09GRl9PTl9TVEFOREJZCj4+ID4+IC0gwqAgwqAgY29kZWMt
PnNldF9iaWFzX2xldmVsID0gdWRhMTM0eF9zZXRfYmlhc19sZXZlbDsKPj4gPj4gLSNlbmRpZgo+
PiA+PiArCj4+ID4+ICsgwqAgwqAgaWYgKCFwZC0+aXNfcG93ZXJlZF9vbl9zdGFuZGJ5KSB7Cj4+
ID4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgY29kZWMtPnNldF9iaWFzX2xldmVsID0gdWRhMTM0eF9z
ZXRfYmlhc19sZXZlbDsKPj4gPgo+PiA+IFRoZSBjb2RlYyBvcHMgcG9pbnRlcnMgaGF2ZSBtb3Zl
ZCBpbiBtdWx0aS1jb21wb25lbnQuIENhbiB5b3UgcHV0IHRoaXMKPj4gPiBjaGVjayBpbiB5b3Vy
IHVkYTEzNHhfc2V0X2JpYXNfbGV2ZWwoKSBpbnN0ZWFkLgo+PiA+Cj4+IE5vdCBzdXJlIEkgdW5k
ZXJzdGFuZCB0aGUgcHJvYmxlbSwgYW5kIEkgZG8gbm90IHNlZSBhIHNpbXBsZSBzb2x1dGlvbgo+
PiBmb3IgYWN0dWFsIGJ1Z2ZpeCBpbiBwYXRjaCAyLzIsIGlmIHRoaXMgY2hlY2sgaXMgcGxhY2Vk
IGluCj4+IHVkYTEzNHhfc2V0X2JpYXNfbGV2ZWwoKS4gUGxlYXNlIGNvdWxkIHlvdSBwcm92aWRl
IG1lIHdpdGggYSBoaW50IG9yCj4+IGxpbmsgdG8gc29tZSBjb2RlYyBzb3VyY2UgZmlsZT8KPgo+
IEkgd2FzIG1lYW5pbmcgc29tZXRoaW5nIGxpa2UgOi0KPgo+IHVkYTEzNHhfc2V0X2JpYXNfbGV2
ZWwoKQo+IHsKPiDCoCDCoCDCoCDCoGlmIChwZC0+aXNfcG93ZXJlZF9vbl9zdGFuZGJ5KQo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuCj4KPiDCoCDCoCDCoCDCoC8qIHJlc3Qgb2YgZnVu
YyAqLwo+Cj4gfQo+ClRoYW5rIHlvdSwgZ29vZCB0aGF0IEkgbWVhbnQgdGhlIHNhbWUuIEJ1dCB0
aGF0IG1ha2VzIHF1aXRlIGltcG9zc2libGUKdG8gc2V0IGEgbWFuZGF0b3J5IGJpYXMgbGV2ZWwg
b24gaW5pdGlhbGl6YXRpb24gd2l0aG91dCBhZGRpdGlvbmFsIGNvZGUKY29tcGxpY2F0aW9uLgoK
PiBUaGUgbXVsdGktY29tcG9uZW50IGJyYW5jaCBtYWtlcyBjb2RlYy0+c2V0X2JpYXNfbGV2ZWwg
YSBkcml2ZXIgbGV2ZWwKPiBvcGVyYXRpb24gKHRoYXQgY2FuIGJlIHNoYXJlZCBhbW9uZ3N0IG90
aGVyIHVkYTEzNHggY29kZWMgZGV2aWNlcyBzbyB3ZQo+IGNhbnQgY2hhbmdlIHRoaXMgYXQgcnVu
dGltZSkKPgpMb29rcyBsaWtlIEkgbWlzcyBzb21ldGhpbmcsIGJlY2F1c2UgaW4gY29kZWMgZHJp
dmVycyBJIG9ic2VydmUKY29kZWMtPnNldF9iaWFzX2xldmVsIGlzIHNldCBpbiBwcm9iZSBmdW5j
dGlvbiwgbGlrZSBpdCBpcyBpbiB1ZGExMzR4LgoKV291bGQgaXQgYmUgYmV0dGVyIGp1c3QgdG8g
ZHJvcCBhIGNvbmRpdGlvbiBvZiBwZC0+aXNfcG93ZXJlZF9vbl9zdGFuZGJ5PwpXaGF0IGRvIHlv
dSB0aGluaz8KClZsYWRpbWlyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
