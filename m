From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 02/10] clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to ac-dig
Date: Tue, 17 Jan 2017 15:02:22 +0100
Message-ID: <20170117140230.23142-3-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, alexandre.belloni@free-electrons.com, mylene.josserand@free-electrons.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

VGhlIGF1ZGlvIERBSSBuZWVkcyB0byBzZXQgdGhlIGNsb2NrIHJhdGVzIG9mIHRoZSBhYy1kaWcg
Y2xvY2suClRvIG1ha2UgaXQgcG9zc2libGUsIHRoZSBwYXJlbnQgUExMIGF1ZGlvIGNsb2NrIHJh
dGVzIHNob3VsZAphbHNvIGJlIGNoYW5nZWQuIFRoaXMgaXMgcG9zc2libGUgdmlhICJDTEtfU0VU
X1JBVEVfUEFSRU5UIiBmbGFnLgoKU2lnbmVkLW9mZi1ieTogTXlsw6huZSBKb3NzZXJhbmQgPG15
bGVuZS5qb3NzZXJhbmRAZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIGRyaXZlcnMvY2xrL3N1bnhp
LW5nL2NjdS1zdW44aS1hMzMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3N1bnhpLW5nL2NjdS1z
dW44aS1hMzMuYyBiL2RyaXZlcnMvY2xrL3N1bnhpLW5nL2NjdS1zdW44aS1hMzMuYwppbmRleCA5
YmQxZjc4YTA1NDcuLjNjZDQxOTBjY2Q1OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jbGsvc3VueGkt
bmcvY2N1LXN1bjhpLWEzMy5jCisrKyBiL2RyaXZlcnMvY2xrL3N1bnhpLW5nL2NjdS1zdW44aS1h
MzMuYwpAQCAtNDQwLDcgKzQ0MCw3IEBAIHN0YXRpYyBTVU5YSV9DQ1VfTV9XSVRIX0dBVEUodmVf
Y2xrLCAidmUiLCAicGxsLXZlIiwKIAkJCSAgICAgMHgxM2MsIDE2LCAzLCBCSVQoMzEpLCBDTEtf
U0VUX1JBVEVfUEFSRU5UKTsKIAogc3RhdGljIFNVTlhJX0NDVV9HQVRFKGFjX2RpZ19jbGssCSJh
Yy1kaWciLAkicGxsLWF1ZGlvIiwKLQkJICAgICAgMHgxNDAsIEJJVCgzMSksIDApOworCQkgICAg
ICAweDE0MCwgQklUKDMxKSwgQ0xLX1NFVF9SQVRFX1BBUkVOVCk7CiBzdGF0aWMgU1VOWElfQ0NV
X0dBVEUoYWNfZGlnXzR4X2NsaywJImFjLWRpZy00eCIsCSJwbGwtYXVkaW8tNHgiLAogCQkgICAg
ICAweDE0MCwgQklUKDMwKSwgMCk7CiBzdGF0aWMgU1VOWElfQ0NVX0dBVEUoYXZzX2NsaywJCSJh
dnMiLAkJIm9zYzI0TSIsCi0tIAoyLjExLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
