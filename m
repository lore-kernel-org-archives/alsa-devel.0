From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 05/10] intelhdmi - probe for monitor/eld
	presence at	module init time
Date: Wed, 18 Nov 2009 17:16:12 +0800
Message-ID: <20091118091612.GA2478@localhost>
References: <20091118043758.141785140@intel.com>
	<20091118043935.310210374@intel.com> <s5hvdh8b3vv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 10651103803
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 10:16:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvdh8b3vv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>, David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBOb3YgMTgsIDIwMDkgYXQgMDU6MDQ6MjBQTSArMDgwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IEF0IFdlZCwgMTggTm92IDIwMDkgMTI6Mzg6MDMgKzA4MDAsCj4gV3UgRmVuZ2d1YW5n
IHdyb3RlOgo+ID4gCj4gPiBUaGlzIGF2b2lkcyBsb3N0IG9mIHByZXNlbmNlIGluZm8gb24gbW9k
dWxlIHJlbG9hZGluZy4KPiA+IFRoZSBwcmVzZW5jZSBpbmZvIHVzZWQgdG8gYmUgb25seSB1cGRh
dGVkIGF0IHRoZSAocmFyZSkgaG90cGx1ZyBldmVudHMuCj4gPiAKPiA+IFByb3Bvc2VkIGJ5IERh
dmlkLCB0aGFua3MhCj4gPiAKPiA+IENDOiBEYXZpZCBIw6RyZGVtYW4gPGRhdmlkQGhhcmRlbWFu
Lm51Pgo+ID4gU2lnbmVkLW9mZi1ieTogV3UgRmVuZ2d1YW5nIDxmZW5nZ3Vhbmcud3VAaW50ZWwu
Y29tPgo+IAo+IEkgdGhpbmsgd2Ugc2hvdWxkIGhhbmRsZSB0aGlzIGFsc28gYXQgcmVzdW1lLgo+
IFR5cGljYWxseSwgdGhlIGNvZGVjIHJlc3VtZSBjYWxsYmFjayBjYWxscyB0aGUgdW5zb2xpY2l0
ZWQgZXZlbnQKPiBleHBsaWNpdGx5Lgo+IAo+IEJ1dCwgdGhlIHJlc3VtZSBjYWxsYmFjayBjYW4g
YmUgdXNlZCBmb3IgcmVzdW1pbmcgZnJvbSB0aGUKPiBwb3dlci1zYXZpbmcgbW9kZSwgdG9vLiAg
VGh1cyBpdCBzaG91bGQgYmUgb3B0aW1pemVkIGFuZCBsZXNzCj4gdmVyYm9zZSwgZS5nLiBjYWNo
ZSB0aGUgRUxEIGJ5dGVzLCBjb21wYXJlIHRoZSBuZXcgZGF0YSB3aXRoIHRoZQo+IGNhY2hlZCBk
YXRhLCBhbmQgc2tpcCB0aGUgcHJvY2VkdXJlIGlmIGl0J3MgdGhlIHNhbWUgY29udGVudC4KPiAK
PiBBbnl3YXksIGFsbCBwYXRjaGVzIGhhdmUgYmVlbiBhcHBsaWVkLCBzbyBsZXQncyBmaXggdGhp
cyBvbiB0aGUKPiBjdXJyZW50IHRyZWUuCgpPSywgdGhhbmtzIGZvciB0aGUgdGlwcy4gIEFjdHVh
bGx5IEkgaGF2ZSBub3QgdGVzdGVkIHN1c3BlbmQvcmVzdW1lCnlldCwgSSB3aWxsIGRvIGl0IG5l
eHQgd2Vlay4gQ3VycmVudGx5IEkgaGF2ZSBzb21lIHBlbmRpbmcgaXRlbXMKKHRoYXQncyB3aHkg
SSBoYXZlIHRvIHB1dCBvZmYgdGhlIGtlZXAtcG93ZXItb24gcGF0Y2gpLgoKVGhhbmtzLApGZW5n
Z3VhbmcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
