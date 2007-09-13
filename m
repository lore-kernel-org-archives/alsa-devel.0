From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: [PATCH] ad1848_lib: waiting loops done after cs4231_lib
Date: Thu, 13 Sep 2007 15:11:40 +0200
Message-ID: <8c74410a0709130611t3fe22704j283eda8f34d57a41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10951_31132440.1189689100836"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CAE724347
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 15:11:44 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so374421nzf
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 06:11:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_Part_10951_31132440.1189689100836
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes ad1848_lib waiting loops to be the same as in the cs4231_lib.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

------=_Part_10951_31132440.1189689100836
Content-Type: text/x-patch; name="ad1848-sync.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ad1848-sync.diff"
X-Attachment-Id: f_f6ja3pce

ZGlmZiAtdXJwIGFsc2EtZHJpdmVyLTEuMC4xNXJjMi9zb3VuZC9pc2EvYWQxODQ4L2FkMTg0OF9s
aWIuYyBhbHNhLWRyaXZlci5uZXcvc291bmQvaXNhL2FkMTg0OC9hZDE4NDhfbGliLmMKLS0tIGFs
c2EtZHJpdmVyLTEuMC4xNXJjMi9zb3VuZC9pc2EvYWQxODQ4L2FkMTg0OF9saWIuYwkyMDA3LTA5
LTEyIDEzOjMzOjUxLjAwMDAwMDAwMCArMDIwMAorKysgYWxzYS1kcml2ZXIubmV3L3NvdW5kL2lz
YS9hZDE4NDgvYWQxODQ4X2xpYi5jCTIwMDctMDktMTMgMTQ6NDE6NDQuMDAwMDAwMDAwICswMjAw
CkBAIC0yMDUsNyArMjA1LDcgQEAgc3RhdGljIHZvaWQgc25kX2FkMTg0OF9tY2VfZG93bihzdHJ1
Y3QgcwogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJaW50IHRpbWVvdXQ7Ci0Jc2lnbmVkIGxv
bmcgdGltZTsKKwl1bnNpZ25lZCBsb25nIGVuZF90aW1lOwogCiAJc3Bpbl9sb2NrX2lycXNhdmUo
JmNoaXAtPnJlZ19sb2NrLCBmbGFncyk7CiAJZm9yICh0aW1lb3V0ID0gNTsgdGltZW91dCA+IDA7
IHRpbWVvdXQtLSkKQEAgLTI0MCwyNyArMjQwLDI3IEBAIHN0YXRpYyB2b2lkIHNuZF9hZDE4NDhf
bWNlX2Rvd24oc3RydWN0IHMKIAogCXNuZF9wcmludGRkKCIoMikgamlmZmllcyA9ICVsdVxuIiwg
amlmZmllcyk7CiAKLQl0aW1lID0gbXNlY3NfdG9famlmZmllcygyNTApOworCWVuZF90aW1lID0g
amlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMjUwKTsKIAl3aGlsZSAoc25kX2FkMTg0OF9pbihj
aGlwLCBBRDE4NDhfVEVTVF9JTklUKSAmIEFEMTg0OF9DQUxJQl9JTl9QUk9HUkVTUykgewogCQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZjaGlwLT5yZWdfbG9jaywgZmxhZ3MpOwotCQlpZiAodGlt
ZSA8PSAwKSB7CisJCWlmICh0aW1lX2FmdGVyKGppZmZpZXMsIGVuZF90aW1lKSkgewogCQkJc25k
X3ByaW50ayhLRVJOX0VSUiAibWNlX2Rvd24gLSBhdXRvIGNhbGlicmF0aW9uIHRpbWUgb3V0ICgy
KVxuIik7CiAJCQlyZXR1cm47CiAJCX0KLQkJdGltZSA9IHNjaGVkdWxlX3RpbWVvdXQodGltZSk7
CisJCW1zbGVlcCgxKTsKIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPnJlZ19sb2NrLCBmbGFn
cyk7CiAJfQogCiAJc25kX3ByaW50ZGQoIigzKSBqaWZmaWVzID0gJWx1XG4iLCBqaWZmaWVzKTsK
IAotCXRpbWUgPSBtc2Vjc190b19qaWZmaWVzKDEwMCk7CisJZW5kX3RpbWUgPSBqaWZmaWVzICsg
bXNlY3NfdG9famlmZmllcygxMDApOwogCXdoaWxlIChpbmIoQUQxODQ4UChjaGlwLCBSRUdTRUwp
KSAmIEFEMTg0OF9JTklUKSB7CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPnJlZ19s
b2NrLCBmbGFncyk7Ci0JCWlmICh0aW1lIDw9IDApIHsKKwkJaWYgKHRpbWVfYWZ0ZXIoamlmZmll
cywgZW5kX3RpbWUpKSB7CiAJCQlzbmRfcHJpbnRrKEtFUk5fRVJSICJtY2VfZG93biAtIGF1dG8g
Y2FsaWJyYXRpb24gdGltZSBvdXQgKDMpXG4iKTsKIAkJCXJldHVybjsKIAkJfQotCQl0aW1lID0g
c2NoZWR1bGVfdGltZW91dCh0aW1lKTsKKwkJbXNsZWVwKDEpOwogCQlzcGluX2xvY2tfaXJxc2F2
ZSgmY2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsKIAl9CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Y2hpcC0+cmVnX2xvY2ssIGZsYWdzKTsK
------=_Part_10951_31132440.1189689100836
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_10951_31132440.1189689100836--
