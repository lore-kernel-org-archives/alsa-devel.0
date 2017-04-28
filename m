From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 1/3] ASoC: simple-card: Use devm_kcalloc()
 in asoc_simple_card_parse_aux_devs()
Date: Fri, 28 Apr 2017 12:48:15 +0200
Message-ID: <49bbbcac-f970-bbb9-c66b-c9c25229cc6a@users.sourceforge.net>
References: <8b5e37d1-17c5-4551-801f-ca7939d5efd7@users.sourceforge.net>
 <8c8c6979-0368-9ef5-2e10-57199f0bc03e@users.sourceforge.net>
 <20170428085735.i7xpxph24t5v5f5q@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 900EB266860
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 12:48:35 +0200 (CEST)
In-Reply-To: <20170428085735.i7xpxph24t5v5f5q@piout.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Pj4gQEAgLTMzNCw4ICszMzQsOCBAQCBzdGF0aWMgaW50IGFzb2Nfc2ltcGxlX2NhcmRfcGFyc2Vf
YXV4X2RldnMoc3RydWN0IGRldmljZV9ub2RlICpub2RlLAo+PiAgCWlmIChuIDw9IDApCj4+ICAJ
CXJldHVybiAtRUlOVkFMOwo+PiAgCj4+IC0JY2FyZC0+YXV4X2RldiA9IGRldm1fa3phbGxvYyhk
ZXYsCj4+IC0JCQluICogc2l6ZW9mKCpjYXJkLT5hdXhfZGV2KSwgR0ZQX0tFUk5FTCk7Cj4+ICsJ
Y2FyZC0+YXV4X2RldiA9IGRldm1fa2NhbGxvYyhkZXYsIG4sIHNpemVvZigqY2FyZC0+YXV4X2Rl
diksCj4+ICsJCQkJICAgICBHRlBfS0VSTkVMKTsKPiAKPiBEbyB5b3UgcmVhbGl6ZSB0aGF0IHRo
aXMgY2hhbmdlIGhhcyBhYnNvbHV0ZWx5IG5vIHZhbHVlCgpXZSBjYW4gaGF2ZSBkaWZmZXJlbnQg
c29mdHdhcmUgZGV2ZWxvcG1lbnQgb3BpbmlvbnMgYWJvdXQgc3VjaCBhIHNvdXJjZSBjb2RlIGFk
anVzdG1lbnQuCkRvZXMgaXQgaW1wcm92ZSB0aGUgaW5kZW50YXRpb24gZm9yIHRoZSBwYXJhbWV0
ZXJzIHdoaWNoIGFyZSBwYXNzZWQgdG8gdGhpcyBmdW5jdGlvbiBjYWxsPwoKCj4gYW5kIGp1c3Qg
bWFrZXMgdGhlIGNvZGUgc2xvd2VyIChvbmUgbW9yZSB0ZXN0IGluIHRoZSBhbGxvY2F0aW9uIHBh
dGgpPwoKRG8gd2Ugc3R1bWJsZSBvbiBhIHRhcmdldCBjb25mbGljdCBmb3IgdGhlIHNob3duIGlt
cGxlbWVudGF0aW9uIGRldGFpbD8KCkRvZXMgdGhlIHByZXZpb3VzIHNpemUgY2FsY3VsYXRpb24g
Y29udGFpbiB0aGUgZ2VuZXJhbCBwb3NzaWJpbGl0eSBmb3IKYW4gaW50ZWdlciBvdmVyZmxvdz8K
aHR0cHM6Ly9jd2UubWl0cmUub3JnL2RhdGEvZGVmaW5pdGlvbnMvMTkwLmh0bWwKClRoZSB2YWx1
ZSBmb3IgdGhlIHZhcmlhYmxlIOKAnGxlbuKAnSAoYW5kIGFsc28g4oCcbuKAnSkgbWlnaHQgYmUg
c21hbGwgZW5vdWdoIHNvIHRoYXQKdGhlIGNvbXB1dGVkIHZhbHVlIHdpbGwgdXN1YWxseSBub3Qg
ZXhjZWVkIHRoZSBkYXRhIHR5cGUgbGltaXQgaW4gdGhpcyB1c2UgY2FzZS4KClJlZ2FyZHMsCk1h
cmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
