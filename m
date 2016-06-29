From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: [REPOST REPOST PATCH v3 0/3] ASoC: Reduce audio
 related kernel spew.
Date: Wed, 29 Jun 2016 23:39:09 +0000
Message-ID: <1467243549.32449.11.camel@intel.com>
References: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
 <1466815031-31922-1-git-send-email-vedang.patel@intel.com>
 <20160627145029.GX28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3814A266A00
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 01:39:12 +0200 (CEST)
In-Reply-To: <20160627145029.GX28202@sirena.org.uk>
Content-Language: en-US
Content-ID: <F7AA0BE743CEB44494AE683D651C34AF@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Herbert, Marc" <marc.herbert@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

VGhhbmtzIE1hcmsgZm9yIG1lcmdpbmcgdGhlIHBhdGNoZXMuIEkgYXBvbG9naXplIGZvciBhbnkg
dW53YW50ZWQgbm9pc2UNCmluIHlvdXIgaW5ib3guDQoNCkkgZGlkIHBvc3QgdGhlIHBhdGNoZXMg
YSBmZXcgd2Vla3MgYmFjayAoaHR0cDovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9hDQpsc2EtZGV2
ZWwvbXNnNTA3ODIuaHRtbCkuIFRoZSBvbmx5IGRpZmZlcmVuY2UgdGhpcyB0aW1lIHdhcyBJIGNj
J2VkIHlvdQ0KaW4gdGhlIHBhdGNoZXMuIE1vdmluZyBmb3J3YXJkLCB3aGF0IGlzIHRoZSBwcmVm
ZXJyZWQgbWV0aG9kIGZvcg0Kc3VibWl0dGluZyBwYXRjaGVzIGZvciB0aGUgZmlyc3QgdGltZSBv
ciByZXBvc3RpbmcgdGhlbSBzbyB0aGF0IHlvdSBhcmUNCmxlc3MgbGlrZWx5IHRvIG1pc3MgdGhl
bT8NCg0KVGhhbmtzLA0KVmVkYW5nDQoNCk9uIE1vbiwgMjAxNi0wNi0yNyBhdCAxNTo1MCArMDEw
MCwgTWFyayBCcm93biB3cm90ZToNCj4gT24gRnJpLCBKdW4gMjQsIDIwMTYgYXQgMDU6Mzc6MDhQ
TSAtMDcwMCwgdmVkYW5nLnBhdGVsQGludGVsLmNvbQ0KPiB3cm90ZToNCj4gPiANCj4gPiBGcm9t
OiBWZWRhbmcgUGF0ZWwgPHZlZGFuZy5wYXRlbEBpbnRlbC5jb20+DQo+ID4gDQo+ID4gVGhlcmUg
aGF2ZSBiZWVuIGNvbXBsYWludHMgcmVnYXJkaW5nIGF1ZGlvIHJlbGF0ZWQga2VybmVsIG1lc3Nh
Z2VzDQo+ID4gZmxvb2RpbmcNCj4gPiBkbWVzZy4gVGhpcyBzZXJpZXMgdHJpZXMgdG8gYWRkcmVz
cyB0aG9zZSBjb21wbGFpbnRzLg0KPiBQbGVhc2UgZG9uJ3QgaW5jbHVkZSBub2lzZSBsaWtlIFJF
UE9TVCBpbiB0aGUgc3ViamVjdCBsaW5lLA0KPiBlc3BlY2lhbGx5DQo+IG5vdCBhdCB0aGUgc3Rh
cnQgb2YgdGhlIHN1YmplY3QgbGluZSB3aGVyZSBpdCBtYWtlcyBpdCBsb29rIGxlc3MgbGlrZQ0K
PiBhDQo+IHBhdGNoIGUtbWFpbCBhbmQgc28gaGFyZGVyIHRvIHNwb3QgaW4gYW4gaW5ib3guwqDC
oEkgYWxzbyBub3RlIHRoYXQNCj4gdGhpcw0KPiBhcHBlYXJzIHRvIGJlIHRoZSBmaXJzdCB0aW1l
IHlvdSd2ZSBzZW50IG1lIHRoZXNlIHBhdGNoZXMuLi4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
