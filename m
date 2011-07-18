From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RESEND][PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0
	internal dma driver
Date: Mon, 18 Jul 2011 13:08:01 +0530
Message-ID: <CABb+yY01c9WMfuGYpHZhAAvYiz=FH9bioQ=3Y4ioz7kz=9G3pQ@mail.gmail.com>
References: <1310533191-31645-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id EB0D0243B5
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 09:38:01 +0200 (CEST)
Received: by fxh2 with SMTP id 2so6106291fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 00:38:01 -0700 (PDT)
In-Reply-To: <1310533191-31645-1-git-send-email-sbkim73@samsung.com>
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

T24gV2VkLCBKdWwgMTMsIDIwMTEgYXQgMTA6MjkgQU0sIFNhbmdiZW9tIEtpbSA8c2JraW03M0Bz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4gSTJTIGluIEV4eW5vczQgYW5kIFM1UEMxMTAoUzVQVjIxMCkg
aGFzIGEgaW50ZXJuYWwgZG1hLgo+IEl0IGNhbiBiZSB1c2VkIGxvdyBwb3dlciBhdWRpbyBtb2Rl
IGFuZCAybmQgY2hhbm5lbCB0cmFuc2Zlci4KPiBUaGlzIHBhdGNoIGNhbiBzdXBwb3J0IGlkbWEu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTYW5nYmVvbSBLaW0gPHNia2ltNzNAc2Ftc3VuZy5jb20+Cj4g
LS0tCj4gVjI6IGNoYW5nZSBpZG1hX25ldyBieSBuZXcgcGNtX25ldyBhcGkKPiDCoCDCoGFkZCBo
YW5kbGluZyBkaWZmZXJlbnQgaWRtYSBhZGRyZXNzCj4gwqAgwqBhcyBqYXNzaSBjb21tZW50cywg
TW9kaWZ5IHRoZSBpZG1hIGRyaXZlcgo+Cj4gVjM6IG1lcmdlIGlkbWFfcmVnX2ludCBhbmQgaWRt
YV9hZGRyX2luaXQKPgo+IFY0OiBtb3ZlIGlkbWEgc2V0dGluZyBpbiBpMnMuYyB0byBpZG1hX2h3
X3BhcmFtcyBpbiBpZG1hLmMKPiDCoCDCoG1vdmUgaWRtYV9yZWdfYWRkcl9pbml0IGNhbGxpbmcK
PiDCoCDCoG1vZGlmeSBpZG1hIGFkZHJlc3MgaGFuZGxpbmcgZXJyb3IKPiDCoCDCoG1vZGlmeSBt
b2R1bGUgaW5mb3JtYXRpb24KPiDCoCDCoGRlbGV0ZSB1c2VsZXNzIGRldl9kYmcKPgo+IFY1OiBk
ZWxldGUgcmVkdW5kYW50IGVycm9yIHByaW50IGFuZCBjaGVjayByb3V0aW5lCj4gwqAgwqBtb2Rp
ZnkgaXJxIGhhbmRsZXIgYXMgamFzc2kgY29tbWVudAo+IMKgIMKgZml4IHRoZSBpbmRlbnQgZXJy
b3IKPiDCoCDCoG1vZGlmeSBwZXJpb2RfYnl0ZXNfbWF4IHZhbHVlIHRvIHNldCBoYWxmIHNpemUg
b2YgbWF4IGJ1ZmZlcgoKUGVyaGFwcyB5b3UgZm9yZ290IHRvIG1lbnRpb24gdGhlIHJlYXNvbiBm
b3IgcmVzZW5kID8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
