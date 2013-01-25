From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?=
 <benoit.thebaudeau@advansee.com>
Subject: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Fri, 25 Jan 2013 18:19:20 +0100
Message-ID: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta15.web4all.fr (zose-mta15.web4all.fr [178.33.204.94])
 by alsa0.perex.cz (Postfix) with ESMTP id D29172650BA
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 18:20:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

VGhlIFRMVjMyMEFJQzN4IERBSSBzdXBwb3J0cyBvbmx5IHN0ZXJlby4gVGhpcyBwYXRjaCBmaXhl
cyBtb25vIHN1cHBvcnQgZm9yIHRoaXMKY29kZWMgYnkgYWxsb3dpbmcgb25seSBzdGVyZW8gYXQg
Y29kZWMgbGV2ZWwuCgpUZXN0ZWQgd2l0aCBpbXgtc3NpIGFuZCBUTFYzMjBBSUMzMTA0LgoKQ2M6
IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+CkNjOiBNYXJrIEJyb3duIDxicm9v
bmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4KQ2M6IDxhbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmc+ClNpZ25lZC1vZmYtYnk6IEJlbm/DrnQgVGjDqWJhdWRlYXUgPGJlbm9pdC50aGVi
YXVkZWF1QGFkdmFuc2VlLmNvbT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzN4LmMg
fCAgICA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMzeC5jIGIvc291bmQv
c29jL2NvZGVjcy90bHYzMjBhaWMzeC5jCmluZGV4IDU3MDhhOTcuLjQ5ODkxNDMgMTAwNjQ0Ci0t
LSBhL3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljM3guYworKysgYi9zb3VuZC9zb2MvY29kZWNz
L3RsdjMyMGFpYzN4LmMKQEAgLTEyMTAsMTMgKzEyMTAsMTMgQEAgc3RhdGljIHN0cnVjdCBzbmRf
c29jX2RhaV9kcml2ZXIgYWljM3hfZGFpID0gewogCS5uYW1lID0gInRsdjMyMGFpYzN4LWhpZmki
LAogCS5wbGF5YmFjayA9IHsKIAkJLnN0cmVhbV9uYW1lID0gIlBsYXliYWNrIiwKLQkJLmNoYW5u
ZWxzX21pbiA9IDEsCisJCS5jaGFubmVsc19taW4gPSAyLAogCQkuY2hhbm5lbHNfbWF4ID0gMiwK
IAkJLnJhdGVzID0gQUlDM1hfUkFURVMsCiAJCS5mb3JtYXRzID0gQUlDM1hfRk9STUFUUyx9LAog
CS5jYXB0dXJlID0gewogCQkuc3RyZWFtX25hbWUgPSAiQ2FwdHVyZSIsCi0JCS5jaGFubmVsc19t
aW4gPSAxLAorCQkuY2hhbm5lbHNfbWluID0gMiwKIAkJLmNoYW5uZWxzX21heCA9IDIsCiAJCS5y
YXRlcyA9IEFJQzNYX1JBVEVTLAogCQkuZm9ybWF0cyA9IEFJQzNYX0ZPUk1BVFMsfSwKLS0gCjEu
Ny4xMC40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
