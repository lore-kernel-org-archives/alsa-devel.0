From: Simon Horman <simon@horms.net>
Subject: Re: [PATCH] ASoC: fsi: fixup compile error for
	simple-card
Date: Mon, 17 Mar 2014 10:18:54 +0900
Message-ID: <20140317011851.GA31549@verge.net.au>
References: <5323ad1c.V6m3nhSN8UwkI6jk%fengguang.wu@intel.com>
 <87ppllvexh.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 57305261647
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 02:19:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ppllvexh.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBNYXIgMTYsIDIwMTQgYXQgMDU6Mzc6MDZQTSAtMDcwMCwgS3VuaW5vcmkgTW9yaW1v
dG8gd3JvdGU6Cj4gRnJvbTogS3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3JpLm1vcmltb3RvLmd4
QHJlbmVzYXMuY29tPgo+IAo+IFRoaXMgcGF0Y2hlcyBmaXhlcwo+IGM3YTUwN2VlYTFkYjE0MzA0
NzYyODlmNTI1ZjljODUzZDVkNDg1ZTgKPiAoQVNvQzogZnNpOiBmaXh1cCBTTkRfU09DX0RBSUZN
VF9DQnhfQ0Z4IGZsYWdzKQo+IGNvbW1pdCdzIGNvbXBpZSBlcnJvcgo+IAo+IGFyY2gvYXJtL21h
Y2gtc2htb2JpbGUvYm9hcmQtbWFja2VyZWwuYzo1MTI6MjogXAo+ICAgZXJyb3I6IHVua25vd24g
ZmllbGQgJ2ZtdCcgc3BlY2lmaWVkIGluIGluaXRpYWxpemVyCj4gCj4gU2lnbmVkLW9mZi1ieTog
S3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3JpLm1vcmltb3RvLmd4QHJlbmVzYXMuY29tPgoKQWNr
ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU+Cgo+IC0tLQo+
IE1hcmsKPiAKPiBUaGlzIHBhdGNoIGlzIGZvciBtYXJrL2ZpeC9yY2FyCj4gCj4gIGFyY2gvYXJt
L21hY2gtc2htb2JpbGUvYm9hcmQtbWFja2VyZWwuYyB8ICAgIDIgKy0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtc2htb2JpbGUvYm9hcmQtbWFja2VyZWwuYyBiL2FyY2gvYXJtL21hY2gtc2htb2Jp
bGUvYm9hcmQtbWFja2VyZWwuYwo+IGluZGV4IDhjNDMzMjEuLjBmZjRkOGUgMTAwNjQ0Cj4gLS0t
IGEvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9ib2FyZC1tYWNrZXJlbC5jCj4gKysrIGIvYXJjaC9h
cm0vbWFjaC1zaG1vYmlsZS9ib2FyZC1tYWNrZXJlbC5jCj4gQEAgLTUwOSw3ICs1MDksNyBAQCBz
dGF0aWMgc3RydWN0IGFzb2Nfc2ltcGxlX2NhcmRfaW5mbyBmc2kyX2hkbWlfaW5mbyA9IHsKPiAg
CS5jYXJkCQk9ICJGU0kyQi1IRE1JIiwKPiAgCS5jb2RlYwkJPSAic2gtbW9iaWxlLWhkbWkiLAo+
ICAJLnBsYXRmb3JtCT0gInNoX2ZzaTIiLAo+IC0JLmZtdAkJPSBTTkRfU09DX0RBSUZNVF9DQlNf
Q0ZTLAo+ICsJLmRhaWZtdAkJPSBTTkRfU09DX0RBSUZNVF9DQlNfQ0ZTLAo+ICAJLmNwdV9kYWkg
PSB7Cj4gIAkJLm5hbWUJPSAiZnNpYi1kYWkiLAo+ICAJfSwKPiAtLSAKPiAxLjcuOS41Cj4gCgot
LSAKU2ltb24gSG9ybWFuL+ODm+ODvOODnuODsyDjgrXjgqTjg6Ljg7MgICAgICAgIHNpbW9uQGhv
cm1zLm5ldApIb3JtcyBTb2x1dGlvbnMg5qCq5byP5Lya56S+ICAgICAgICAgICAgICAgIHd3dy5o
b3Jtcy5uZXQK44CSNjUxLTAwODQg5YW15bqr55yM56We5oi45biC5Lit5aSu5Yy656Ov6L666YCa
NC0xLTggSVRD44OT44OrOTAx5Y+3ClRlbDogMDMgNjM2NSA1OTc3ICAgICAgICAgICAgICAgICAg
IEZheDogMDMgNjY3MyA0MjY4ClNreXBlOiBob3JtczcKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
