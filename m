From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RESEND][PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0
 internal dma driver
Date: Mon, 18 Jul 2011 17:17:12 +0530
Message-ID: <CABb+yY2Gj17Qf5stxWiTXLrp3jSAH0WP92+8tGSMZbMZ77uo5w@mail.gmail.com>
References: <1310533191-31645-1-git-send-email-sbkim73@samsung.com>
	<CABb+yY01c9WMfuGYpHZhAAvYiz=FH9bioQ=3Y4ioz7kz=9G3pQ@mail.gmail.com>
	<026701cc452b$75f51cd0$61df5670$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f173.google.com (mail-ey0-f173.google.com
	[209.85.215.173])
	by alsa0.perex.cz (Postfix) with ESMTP id EF33824388
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 13:47:15 +0200 (CEST)
Received: by eyb7 with SMTP id 7so1163222eyb.4
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 04:47:13 -0700 (PDT)
In-Reply-To: <026701cc452b$75f51cd0$61df5670$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKdWwgMTgsIDIwMTEgYXQgMjo0NyBQTSwgU2FuZ2Jlb20gS2ltIDxzYmtpbTczQHNh
bXN1bmcuY29tPiB3cm90ZToKPiBIaSwKPiBPbiBNb24sIEp1bHkgMTgsIDIwMTEgYXQgNDozOCBQ
TSwgSmFzc2kgQnJhciB3cm90ZToKPj4gT24gV2VkLCBKdWwgMTMsIDIwMTEgYXQgMTA6MjkgQU0s
IFNhbmdiZW9tIEtpbSA8c2JraW03M0BzYW1zdW5nLmNvbT4gd3JvdGU6Cj4+ID4gSTJTIGluIEV4
eW5vczQgYW5kIFM1UEMxMTAoUzVQVjIxMCkgaGFzIGEgaW50ZXJuYWwgZG1hLgo+PiA+IEl0IGNh
biBiZSB1c2VkIGxvdyBwb3dlciBhdWRpbyBtb2RlIGFuZCAybmQgY2hhbm5lbCB0cmFuc2Zlci4K
Pj4gPiBUaGlzIHBhdGNoIGNhbiBzdXBwb3J0IGlkbWEuCj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5
OiBTYW5nYmVvbSBLaW0gPHNia2ltNzNAc2Ftc3VuZy5jb20+Cj4+ID4gLS0tCj4+ID4gVjI6IGNo
YW5nZSBpZG1hX25ldyBieSBuZXcgcGNtX25ldyBhcGkKPj4gPiDCoCDCoGFkZCBoYW5kbGluZyBk
aWZmZXJlbnQgaWRtYSBhZGRyZXNzCj4+ID4gwqAgwqBhcyBqYXNzaSBjb21tZW50cywgTW9kaWZ5
IHRoZSBpZG1hIGRyaXZlcgo+PiA+Cj4+ID4gVjM6IG1lcmdlIGlkbWFfcmVnX2ludCBhbmQgaWRt
YV9hZGRyX2luaXQKPj4gPgo+PiA+IFY0OiBtb3ZlIGlkbWEgc2V0dGluZyBpbiBpMnMuYyB0byBp
ZG1hX2h3X3BhcmFtcyBpbiBpZG1hLmMKPj4gPiDCoCDCoG1vdmUgaWRtYV9yZWdfYWRkcl9pbml0
IGNhbGxpbmcKPj4gPiDCoCDCoG1vZGlmeSBpZG1hIGFkZHJlc3MgaGFuZGxpbmcgZXJyb3IKPj4g
PiDCoCDCoG1vZGlmeSBtb2R1bGUgaW5mb3JtYXRpb24KPj4gPiDCoCDCoGRlbGV0ZSB1c2VsZXNz
IGRldl9kYmcKPj4gPgo+PiA+IFY1OiBkZWxldGUgcmVkdW5kYW50IGVycm9yIHByaW50IGFuZCBj
aGVjayByb3V0aW5lCj4+ID4gwqAgwqBtb2RpZnkgaXJxIGhhbmRsZXIgYXMgamFzc2kgY29tbWVu
dAo+PiA+IMKgIMKgZml4IHRoZSBpbmRlbnQgZXJyb3IKPj4gPiDCoCDCoG1vZGlmeSBwZXJpb2Rf
Ynl0ZXNfbWF4IHZhbHVlIHRvIHNldCBoYWxmIHNpemUgb2YgbWF4IGJ1ZmZlcgo+Pgo+PiBQZXJo
YXBzIHlvdSBmb3Jnb3QgdG8gbWVudGlvbiB0aGUgcmVhc29uIGZvciByZXNlbmQgPwo+IFNvcnJ5
LCBJIGNoYW5nZWQgTUFYX0lETUFfQlVGRkVSIHZhbHVlICgxMjhLQikKPiBCZWNhdXNlIEkgdXNl
ZCB3cm9uZyBNQVhfSURNQV9CVUZGRVIgdmFsdWUuCk5vLCB3ZSBzaG91bGQgbm90IHNldCBwZXJp
b2RfYnl0ZXNfbWF4IHRvIGhhbGYgdGhlIGJ1ZmZlci4KVGhhdCB3aWxsIGxlYXZlIG5vIHNjb3Bl
IGZvciBldmVuIGN1c3RvbWl6ZWQgYXBwbGljYXRpb25zIHRvCmdldCBtYXggcG9zc2libGUgcG93
ZXIgc2F2aW5ncy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
