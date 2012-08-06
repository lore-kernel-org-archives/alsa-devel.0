From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/1] mx27_3ds: Add sound support
Date: Mon, 6 Aug 2012 16:38:25 -0300
Message-ID: <CAOMZO5C-h214dtpRx6n13=6i2M+epebOeyrctr6zsApUtTgeBg@mail.gmail.com>
References: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
 <CAOMZO5B9ZmTHrYjVc5a7j=uUgUEyfDva54cKxBP3UeCYZsUWRw@mail.gmail.com>
 <501FD389.1050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 33C8D265DDA
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 21:08:40 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so5737942obb.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 12:38:25 -0700 (PDT)
In-Reply-To: <501FD389.1050105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

R2HDq3RhbiwKCk9uIE1vbiwgQXVnIDYsIDIwMTIgYXQgMTE6MjQgQU0sIEdhw6t0YW4gQ2FybGll
ciA8Z2NlbWJlZEBnbWFpbC5jb20+IHdyb3RlOgo+IEhpIEZhYmlvLAo+IFNvcnJ5LCBJIGhhdmUg
bWlzc2VkIHlvdXIgcGF0Y2ggaW4gbXkgZW1haWwgYXJjaGl2ZS4gSSBkaWRuJ3Qgc2VhcmNoIHRo
ZQo+IHJpZ2h0IGtleXdvcmRzLgo+IEkgYXBwbGllZCB5b3VyIFtwYXRjaCAxLzJdICgyLzIgaXMg
YWxyZWFkeSBtZXJnZWQpIGJ1dCBJIGhhdmUgc2FtZSBlZmZlY3QuIEkKPiB1c2UgYXBsYXkgd2l0
aCBmaWxlIGszYl9lcnJvcjEud2F2IChVbnNpZ25lZCA4IGJpdCwgUmF0ZSA4MDAwIEh6LCBNb25v
KSBhbmQKPiBhbHNhL0Zyb250X0xlZnQud2F2IChTaWduZWQgMTYgYml0IExpdHRsZSBFbmRpYW4s
IFJhdGUgNDgwMDAgSHosIE1vbm8pLiBUd28KPiBzb3VuZHMgYXJlIHBsYXllZCB0b28gZmFzdC4K
PiBJdCBpcyBtYXliZSBhIGJhZCBjb25maWd1cmF0aW9uIG9mIEFsc2EgKGJ1dCB0aGlzIGlzIHdv
cmtpbmcgd2l0aCBrZXJuZWwKPiAyLjYuMjIgZnJvbSBGcmVlc2NhbGUpLgoKSSBoYXZlIGp1c3Qg
c2VudCB0aGUgZm9sbG93aW5nIHBhdGNoIHRvIHRoZSBhbHNhLWxpc3Qgd2hpY2ggZml4ZXMgdGhp
cwptb25vIHBsYXliYWNrIGlzc3VlLgoKUmVnYXJkcywKCkZhYmlvIEVzdGV2YW0KCkZyb20gYmM0
NjA4NzExMGJkNDhhNDFmMWY3ZGNiODI2ODUzMzQ5NjYyYzc2NiBNb24gU2VwIDE3IDAwOjAwOjAw
IDIwMDEKRnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBmcmVlc2NhbGUuY29tPgpE
YXRlOiBNb24sIDYgQXVnIDIwMTIgMTY6MzA6NTEgLTAzMDAKU3ViamVjdDogW1BBVENIXSBBU29D
OiBpbXgtc3NpOiBGaXggbW9ubyBwbGF5YmFjawoKQ3VycmVudGx5IG1vbm8gcGxheWJhY2sgaXMg
cGxheWVkIG9uIGEgZmFzdGVyIHJhdGUuCgpBZGp1c3QgY2hhbm5lbHNfbWluIHRvIDIgY2hhbm5l
bHMgaW4gb3JkZXIgdG8gcGxheSBpdCBiYWNrIGNvcnJlY3RseS4KClJlcG9ydGVkLWJ5OiBHYcOr
dGFuIENhcmxpZXIgPGdjZW1iZWRAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBGYWJpbyBFc3Rl
dmFtIDxmYWJpby5lc3RldmFtQGZyZWVzY2FsZS5jb20+Ci0tLQogc291bmQvc29jL2ZzbC9pbXgt
c3NpLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2lteC1zc2kuYyBiL3NvdW5kL3Nv
Yy9mc2wvaW14LXNzaS5jCmluZGV4IDI4ZGQ3NmMuLmM0MmRmMzEgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3NvYy9mc2wvaW14LXNzaS5jCisrKyBiL3NvdW5kL3NvYy9mc2wvaW14LXNzaS5jCkBAIC0zODAs
NyArMzgwLDcgQEAgc3RhdGljIGludCBpbXhfc3NpX2RhaV9wcm9iZShzdHJ1Y3Qgc25kX3NvY19k
YWkgKmRhaSkKIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyIGlteF9zc2lfZGFpID0g
ewogCS5wcm9iZSA9IGlteF9zc2lfZGFpX3Byb2JlLAogCS5wbGF5YmFjayA9IHsKLQkJLmNoYW5u
ZWxzX21pbiA9IDEsCisJCS5jaGFubmVsc19taW4gPSAyLAogCQkuY2hhbm5lbHNfbWF4ID0gMiwK
IAkJLnJhdGVzID0gU05EUlZfUENNX1JBVEVfODAwMF85NjAwMCwKIAkJLmZvcm1hdHMgPSBTTkRS
Vl9QQ01fRk1UQklUX1MxNl9MRSwKLS0gCjEuNy4xCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
