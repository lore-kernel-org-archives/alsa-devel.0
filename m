From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] codecs/tlv320aic23: fix bias management
 for suspend/resume
Date: Wed, 23 Jun 2010 11:35:41 +0100
Message-ID: <1277289341.3092.28.camel@odin>
References: <20100619105929.GB2409@opensource.wolfsonmicro.com>
	<1276968819-17285-1-git-send-email-eric@eukrea.com>
	<20100622231752.GC2453@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A3B5424427
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 12:35:43 +0200 (CEST)
Received: by wyb38 with SMTP id 38so910654wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 03:35:43 -0700 (PDT)
In-Reply-To: <20100622231752.GC2453@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAyMDEwLTA2LTIzIGF0IDAwOjE3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IE9u
IFNhdCwgSnVuIDE5LCAyMDEwIGF0IDA3OjMzOjM5UE0gKzAyMDAsIEVyaWMgQsOpbmFyZCB3cm90
ZToKPiAKPiA+IGluIHRsdjMyMGFpYzIzX3NldF9iaWFzX2xldmVsLCBmb3IgdGhlIGNhc2UgU05E
X1NPQ19CSUFTX09OLCB0aGUKPiA+IGNvbW1lbnQgc2F5cyAidnJlZi9taWQsIG9zYyBvbiwgZGFj
IHVubXV0ZSIgYnV0IHRoZSBjb2RlIGRvZXNuJ3QKPiA+IGNsZWFyIHRoZSBjb3JyZXNwb25kaW5n
IGJpdHMsIHRodXMgd2hlbiByZXN1bWluZywgc2V2ZXJhbCBiaXRzIGFyZQo+ID4gbm90IGNsZWFy
ZWQgcHJldmVudGluZyB0aGUgY29kZWMgZnJvbSB3b3JraW5nLgo+IAo+IFNvcnJ5IC0gSSBzaG91
bGQndmUgcmVnaXN0ZXJlZCB0aGF0IHRoaXMgd2FzIG9uZSB0aGF0IHNob3VsZCBnbyB0aHJvdWdo
Cj4gTGlhbSdzIHRyZWUKPiAKPiBBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291
cmNlLndvbGZzb25taWNyby5jb20+Cj4gCkFwcGxpZWQKCkxpYW0KLS0gCkZyZWVsYW5jZSBEZXZl
bG9wZXIsIFNsaW1Mb2dpYyBMdGQKQVNvQyBhbmQgVm9sdGFnZSBSZWd1bGF0b3IgTWFpbnRhaW5l
ci4KaHR0cDovL3d3dy5zbGltbG9naWMuY28udWsKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
