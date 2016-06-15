From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 0/4] ASoC: sunxi: Add i2s controller support
Date: Wed, 15 Jun 2016 23:11:19 +0200
Message-ID: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id E0F432656F5
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 23:11:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, gianfranco@moddevices.com, linux-kernel@vger.kernel.org, Code Kipper <codekipper@gmail.com>, Andrea Venturi <ennesimamail.av@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgZXZlcnlvbmUsCgpUaGlzIGlzIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiB0aGUgSTJTIHN1cHBv
cnQgZm9yIHRoZSBjb250cm9sbGVyIGZvdW5kCmluIHRoZSBBbGx3aW5uZXIgQTEwIGFuZCBsYXRl
ciBTb0NzLgoKUGxheWJhY2sgaGFzIGJlZW4gdGVzdGVkIHdpdGggYW4gVURBMTM4MCBvbiBhbiBB
MjAtT2xpbnV4aW5vLiBDYXB0dXJlCmlzIG5vdCBpbXBsZW1lbnRlZCB5ZXQsIGJ1dCB3aWxsIGNv
bWUgZXZlbnR1YWxseS4KCkxldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLApNYXhpbWUKCkNoYW5n
ZXMgZnJvbSB2MToKICAtIEZpeGVkIGJvZ3VzIGluZGVudGF0aW9uIGFuZCBzcHVyaW91cyB3aGl0
ZXNwYWNlcyAvIG5ld2xpbmVzCiAgLSBNb3ZlZCB0aGUgZGV2aWNlIGluaXRpYWxpc2F0aW9uIGlu
IHRoZSBwcm9iZSB0byB0aGUgc3RhcnR1cCBmdW5jdGlvbgogIC0gRGlzYWJsZWQgdGhlIGRldmlj
ZSBpbiBzaHV0ZG93bgogIC0gUmVtb3ZlZCBmdW5jdGlvbiB0byBnZXQgd3NzIGFuZCBzciB0byBp
bmxpbmUgdGhlbSBpbiBod19wYXJhbXMKICAtIENoYW5nZWQgdGhlIHdheSB0byBhY2Nlc3MgdGhl
IGRpdmlkZXIgYXJyYXkKICAtIENoZWNrZWQgY2xrX3NldF9yYXRlIHJldHVybiBjb2RlCiAgLSBG
aXhlZCBjb25kaXRpb24gZm9yIGludmFsaWQgYmNsayBhbmQgbWNsayBkaXZpZGVycwogIC0gQWRk
ZWQgc291bmQtZGFpLWNlbGxzIHRvIHRoZSBiaW5kaW5ncyBkb2N1bWVudGF0aW9uIHJlcXVpcmVk
IHByb3BlcnRpZXMKCkVtaWxpbyBMw7NwZXogKDEpOgogIEFSTTogc3VuN2k6IEFkZCBtb2QxIGNs
b2NrIG5vZGVzCgpNYXhpbWUgUmlwYXJkICgzKToKICBBU29DOiBzdW54aTogQWRkIEExMCBJMlMg
Y29udHJvbGxlciBiaW5kaW5nIGRvY3VtZW50YXRpb24KICBBU29DOiBzdW54aTogQWRkIEFsbHdp
bm5lciBBMTAgRGlnaXRhbCBBdWRpbyBkcml2ZXIKICBBUk06IHN1bjdpOiBBZGQgREFJIG5vZGVz
CgogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvc3VuNGktaTJzLnR4dCAgICAgICAgfCAg
MzQgKwogYXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLmR0c2kgICAgICAgICAgICAgICAgICAg
fCAgODcgKystCiBzb3VuZC9zb2Mvc3VueGkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgOSArCiBzb3VuZC9zb2Mvc3VueGkvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMiArLQogc291bmQvc29jL3N1bnhpL3N1bjRpLWkycy5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCA3MDMgKysrKysrKysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQs
IDgzMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zdW40aS1pMnMudHh0CiBjcmVh
dGUgbW9kZSAxMDA2NDQgc291bmQvc29jL3N1bnhpL3N1bjRpLWkycy5jCgotLSAKMi45LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
