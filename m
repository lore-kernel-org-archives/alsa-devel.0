From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/3] dt-bindings: Document the dmas and dma-names
 properties for VC4 HDMI
Date: Mon, 27 Feb 2017 12:28:01 -0800
Message-ID: <20170227202803.12855-1-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

RnJvbTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AZnJlZS1lbGVjdHJvbnMuY29t
PgoKVGhlc2UgYXJlIG9wdGlvbmFsLCBidXQgbmVjZXNzYXJ5IGZvciBIRE1JIGF1ZGlvIHN1cHBv
cnQuCgpTaWduZWQtb2ZmLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVl
LWVsZWN0cm9ucy5jb20+ClNpZ25lZC1vZmYtYnk6IEVyaWMgQW5ob2x0IDxlcmljQGFuaG9sdC5u
ZXQ+CkFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgotLS0KCnYyOiBubyBj
aGFuZ2VzCgogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJjbSxi
Y20tdmM0LnR4dCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJjbSxi
Y20tdmM0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2Jy
Y20sYmNtLXZjNC50eHQKaW5kZXggMzRjN2ZkZGNlYTM5Li5jYTAyZDNlNGRiOTEgMTAwNjQ0Ci0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyY20sYmNtLXZj
NC50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJj
bSxiY20tdmM0LnR4dApAQCAtMzQsNiArMzQsOSBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzIGZvciBI
RE1JOgogLSBocGQtZ3Bpb3M6CVRoZSBHUElPIHBpbiBmb3IgSERNSSBob3RwbHVnIGRldGVjdCAo
aWYgaXQgZG9lc24ndCBhcHBlYXIKIAkJICBhcyBhbiBpbnRlcnJ1cHQvc3RhdHVzIGJpdCBpbiB0
aGUgSERNSSBjb250cm9sbGVyCiAJCSAgaXRzZWxmKS4gIFNlZSBiaW5kaW5ncy9waW5jdHJsL2Jy
Y20sYmNtMjgzNS1ncGlvLnR4dAorLSBkbWFzOgkJU2hvdWxkIGNvbnRhaW4gb25lIGVudHJ5IHBv
aW50aW5nIHRvIHRoZSBETUEgY2hhbm5lbCB1c2VkIHRvCisJCXRyYW5zZmVyIGF1ZGlvIGRhdGEK
Ky0gZG1hLW5hbWVzOglTaG91bGQgY29udGFpbiAiYXVkaW8tcngiCiAKIFJlcXVpcmVkIHByb3Bl
cnRpZXMgZm9yIERQSToKIC0gY29tcGF0aWJsZToJU2hvdWxkIGJlICJicmNtLGJjbTI4MzUtZHBp
IgotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
