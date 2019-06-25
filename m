From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
 UUID API
Date: Tue, 25 Jun 2019 20:15:19 +0300
Message-ID: <20190625171519.GE9224@smile.fi.intel.com>
References: <20190619150213.87691-1-andriy.shevchenko@linux.intel.com>
 <20190624105157.18a348ce@xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0B00F8075C
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 19:15:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190624105157.18a348ce@xxx>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKdW4gMjQsIDIwMTkgYXQgMTA6NTE6NTdBTSArMDIwMCwgQW1hZGV1c3ogU8WCYXdp
xYRza2kgd3JvdGU6Cj4gT24gV2VkLCAxOSBKdW4gMjAxOSAxODowMjoxMyArMDMwMAo+IEFuZHkg
U2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToKClRo
YW5rcyBmb3IgcmV2aWV3LCB0aG91Z2ggdGhpcyBvbmUgd2lsbCBiZSBwYXJ0IG9mIHVwc3RyZWFt
LgoKPiA+IC1zdHJ1Y3QgVVVJRCB7Cj4gPiAtCXU4IGlkWzE2XTsKPiA+IC19Owo+ID4gLQoKPiA+
ICBzdHJ1Y3QgYWRzcF9tb2R1bGVfZW50cnkgewo+ID4gIAl1MzIgc3RydWN0X2lkOwo+ID4gIAl1
OCAgbmFtZVs4XTsKPiA+IC0Jc3RydWN0IFVVSUQgdXVpZDsKPiA+ICsJdTggIHV1aWRbMTZdOwo+
IAo+IGd1aWRfdCB1dWlkOwoKVGhpcyBzZWVtcyBhIHBhcnQgb2YgQUJJLgpBQkkgZG9lc24ndCBh
bmQgc2hvdWxkbid0IGtub3cgYW55dGhpbmcgYWJvdXQga2VybmVsIGludGVybmFsIHR5cGVzLgoK
SWYgSSdtIG1pc3Rha2VuLCBvbmUsIHdobyBrbm93cyBiZXR0ZXIgdGhlIGFyZWEsIGNhbiBzdWJt
aXQgYSBmb2xsb3d1cC4KCj4gPiAgc3RydWN0IHNrbF9tb2R1bGVfaW5zdF9pZCB7Cj4gPiAtCXV1
aWRfbGUgbW9kX3V1aWQ7Cj4gPiArCWd1aWRfdCBtb2RfdXVpZDsKPiA+ICAJaW50IG1vZHVsZV9p
ZDsKPiA+ICAJdTMyIGluc3RhbmNlX2lkOwo+ID4gIAlpbnQgcHZ0X2lkOwo+ID4gQEAgLTM2MCw3
ICszNjAsNyBAQCBzdHJ1Y3Qgc2tsX21vZHVsZV9yZXMgewo+ID4gIH07Cj4gPiAgCj4gPiAgc3Ry
dWN0IHNrbF9tb2R1bGUgewo+ID4gLQl1dWlkX2xlIHV1aWQ7Cj4gPiArCWd1aWRfdCB1dWlkOwo+
ID4gIAl1OCBsb2FkYWJsZTsKPiA+ICAJdTggaW5wdXRfcGluX3R5cGU7Cj4gPiAgCXU4IG91dHB1
dF9waW5fdHlwZTsKPiAKPiAKPiBJIHdvdWxkIGFsc28gYWRkOgo+IAo+IHN0cnVjdCBza2xfbW9k
dWxlX2NmZyB7Cj4gLQl1OCBndWlkWzE2XTsKPiArCWd1aWRfdCB1dWlkOwo+IAo+IHNob3VsZCBn
ZXQgcmlkIG9mIGZldyBjYXN0cyBhYm92ZS4gT3ZlcmFsbCBJIHdvdWxkIGV4cGVjdCBubyBjYXN0
cyBhdAo+IGFsbC4KClNlZSBhYm92ZS4KCk5ldmVydGhlbGVzcywgdGhlcmUgaXMgYW4gaWRlYSB0
byBhZGQgc29tZSB3cmFwcGVycyB0byBVVUlEIGZyYW1ld29yayB0byBjb3ZlcgpjYXNlcyB3aGVu
IHJhdyBidWZmZXIgaXMgY29waWVkIHRvIFVVSUQgdHlwZSBvciBiYWNrIGFuZCBhY2NvbXBhbnlp
bmcgQVBJLgoKQXQgbGVhc3QgYnRyZnMgZXhwZWN0cyBzdWNoLgoKSSB3aWxsIHRyeSB0byBrZWVw
IHRoaXMgaW4gbWluZCBhbmQgY29udmVydCBBU29DIHN0dWZmIHRvIHRoZSBuZXcgQVBJIHdoZW4g
aXQKYXBwZWFycyBpbiB0aGUgdXBzdHJlYW0uCgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkg
U2hldmNoZW5rbwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
