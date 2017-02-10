From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH 3/4] ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY
Date: Fri, 10 Feb 2017 10:41:32 +0100
Message-ID: <20170210094133.11382-4-mylene.josserand@free-electrons.com>
References: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, mylene.josserand@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

U09DX01JWEVSX0FSUkFZIGlzIGEgc2ltcGxpZmllZCBmdW5jdGlvbiBvZiBTTkRfU09DX0RBUE1f
TUlYRVIKd2hpY2ggaGFuZGxlcyBhdXRvbWF0aWNhbGx5IHRoZSBBUlJBWV9TSVpFIG9mIGNvbnRy
b2xzLgoKVXBkYXRlIHRoZSBkcml2ZXIgdG8gdXNlIFNPQ19NSVhFUl9BUlJBWS4KClNpZ25lZC1v
ZmYtYnk6IE15bMOobmUgSm9zc2VyYW5kIDxteWxlbmUuam9zc2VyYW5kQGZyZWUtZWxlY3Ryb25z
LmNvbT4KLS0tCiBzb3VuZC9zb2Mvc3VueGkvc3VuOGktY29kZWMuYyB8IDEwICsrKystLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL3N1bnhpL3N1bjhpLWNvZGVjLmMgYi9zb3VuZC9zb2Mvc3VueGkvc3Vu
OGktY29kZWMuYwppbmRleCAxMDdmYTgyMTM2MDAuLmE3NWE5ODM5NzRkOSAxMDA2NDQKLS0tIGEv
c291bmQvc29jL3N1bnhpL3N1bjhpLWNvZGVjLmMKKysrIGIvc291bmQvc29jL3N1bnhpL3N1bjhp
LWNvZGVjLmMKQEAgLTI4OCwxMiArMjg4LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3Nv
Y19kYXBtX3dpZGdldCBzdW44aV9jb2RlY19kYXBtX3dpZGdldHNbXSA9IHsKIAkJCSBTVU44SV9B
SUYxX0RBQ0RBVF9DVFJMX0FJRjFfREEwUl9FTkEsIDApLAogCiAJLyogREFDIE1peGVycyAqLwot
CVNORF9TT0NfREFQTV9NSVhFUigiTGVmdCBEaWdpdGFsIERBQyBNaXhlciIsIFNORF9TT0NfTk9Q
TSwgMCwgMCwKLQkJCSAgIHN1bjhpX2RhY19taXhlcl9jb250cm9scywKLQkJCSAgIEFSUkFZX1NJ
WkUoc3VuOGlfZGFjX21peGVyX2NvbnRyb2xzKSksCi0JU05EX1NPQ19EQVBNX01JWEVSKCJSaWdo
dCBEaWdpdGFsIERBQyBNaXhlciIsIFNORF9TT0NfTk9QTSwgMCwgMCwKLQkJCSAgIHN1bjhpX2Rh
Y19taXhlcl9jb250cm9scywKLQkJCSAgIEFSUkFZX1NJWkUoc3VuOGlfZGFjX21peGVyX2NvbnRy
b2xzKSksCisJU09DX01JWEVSX0FSUkFZKCJMZWZ0IERpZ2l0YWwgREFDIE1peGVyIiwgU05EX1NP
Q19OT1BNLCAwLCAwLAorCQkJc3VuOGlfZGFjX21peGVyX2NvbnRyb2xzKSwKKwlTT0NfTUlYRVJf
QVJSQVkoIlJpZ2h0IERpZ2l0YWwgREFDIE1peGVyIiwgU05EX1NPQ19OT1BNLCAwLCAwLAorCQkJ
c3VuOGlfZGFjX21peGVyX2NvbnRyb2xzKSwKIAogCS8qIENsb2NrcyAqLwogCVNORF9TT0NfREFQ
TV9TVVBQTFkoIk1PRENMSyBBRkkxIiwgU1VOOElfTU9EX0NMS19FTkEsCi0tIAoyLjExLjAKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
