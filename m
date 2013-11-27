From: Denis Carikli <denis@eukrea.com>
Subject: [PATCHv8][ 2/5] ARM: dts: mbimxsd25: Add sound support.
Date: Wed, 27 Nov 2013 16:54:21 +0100
Message-ID: <1385567664-758-2-git-send-email-denis@eukrea.com>
References: <1385567664-758-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 306082650AF
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 16:54:45 +0100 (CET)
In-Reply-To: <1385567664-758-1-git-send-email-denis@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Denis Carikli <denis@eukrea.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Q2M6IFJvYiBIZXJyaW5nIDxyb2IuaGVycmluZ0BjYWx4ZWRhLmNvbT4KQ2M6IFBhd2VsIE1vbGwg
PHBhd2VsLm1vbGxAYXJtLmNvbT4KQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+CkNjOiBTdGVwaGVuIFdhcnJlbiA8c3dhcnJlbkB3d3dkb3Rvcmcub3JnPgpDYzogSWFuIENh
bXBiZWxsIDxpamMrZGV2aWNldHJlZUBoZWxsaW9uLm9yZy51az4KQ2M6IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnCkNjOiBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPgpDYzog
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPgpDYzogYWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCkNjOiBTYXNjaGEgSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT4KQ2M6IEVyaWMg
QsOpbmFyZCA8ZXJpY0BldWtyZWEuY29tPgpTaWduZWQtb2ZmLWJ5OiBEZW5pcyBDYXJpa2xpIDxk
ZW5pc0BldWtyZWEuY29tPgotLS0KQ2hhbmdlTG9nIHY3LT52ODoKLSBBanVzdGVkIHRvIG1hdGNo
IHRoZSBkcml2ZXIgY2hhbmdlcy4KLS0tCiAuLi4vYm9vdC9kdHMvaW14MjUtZXVrcmVhLW1iaW14
c2QyNS1iYXNlYm9hcmQuZHRzICB8ICAgIDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14MjUtZXVrcmVh
LW1iaW14c2QyNS1iYXNlYm9hcmQuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14MjUtZXVrcmVh
LW1iaW14c2QyNS1iYXNlYm9hcmQuZHRzCmluZGV4IGZhZDY4NDcuLjgxM2ExMTQgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI1LWV1a3JlYS1tYmlteHNkMjUtYmFzZWJvYXJkLmR0
cworKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXgyNS1ldWtyZWEtbWJpbXhzZDI1LWJhc2Vib2Fy
ZC5kdHMKQEAgLTQzLDYgKzQzLDE0IEBACiAJCQlsaW51eCxkZWZhdWx0LXRyaWdnZXIgPSAiaGVh
cnRiZWF0IjsKIAkJfTsKIAl9OworCisJc291bmQgeworCQljb21wYXRpYmxlID0gImV1a3JlYSxh
c29jLXRsdjMyMCI7CisJCWV1a3JlYSxtb2RlbCA9ICJpbXgyNS1ldWtyZWEtdGx2MzIwYWljMjMi
OworCQlzc2ktY29udHJvbGxlciA9IDwmc3NpMT47CisJCWZzbCxtdXgtaW50LXBvcnQgPSA8MT47
CisJCWZzbCxtdXgtZXh0LXBvcnQgPSA8NT47CisJfTsKIH07CiAKICZhdWRtdXggewpAQCAtOTgs
NiArMTA2LDcgQEAKIH07CiAKICZzc2kxIHsKKwljb2RlYy1oYW5kbGUgPSA8JnRsdjMyMGFpYzIz
PjsKIAlmc2wsbW9kZSA9ICJpMnMtc2xhdmUiOwogCXN0YXR1cyA9ICJva2F5IjsKIH07Ci0tIAox
LjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
