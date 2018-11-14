From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/2] ASoC: dt-bindings: add bindings for
	AK4118 transceiver
Date: Wed, 14 Nov 2018 13:16:42 +0100
Message-ID: <20181114121642.1404-2-peron.clem@gmail.com>
References: <20181114121642.1404-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BDD59267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 13:17:00 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so14499889wme.3
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 04:17:00 -0800 (PST)
In-Reply-To: <20181114121642.1404-1-peron.clem@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

RG9jdW1lbnQgdGhlIGJpbmRpbmdzIGZvciBBSzQxMTggUy9QRElGIHRyYW5zY2VpdmVyCgpTaWdu
ZWQtb2ZmLWJ5OiBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNsZW1AZ21haWwuY29tPgotLS0KIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FrNDExOC50eHQgICAgICB8IDIyICsrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FrNDExOC50
eHQKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
YWs0MTE4LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hazQx
MTgudHh0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uNmUxMWEyZjc0
MDRjCi0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvdW5kL2FrNDExOC50eHQKQEAgLTAsMCArMSwyMiBAQAorQUs0MTE4IFMvUERJRiB0cmFuc2Nl
aXZlcgorCitUaGlzIGRldmljZSBzdXBwb3J0cyBJMkMgbW9kZS4KKworUmVxdWlyZWQgcHJvcGVy
dGllczoKKworLSBjb21wYXRpYmxlIDogImFzYWhpLWthc2VpLGFrNDExOCIKKy0gcmVnIDogVGhl
IEkyQyBhZGRyZXNzIG9mIHRoZSBkZXZpY2UgZm9yIEkyQworLSByZXNldC1ncGlvczogQSBHUElP
IHNwZWNpZmllciBmb3IgdGhlIHJlc2V0IHBpbgorLSBpcnEtZ3Bpb3M6IEEgR1BJTyBzcGVjaWZp
ZXIgZm9yIHRoZSBJUlEgcGluCisKK0V4YW1wbGU6CisKKyZpMmMgeworCWFrNDExODogYWs0MTE4
QDEzIHsKKwkJI3NvdW5kLWRhaS1jZWxscyA9IDwwPjsKKwkJY29tcGF0aWJsZSA9ICJhc2FoaS1r
YXNlaSxhazQxMTgiOworCQlyZWcgPSA8MHgxMz47CisJCXJlc2V0LWdwaW9zID0gPCZncGlvIDAg
R1BJT19BQ1RJVkVfTE9XPgorCQlpcnEtZ3Bpb3MgPSA8JmdwaW8gMSBHUElPX0FDVElWRV9ISUdI
PjsKKwl9OworfTsKLS0gCjIuMTkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
