From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Fix possible sprintf overrun
	in	snd_pcm_hw_open
Date: Wed, 08 Dec 2010 13:56:01 +0100
Message-ID: <4CFF8061.1040802@canonical.com>
References: <4CFF5AF3.5030103@canonical.com> <4CFF762A.9080501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 866F32449F
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 13:56:07 +0100 (CET)
In-Reply-To: <4CFF762A.9080501@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gMjAxMC0xMi0wOCAxMzoxMiwgQ2xlbWVucyBMYWRpc2NoIHdyb3RlOgo+IERhdmlkIEhlbm5p
bmdzc29uIHdyb3RlOgo+PiBQb3NzaWJsZSBidWZmZXIgb3ZlcnJ1biBpZiB0aGUgbnVtYmVyIG9m
ICJjYXJkIiBhbmQgImRldmljZSIKPj4gYXJlIGFic3VyZGx5IGhpZ2gsIGVzcGVjaWFsbHkgb24g
NjQtYml0IHBsYXRmb3Jtcy4KPgo+IFRoZSBzaXplIG9mICJpbnQiIGlzIDMyIGJpdHMgZXZlbiBv
biA2NC1iaXQgcGxhdGZvcm1zLgoKU2VlbXMgeW91J3JlIHJpZ2h0LCB0aGVuIEkgbGVhcm5lZCBz
b21ldGhpbmcgbmV3IHRvZGF5IDotKQoKQWx0aG91Z2ggdGhpcyBtaWdodCBiZSBjb21waWxlciBk
ZXBlbmRlbnQsIGFuZCBzb21lIGV4b3RpYyBwbGF0Zm9ybSAKbWlnaHQgZGVjaWRlIG90aGVyd2lz
ZSBpbiB0aGUgZnV0dXJlPwoKPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCB0aGVyZSBpcyBubyBidWcu
CgpFdmVuIGZvciAzMi1iaXQgcGxhdGZvcm1zLCB5b3Ugd291bGQgc3RpbGwgb3ZlcnJ1biB0aGUg
YnVmZmVyIGlmIHlvdSBzZXQgCmNhcmQgPSBkZXZpY2UgPSDiiJIyMTQ3NDgzNjQ3LgoKLS0gCkRh
dmlkIEhlbm5pbmdzc29uLCBDYW5vbmljYWwgTHRkLgpodHRwOi8vbGF1bmNocGFkLm5ldC9+ZGl3
aWMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
