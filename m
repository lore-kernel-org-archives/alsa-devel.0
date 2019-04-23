From: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v3 0/3] Add runtime PM for SAI digital audio interface
Date: Tue, 23 Apr 2019 07:20:28 +0000
Message-ID: <1556004028.2595.2.camel@nxp.com>
References: <20190422190213.30726-1-daniel.baluta@nxp.com>
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422190213.30726-1-daniel.baluta@nxp.com>
Content-Language: en-US
Content-ID: <49DC249CD2CE524181637C22138BD5A6@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rm9yIHRoaXMgc2VyaWVzOg0KDQpSZXZpZXdlZC1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3Vt
YW5AbnhwLmNvbT4NCg0KT24gTHUsIDIwMTktMDQtMjIgYXQgMTk6MDIgKzAwMDAsIERhbmllbCBC
YWx1dGEgd3JvdGU6DQo+IEZpcnN0IHBhdGNoIGZpeGVzIGEgYnVnIGJ5IGNvcnJlY3RseSBzZXR0
aW5nIGlzX3NsYXZlX21vZGUsIHRoZW4NCj4gc2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3Ig
cnVudGltZSBQTSBhbmQgZmluYWxseSAzcmQgcGF0Y2ggbW92ZXMNCj4gY2xvY2sgaGFuZGxpbmcg
ZnJvbSBzdGFydHVwL3NodHVkb3duIGZ1bmN0aW9uIHRvIHJ1bnRpbWUgUE0gaGFuZGxlcnMuDQo+
IA0KPiBDaGFuZ2VzIHNpbmNlIHYyOiAoYWZ0ZXIgVmlvcmVsJ3MgY29tbWVudHMpDQo+IAktIG5v
IG5lZWQgdG8gY2hlY2sgZm9yIGlzX3NsYXZlX21vZGUgd2hlbiBlbmFibGluZy9kaXNhYmxpbmcg
dGhlIGNsb2Nrcw0KPiAJYmVjYXVzZSBzYWktPm1jbGtfc3RyZWFtcyBpcyBvbmx5IHNldCB3aGVu
IFNBSSBpcyBpbiBtYXN0ZXIgbW9kZS4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6IChhZnRlciBO
aWNvbGluJ3MgY29tbWVudHMpDQo+IAktIGFkZGVkIHBhdGNoIDENCj4gCS0gYWRkZWQgZnNsX3Nh
aV9yZW1vdmUgaW4gb3JkZXIgdG8gY2FsbCBwbV9ydW50aW1lX2Rpc2FibGUNCj4gCS0gb25seSBk
aXNhYmxlL2VuYWJsZSBtY2xrIHdoZW4gU0FJIGluIG1hc3RlciBtb2RlLg0KPiANCj4gRGFuaWVs
IEJhbHV0YSAoMik6DQo+IMKgIEFTb0M6IGZzbF9zYWk6IFVwZGF0ZSBpc19zbGF2ZV9tb2RlIHdp
dGggY29ycmVjdCB2YWx1ZQ0KPiDCoCBBU29DOiBmc2xfc2FpOiBBZGQgc3VwcG9ydCBmb3IgcnVu
dGltZSBwbQ0KPiANCj4gU2hlbmdqaXUgV2FuZyAoMSk6DQo+IMKgIEFTb0M6IGZzbF9zYWk6IE1v
dmUgY2xvY2sgb3BlcmF0aW9uIHRvIFBNIHJ1bnRpbWUNCj4gDQo+IMKgc291bmQvc29jL2ZzbC9m
c2xfc2FpLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4g
DQo+IC0twqANCj4gMi4xNy4xDQo+IA==
