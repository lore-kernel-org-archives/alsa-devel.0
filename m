From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 0/3] Add runtime PM for SAI digital audio interface
Date: Mon, 22 Apr 2019 19:02:27 +0000
Message-ID: <20190422190213.30726-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Rmlyc3QgcGF0Y2ggZml4ZXMgYSBidWcgYnkgY29ycmVjdGx5IHNldHRpbmcgaXNfc2xhdmVfbW9k
ZSwgdGhlbg0Kc2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcnVudGltZSBQTSBhbmQgZmlu
YWxseSAzcmQgcGF0Y2ggbW92ZXMNCmNsb2NrIGhhbmRsaW5nIGZyb20gc3RhcnR1cC9zaHR1ZG93
biBmdW5jdGlvbiB0byBydW50aW1lIFBNIGhhbmRsZXJzLg0KDQpDaGFuZ2VzIHNpbmNlIHYyOiAo
YWZ0ZXIgVmlvcmVsJ3MgY29tbWVudHMpDQoJLSBubyBuZWVkIHRvIGNoZWNrIGZvciBpc19zbGF2
ZV9tb2RlIHdoZW4gZW5hYmxpbmcvZGlzYWJsaW5nIHRoZSBjbG9ja3MNCgliZWNhdXNlIHNhaS0+
bWNsa19zdHJlYW1zIGlzIG9ubHkgc2V0IHdoZW4gU0FJIGlzIGluIG1hc3RlciBtb2RlLg0KDQpD
aGFuZ2VzIHNpbmNlIHYxOiAoYWZ0ZXIgTmljb2xpbidzIGNvbW1lbnRzKQ0KCS0gYWRkZWQgcGF0
Y2ggMQ0KCS0gYWRkZWQgZnNsX3NhaV9yZW1vdmUgaW4gb3JkZXIgdG8gY2FsbCBwbV9ydW50aW1l
X2Rpc2FibGUNCgktIG9ubHkgZGlzYWJsZS9lbmFibGUgbWNsayB3aGVuIFNBSSBpbiBtYXN0ZXIg
bW9kZS4NCg0KRGFuaWVsIEJhbHV0YSAoMik6DQogIEFTb0M6IGZzbF9zYWk6IFVwZGF0ZSBpc19z
bGF2ZV9tb2RlIHdpdGggY29ycmVjdCB2YWx1ZQ0KICBBU29DOiBmc2xfc2FpOiBBZGQgc3VwcG9y
dCBmb3IgcnVudGltZSBwbQ0KDQpTaGVuZ2ppdSBXYW5nICgxKToNCiAgQVNvQzogZnNsX3NhaTog
TW92ZSBjbG9jayBvcGVyYXRpb24gdG8gUE0gcnVudGltZQ0KDQogc291bmQvc29jL2ZzbC9mc2xf
c2FpLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjE3LjENCg0K
