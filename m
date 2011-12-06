From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Tue, 6 Dec 2011 13:37:35 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7F45@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
	<1322973076.30390.14.camel@vkoul-udesk3>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>
	<001501ccb361$3af49990$b0ddccb0$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7DAC@bgsmsx502.gar.corp.intel.com>
	<1323151380.1641.7.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BF9524436
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 09:08:18 +0100 (CET)
In-Reply-To: <1323151380.1641.7.camel@vkoul-udesk3>
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
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

PiA+DQo+ID4gRXZlbiB0aGUgdGhyZWFkIHdoaWNoIGFjdHVhbGx5IHdyaXRlcyB0aGUgZGF0YSB0
byByaW5nIGJ1ZmZlciBtYXkgbm90DQo+ID4gaGF2ZSB0aGUgaWRlYSBvZiBmcmFtZXMgU28gdGhl
IHN0YXJ0IHRocmVzaG9sZCBkb2VzIG5vdCByZXF1aXJlIHRvIGJlDQo+ID4gb24gZnJhbWUgYm91
bmRhcmllcy4gSXQgaXMganVzdCB0byBhdm9pZCBTVEFSVCB3aGVuIHRoZSBidWZmZXIgaXMNCj4g
PiB3cml0dGVuIHdpdGggdGhlIGRhdGEuIElmIHRoZSB3cml0ZSBnaXZlcyBtb3JlIGRhdGEgdGhh
biB0aGUgcmluZyBidWZmZXIsIHdyaXRlIHdpbGwNCj4gbm90IHVuYmxvY2sgYW5kIHRoZSB1c2Vy
IHNwYWNlIGFwcGxpY2F0aW9uIG1heSBub3QgYmUgYWJsZSB0byBjYWxsIFNUQVJULg0KPiA+IFRo
aXMgd2lsbCBiZSBhbiBpc3N1ZSBpZiB5b3UgZ28gZm9yIG5vbi1ibG9ja2luZyBpbXBsZW1lbnRh
dGlvbi4NCj4gPiBPdGhlcndpc2UsIFNUQVJUIHNob3VsZCBiZSBjYWxsZWQgaW4gYW5vdGhlciB0
aHJlYWQgdGhhbiB0aGUgdGhyZWFkIHdoaWNoIHdyaXRlcw0KPiB0aGUgZGF0YS4NCj4gWW91IGFy
ZSBjb25mdXNpbmcga2VybmVsIEFQSSB0byB1c2VyIHNwYWNlIHN0dWZmLiBQbGVhc2Ugc3RpY2sg
dG8ga2VybmVsIEFQSSBkaXNjdXNzaW9uDQo+IGhlcmUuIE5ldmVydGhlbGVzcyBhYm92ZSBoYXMg
bm90aGluZyB0byBkbyB3aXRoIHRocmVzaG9sZCBxdWVzdGlvbiENCj4gDQpJIGRvbuKAmXQgdGhp
bmsgeW91IHVuZGVyc3Rvb2QgbXkgcG9pbnQuIEl0IGlzIHRoZSBrZXJuZWwgaW1wbGVtZW50YXRp
b24gd2hpY2ggaW1wYWN0cyB0aGUgdXNlciBzcGFjZQ0KSW1wbGVtZW50YXRpb24uDQoNCj4gDQo+
IC0tDQo+IH5WaW5vZA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
