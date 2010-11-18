From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: add codec support for mini6410 and
	real6410 boards
Date: Thu, 18 Nov 2010 10:30:00 +0900
Message-ID: <AANLkTim1Qwzx3=q3tQmXJNRmb4YkbNJFqjv_JA0MG31z@mail.gmail.com>
References: <20101117202131.3540.44215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9109E1038C9
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 02:30:00 +0100 (CET)
Received: by bwz8 with SMTP id 8so2310841bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 17:30:00 -0800 (PST)
In-Reply-To: <20101117202131.3540.44215.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: jassi.brar@samsung.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBOb3YgMTgsIDIwMTAgYXQgNToyMSBBTSwgUGF1bGl1cyBaYWxlY2thcwo8cGF1bGl1
cy56YWxlY2thc0BnbWFpbC5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IFBhdWxpdXMgWmFs
ZWNrYXMgPHBhdWxpdXMuemFsZWNrYXNAZ21haWwuY29tPgo+IC0tLQo+Cj4gwqBzb3VuZC9zb2Mv
czNjMjR4eC9LY29uZmlnIHwgwqAgwqAyICstCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvczNjMjR4
eC9LY29uZmlnIGIvc291bmQvc29jL3MzYzI0eHgvS2NvbmZpZwo+IGluZGV4IDhhNmI1M2MuLmIx
ZmNiZDMgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL3MzYzI0eHgvS2NvbmZpZwo+ICsrKyBiL3Nv
dW5kL3NvYy9zM2MyNHh4L0tjb25maWcKPiBAQCAtMTMyLDcgKzEzMiw3IEBAIGNvbmZpZyBTTkRf
UzNDMjRYWF9TT0NfUlgxOTUwX1VEQTEzODAKPgo+IMKgY29uZmlnIFNORF9TT0NfU01ES19XTTk3
MTMKPiDCoCDCoCDCoCDCoHRyaXN0YXRlICJTb0MgQUM5NyBBdWRpbyBzdXBwb3J0IGZvciBTTURL
IHdpdGggV005NzEzIgo+IC0gwqAgwqAgwqAgZGVwZW5kcyBvbiBTTkRfUzNDMjRYWF9TT0MgJiYg
KE1BQ0hfU01ESzY0MTAgfHwgTUFDSF9TTURLQzEwMCB8fCBNQUNIX1NNREtWMjEwIHx8IE1BQ0hf
U01ES0MxMTApCj4gKyDCoCDCoCDCoCBkZXBlbmRzIG9uIFNORF9TM0MyNFhYX1NPQyAmJiAoTUFD
SF9TTURLNjQxMCB8fCBNQUNIX1NNREtDMTAwIHx8IE1BQ0hfU01ES1YyMTAgfHwgTUFDSF9TTURL
QzExMCB8fCBNQUNIX01JTkk2NDEwIHx8IE1BQ0hfUkVBTDY0MTApCj4gwqAgwqAgwqAgwqBzZWxl
Y3QgU05EX1NPQ19XTTk3MTMKPiDCoCDCoCDCoCDCoHNlbGVjdCBTTkRfUzNDX1NPQ19BQzk3Cj4g
wqAgwqAgwqAgwqBoZWxwCgpBY2tlZC1ieTogSmFzc2kgQnJhciA8amFzc2kuYnJhckBzYW1zdW5n
LmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
