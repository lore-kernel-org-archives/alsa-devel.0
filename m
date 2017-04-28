From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Fri, 28 Apr 2017 16:21:55 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F882502622@SHSMSX103.ccr.corp.intel.com>
References: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
 <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
 <CAD8Lp44uqQW9+V_ZgB4LLXa8WFb+=CX8hT8PmWbZEGFhZGTvBw@mail.gmail.com>
 <7dbec345-e058-18ca-b4b3-e071fbc08fb0@linux.intel.com>
 <CAD8Lp47u3ERC_pn4ScJ6DQZ9HOuDcUZ0zM4fEQ99c3EVzP_YXA@mail.gmail.com>
 <1493375701.2540.53.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F88250258C@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C87E266A53
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 18:22:01 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F88250258C@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Daniel Drake <drake@endlessm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbHNhLWRldmVsLWJvdW5jZXNA
YWxzYS1wcm9qZWN0Lm9yZyBbbWFpbHRvOmFsc2EtZGV2ZWwtDQo+IGJvdW5jZXNAYWxzYS1wcm9q
ZWN0Lm9yZ10gT24gQmVoYWxmIE9mIExpbiwgTWVuZ2RvbmcNCj4gU2VudDogRnJpZGF5LCBBcHJp
bCAyOCwgMjAxNyAxMTowMyBQTQ0KPiA+DQo+ID4gSSB0aGluayBpdCB3YXMgcHJvYmFibHkgZHVl
IHRvIG91ciBsaW1pdGVkIG51bWJlciBvZiB0ZXN0IG1hY2hpbmVzIGFsbA0KPiA+IHJlcG9ydGlu
ZyBiZXR0ZXIgaW5mbyB2aWEgRE1JX0JPQVJEX1ZFTkRPUi4NCj4gPg0KPiA+ID4gSW4gYSBETUkg
ZGF0YWJhc2Ugb2YgMTEzIFBDIG1vZGVscyB0aGF0IHdlIGhhdmUgd29ya2VkIHdpdGggaGVyZToN
Cj4gPiA+DQo+ID4gPiAxMTIgaGF2ZSBjb3JyZWN0L21lYW5pbmdmdWwgc3lzX3ZlbmRvciwgMSBp
cyB1c2VsZXNzIChUbyBiZSBmaWxsZWQNCj4gPiA+IGJ5DQo+ID4gPiBPRU0pDQo+ID4gPiAxMDYg
aGF2ZSBjb3JyZWN0IGJvYXJkX3ZlbmRvciwgNyBoYXZlIGluY29ycmVjdCBvciB1c2VsZXNzIHZh
bHVlcw0KPiA+ID4NCj4gPiA+IEFuZCBhd2t3YXJkbHkgdGhlIG9uZSBzeXN0ZW0gdGhhdCBJJ2Qg
bGlrZSB0byBtYXRjaCBpbiBVQ00gcnVsZXMNCj4gPiA+IGhlcmUgaGFzIGNvcnJlY3Qgc3lzX3Zl
bmRvciBidXQgYmFkIGJvYXJkX3ZlbmRvci4NCj4gPiA+DQo+ID4NCj4gPiBTbyBnaXZlbiB5b3Vy
IGxhcmdlciBkYXRhYmFzZSBpcyBzaG93aW5nIGJldHRlciByZXN1bHRzIGZvcg0KPiA+IERNSV9T
WVNfVkVORE9SIGl0IG1heSBiZSBiZXN0IHRvIHRyeSB0aGlzIGZpcnN0IGFuZCBpZiB0aGF0J3Mg
TlVMTA0KPiA+IHRoZW4gdXNlIERNSV9CT0FSRF9WRU5ET1IuDQo+IA0KPiBZZXMsIGl04oCZcyBi
ZXR0ZXIgdG8gb25seSB1c2Ugb25lIG5hbWUuIE90aGVyd2lzZSwgaXQncyBwb3NzaWJsZSB0byBl
eGNlZWQgODANCj4gY2hhcmFjdGVycyBsaW1pdCBmb3IgdGhlIGNhcmQgbG9uZyBuYW1lIHNpbmNl
IHNvbWV0aW1lcyBETUkgZmllbGRzIGNhbiBiZQ0KPiBsb25nLg0KPiANCj4gPg0KPiA+IFdvdWxk
IHlvdSBjYXJlIHRvIHN1Ym1pdCBhIHBhdGNoID8gb3IgTWVuZ2RvbmcgPyAgU29ycnksIEkgd29u
dCBiZQ0KPiA+IGFibGUgdG8gZ2V0IHRvIHRoaXMgZm9yIGEgd2VlayBkdWUgdG8gc29tZSB0cmF2
ZWwuDQo+ID4NCj4gDQo+IEkgd2lsbCBmaXggdGhpcyBlYXJseSBuZXh0IHdlZWsgYWZ0ZXIgZG91
YmxlIGNoZWNraW5nIG15IG1hY2hpbmVzIG9uIGhhbmQuDQo+IERhbmllbCdzIGRhdGFiYXNlIGlz
IG11Y2ggbGFyZ2VyIHRoYW4gbXkgdGVzdCBzZXQgYW5kIHNvIHdlIG5lZWQgdG8NCj4gc3VwcG9y
dCA6LSkNCg0KSSBqdXN0IHN1Ym1pdHRlZCBhIHBhdGNoIHRvIGZpeCB0aGlzIGh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwvMjAxNy1BcHJpbC8xMjAy
NzEuaHRtbA0KSXQgcGFzc2VkIGJ1aWxkaW5nIGFuZCBJIHdpbGwgdGVzdCBpdCBuZXh0IFR1ZXNk
YXkuIDMgSW50ZWwgbWFjaGluZXMgbWF5IGhhdmUgbnVsbCBETUlfU1lTX1ZFTkRPUi4NCg0KVGhh
bmtzDQpNZW5nZG9uZw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
