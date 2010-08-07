From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/6] ASoC: new
	ADAU1761 codec driver
Date: Sat, 7 Aug 2010 18:29:36 -0400
Message-ID: <AANLkTinZd8KPqF+6r-sdZKkoSWF4tFVhxNV4B0xzwVqJ@mail.gmail.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-5-git-send-email-vapier@gentoo.org>
	<B3F28327-BBE5-489F-B077-C865B0F21332@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 72E3F103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:29:56 +0200 (CEST)
Received: by wyb42 with SMTP id 42so8851064wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 15:29:56 -0700 (PDT)
In-Reply-To: <B3F28327-BBE5-489F-B077-C865B0F21332@opensource.wolfsonmicro.com>
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
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBBdWcgNywgMjAxMCBhdCAxODoxNiwgTWFyayBCcm93biB3cm90ZToKPiBPbiA3IEF1
ZyAyMDEwLCBhdCAyMToyOCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6Cj4+ICtjb25maWcgU05EX1NP
Q19BREFVMTc2MQo+PiArIMKgIMKgIHRyaXN0YXRlCj4+ICsgwqAgwqAgc2VsZWN0IFNJR01BCj4+
ICsKPgo+IFdoYXQgaXMgU0lHTUE/CgppdCdzIGEgbmV3IGZpcm13YXJlIGxvYWRlciB0aGF0J3Mg
c3RhbmRhcmRpemVkIGFjcm9zcyBTaWdtYURTUCBwYXJ0cy4KaSAoY29ycmVjdGx5KSBhc3N1bWVk
IHRoaXMgZHJpdmVyIHdhc250IGdvaW5nIHRvIGJlIGFjY2VwdGVkIHJpZ2h0CmF3YXksIHNvIGkg
d2FudGVkIHRvIGdldCBmZWVkYmFjayBpbiBwYXJhbGxlbCB0byB0aGUgZmlybXdhcmUgbG9hZGVy
CmJlaW5nIG1lcmdlZC4KCj4+ICtzdGF0aWMgc3NpemVfdCBhZGF1MTM3MV9kc3BfbG9hZChzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3QgY2hhciAqYnVmLCBzaXplX3Qg
Y291bnQpCj4+ICt7Cj4+ICsgwqAgwqAgc3RydWN0IHNuZF9zb2NfZGV2aWNlICpzb2NkZXYgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2KTsKPj4gKyDCoCDCoCBzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29k
ZWMgPSBzb2NkZXYtPmNhcmQtPmNvZGVjOwo+PiArIMKgIMKgIGludCByZXQgPSAwOwo+PiArCj4+
ICsgwqAgwqAgcmV0ID0gYWRhdTE3NjFfc2V0cHJvZ3JhbShjb2RlYyk7Cj4+ICsgwqAgwqAgaWYg
KHJldCkKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gcmV0Owo+PiArIMKgIMKgIGVsc2UK
Pj4gKyDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gY291bnQ7Cj4+ICt9Cj4+ICtzdGF0aWMgREVW
SUNFX0FUVFIoZHNwLCAwNjQ0LCBOVUxMLCBhZGF1MTM3MV9kc3BfbG9hZCk7Cj4KPiBUaGlzIGxv
b2tzIHJlZHVuZGFudCAtIGl0IGRvZXNuJ3Qgb2ZmZXIgYW55IG9wcG9ydHVuaXR5IHRvIGNvbmZp
Z3VyZSB0aGUgZmlybXdhcmUgdG8gZG93bmxvYWQgYW5kIHlvdSdyZSBhbHJlYWR5IChhcyBvbmUg
b25lIHdvdWxkIGV4cGVjdCkgYXV0b21hdGljYWxseSBkb3dubG9hZGluZyB0aGUgZmlybXdhcmUu
IElmIHRoaXMgaXMgYmVpbmcgZXhwb3NlZCBhdCBhbGwgaXQgc2hvdWxkIGJlIHZpYSBkZWJ1Z2Zz
LgoKU2lnbWFEU1AgcGFydHMgaGF2ZSB0aGUgYWJpbGl0eSB0byBjaGFuZ2UgZmlybXdhcmVzIG9u
IHRoZSBmbHkuICB0aGlzCmlzbnQgYSBkZWJ1ZyBmZWF0dXJlLCBpdCdzIHNvbWV3aGF0IGNvcmUg
dG8gdGhlc2UgcGFydHMuICBpZGVhIGJlaW5nCnRoYXQgeW91IGNhbiBsb2FkIHVwIGRpZmZlcmVu
dCBtaW5pIHNpZ25hbCBwcm9jZXNzaW5nIGVuZ2luZXMgYmFzZWQgb24KdGhlIGN1cnJlbnQgbmVl
ZHMuCi1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
