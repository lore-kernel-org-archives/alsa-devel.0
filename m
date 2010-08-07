From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/6] ASoC: new
	ADAU1761 codec driver
Date: Sat, 7 Aug 2010 18:41:26 -0400
Message-ID: <AANLkTim0=+ujDOZvGb=F0GtS+UvDpEOroNnddz12uJpv@mail.gmail.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-5-git-send-email-vapier@gentoo.org>
	<B3F28327-BBE5-489F-B077-C865B0F21332@opensource.wolfsonmicro.com>
	<AANLkTinZd8KPqF+6r-sdZKkoSWF4tFVhxNV4B0xzwVqJ@mail.gmail.com>
	<DE733C15-5D63-4470-8124-238563F4629B@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8074C103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:41:46 +0200 (CEST)
Received: by wwb31 with SMTP id 31so299955wwb.20
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 15:41:46 -0700 (PDT)
In-Reply-To: <DE733C15-5D63-4470-8124-238563F4629B@opensource.wolfsonmicro.com>
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

T24gU2F0LCBBdWcgNywgMjAxMCBhdCAxODozNiwgTWFyayBCcm93biB3cm90ZToKPiBPbiA3IEF1
ZyAyMDEwLCBhdCAyMzoyOSwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6Cj4+Pj4gK3N0YXRpYyBzc2l6
ZV90IGFkYXUxMzcxX2RzcF9sb2FkKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+PiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLAo+Pj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCj4+Pj4gK3sKPj4+PiArIMKgIMKg
IHN0cnVjdCBzbmRfc29jX2RldmljZSAqc29jZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4+
Pj4gKyDCoCDCoCBzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBzb2NkZXYtPmNhcmQtPmNv
ZGVjOwo+Pj4+ICsgwqAgwqAgaW50IHJldCA9IDA7Cj4+Pj4gKwo+Pj4+ICsgwqAgwqAgcmV0ID0g
YWRhdTE3NjFfc2V0cHJvZ3JhbShjb2RlYyk7Cj4+Pj4gKyDCoCDCoCBpZiAocmV0KQo+Pj4+ICsg
wqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJldDsKPj4+PiArIMKgIMKgIGVsc2UKPj4+PiArIMKg
IMKgIMKgIMKgIMKgIMKgIHJldHVybiBjb3VudDsKPj4+PiArfQo+Pj4+ICtzdGF0aWMgREVWSUNF
X0FUVFIoZHNwLCAwNjQ0LCBOVUxMLCBhZGF1MTM3MV9kc3BfbG9hZCk7Cj4+Pgo+Pj4gVGhpcyBs
b29rcyByZWR1bmRhbnQgLSBpdCBkb2Vzbid0IG9mZmVyIGFueSBvcHBvcnR1bml0eSB0byBjb25m
aWd1cmUgdGhlCj4+PiBmaXJtd2FyZSB0byBkb3dubG9hZCBhbmQgeW91J3JlIGFscmVhZHkgKGFz
IG9uZSBvbmUgd291bGQgZXhwZWN0KQo+Pj4gYXV0b21hdGljYWxseSBkb3dubG9hZGluZyB0aGUg
ZmlybXdhcmUuIElmIHRoaXMgaXMgYmVpbmcgZXhwb3NlZCBhdCBhbGwgaXQKPj4+IHNob3VsZCBi
ZSB2aWEgZGVidWdmcy4KPj4KPj4gU2lnbWFEU1AgcGFydHMgaGF2ZSB0aGUgYWJpbGl0eSB0byBj
aGFuZ2UgZmlybXdhcmVzIG9uIHRoZSBmbHkuIMKgdGhpcwo+PiBpc250IGEgZGVidWcgZmVhdHVy
ZSwgaXQncyBzb21ld2hhdCBjb3JlIHRvIHRoZXNlIHBhcnRzLiDCoGlkZWEgYmVpbmcKPj4gdGhh
dCB5b3UgY2FuIGxvYWQgdXAgZGlmZmVyZW50IG1pbmkgc2lnbmFsIHByb2Nlc3NpbmcgZW5naW5l
cyBiYXNlZCBvbgo+PiB0aGUgY3VycmVudCBuZWVkcy4KPgo+IFJpZ2h0LCBidXQgc2VlIG15IHBv
aW50IGFib3V0IHRoZXJlIGJlaW5nIG5vIG9wcG9ydHVuaXR5IHRvIGNvbmZpZ3VyZSB0aGUKPiBm
aXJtd2FyZSAtIGlmIHlvdSB3ZXJlIGFsbG93aW5nIHRoZSB1c2VyIHRvIHNlbGVjdCBiZXR3ZWVu
IG11bHRpcGxlCj4gZmlybXdhcmVzIGF2YWlsYWJsZSB0aGVuIEkgZXhwZWN0IHRoYXQgdGhlIHZh
bHVlIHdyaXR0ZW4gaW50byB0aGUgc3lzZnMgZmlsZQo+IHdvdWxkIGJlIHBhcnNlZCBhcyB0aGUg
bmFtZSBvZiB0aGUgbmV3IGZpcm13YXJlIGZpbGUgdG8gbG9hZCBvciBvdGhlcndpc2UKPiBzZWxl
Y3QgYSBuZXcgZmlybXdhcmUuIFdpdGggdGhlIGN1cnJlbnQgY29kZSB0aGUgdmFsdWUgd3JpdHRl
biBpcyB0b3RhbGx5Cj4gaWdub3JlZCBhbmQgdGhlIGFwcGxpY2F0aW9uIGxheWVyIGhhcyB0byBv
dmVyd3JpdGUgdGhlIGZpcm13YXJlIGluIHRoZQo+IGZpbGVzeXN0ZW0gKG9yIGhhdmUgYSBjdXN0
b20gaGVscGVyIHByb2dyYW0gd2hpY2ggZG9lcyB0aGUgZXF1aXZhbGVudAo+IHRoZXJlb2YpIHNv
IGFzIGZhciBhcyB0aGUga2VybmVsIGlzIGNvbmNlcm5lZCBpdCdzIGdvaW5nIHRvIHJlbG9hZCB0
aGUgc2FtZQo+IGZpcm13YXJlIHdoaWNoIGlzbid0IGlkZWFsLgoKeWVzLCB0aGF0IGlzIHRoZSBj
dXJyZW50IGxpbWl0YXRpb24gdGhhdCdsbCBuZWVkIHRvIGJlIGZpeGVkLiAgbm90IGEKYmlnIGhh
c3NsZSBmb3IgdXMgdG8gcmVwbGFjZSB0aGUgZmlsZSB3aGVuIGRvaW5nIGluaXRpYWwgdGVzdGlu
ZyA7KS4KLW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
