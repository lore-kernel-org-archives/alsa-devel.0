From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Don't issue ipc when processing
	response
Date: Fri,  1 Aug 2014 23:09:44 +0800
Message-ID: <1406905784-31182-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EC93126551C
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 17:08:46 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, pawel.piskorski@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

RnJvbTogUGF3ZcWCIFBpc2tvcnNraSA8cGF3ZWwucGlza29yc2tpQGludGVsLmNvbT4KCk1ha2Ug
c3VyZSB3ZSBkb250IGlzc3VlIElQQyB3aGVuIHdlIGFyZSBwcm9jZXNzaW5nIGEgcmVzcG9uc2Uu
CgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgUGlza29yc2tpIDxwYXdlbC5waXNrb3Jza2lAaW50ZWwu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBMaWFtIEdpcmR3b29kIDxsaWFtLnIuZ2lyZHdvb2RAbGludXgu
aW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBKaWUgWWFuZyA8eWFuZy5qaWVAaW50ZWwuY29tPgot
LS0KIHNvdW5kL3NvYy9pbnRlbC9zc3QtaGFzd2VsbC1pcGMuYyB8IDUgKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2ludGVsL3NzdC1oYXN3ZWxsLWlwYy5jIGIvc291bmQvc29jL2ludGVsL3NzdC1oYXN3
ZWxsLWlwYy5jCmluZGV4IDVhNjA3YWIuLjBmZWM2ODYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9p
bnRlbC9zc3QtaGFzd2VsbC1pcGMuYworKysgYi9zb3VuZC9zb2MvaW50ZWwvc3N0LWhhc3dlbGwt
aXBjLmMKQEAgLTQ1Nyw5ICs0NTcsMTAgQEAgc3RhdGljIHZvaWQgaXBjX3R4X21zZ3Moc3RydWN0
IGt0aHJlYWRfd29yayAqd29yaykKIAkJcmV0dXJuOwogCX0KIAotCS8qIGlmIHRoZSBEU1AgaXMg
YnVzeSB3ZSB3aWxsIFRYIG1lc3NhZ2VzIGFmdGVyIElSUSAqLworCS8qIGlmIHRoZSBEU1AgaXMg
YnVzeSwgd2Ugd2lsbCBUWCBtZXNzYWdlcyBhZnRlciBJUlEuCisJICogYWxzbyBwb3N0cG9uZSBp
ZiB3ZSBhcmUgaW4gdGhlIG1pZGRsZSBvZiBwcm9jZXNpbmcgY29tcGxldGlvbiBpcnEqLwogCWlw
Y3ggPSBzc3RfZHNwX3NoaW1fcmVhZF91bmxvY2tlZChoc3ctPmRzcCwgU1NUX0lQQ1gpOwotCWlm
IChpcGN4ICYgU1NUX0lQQ1hfQlVTWSkgeworCWlmIChpcGN4ICYgKFNTVF9JUENYX0JVU1kgfCBT
U1RfSVBDWF9ET05FKSkgewogCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc3ctPmRzcC0+c3Bp
bmxvY2ssIGZsYWdzKTsKIAkJcmV0dXJuOwogCX0KLS0gCjEuOC4zLjIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
