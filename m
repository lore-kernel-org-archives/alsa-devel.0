From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH 0/2] ASoC: fsl: audmix: fix two issues
Date: Tue, 9 Apr 2019 08:35:32 +0000
Message-ID: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

VGhlIGxhdGVzdCBhdWRtaXggcGF0Y2gtc2V0ICh2NSkgaGFkIHRoZSAibW9kZWwiIGF0dHJpYnV0
ZQ0KcmVtb3ZlZCBhcyByZXF1ZXN0ZWQgYnkgTmljb2xpbiBDaGVuLCBidXQgbG9va3MgbGlrZSAo
djQpDQp2ZXJzaW9uIG9mIERBSSBkcml2ZXIgcmVhY2hlZCAiZm9yLW5leHQiIGJyYW5jaCAtIGZp
eCB0aGlzLg0KQXNzaWRlIG9mIHRoaXMgZml4IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gbWFj
aGluZSBwcm9iZSByZXBvcnRlZA0KYnkgSnVsaWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDIp
Og0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1vdmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgQVNvQzog
aW14LWF1ZG1peDogZml4IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gcHJvYmUNCg0KIHNvdW5k
L3NvYy9mc2wvZnNsX2F1ZG1peC5jIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIHNvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jIHwgMzEgKysrKysr
KysrLS0tLS0tLS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDQ5
IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNy40DQoNCg==
