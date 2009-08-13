From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/3] new ad1836 codec
	driver based on asoc
Date: Thu, 13 Aug 2009 05:34:11 -0400
Message-ID: <8bd0f97a0908130234r305186d6x70a3a69898b9014e@mail.gmail.com>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<20090812134645.GC11898@rakim.wolfsonmicro.main>
	<3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
	<20090813090801.GA31504@sirena.org.uk>
	<8bd0f97a0908130222x7ad7e57bw5d61c9ec6c826dde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id BA9E6243E4
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:34:31 +0200 (CEST)
Received: by yxe6 with SMTP id 6so808388yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 02:34:31 -0700 (PDT)
In-Reply-To: <8bd0f97a0908130222x7ad7e57bw5d61c9ec6c826dde@mail.gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBdWcgMTMsIDIwMDkgYXQgMDU6MjIsIE1pa2UgRnJ5c2luZ2VyIHdyb3RlOgo+IE9u
IFRodSwgQXVnIDEzLCAyMDA5IGF0IDA1OjA4LCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBUaHUs
IEF1ZyAxMywgMjAwOSBhdCAxMTo0MToxM0FNICswODAwLCBCYXJyeSBTb25nIHdyb3RlOgo+Pj4g
T24gV2VkLCBBdWcgMTIsIDIwMDkgYXQgOTo0NiBQTSwgTWFyayBCcm93biB3cm90ZToKPj4+ID4g
SnVzdCAiYWQxODM2IiAtIHRoZSBmYWN0IHRoYXQgaXQncyBjb250cm9sbGVkIHZpYSBTUEkgaXMg
Y2xlYXIgZnJvbSB0aGUKPj4+ID4gZmFjdCB0aGF0IHRoaXMgaXMgYSBzdHJ1Y3Qgc3BpX2RyaXZl
ci4KPj4+Cj4+PiBJIGFncmVlIHRoZSBzcGkgc3RydWN0dXJlIGltcGxpZXMgdGhlIG1lYW5pbmcg
b2Ygc3BpLiDCoEJ1dCBmaWxlcyBpbgo+Pj4gYXJjaC9ibGFja2Zpbi9tYWNoLi4uIGFyZSB1c2lu
ZyBuYW1lcyBsaWtlICJ4eHgtc3BpIiBmb3IgYWxtb3N0IGFsbAo+Pj4gc3BpIGRldmljZXMuIEhv
dyBhYm91dCBrZWVwaW5nIHRoZSBjb2hlcmVuY2U/Cj4+Cj4+IE9oIGRlYXIuIMKgTG9va3MgbGlr
ZSB5b3UndmUgZXNzZW50aWFsbHkgZ290IGEgY2hvaWNlIGJldHdlZW4gYmVpbmcKPj4gY29uc2lz
dGVudCB3aXRoIHRoZSByZXN0IG9mIHRoZSB3b3JsZCBhbmQgYmVpbmcgY29uc2lzdGVudCB3aXRo
IHdoYXQgdGhlCj4+IGJsYWNrZmluIHN0dWZmIGlzIGRvaW5nLgo+Cj4gaXQgcmVhbGx5IGlzbnQg
dGhhdCBiYWQuIMKgdGhlIGRyaXZlcnMgdGhhdCB1c2UgIi1zcGkiIHN1ZmZpeDoKPiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoC5tb2RhbGlhcyA9ICJhZDE4MzYtc3BpIiwgwqAgIyBhdWRpbwo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLm1vZGFsaWFzID0gImFkMTkzOC1zcGkiLCDCoCAjIGF1ZGlv
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kYWxpYXMgPSAiYWQ3MTQ3LXNwaSIsIMKgICMg
aW5wdXQKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2RhbGlhcyA9ICJhZDk5NjAtc3BpIiwg
wqAgIyBkZWFkCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kYWxpYXMgPSAiYmZpbi1scTAz
NXExLXNwaSIsIMKgIyB2aWRlbwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLm1vZGFsaWFzID0g
ImZ4by1zcGkiLCDCoCAjIGRlYWQKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2RhbGlhcyA9
ICJmeHMtc3BpIiwgwqAgIyBkZWFkCj4KPiBkcm9wcGluZyB0aGUgZGVhZCBkZXZpY2VzIGxlYXZl
cyB1cyB3aXRoIDQgZHJpdmVycyB0byBmaXgsIHR3byBvZgo+IHdoaWNoIGFyZSBhdWRpby4gwqBz
aG91bGQgYmUgZWFzeSBmb3IgdXMgdG8gZml4LgoKc2VtaS1zY3JhdGNoIHRoYXQuICBpdmUgcHVu
dGVkIHRoZSBkZWFkIGRldmljZXMgZnJvbSBvdXIgdHJlZSwgYnV0IHRoZQpiZmluLWxxMDM1cTEt
c3BpIGlzIGNvcnJlY3QgYXMgdGhhdCBkZXZpY2UgZHJpdmVyIHJlcXVpcmVzIHR3byB0aGluZ3MK
LS0gYSBwbGF0Zm9ybSBkcml2ZXIgbmFtZWQgImJmaW4tbHEwMzVxMSIgYW5kIGEgc3BpIGRyaXZl
ciBuYW1lZAoiYmZpbi1scTAzNXExLXNwaSIuCgppJ2xsIGhhdmUgdG8gc2VuZCBhIHBhdGNoIG91
dCBmb3IgdGhlIGFkNzE0Ny1zcGkgc2luY2UgaXQncyBiZWVuCm1lcmdlZCBpbnRvIHRoZSBpbnB1
dCB0cmVlIGlpcmMsIGJ1dCBCYXJyeSBjYW4gaGFuZGxlIHRoZXNlIHR3bwpjb2RlY3MuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
