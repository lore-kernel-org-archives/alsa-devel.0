From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/1] ASoC: samsung: Remove unused variable from
	idma.c
Date: Thu, 26 Jun 2014 12:17:24 +0530
Message-ID: <1403765244-20642-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 681F7262632
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 08:50:47 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id r10so2659428pdi.4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 23:50:46 -0700 (PDT)
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
Cc: sbkim73@samsung.com, trb.linux@gmail.com, broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

4oCYaWlzY29u4oCZIGlzIG5vdCB1c2VkIGluIHRoZSBmdW5jdGlvbi4gUmVtb3ZlIGl0LgoKU2ln
bmVkLW9mZi1ieTogU2FjaGluIEthbWF0IDxzYWNoaW4ua2FtYXRAc2Ftc3VuZy5jb20+Ci0tLQog
c291bmQvc29jL3NhbXN1bmcvaWRtYS5jIHwgICAgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc2Ftc3Vu
Zy9pZG1hLmMgYi9zb3VuZC9zb2Mvc2Ftc3VuZy9pZG1hLmMKaW5kZXggOGNjNTc3MGFiYjM5Li5k
YjZjZWZhMTgwMTcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9zYW1zdW5nL2lkbWEuYworKysgYi9z
b3VuZC9zb2Mvc2Ftc3VuZy9pZG1hLmMKQEAgLTI2MSwxMCArMjYxLDkgQEAgc3RhdGljIGludCBp
ZG1hX21tYXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiBzdGF0aWMgaXJx
cmV0dXJuX3QgaWlzX2lycShpbnQgaXJxbm8sIHZvaWQgKmRldl9pZCkKIHsKIAlzdHJ1Y3QgaWRt
YV9jdHJsICpwcnRkID0gKHN0cnVjdCBpZG1hX2N0cmwgKilkZXZfaWQ7Ci0JdTMyIGlpc2Nvbiwg
aWlzYWhiLCB2YWwsIGFkZHI7CisJdTMyIGlpc2FoYiwgdmFsLCBhZGRyOwogCiAJaWlzYWhiICA9
IHJlYWRsKGlkbWEucmVncyArIEkyU0FIQik7Ci0JaWlzY29uICA9IHJlYWRsKGlkbWEucmVncyAr
IEkyU0NPTik7CiAKIAl2YWwgPSAoaWlzYWhiICYgQUhCX0xWTDBJTlQpID8gQUhCX0NMUkxWTDBJ
TlQgOiAwOwogCi0tIAoxLjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
