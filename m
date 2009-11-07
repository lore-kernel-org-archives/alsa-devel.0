From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH v4 11/12] string: on strstrip(),
	first remove leading spaces before running over str
Date: Sat,  7 Nov 2009 13:16:19 -0200
Message-ID: <384d1e35bda461d2478997ce9aefbf438cacb231.1257602781.git.andre.goddard__26946.113506756$1257837103$gmane$org@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id D77A6244FC
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 16:22:36 +0100 (CET)
Received: by mail-px0-f187.google.com with SMTP id 17so551618pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 07:22:36 -0800 (PST)
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-f>
Cc: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
List-Id: alsa-devel@alsa-project.org

Li4uIHNvIHRoYXQgc3RybGVuKCkgaXRlcmF0ZXMgb3ZlciBhIHNtYWxsZXIgc3RyaW5nIGNvbXBy
aXNpbmcgb2YgdGhlCnJlbWFpbmluZyBjaGFyYWN0ZXJzIG9ubHkuCgpTaWduZWQtb2ZmLWJ5OiBB
bmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4KLS0tCiBsaWIvc3Ry
aW5nLmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9zdHJpbmcuYyBiL2xpYi9zdHJpbmcuYwppbmRl
eCBkOWE1MWQ1Li5jZjg2ZWFiIDEwMDY0NAotLS0gYS9saWIvc3RyaW5nLmMKKysrIGIvbGliL3N0
cmluZy5jCkBAIC0zNTYsOCArMzU2LDggQEAgY2hhciAqc3Ryc3RyaXAoY2hhciAqcykKIAlzaXpl
X3Qgc2l6ZTsKIAljaGFyICplbmQ7CiAKKwlzID0gKGNoYXIgKilza2lwX3NwYWNlcyhzKTsKIAlz
aXplID0gc3RybGVuKHMpOwotCiAJaWYgKCFzaXplKQogCQlyZXR1cm4gczsKIApAQCAtMzY2LDcg
KzM2Niw3IEBAIGNoYXIgKnN0cnN0cmlwKGNoYXIgKnMpCiAJCWVuZC0tOwogCSooZW5kICsgMSkg
PSAnXDAnOwogCi0JcmV0dXJuIChjaGFyICopc2tpcF9zcGFjZXMocyk7CisJcmV0dXJuIHM7CiB9
CiBFWFBPUlRfU1lNQk9MKHN0cnN0cmlwKTsKIAotLSAKMS42LjUuMi4xNTMuZzZlMzFmLmRpcnR5
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
