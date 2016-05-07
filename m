From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] pcm: softvol: fix signedness of tlv data
	type
Date: Sat, 7 May 2016 09:06:39 +0200
Message-ID: <38c794bd-5eda-2bb2-7022-a13e2869dc3a@ladisch.de>
References: <1462568920-19891-1-git-send-email-joerg.krause@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4B4F326040E
 for <alsa-devel@alsa-project.org>; Sat,  7 May 2016 09:07:36 +0200 (CEST)
In-Reply-To: <1462568920-19891-1-git-send-email-joerg.krause@embedded.rocks>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?J=c3=b6rg_Krause?= <joerg.krause@embedded.rocks>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SsO2cmcgS3JhdXNlIHdyb3RlOgo+IEZvciB0aGUgc29mdHZvbCBwbHVnaW4gdGhlIFRMViBkYXRh
IGFyZSB3cml0dGVuIHdyb25nLCBlLmcuIGZvciB0aGUgZGVmYXVsdCB2YWx1ZXMKPiBvZiBtaW5f
ZEIgPSAtNTEgZEIgYW5kIG1heF9kQiA9IDAgZEIsIGFsc2FjdGwgZ2VuZXJhdGVzIHRoZSBmb2xs
b3dpbmcgc3RhdGU6Cj4KPiAgICAgICAgICAgICAgICAgICAgICAgICB0bHYgJzAwMDAwMDAxMDAw
MDAwMDgwMDAwMDAwMDAwMDAwMDE0Jwo+Cj4gQXMgYm90aCBtaW5fZEIgYW5kIG1heF9kQiBjYW4g
YmUgbmVnYXRpdmUgbnVtYmVycywgdGhlIHRsdiB0eXBlIG11c3Qgbm90IGJlCj4gdW5zaWduZWQu
CgpUTFZzIGFsd2F5cyBhcmUgdW5zaWduZWQuICBCdXQgdGhleSBjYW4gY29udGFpbiBiaXQgcGF0
dGVybnMgdGhhdCBhcmUgdG8KYmUgaW50ZXJwcmV0ZWQgYXMgc2lnbmVkLgoKPiAtCXVuc2lnbmVk
IGludCB0bHZbNF07Cj4gKwlpbnQgdGx2WzRdOwo+ICAJdGx2WzBdID0gU05EX0NUTF9UTFZUX0RC
X1NDQUxFOwo+ICAJdGx2WzFdID0gMiAqIHNpemVvZihpbnQpOwo+ICAJdGx2WzJdID0gc3ZvbC0+
bWluX2RCICogMTAwOwoKVGhlIHByb2JsZW0gaXMgdGhhdCBjb252ZXJzaW9uIG9mIGEgbmVnYXRp
dmUgZmxvYXRpbmctcG9pbnQgbnVtYmVyIGludG8KYW4gdW5zaWduZWQgaW50ZWdlciByZXN1bHRz
IGluIHVuZGVmaW5lZCBiZWhhdmlvdXIsIGFuZCBvbiB5b3VyCmFyY2hpdGVjdHVyZSAod2hhdGV2
ZXIgaXQgaXMpLCB0aGlzIHJlc3VsdHMgaW4gemVyby4KClRoZSBjb3JyZWN0IHdheSB0byBoYW5k
bGUgdGhpcyB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzOgoKICB0bHZbaV0gPSAoaW50KSgu
Li4pOwoKClJlZ2FyZHMsCkNsZW1lbnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
