From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH v2] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Tue, 13 Dec 2011 20:27:16 +0200
Message-ID: <CALq1K=+Thd2rrTu1psL+CSmiTKPYs5fW_c+GQNQ0eU_gepk5=Q@mail.gmail.com>
References: <1323719154-18344-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF175186086F@HQMAIL01.nvidia.com>
	<CALq1K=Kna7wdqcJ0cPV1bvurUqYfE9zcQ+ZxZEG1YompsqP3nQ@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1751860ABB@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E30FD103BC1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 19:27:39 +0100 (CET)
Received: by vbbfp1 with SMTP id fp1so5077550vbb.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 10:27:37 -0800 (PST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1751860ABB@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBEZWMgMTMsIDIwMTEgYXQgMTk6MjMsIFN0ZXBoZW4gV2FycmVuIDxzd2FycmVuQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gTGVvbiBSb21hbm92c2t5IHdyb3RlIGF0IE1vbmRheSwgRGVj
ZW1iZXIgMTIsIDIwMTEgMTE6MzYgUE06Cj4gPiBPbiBNb24sIERlYyAxMiwgMjAxMSBhdCAyMjoy
MCwgU3RlcGhlbiBXYXJyZW4gPHN3YXJyZW5AbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+IExlb24g
Um9tYW5vdnNreSB3cm90ZSBhdCBNb25kYXksIERlY2VtYmVyIDEyLCAyMDExIDEyOjQ2IFBNOgo+
ID4gPj4gQXQgdGhpcyBzdGFnZSBvbmx5IFRvc2hpYmEgQUMxMDAvRHluYWJvb2sgc3VwcG9ydGVk
Lgo+IC4uLgo+ID4gPj4gK3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19qYWNrX2dwaW8gdGVncmFfYWxj
NTYzMl9oc19qYWNrX2dwaW8gPSB7Cj4gPiA+PiArIMKgIMKgIC5uYW1lID0gIkhlYWRzZXQgRGV0
ZWN0IiwKPiA+ID4+ICsgwqAgwqAgLnJlcG9ydCA9IFNORF9KQUNLX0hFQURTRVQsCj4gPiA+PiAr
IMKgIMKgIC5kZWJvdW5jZV90aW1lID0gMTUwLAo+ID4gPj4gK307Cj4gPiA+IC4uLgo+ID4gPj4g
K3N0YXRpYyBpbnQgdGVncmFfYWxjNTYzMl9hc29jX2luaXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1
bnRpbWUgKnJ0ZCkKPiA+ID4+ICt7Cj4gPiA+IC4uLgo+ID4gPj4gKyDCoCDCoCBzbmRfc29jX2ph
Y2tfYWRkX2dwaW9zKCZ0ZWdyYV9hbGM1NjMyX2hzX2phY2ssCj4gPiA+PiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDEsICZ0ZWdyYV9hbGM1NjMyX2hzX2phY2tfZ3Bpbyk7Cj4gPiA+
Cj4gPiA+IFNpbmNlIHRlZ3JhX2FsYzU2MzJfaHNfamFja19ncGlvIGlzIG5ldmVyIHNldCwgZG9l
c24ndCB0aGlzIGVuZCB1cCB1c2luZwo+ID4gPiBHUElPIDAgYXMgdGhlIGhlYWRzZXQgZGV0ZWN0
LCB3aGljaCBtb3N0IGxpa2VseSBpcyBzb21ldGhpbmcgY29tcGxldGVseQo+ID4gPiB1bnJlbGF0
ZWQgdG8gYXVkaW8uCj4gPgo+ID4gVGhpcyBpcyBpbml0aWFsIHN1cHBvcnQgb2YgYm9hcmQgZmls
ZSwgYXQgdGhlIGNvbWluZyBwYXRjaCBzZXQsIEknbGwKPiA+IHVwZGF0ZSBib2FyZC1wYXowMC1w
aW5tdXguYyBbMV0gd2l0aCBhdWRpbyByZWxhdGVkIHBpbnMgYW5kIEknbGwgYWRkCj4gPiBwbGF0
Zm9ybSBkZXZpY2Ugc3VwcG9ydC4KPiA+IEkgdGhpbmsgSXQgaXMgZWFzeSBmb3IgcmV2aWV3IGlu
IHRoaXMgd2F5Lgo+Cj4gSSdtIGZpbmUgYWRkaW5nIHRoZSBmZWF0dXJlIGxhdGVyLiBCdXQsIEkg
dGhpbmsgeW91IHNob3VsZG4ndCBjYWxsCj4gc25kX3NvY19qYWNrX2FkZF9ncGlvcygpIHVudGls
IHRoZSBwbGF0Zm9ybSBkYXRhIGlzIHRoZXJlLCBvciB5b3UnbGwKPiBlbmQgdXAgZW5hYmxpbmcg
dGhlIGZlYXR1cmUgYWxyZWFkeSwgYnV0IHVzaW5nIHRoZSB3cm9uZyBHUElPLgpEb2VzIGl0IG1h
dHRlciA/IEFueXdheSwgdGhpcyBmaWxlIGlzIHVzZWxlc3Mgd2l0aG91dCBwcm9wZXIgYXVkaW8K
c3VwcG9ydCwgYW5kIGN1cnJlbnRseSBvbmx5IHBhejAwIHdpbGwgYmUgdXNpbmcgdGhpcyBmaWxl
LgoKCgotLQpMZW9uIFJvbWFub3Zza3kgfCBJbmRlcGVuZGVudCBMaW51eCBDb25zdWx0YW50CsKg
IMKgIMKgIMKgwqB3d3cubGVvbi5udcKgfCBsZW9uQGxlb24ubnUKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
