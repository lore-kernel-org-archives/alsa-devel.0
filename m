From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH v5 1/3] ARM: mxs: add saif clkmux functions
Date: Fri, 18 Nov 2011 08:57:52 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722E4962@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
	<1321003855-13430-2-git-send-email-b29396@freescale.com>
	<201111180554.42242.marek.vasut@gmail.com>
	<65EE16ACC360FA4D99C96DC085B3F7722E47BC@039-SN1MPN1-002.039d.mgd.msft.net>
	<20166.6019.921262.50184@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 55B5C10383B
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 09:58:05 +0100 (CET)
In-Reply-To: <20166.6019.921262.50184@ipc1.ka-ro>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, Marek Vasut <marek.vasut@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3RoYXIgV2HDn21hbm4gW21h
aWx0bzpMV0BLQVJPLWVsZWN0cm9uaWNzLmRlXQ0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE4
LCAyMDExIDQ6MzAgUE0NCj4gVG86IERvbmcgQWlzaGVuZy1CMjkzOTYNCj4gQ2M6IE1hcmVrIFZh
c3V0OyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
DQo+IGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tOyB3LnNhbmdAcGVuZ3V0cm9u
aXguZGU7IEd1byBTaGF3bi0NCj4gUjY1MDczOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZTsgbHJnQHRpLmNvbTsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJFOiBbYWxzYS1kZXZlbF0gW1BBVENI
IHY1IDEvM10gQVJNOiBteHM6IGFkZCBzYWlmIGNsa211eA0KPiBmdW5jdGlvbnMNCj4gDQo+IEhp
LA0KPiANCj4gRG9uZyBBaXNoZW5nLUIyOTM5NiB3cml0ZXM6DQo+IFsuLi5dDQo+ID4gPiA+ICsj
ZGVmaW5lIEhXX0RJR0NUTF9DVFJMCQkJMHgwDQo+ID4gPiA+ICsjZGVmaW5lICBCUF9ESUdDVExf
Q1RSTF9TQUlGX0NMS01VWAkoMTApDQo+ID4gPg0KPiA+ID4gRG8geW91IG5lZWQgdGhlIHBhcmVu
dGhlc2lzIGFib3ZlID8NCj4gPiA+DQo+ID4gSSdtIG5vdCBzdXJlIGFib3V0IGhpcy4NCj4gPiBI
V19ESUdDVExfQ1RSTCBpcyB0aGUgcmVnaXN0ZXIgb2Zmc2V0Lg0KPiA+IERvIHdlIGhhdmUgdG8g
ZG8gdGhpcz8NCj4gPg0KPiBZb3UgbmVlZCBwYXJlbnMgYXJvdW5kIG1hY3JvIHBhcmFtZXRlcnMg
dGhhdCBhcmUgdXNlZCBpbiBhbiBleHByZXNzaW9uDQo+IGluc2lkZSB0aGUgbWFjcm8uIEJ1dCB5
b3UgbmV2ZXIgZXZlciBuZWVkIHRvIGVuY2xvc2UgYSBiYXJlIG51bWJlciBpbg0KPiBwYXJlbnMh
DQo+IA0KWWVwIQ0KSSB3aWxsIHJlbW92ZSBpdC4NClNhdmluZyB0d28gYnl0ZXMgaW4gY29kZSBz
aXplISA6LSkNCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
