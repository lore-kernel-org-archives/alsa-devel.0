From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-ssi: Remove mono support
Date: Wed, 08 Aug 2012 15:18:38 +0200
Message-ID: <5022672E.8080502@gmail.com>
References: <1344369094-24085-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 0400B2661C9
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 14:49:37 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so257722bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 08 Aug 2012 06:19:23 -0700 (PDT)
In-Reply-To: <1344369094-24085-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAwOC8wNy8yMDEyIDA5OjUxIFBNLCBGYWJpbyBFc3RldmFtIHdyb3RlOgo+IEZyb206
IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AZnJlZXNjYWxlLmNvbT4KPgo+IFBsYXlpbmcg
YSBtb25vIHRyYWNrIHJlc3VsdHMgaW4gaW5jb3JyZWN0IHBsYXliYWNrIHJhdGUsIGllLCB0aGUg
YXVkaW8KPiBpcyBwbGF5ZWQgYXQgYSBmYXN0ZXIgcmF0ZS4KPgo+IFJlbW92ZSBtb25vIHN1cHBv
cnQgaW4gdGhlIGRyaXZlciBieSBzZXR0aW5nICdjaGFubmVzX21pbicgdG8gZHVhbC1jaGFubmVs
Cj4gYW5kIHRoaXMgYWxsb3dzIG1vbm8gdHJhY2tzIHRvIGJlIHBsYXllZCBjb3JyZWN0bHkuCj4K
PiBSZXBvcnRlZC1ieTogR2HDq3RhbiBDYXJsaWVyIDxnY2VtYmVkQGdtYWlsLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQGZyZWVzY2FsZS5jb20+Cj4g
LS0tCj4gQ2hhbmdlcyBzaW5jZSB2MToKPiAtIEFsc28gY2hhbmdlICdjaGFubmVsc19taW4nIGZv
ciB0aGUgY2FwdHVyZQo+IC0gSW1wcm92ZSB0aGUgY29tbWl0IGxvZwo+ICAgc291bmQvc29jL2Zz
bC9pbXgtc3NpLmMgfCAgICA1ICsrKy0tCj4gICAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2lteC1z
c2kuYyBiL3NvdW5kL3NvYy9mc2wvaW14LXNzaS5jCj4gaW5kZXggM2M1MjBjNC4uNzA3NGFlNiAx
MDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvZnNsL2lteC1zc2kuYwo+ICsrKyBiL3NvdW5kL3NvYy9m
c2wvaW14LXNzaS5jCj4gQEAgLTM4MCwxMyArMzgwLDE0IEBAIHN0YXRpYyBpbnQgaW14X3NzaV9k
YWlfcHJvYmUoc3RydWN0IHNuZF9zb2NfZGFpICpkYWkpCj4gICBzdGF0aWMgc3RydWN0IHNuZF9z
b2NfZGFpX2RyaXZlciBpbXhfc3NpX2RhaSA9IHsKPiAgIAkucHJvYmUgPSBpbXhfc3NpX2RhaV9w
cm9iZSwKPiAgIAkucGxheWJhY2sgPSB7Cj4gLQkJLmNoYW5uZWxzX21pbiA9IDEsCj4gKwkJLyog
VGhlIFNTSSBkb2VzIG5vdCBzdXBwb3J0IG1vbmF1cmFsIGF1ZGlvLiAqLwo+ICsJCS5jaGFubmVs
c19taW4gPSAyLAo+ICAgCQkuY2hhbm5lbHNfbWF4ID0gMiwKPiAgIAkJLnJhdGVzID0gU05EUlZf
UENNX1JBVEVfODAwMF85NjAwMCwKPiAgIAkJLmZvcm1hdHMgPSBTTkRSVl9QQ01fRk1UQklUX1Mx
Nl9MRSwKPiAgIAl9LAo+ICAgCS5jYXB0dXJlID0gewo+IC0JCS5jaGFubmVsc19taW4gPSAxLAo+
ICsJCS5jaGFubmVsc19taW4gPSAyLAo+ICAgCQkuY2hhbm5lbHNfbWF4ID0gMiwKPiAgIAkJLnJh
dGVzID0gU05EUlZfUENNX1JBVEVfODAwMF85NjAwMCwKPiAgIAkJLmZvcm1hdHMgPSBTTkRSVl9Q
Q01fRk1UQklUX1MxNl9MRSwKPgoKT24gaW14MjdfM2RzIGJvYXJkOgoKVGVzdGVkLWJ5OiBHYcOr
dGFuIENhcmxpZXIgPGdjZW1iZWRAZ21haWwuY29tPgoKUmVnYXJkcywKR2HDq3RhbiBDYXJsaWVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
