From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v5 6/6] dt-bindings: Add documentation for rockchip-hdmi-audio
 driver
Date: Sat, 20 Jun 2015 00:33:21 +0800
Message-ID: <1434731601-11152-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-rockchip@lists.infradead.org, alsa-devel <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andy Yan <andy.yan@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

UmVxdWlyZWQgcHJvcGVydGllczoKLSBjb21wYXRpYmxlOiBwbGF0Zm9ybSBzcGVjaWZpYwotIGky
cy1jb250cm9sbGVyOiB0aGUgaTJzIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUKClNpZ25lZC1vZmYt
Ynk6IFlha2lyIFlhbmcgPHlra0Byb2NrLWNoaXBzLmNvbT4KLS0tCkNoYW5nZXMgaW4gdjU6IE5v
bmUKQ2hhbmdlcyBpbiB2NDogTm9uZQpDaGFuZ2VzIGluIHYzOgotIG1vZGlmeSBjcHUtb2Ytbm9k
ZSB0byBpMnMtY29udHJvbGxlcgoKQ2hhbmdlcyBpbiB2MjoKLSByZW1vdmUgY29kZWMtbmFtZSBh
bmQgY29kZWMtZGFpLW5hbWUKLSByZW5hbWUgcm9ja2NoaXAscm9ja2NoaXAtaGRtaS1hdWRpby50
eHQgdG8gcm9ja2NoaXAscm9ja2NoaXAtZHctaGRtaS1hdWRpby50eHQKCiAuLi4vYmluZGluZ3Mv
c291bmQvcm9ja2NoaXAscm9ja2NoaXAtZHctaGRtaS1hdWRpby50eHQgICAgICAgfCAxMiArKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3JvY2tjaGlwLHJv
Y2tjaGlwLWR3LWhkbWktYXVkaW8udHh0CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL3JvY2tjaGlwLHJvY2tjaGlwLWR3LWhkbWktYXVkaW8udHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3JvY2tjaGlwLHJvY2tj
aGlwLWR3LWhkbWktYXVkaW8udHh0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LmYwZDIzYzUKLS0tIC9kZXYvbnVsbAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvcm9ja2NoaXAscm9ja2NoaXAtZHctaGRtaS1hdWRpby50eHQKQEAgLTAsMCAr
MSwxMiBAQAorUm9ja2NoaXAgaGRtaSBhdWRpbyBiaW5kaW5ncworCitSZXF1aXJlZCBwcm9wZXJ0
aWVzOgorLSBjb21wYXRpYmxlOiBwbGF0Zm9ybSBzcGVjaWZpYworLSBpMnMtY29udHJvbGxlcjog
dGhlIGkycyBjb250cm9sbGVyIGRldmljZSBub2RlCisKK0V4YW1wbGU6CisKK3NvdW5kIHsKKwlj
b21wYXRpYmxlID0gInJvY2tjaGlwLHJrMzI4OC1oZG1pLWF1ZGlvIjsKKwlpMnMtY29udHJvbGxl
ciA9IDwmaTJzPjsKK307Ci0tIAoyLjEuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
