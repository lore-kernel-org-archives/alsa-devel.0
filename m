From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware,
 loader support
Date: Fri, 21 Dec 2018 17:05:04 +0800
Message-ID: <f715299c-d610-2dc2-d968-82c4cf75a5ea@linux.intel.com>
References: <mailman.3934.1544619824.753.alsa-devel@alsa-project.org>
 <1ce21393-048f-6c04-b899-8cbfbf93983e@linux.intel.com>
 <s5h8t0kobov.wl-tiwai@suse.de>
 <05d38b48-559f-75ce-6299-e1dfd3a62c30@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <05d38b48-559f-75ce-6299-e1dfd3a62c30@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: daniel.baluta@gmail.com, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, alan@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDEyLzIwLzIwMTggMTE6MDcgUE0sIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IHdyb3RlOgo+Cj4+
Pj4+ICsgc25kX3NvZl9kc3BfYmxvY2tfd3JpdGUoc2Rldiwgb2Zmc2V0LAo+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQgKilibG9jayArIHNpemVvZigq
YmxvY2spLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxv
Y2stPnNpemUpOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBuZXh0IGJsb2NrICov
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBibG9jayA9ICh2b2lkICopYmxvY2sgKyBzaXplb2YoKmJs
b2NrKSArIGJsb2NrLT5zaXplOwo+Pj4+IFRoaXMgbWF5IGxlYWQgdG8gYW4gdW5hbGlnbmVkIGFj
Y2Vzcy4KPj4+IERpZCB5b3UgbWVhbiB3ZSBzaG91bGQgZG91YmxlIGNoZWNrIHRoZSBibG9jay0+
c2l6ZSB0bwo+Pj4gcHJldmVudCBhY2Nlc3MgdG8gYW4gaW52YWxpZCBhZGRyZXNzPwo+PiBZb3Ug
bmVlZCB0d28gdHlwZXMgb2YgY2hlY2tzIGZvciB0aGUgZ2l2ZW4gZGF0YToKPj4gLSBUaGUgYm91
bmNlIGNoZWNrIG9mIGJsb2NrLT5zaXplOwo+PiDCoMKgIFdlIG5lZWQgdG8gYXZvaWQgb3V0LW9m
LWJvdW5jZSBhY2Nlc3MuCj4gcy9ib3VuY2UvYm91bmRzID8KPj4KPj4gLSBBbGlnbm1lbnQgb2Yg
YmxvY2stPnNpemU7Cj4+IMKgwqAgRm9yIHNvbWUgbm9uLXg4NiBwbGF0Zm9ybXMsIHRoZSBhY2Nl
c3MgdG8gYW4gdW5hbGlnbmVkIGFkZHJlc3MgbWlnaHQKPj4gwqDCoCBiZSBpbGxlZ2FsLgo+Cj4g
TWF5YmUgSSBhbSBtaXNzaW5nIHNvbWV0aGluZyBidXQgSSBkb24ndCBzZWUgYW55IHNvcnQgb2Yg
ZXhwbGljaXQgCj4gcmVzdHJpY3Rpb24gb24gYWxpZ25tZW50IGluIHRoZSBTT0YgdG9vbHMuIGl0
IGxvb2tzIGltcGxpY2l0IGJhc2VkIG9uIAo+IGFkZHJlc3Mgb2Zmc2V0cyBhbmQgYmFzZXMuCgpN
YXliZSBnZXRfdW5hbGlnbmVkKCkgaXMgZ29vZCBlbm91Z2ggdG8gYXZvaWQgdW5hbGlnbmVkIGFj
Y2Vzcz8KCj4KPiBMaWFtLCBkbyB5b3Ugc2VlIGFueSBuZWdhdGl2ZSBzaWRlIGVmZmVjdHMgaWYg
d2UgZW5mb3JjZSBhIDMyLWJpdCAKPiBhbGlnbm1lbnQgZm9yIGFsbCBibG9ja3MgKHdoaWNoIGVz
c2VudGlhbGx5IG1lYW5zIGFsbCBibG9jayBzaXplcyBhcmUgCj4gbXVsdGlwbGUgb2YgNCk/IHdl
IGNhbiB0cnkgYW5kIGV4cGVyaW1lbnQgYnV0IGl0J3MgYmV0dGVyIGlmIHdlIGhhdmUgCj4gYW4g
YWdyZWVtZW50IG9uIHRoZSBkZXNpZ24uCj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
