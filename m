From: Rick Mann <rmann@latencyzero.com>
Subject: Additional bugs in tlv320aic3x.c driver (register
	defaults)
Date: Wed, 30 Sep 2015 17:12:56 -0700
Message-ID: <02F2390E-A4E9-489D-B699-8B766B510D7E@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5BF93266485
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 02:12:58 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id AD39420341
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 20:12:57 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org

QmVub8OudCwKCkkndmUgZGlzY292ZXJlZCBzb21lIGFkZGl0aW9uYWwgbWlub3IgYnVncyBpbiB0
aGUgdGx2MzIwYWljMzEwNCBzdXBwb3J0IGluIHRoZSB0bHYzMjBhaWMzeCBkcml2ZXIuIEluIHRo
aXMgaW5zdGFuY2UsIHRoZSByZWdfZGVmYXVsdCB2YWx1ZXMgYXJlbid0IHF1aXRlIHJpZ2h0LgoK
SSd2ZSB3cml0dGVuIGEgY29ycmVjdGVkIGxpc3QsIGJ1dCB0aGUgc2V0IHNwZWNpZmllZCBpbmNs
dWRlcyB0aGUgcmVzZXJ2ZWQgcmVnaXN0ZXJzLiBJIGRvbid0IGtub3cgaWYgZGV2bV9yZWdtYXBf
aW5pdF9pMmMoKSBhdHRlbXB0cyB0byB3cml0ZSB0aGUgZGVmYXVsdCB2YWx1ZXMsIG9yIHVzZXMg
dGhlbSBhcyB0aGUgaW5pdGlhbCB2YWx1ZXMgaW4gYSBjYWNoZSAoYW5kIGF0dGVtcHRzIHRvIGF2
b2lkIHdyaXRlcyB1bmxlc3Mgc3BlY2lmaWMgcmVnaXN0ZXJzIGNoYW5nZSkuIEluIG15IGRlYnVn
Z2luZywgaXQgZG9lcyBub3QgYXBwZWFyIHRvIHdyaXRlIHRoZSBlbnRpcmUgcmVnaXN0ZXIgbWFw
IGF0IGFueSBwb2ludCB0byB0aGUgSUMsIHNvIEkgdGhpbmsgaXQncyB0aGUgbGF0dGVyLgoKSSBh
bHNvIGRvbid0IGtub3cgaG93IHRoZSByZWdtYXAgaXMgaW50ZW5kZWQgdG8gYmUgdXNlZC4gSXQg
aXMgcGFzc2VkIHRvIGRldm1fcmVnbWFwX2luaXRfaTJjKCkgYXMgLnJlZ19kZWZhdWx0cywgaW1w
bHlpbmcgdGhlIGFycmF5IHByb3ZpZGVzIHN0YXJ0aW5nIHZhbHVlcywgYnV0IG90aGVyIHBhcnRz
IG9mIHRoZSBjb2RlIHJlZmVyIHRvIHRoZSBhcnJheSBhcyBpZiB0aGUgdmFsdWVzIGFyZSBjaGFu
Z2VkIGluIHRoYXQgYXJyYXkgYXMgdGhleSdyZSByZWFkIGFuZCB3cml0dGVuLgoKRG9jdW1lbnRh
dGlvbiBmb3IgcmVnbWFwIHN1Z2dlc3RzIHJlZ21hcHMgY2FuIGJlICJzcGFyc2UsIiB3aGljaCBJ
IHByZXN1bWUgd291bGQgYmUgZG9uZSBieSBvbWl0dGluZyB0aGUgcmVzZXJ2ZWQgcmVnaXN0ZXJz
IGZyb20gdGhlIGRlZmF1bHRzIGFycmF5LgoKSW4gYW55IGNhc2UsIHRoZSBmaXggaXMgbm90IHRy
aXZpYWwsIGFuZCBJIGRvbid0IHdhbnQgdG8gZ28gZG93biB0aGF0IHJvYWQgbm90IGtub3dpbmcg
aWYgaXQncyB0aGUgcmlnaHQgYXBwcm9hY2guIERvZXMgdGhpcyBtYWtlIHNlbnNlPwoKRm9yIHJl
ZmVyZW5jZSwgdGhlIHJlZ2lzdGVycyB3aXRoIGRpZmZlcmVudCBkZWZhdWx0IHZhbHVlcyAodGhh
biB0aGUgb25lcyBzcGVjaWZpZWQgaW4gdGhhdCBmaWxlKSBhcmUgMzIsIDMzLCA1MSwgNTgsIDY1
LCA3MiwgOTMuCgpUaGFua3MsCgotLSAKUmljayBNYW5uCnJtYW5uQGxhdGVuY3l6ZXJvLmNvbQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
