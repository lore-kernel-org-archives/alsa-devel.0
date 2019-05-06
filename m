From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/3] ASoC: SOF: Fix a compile warning with
 CONFIG_PCI=n
Date: Mon, 6 May 2019 10:40:48 -0500
Message-ID: <ea78fa2e-5cc3-2639-4b73-4b9e4f3e1963@linux.intel.com>
References: <20190506150224.1394-1-tiwai@suse.de>
 <20190506150224.1394-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7630FF896FD
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:40:50 +0200 (CEST)
In-Reply-To: <20190506150224.1394-3-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gNS82LzE5IDEwOjAyIEFNLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gQSB0cml2aWFsIGZpeCBm
b3IgdGhlIHJhbmRjb25maWcgYnVpbGQgZXJyb3I6Cj4gICAgc291bmQvc29jL3NvZi9vcHMuYzoy
MDo2OiB3YXJuaW5nOiDigJhyZXTigJkgaXMgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVu
Y3Rpb24gWy1XdW5pbml0aWFsaXplZF0KPiAKPiBGaXhlczogZDFkOTVmY2I2M2UzICgiQVNvQzog
U09GOiBBZGQgRFNQIEhXIGFic3RyYWN0aW9uIG9wZXJhdGlvbnMiKQo+IFNpZ25lZC1vZmYtYnk6
IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KCkkgcmVtZW1iZXIgZml4aW5nIHRoaXMsIHBy
b2JhYmx5IG5ldmVyIGFwcGxpZWQgaXQgdG8gdGhlIHJpZ2h0IGJyYW5jaCAKOi0oIFRoYW5rcyBU
YWthc2hpLgoKQWNrZWQtYnk6IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9z
c2FydEBsaW51eC5pbnRlbC5jb20+CgoKPiAtLS0KPiAgIHNvdW5kL3NvYy9zb2Yvb3BzLmMgfCAy
ICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9vcHMuYyBiL3NvdW5kL3NvYy9zb2Yvb3BzLmMK
PiBpbmRleCA4MGY5MDc3NDBiODIuLjdhMjdjM2I3MTllNyAxMDA2NDQKPiAtLS0gYS9zb3VuZC9z
b2Mvc29mL29wcy5jCj4gKysrIGIvc291bmQvc29jL3NvZi9vcHMuYwo+IEBAIC0xNyw3ICsxNyw3
IEBAIGJvb2wgc25kX3NvZl9wY2lfdXBkYXRlX2JpdHNfdW5sb2NrZWQoc3RydWN0IHNuZF9zb2Zf
ZGV2ICpzZGV2LCB1MzIgb2Zmc2V0LAo+ICAgewo+ICAgCXN0cnVjdCBwY2lfZGV2ICpwY2kgPSB0
b19wY2lfZGV2KHNkZXYtPmRldik7Cj4gICAJdW5zaWduZWQgaW50IG9sZCwgbmV3Owo+IC0JdTMy
IHJldDsKPiArCXUzMiByZXQgPSAwOwo+ICAgCj4gICAJcGNpX3JlYWRfY29uZmlnX2R3b3JkKHBj
aSwgb2Zmc2V0LCAmcmV0KTsKPiAgIAlvbGQgPSByZXQ7Cj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
