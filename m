From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: simple-scu-card: Parse off codec
	widgets
Date: Mon, 21 Aug 2017 08:31:41 +0000
Message-ID: <1503304300.24887.78.camel@nxp.com>
References: <1502460739-12134-1-git-send-email-daniel.baluta@nxp.com>
 <87inhhdaeh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0079.outbound.protection.outlook.com [104.47.1.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D885266BCF
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 10:31:44 +0200 (CEST)
In-Reply-To: <87inhhdaeh.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <4DFA77F0B53FA546842762A8747D0799@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, Viorel Suman <viorel.suman@nxp.com>, Mihai Serban <mihai.serban@nxp.com>
List-Id: alsa-devel@alsa-project.org

T24gTHUsIDIwMTctMDgtMjEgYXQgMDA6NDMgKzAwMDAsIEt1bmlub3JpIE1vcmltb3RvIHdyb3Rl
Og0KPiBIaQ0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5p
ZWwuYmFsdXRhQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gwqBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLXNjdS1jYXJkLnR4dCB8IDEgKw0KPiA+IMKgc291bmQv
c29jL2dlbmVyaWMvc2ltcGxlLXNjdS1jYXJkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgNCArKysrDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLXNjdS1jYXJkLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zaW1wbGUtc2N1LWNhcmQudHh0DQo+ID4gaW5kZXgg
MzI3ZDIyOS4uMzJmOGRiYyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLXNjdS1jYXJkLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zaW1wbGUtc2N1LWNhcmQudHh0DQo+ID4g
QEAgLTI0LDYgKzI0LDcgQEAgT3B0aW9uYWwgc3Vibm9kZSBwcm9wZXJ0aWVzOg0KPiA+IMKgLSBz
aW1wbGUtYXVkaW8tY2FyZCxjb252ZXJ0LXJhdGUJOiBwbGF0Zm9ybSBzcGVjaWZpZWQgc2FtcGxp
bmcgcmF0ZSBjb252ZXJ0DQo+ID4gwqAtIHNpbXBsZS1hdWRpby1jYXJkLGNvbnZlcnQtY2hhbm5l
bHMJOiBwbGF0Zm9ybSBzcGVjaWZpZWQgY29udmVydGVkIGNoYW5uZWwgc2l6ZSAoMiAtIDggY2gp
DQo+ID4gwqAtIHNpbXBsZS1hdWRpby1jYXJkLHByZWZpeAkJOiBzZWUgcm91dGluZw0KPiA+ICst
IHNpbXBsZS1hdWRpby1jYXJkLHdpZGdldHMJCTogUGxlYXNlIHJlZmVyIHRvIHdpZGdldHMudHh0
Lg0KPiA+IMKgLSBzaW1wbGUtYXVkaW8tY2FyZCxyb3V0aW5nCQk6IEEgbGlzdCBvZiB0aGUgY29u
bmVjdGlvbnMgYmV0d2VlbiBhdWRpbyBjb21wb25lbnRzLg0KPiA+IMKgCQkJCQnCoMKgRWFjaCBl
bnRyeSBpcyBhIHBhaXIgb2Ygc3RyaW5ncywgdGhlIGZpcnN0IGJlaW5nIHRoZSBjb25uZWN0aW9u
J3Mgc2luaywNCj4gPiDCoAkJCQkJwqDCoHRoZSBzZWNvbmQgYmVpbmcgdGhlIGNvbm5lY3Rpb24n
cyBzb3VyY2UuIFZhbGlkIG5hbWVzIGZvciBzb3VyY2VzLg0KPiBJdCBjYW4gYmUgInNlZSBzaW1w
bGUtYXVkaW8tY2FyZC50eHQiIHNhbWUgYXMgb3RoZXIgcHJvcGVydGllcy4NCj4gTm90IGEgYmln
IGRlYWwgdGhvdWdoDQo+IA0KPiBBY2tlZC1ieTogS3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3Jp
Lm1vcmltb3RvLmd4QHJlbmVzYXMuY29tPg0KDQpUaGFua3MgZm9yIGhhdmluZyBhIGxvb2suIEkg
ZG9uJ3QgaGF2ZSBhIHN0cm9uZyBwcmVmZXJlbmNlLCBidXQgZ2l2ZW4gdGhhdA0KdGhlIHBhdGNo
IHdhcyBhbHJlYWR5IHB1c2hlZCBhbmQgd2hlbiB5b3UnbGwgZ28gdG8gc2ltcGxlLWF1ZGlvLWNh
cmQudHh0IGl0DQp3aWxsIHBvaW50IHlvdSB0byB3aWRnZXRzLnR4dCB3ZSBjYW4gbGVhdmUgaXQg
bGlrZSB0aGF0Lg0KDQpEYW5pZWwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
