From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v2 3/3] ASoC: rt5677: Remove never used
	variables
Date: Thu, 20 Jul 2017 01:47:26 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694023B541D@RTITMBSV02.realtek.com.tw>
References: <20170718173419.65980-1-andriy.shevchenko@linux.intel.com>
 <20170718173419.65980-4-andriy.shevchenko@linux.intel.com>
 <20170719112412.wrqgdk7typqie72d@sirena.org.uk>
 <1500464913.29303.105.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C8E8D267343
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 03:47:41 +0200 (CEST)
In-Reply-To: <1500464913.29303.105.camel@linux.intel.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Keeping <john@metanate.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

PiBPbiBXZWQsIDIwMTctMDctMTkgYXQgMTI6MjQgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
ID4gT24gVHVlLCBKdWwgMTgsIDIwMTcgYXQgMDg6MzQ6MTlQTSArMDMwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOg0KPiA+ID4gVGhlcmUgYXJlIHR3byB2YXJpYWJsZXMgdGhhdCBoYXZlIG5ldmVy
IGJlZW4gdXNlZC4NCj4gPiA+DQo+ID4gPiBzb3VuZC9zb2MvY29kZWNzL3J0NTY3Ny5jOjc4NToz
NTogd2FybmluZzog4oCYaW5fdm9sX3RsduKAmSBkZWZpbmVkIGJ1dA0KPiA+ID4gbm90IHVzZWQg
Wy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0gc3RhdGljIGNvbnN0DQo+ID4gPiBERUNMQVJFX1RM
Vl9EQl9TQ0FMRShpbl92b2xfdGx2LCAtMzQ1MCwgMTUwLCAwKTsNCj4gPiA+DQo+ID4gPiBzb3Vu
ZC9zb2MvY29kZWNzL3J0NTY3Ny5jOjc4MzozNTogd2FybmluZzog4oCYb3V0X3ZvbF90bHbigJkg
ZGVmaW5lZCBidXQNCj4gPiA+IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dIHN0
YXRpYyBjb25zdA0KPiA+ID4gREVDTEFSRV9UTFZfREJfU0NBTEUob3V0X3ZvbF90bHYsIC00NjUw
LCAxNTAsIDApOw0KPiA+ID4NCj4gPiA+IFNpbXBsZSByZW1vdmUgdGhlbS4NCj4gPg0KPiA+IEFy
ZSB3ZSBzdXJlIHRoaXMgZG9lc24ndCBtZWFuIHNvbWV0aGluZyBoYXMgdGhlIHdyb25nIFRMViBv
ciBhIG1pc3NpbmcNCj4gPiBUTFY/DQo+IA0KPiBHb29kIHF1ZXN0aW9uLg0KPiANCj4gSWYgaXQg
c28sIGl0IHNob3VsZCBub3QgaGF2ZSBiZWVuIHdvcmtpbmcgKHByb3Blcmx5KSBhdCB0aGUgYmVn
aW5uaW5nLg0KPiANCj4gR3V5cyBmcm9tIFJlYWx0ZWssIGNhbiB5b3UgY29tbWVudCBvbiB0aGlz
Pw0KPiANClRoZXkgYXJlIHNlZW1lZCByZWR1bmRhbnQgZGVmaW5pdGlvbnMsIHRoYW5rcy4gDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
