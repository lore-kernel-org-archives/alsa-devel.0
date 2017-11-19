From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH] ALSA: via82xx: Use common error handling
 code in snd_via82xx_create()
Date: Sun, 19 Nov 2017 07:37:37 +0100
Message-ID: <3a2f0905-231d-b2af-d1e8-1635158c6e53@users.sourceforge.net>
References: <2332472c-61d2-8c21-bf46-5c80745d6380@users.sourceforge.net>
 <s5hpobnscx1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AD2266847
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 07:37:49 +0100 (CET)
In-Reply-To: <s5hpobnscx1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Pj4gQEAgLTExNTMsNiArMTE1MCwxNCBAQCBzdGF0aWMgaW50IHNuZF92aWE4Mnh4X2NyZWF0ZShz
dHJ1Y3Qgc25kX2NhcmQgKmNhcmQsCj4+ICAKPj4gIAkqcl92aWEgPSBjaGlwOwo+PiAgCXJldHVy
biAwOwo+PiArCj4+ICtkaXNhYmxlX2RldmljZToKPj4gKwlwY2lfZGlzYWJsZV9kZXZpY2UocGNp
KTsKPj4gKwlnb3RvIGV4aXQ7Cj4+ICtmcmVlX2NoaXA6Cj4+ICsJc25kX3ZpYTgyeHhfZnJlZShj
aGlwKTsKPj4gK2V4aXQ6Cj4+ICsJcmV0dXJuIGVycjsKPiAKPiBEb3VibHkgZ290byBkb2Vzbid0
IGxvb2sgbGlrZSBhbiBpbXByb3ZlbWVudC4KCldvdWxkIHlvdSBsaWtlIHRvIGludGVncmF0ZSBh
bm90aGVyIHNvZnR3YXJlIHVwZGF0ZSB3aXRoIHRoZSBzdGF0ZW1lbnQK4oCccmV0dXJuIGVycjvi
gJ0gaW5zdGVhZCBvZiDigJxnb3RvIGV4aXQ74oCdIGF0IHRoaXMgcGxhY2U/CgpSZWdhcmRzLApN
YXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
