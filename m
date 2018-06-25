From: =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [PATCH 2/2] ASoC: simple-amplifier: add dt-bindings
Date: Mon, 25 Jun 2018 13:06:17 +0200
Message-ID: <1529924777-21136-2-git-send-email-nicveronese@gmail.com>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 29B2D267772
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:06:35 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so3441572wmw.1
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 04:06:35 -0700 (PDT)
In-Reply-To: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogTmljb2zDsiBWZXJvbmVzZSA8bmljdmVyb25lc2VAZ21haWwuY29tPgot
LS0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3NpbXBsZS1hbXBsaWZpZXIudHh0IHwg
MzYgKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMo
KykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvc2ltcGxlLWFtcGxpZmllci50eHQKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLWFtcGxpZmllci50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLWFtcGxpZmllci50eHQKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMWMyYjU3YwotLS0gL2Rldi9udWxsCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zaW1wbGUtYW1wbGlmaWVy
LnR4dApAQCAtMCwwICsxLDM2IEBACitTaW1wbGUtQW1wbGlmaWVyOgorCitTaW1wbGUtQW1wbGlm
aWVyIHNwZWNpZmllcyBhIHNpbXBsZSBhdXggZGV2aWNlIGZvciB5b3VyIGNvZGVjLgorTW9zdCBh
cGxpZmllcnMgYXJlIG1hbmFnZWQgYnkgYSBzaW5nbGUgR1BJTy4gVGhlIG1haW4gZnVuY3Rpb24K
K29mIHRoaXMgZHJpdmVyIGlzIHRvIHRvZ2dsZSB0aGUgTVVURS9TSFVURE9XTiBHUElPLgorCitS
ZXF1aXJlZCBwcm9wZXJ0aWVzOgorCistIGNvbXBhdGlibGUJOiAic2ltcGxlLWF1ZGlvLWFtcGxp
ZmllciIKKworLSBWQ0Mtc3VwcGx5CTogcG93ZXIgc3VwcGx5IGZvciB0aGUgZGV2aWNlLCBhcyBj
b3ZlcmVkCitpbiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3Jl
Z3VsYXRvci50eHQKKworT3B0aW9uYWwgcHJvcGVydGllczoKKworLSBzaHV0ZG93bi1ncGlvcwk6
IFRoZSBncGlvIHRvIGJlIHRvZ2dsZWQgb24gYW5kIG9mZgordG8gc2h1dGRvd24gdGhlIGFtcGxp
ZmllciB3aGVuIG5vdCBpbiB1c2UuIGFzIGNvdmVyZWQKK2luIERvY3VtZW50YXRpb24vZ3Bpby9i
b2FyZC50eHQKKworRXhhbXBsZToKKworc291bmQgeworCWNvbXBhdGlibGUgPSAic2ltcGxlLWF1
ZGlvLWNhcmQiOworCS4uLgorCXNpbXBsZS1hdWRpby1jYXJkLHJvdXRpbmcgPQorCQkiTEVGVCBB
TVAgSU4iLCAiTElORV9PVVRfTEVGVCIsCisJCSJSSUdIVCBBTVAgSU4iLCAiTElORV9PVVRfUklH
SFQiOworCXNpbXBsZS1hdWRpby1jYXJkLGF1eC1kZXZzID0gPCZhbXA+OworCS4uLgorfTsKKwor
YW1wOiBhbXBsaWZpZXIgeworCWNvbXBhdGlibGUgPSAic2ltcGxlLWF1ZGlvLWFtcGxpZmllciI7
CisJVkNDLXN1cHBseSA9IDwmcmVndWxhdG9yPgorCXNodXRkb3duLWdwaW9zID0gPCZyX3BpbyAy
IEdQSU9fQUNUSVZFX0xPVz47Cit9OwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
