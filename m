From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC: simple-card: remove snd_link and
 snd_card from struct asoc_xx_info
Date: Mon, 13 Jan 2014 08:56:48 +0100
Message-ID: <20140113085648.0fbcf63b@armhf>
References: <1389358557-2214-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 00A8B261A0C
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 08:57:10 +0100 (CET)
In-Reply-To: <1389358557-2214-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAxMCBKYW4gMjAxNCAyMDo1NTo1NyArMDgwMApYaXVibyBMaSA8TGkuWGl1Ym9AZnJl
ZXNjYWxlLmNvbT4gd3JvdGU6Cgo+IFdoZXRoZXIgdGhlIGR0IGlzIHVzZWQgb3Igbm90LCBhbG1v
c3QgYWxsIHRoZSBzaW1wbGUgY2FyZCBpbmZvcm1hdGlvbgo+IGZvciB0aGUgREFJIGxpbmsgYW5k
IHNvdW5kIGNhcmQgYXJlIGluaXRpYWxpemVkIGluIHRoZSBzaW1wbGUgY2FyZCBkcml2ZXIuCj4g
Cj4gQW5kIGZvciB0aGUgcGxhdGZvcm0gY2FsbGVyLCB0aGUgc25kX2xpbmsgYW5kIHNuZF9jYXJk
IGFyZSBvZiBubyB1c2UsIHNvCj4gcmVtb3ZlIGl0IGZyb20gc3RydWN0IGFzb2Nfc2ltcGxlX2Nh
cmRfaW5mbywgYW5kIGxldCB0aGVtIHRvIGJlIHRoZSBzaW1wbGUKPiBjYXJkIGRyaXZlcidzIGds
b2JhbCBkYXRhLgo+IAo+IFRoaXMgaXMgYWxzbyBmaXggb25lIGJ1ZyBhYm91dCB3cml0aW5nIHRv
IHRoZSBwbGF0Zm9ybSBkYXRhIGRpcmVjdGx5LCBmb3IKPiBpdCBzaG91bGQgYmUgY29uc3RhbnQu
Cj4gCj4gQW5kIG5vdyBvbmx5IG9uZSBEQUkgbGluayBpcyBzdXBwb3J0ZWQgZm9yIHNpbXBsZSBj
YXJkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFhpdWJvIExpIDxMaS5YaXVib0BmcmVlc2NhbGUuY29t
Pgo+IC0tLQo+IAo+IFRoaXMgcGF0Y2ggbWF5YmUgbm90IHZlcnkgcGVyZmVjdCwgc3VjaCBhcyBz
dXBwb3J0aW5nIG1hbnkgREFJIGxpbmtzLCBldGMuCj4gQW5kIHRoZXJlIHN0aWxsIG5lZWQgZm9s
bG93ZWQgcGF0Y2hlcyB0byBmdWxmaWwgdGhlc2UuCglbc25pcF0KClhpdWJvLAoKSSBkb24ndCBh
Z3JlZSB5b3VyIGNvZGU6IHlvdSBzaG91bGQgbm90IHVzZSB0aGUgY2luZm8gYW55bW9yZSwgYnV0
CnJhdGhlciBtb3ZlIHRoZSBpbmZvcm1hdGlvbiBpdCBjb250YWlucyB0byB0aGUgc291bmQgY2Fy
ZCBzdHJ1Y3R1cmUuCgpUaGVuLCB5b3UgdXNlIGEgc3RhdGljIHZhcmlhYmxlIGFzIHRoZSBjYXJk
IHN0cnVjdHVyZS4gSXQgaXMgbm90CnBvc3NpYmxlIHRvIGV4dGVuZCB0aGlzIHRhYmxlIHRvIGhh
bmRsZSBtYW55IERBSSBsaW5rcywgYW5kLCBhcyBub3QKcmUtZW50cmFudCwgdGhlIGRyaXZlciBj
YW5ub3QgY3JlYXRlIG1hbnkgc291bmQgY2FyZHMuCgotLSAKS2VuIGFyIGMnaGVudGHDsQl8CSAg
ICAgICoqIEJyZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZy
ZWUuZnIvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
