From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: codecs: PCM1789: include gpio/consumer.h
Date: Wed, 30 May 2018 23:53:45 +0200
Message-ID: <20180530215407.1196429-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FAF22677D1
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 23:54:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
List-Id: alsa-devel@alsa-project.org

V2hlbiBDT05GSUdfR1BJT0xJQiBpcyBkaXNhYmxlZCwgdGhpcyBjb2RlYyBmYWlscyB0byBidWls
ZApiZWNhdXNlIGdwaW8vY29uc3VtZXIuaCBpcyBub3QgaW5jbHVkZWQgaW1wbGljaXRseS4KCnNv
dW5kL3NvYy9jb2RlY3MvcGNtMTc4OS5jOiBJbiBmdW5jdGlvbiAncGNtMTc4OV9jb21tb25faW5p
dCc6CnNvdW5kL3NvYy9jb2RlY3MvcGNtMTc4OS5jOjI0NzoxOTogZXJyb3I6IGltcGxpY2l0IGRl
Y2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdkZXZtX2dwaW9kX2dldF9vcHRpb25hbCc7IGRpZCB5b3Ug
bWVhbiAnZGV2bV9ncGlvX3JlcXVlc3Rfb25lJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dCiAgcGNtMTc4OS0+cmVzZXQgPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChk
ZXYsICJyZXNldCIsIEdQSU9EX09VVF9ISUdIKTsKICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CgpGaXhlczogNGFlMzQwZDFiZTM2ICgiQVNvQzogY29kZWNzOiBBZGQg
c3VwcG9ydCBmb3IgUENNMTc4OSIpClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Ci0tLQogc291bmQvc29jL2NvZGVjcy9wY20xNzg5LmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvY29kZWNzL3BjbTE3ODkuYyBiL3NvdW5kL3NvYy9jb2RlY3MvcGNtMTc4OS5jCmluZGV4
IDUwN2FjOTQxMmQ2Yy4uMjFmMTUyMTliM2FkIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNz
L3BjbTE3ODkuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3BjbTE3ODkuYwpAQCAtMyw3ICszLDcg
QEAKIC8vIENvcHlyaWdodCAoQykgMjAxOCBCb290bGluCiAvLyBNeWzDqG5lIEpvc3NlcmFuZCA8
bXlsZW5lLmpvc3NlcmFuZEBib290bGluLmNvbT4KIAotI2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4K
KyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+CiAjaW5jbHVkZSA8bGludXgvd29ya3F1ZXVlLmg+CiAKLS0gCjIuOS4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
