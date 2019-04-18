From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: fix
 compilation warning and quirk handling
Date: Thu, 18 Apr 2019 13:57:10 +0200
Message-ID: <9d12bcab-40d8-c6c6-017a-cbaad64903d8@redhat.com>
References: <20190410160548.24317-1-pierre-louis.bossart@linux.intel.com>
 <fec99a28-8109-659a-a51e-f1475a015144@redhat.com>
 <cbd7885e-07a0-fadb-b5dd-21e7cdec9b25@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49E0EF8065D
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2019 13:57:11 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id k1so1453635wrw.0
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2019 04:57:11 -0700 (PDT)
In-Reply-To: <cbd7885e-07a0-fadb-b5dd-21e7cdec9b25@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Paul Cercueil <paul@crapouillou.net>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAxMC0wNC0xOSAxOTo1OCwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+
IFRoZXJlIGlzIGEgZ29vZCByZWFzb24gdG8gdXNlIC0xIGZvciBxdWlyay1vdmVycmlkZSBub3Qg
c2V0Lgo+Pgo+PiBUaGUgdXNlciBtYXkgd2FudCB0byBvdmVycmlkZSB0aGUgcXVpcmsgdmFyaWFi
bGUgdG8gYWN0dWFsIDAsIG9uCj4+IENIVCB3ZSBkZWZhdWx0IHRvOgo+Pgo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBPdGhlcnMgZGVmYXVsdCB0byBpbnRlcm5hbC1taWMt
aW4xLW1hcCwgbW9uby1zcGVha2VyICovCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHF1aXJrID0gQllUX0NIVF9FUzgzMTZfSU5UTUlDX0lOMV9NQVAgfAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQllUX0NIVF9FUzgzMTZfTU9O
T19TUEVBS0VSOwo+Pgo+PiBXaGljaCBpcyAweDIwMDAwLCBpZiB0aGUgdXNlciBub3cganVzdHMg
d2FudHMgdG8gY2xlYXIgdGhlCj4+IEJZVF9DSFRfRVM4MzE2X01PTk9fU1BFQUtFUiBmbGFnIHRo
cm91Z2ggdGhlIG92ZXJyaWRlLCB0aGVuIHRoZSB1c2VyCj4+IG11c3QgYmUgYWJsZSB0byBzcGVj
aWZ5IDAgYXMgb3ZlcnJpZGUuCj4gCj4gb2ssIEkgYWNjZXB0IHRoZSBhcmd1bWVudCBidXQgdGhl
biB3aHkgZG9uJ3Qgd2UgZG8gdGhlIHNhbWUgaW4gb3RoZXIgbWFjaGluZSBkcml2ZXJzPyBJIGNv
dWxkIG1ha2UgdGhlIHNhbWUgYXJndW1lbnQgZm9yIGJ5dGNyX3J0NTY0MC81MSwgc28gd2Ugc2hv
dWxkIGFsaWduIGFsbCBtYWNoaW5lIGRyaXZlcnMgdXNpbmcgdGhpcyBtZWNoYW5pc20uCgpJIGFn
cmVlIHRoYXQgaWRlYWxseSBhbGwgbWFjaGluZSBkcml2ZXJzIHNob3VsZCBiZSB1cGRhdGVkIHRv
IHVzZSAtMQpmb3IgInF1aXJrIG92ZXJyaWRlIG5vdCBzZXQiLiBUaGUgZHJpdmVycyB3aGljaCBh
cmUgY3VycmVudGx5IG5vdAp1c2luZyAtMSBhbHJlYWR5IGhhZCB0aGVpciBjdXJyZW50IHF1aXJr
LW92ZXJyaWRlIGltcGxlbWVudGF0aW9uIGluCnBsYWNlIGJlZm9yZSBJIHN0YXJ0ZWQgd29ya2lu
ZyBvbiB0aGVtLgoKUmVnYXJkcywKCkhhbnMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
