From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/7] ASoC:davinci-mcasp: bc polarity fix
 and proper format support
Date: Fri, 4 Apr 2014 19:38:22 +0300
Message-ID: <533EDFFE.2060501@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
 <533EB282.6080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4730C265804
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 18:38:28 +0200 (CEST)
In-Reply-To: <533EB282.6080906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

SGkgRGFuaWVsLAoKT24gMDQvMDQvMjAxNCAwNDoyNCBQTSwgRGFuaWVsIE1hY2sgd3JvdGU6Cj4g
SGkgUGV0ZXIsCj4gCj4gT24gMDQvMDQvMjAxNCAwMTozMSBQTSwgUGV0ZXIgVWpmYWx1c2kgd3Jv
dGU6Cj4+IFRoZSBiaXQgY2xvY2sgcG9sYXJpdHkgaGFzIGJlZW4gY29uZmlndXJlZCBpbmNvcnJl
Y3RseSBpbiB0aGUgTWNBU1AgZHJpdmVyIGZvciBhCj4+IGxvbmcgdGltZS4gSUJfTkYsIE5CX0lG
IGFuZCBJQl9JRiB3YXMgbm90IGNvcnJlY3Qgb24gdGhlIHJlY2VpdmUgc2lkZSBzaW5jZSB0aGV5
Cj4+IHdlcmUgc2VsZWN0aW5nIHRoZSBzYW1lIGVkZ2UgYXMgd2UgdXNlZCBmb3IgdGhlIHR4Lgo+
Pgo+PiBUaGUgZHJpdmVyIG9ubHkgaGFkIHN1cHBvcnQgZm9yIERTUF9CIG1vZGUgKGFuZCBwcm9i
YWJseSBBQzk3LCBidXQgSSBjYW4gbm90Cj4+IHRlc3QgdGhhdCkuIEFsbCBvdGhlciBmb3JtYXRz
IHdlcmUgYnJva2VuIChEU1BfQSwgSTJTLCBMRUZUX0osIGV0YykuCj4gCj4gV2VsbCwgd2UncmUg
dXNpbmcgdGhpcyBkcml2ZXIgaW4gSTJTIG1vZGUgZm9yIGEgbnVtYmVyIG9mIGRldmljZXMgc2lu
Y2UKPiBhIHdoaWxlLCBzbyB0aGUgYWJvdmUgc3RhdGVtZW50IGlzIG5vdCBlbnRpcmVseSB0cnVl
IDopCgpUcnVlLCB5b3UgY291bGQgc2VsZWN0IEkyUyBhbmQgYXNrIGZvciBpbnZlcnRlZCBmcmFt
ZSBzeW5jIHdpdGggdGhlIG9sZCBjb2RlLgpIb3dldmVyIGlmIHlvdSBhc2sgZm9yIERTUF9BLCBM
RUZUX0osIGV0YyBpdCB3YXMgZG9pbmcgdGhlIHdyb25nIHRoaW5nLgoKPiBUaGUgY2xlYW51cHMg
bG9vayBzYW5lLCB0aG91Z2guIEkgY2FuIHRlc3QgdGhlbSBvbiBBTTMzeHggYmFzZWQgaGFyZHdh
cmUKPiBlYXJseSBuZXh0IHdlZWsuIElmIHlvdSBkb24ndCB3YW50IHRvIGhvbGQgdGhlbSBvZmYg
dW50aWwgdGhlbiwgbm8KPiBwcm9ibGVtLiBJIGNhbiBhbHNvIHNlbmQgZml4dXBzIGluIGNhc2Ug
SSBzcG90IGEgcmVncmVzc2lvbi4KClRoYXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIGFs
c28gdGVzdCB0aGVzZS4gSXQgc2VhbXMgeW91IGhhdmUgcXVpdGUgZ29vZAphcnJheSBvZiBjb2Rl
Y3MgYXZhaWxhYmxlLgoKPiBPdXQgb2YgaW50ZXJlc3Q6IHdoaWNoIGhhcmR3YXJlIGFuZCB3aGlj
aCBkYWkgZm9ybWF0IGFyZSB5b3UgdGVzdGluZwo+IHRoaXMgd2l0aD8KCkkgaGF2ZSBvbmUgQU0z
MzV4IGJvYXJkLCBvbmUgQU00Mzd4IGFuZCBvbmUgRFJBNyB3aGVyZSBJIGNhbiB0ZXN0IHJpZ2h0
IG5vdy4gSQpqdXN0IGdvIG9uZSBPTUFQLWwxMzggYm9hcmQgd2hpY2ggSSBuZWVkIHRvIHNldCB1
cC4gSXQgaXMgZ29vZCBmb3IgbGVnYWN5IChub24KRFQgYm9vdCkgZGVidWdnaW5nLgoKPiAKPiAK
PiBUaGFua3MsCj4gRGFuaWVsCj4gCgoKLS0gClDDqXRlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
