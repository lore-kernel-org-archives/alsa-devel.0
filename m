From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ams-delta: remove duplicate 'const'
Date: Thu, 7 Mar 2019 15:26:41 +0200
Message-ID: <52357a40-17d3-9dbe-d53c-58baa13116dd@ti.com>
References: <20190307101101.613881-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 990D1F8065A
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 14:26:07 +0100 (CET)
In-Reply-To: <20190307101101.613881-1-arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nick Desaulniers <ndesaulniers@google.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

CgpPbiAwNy8wMy8yMDE5IDEyLjEwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IGNsYW5nIHBvaW50
cyBvdXQgdGhhdCBTT0NfRU5VTV9TSU5HTEVfRVhUX0RFQ0woKSBjb250YWlucyBhICdjb25zdCcK
PiBtb2RpZmllciBhbHJlYWR5LCBzbyBhZGRpbmcgYW5vdGhlciBvbmUgZG9lcyBub3QgbWFrZSBp
dCBtb3JlIGNvbnN0Ogo+IAo+IHNvdW5kL3NvYy90aS9hbXMtZGVsdGEuYzoyMDM6MTQ6IGVycm9y
OiBkdXBsaWNhdGUgJ2NvbnN0JyBkZWNsYXJhdGlvbiBzcGVjaWZpZXIgWy1XZXJyb3IsLVdkdXBs
aWNhdGUtZGVjbC1zcGVjaWZpZXJdCj4gc3RhdGljIGNvbnN0IFNPQ19FTlVNX1NJTkdMRV9FWFRf
REVDTChhbXNfZGVsdGFfYXVkaW9fZW51bSwKPiAgICAgICAgICAgICAgXgo+IGluY2x1ZGUvc291
bmQvc29jLmg6MzUxOjI6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ1NPQ19FTlVNX1NJTkdM
RV9FWFRfREVDTCcKPiAgICAgICAgIGNvbnN0IHN0cnVjdCBzb2NfZW51bSBuYW1lID0gU09DX0VO
VU1fU0lOR0xFX0VYVChBUlJBWV9TSVpFKHh0ZXh0cyksIHh0ZXh0cykKClJldmlld2VkLWJ5OiBQ
ZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPgoKPiAKPiBTaWduZWQtb2ZmLWJ5
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+IC0tLQo+ICBzb3VuZC9zb2MvdGkvYW1z
LWRlbHRhLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvdGkvYW1zLWRlbHRhLmMgYi9zb3Vu
ZC9zb2MvdGkvYW1zLWRlbHRhLmMKPiBpbmRleCA0ZGNlNDk0ZGZiZDMuLmI5NjExZGIxNGM4NiAx
MDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvdGkvYW1zLWRlbHRhLmMKPiArKysgYi9zb3VuZC9zb2Mv
dGkvYW1zLWRlbHRhLmMKPiBAQCAtMjAwLDcgKzIwMCw3IEBAIHN0YXRpYyBpbnQgYW1zX2RlbHRh
X2dldF9hdWRpb19tb2RlKHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAo+ICAJcmV0dXJu
IDA7Cj4gIH0KPiAgCj4gLXN0YXRpYyBjb25zdCBTT0NfRU5VTV9TSU5HTEVfRVhUX0RFQ0woYW1z
X2RlbHRhX2F1ZGlvX2VudW0sCj4gK3N0YXRpYyBTT0NfRU5VTV9TSU5HTEVfRVhUX0RFQ0woYW1z
X2RlbHRhX2F1ZGlvX2VudW0sCj4gIAkJCQkgICAgICBhbXNfZGVsdGFfYXVkaW9fbW9kZSk7Cj4g
IAo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgYW1zX2RlbHRhX2F1ZGlv
X2NvbnRyb2xzW10gPSB7Cj4gCgotIFDDqXRlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBP
eSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElE
OiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
