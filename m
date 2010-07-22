From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Fix
	compile error when registering a DAI
Date: Thu, 22 Jul 2010 17:26:11 +0900
Message-ID: <AANLkTin660THXzF3MXTEMbscB84Axd-roKgZnIfcK1O3@mail.gmail.com>
References: <4C47D3A3.9000102@samsung.com>
	<AANLkTiluZwni88uY6WtwKkB9Qpm2ECz_37z5_bUY1jII@mail.gmail.com>
	<4C47F723.4090506@samsung.com>
	<AANLkTiksuBsdZ7LslGhRqxoDyLry579OxNMJ7X3bhrAb@mail.gmail.com>
	<4C47FBAE.5040106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E5F4C10395E
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 10:26:11 +0200 (CEST)
Received: by wwd20 with SMTP id 20so1179576wwd.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 01:26:11 -0700 (PDT)
In-Reply-To: <4C47FBAE.5040106@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Pj4+Pj4gKyDCoCDCoCDCoCByZXR1cm4gc25kX3NvY19yZWdpc3Rlcl9kYWkoZGV2LCBkcnYpOwo+
Pj4+IEhvdyBhYm91dCBzM2M2NHh4LWkycz8gSSB0aGluaywgaWYgdGhpcyBwYXRjaCBmaXhlcyBh
bGwgZXJyb3JzIGluCj4+PiBTb3JyeSwgSSBjb25mdXNlZCB5b3VyIGNvbW1lbnQuCj4+PiBXaGF0
IGRvIHlvdSBtZWFuICJIb3cgYWJvdXQgczNjNjR4eC1pMnMiID8KPj4KPj4gQWN0dWFsbHkgJ3Nv
dW5kL3NvYy9zM2MyNHh4L3MzYzY0eHgtaTJzLmMnIGhhcyBzYW1lIGVycm9yLgo+Pgo+PiBTbywg
SWYgdGhpcyBwYXRjaCdzIHB1cnBvc2UgaXMgdG8gZml4IGNvbXBpbGUgZXJyb3IsIG15IG9waW5p
b24gaXMKPj4gdGhhdCB0aGlzIHBhdGNoIGZpeCBhbGwgdGhlIHNhbWUgZXJyb3JzIGluICdzb3Vu
ZC9zb2MvczNjMjR4eC8nLgo+Cj4gVGhlICdzb3VuZC9zb2MvczNjMjR4eC9zM2M2NHh4LWkycy5j
JyBoYXZlbid0IGRpcmVjdGx5IGNhbGxlZAo+ICdzbmRfc29jX3JlZ2lzdGVyX2RhaSgpJyBmdW5j
dGlvbi4KPiBJdCBpcyBjYWxsICdzM2NfaTJzdjJfcmVnaXN0ZXJfZGFpKCknIGluICdzb3VuZC9z
b2MvczNjMjR4eC9zM2MtaTJzLXYyLmMnCj4gdG8gcmVnaXN0ZXIgYSBEQUkuCj4KCk9oLCBJIHdh
cyBjb25mdXNlZCBhYm91dCB0aGlzIGV2ZW4gSSBtb2RpZnkgdGhpcyBmZXcgZGF5cyBhZ28uCkkn
bSBzb3JyeSB0aGF0IEkgbWFrZSB5b3UgdG8gYmUgY29uZnVzZWQuCgo+Pgo+Pj4+ICdzb3VuZC9z
b2MvczNjMjR4eCcsCj4+Pj4gSXQnbGwgYmUgbW9yZSBuaWNlIHRoYW4gdGhpcy4KPj4+Cj4KPgoK
VGhhbmtzLApjbGF1ZGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
