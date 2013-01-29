From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Tue, 29 Jan 2013 21:40:18 +0100 (CET)
Message-ID: <832331151.478537.1359492018900.JavaMail.root@advansee.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <20130126085512.GC30594@opensource.wolfsonmicro.com>
 <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
 <20130127025844.GC4650@opensource.wolfsonmicro.com>
 <1064296906.226931.1359407020092.JavaMail.root@advansee.com>
 <20130129020128.GE4748@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta11.web4all.fr (zose-mta11.web4all.fr [178.33.204.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F21C8261643
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 21:40:19 +0100 (CET)
In-Reply-To: <20130129020128.GE4748@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlc2RheSwgSmFudWFyeSAyOSwgMjAxMyAzOjAxOjMyIEFNLCBNYXJrIEJyb3duIHdyb3Rl
Ogo+IE9uIE1vbiwgSmFuIDI4LCAyMDEzIGF0IDEwOjAzOjQwUE0gKzAxMDAsIEJlbm/DrnQgVGjD
qWJhdWRlYXUgd3JvdGU6Cj4gCj4gPiAxKSBzbmRfc29jX2RhaV9zZXRfdGRtX3Nsb3QoY3B1X2Rh
aSwgMHhmZmZmZmZjLCAweGZmZmZmZmMsIDIsIDApOwo+ID4gLT4gYWxsIERBSSBmb3JtYXRzOiB3
cm9uZyBzYW1wbGUgcmF0ZSBmb3IgTC9SLCBwbGF5aW5nIHR3aWNlIHRvbyBmYXN0Cj4gCj4gPiAy
KSBzbmRfc29jX2RhaV9zZXRfdGRtX3Nsb3QoY3B1X2RhaSwgMHhmZmZmZmZlLCAweGZmZmZmZmUs
IDEsIDApOwo+ID4gLT4gYWxsIERBSSBmb3JtYXRzOiBub3RoaW5nIG9uIFIsIHdyb25nIHNhbXBs
ZSByYXRlIGZvciBMLCBwbGF5aW5nIHR3aWNlCj4gPiB0b28KPiA+ICAgIGZhc3QsIHBsdXMgbG91
ZCBub2lzZSBzdXBlcmltcG9zZWQgZm9yIExFRlRfSgo+IAo+IFdoeSBhcmUgeW91IGhhdmluZyB0
byBjYWxsIHRoaXMgaW4gdGhlIGZpcnN0IHBsYWNlPwoKRm9yIEnCslMsIGJlY2F1c2UgdGhlIHJl
ZmVyZW5jZSBtYW51YWwgb2YgdGhlIGkuTVgyNSBzYXlzIHRoYXQgU1NJLlNUQ0NSLkRDCnNob3Vs
ZCBiZSBzZXQgdG8gMSAoaS5lLiAyIGNoYW5uZWxzKSBpbiB0aGlzIG1vZGUuIFRoaXMgYWxzbyBh
bGxvd2VkIHRvIHRlc3QKc2V2ZXJhbCBzZXR0aW5ncyBmb3IgbW9uby4KCkZvciBEU1AgbW9kZXMs
IGJlY2F1c2Ugc3RlcmVvIGRvZXNuJ3Qgd29yayB3aXRob3V0IHRoaXMgY2FsbCAocmlnaHQgY2hh
bm5lbAptaXNzaW5nKS4KCj4gQW55d2F5LCBJIGd1ZXNzIHdlIGRvIGhhdmUgYSBoYXJkd2FyZSBs
aW1pYXRpb24gaGVyZSBzbyBJJ2xsIGFwcGx5IHRoZQo+IHBhdGNoIHdoZW4geW91IHJlc2VuZCBp
dC4KCk9LLiBJIGhhdmUganVzdCByZXNlbnQgaXQuCgpCZXN0IHJlZ2FyZHMsCkJlbm/DrnQKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
