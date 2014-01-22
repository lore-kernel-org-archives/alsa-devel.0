From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 7/7] ASoC: Samsung: smdk_wm8994: Fix unused
	variable warning
Date: Wed, 22 Jan 2014 11:43:33 +0530
Message-ID: <1390371213-21643-8-git-send-email-sachin.kamat@linaro.org>
References: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CBC5E265043
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 07:18:32 +0100 (CET)
Received: by mail-pb0-f43.google.com with SMTP id md12so9398504pbc.16
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 22:18:31 -0800 (PST)
In-Reply-To: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: patches@linaro.org, sbkim73@samsung.com, lgirdwood@gmail.com, tiwai@suse.de, broonie@kernel.org, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

4oCYc21ka19ib2FyZF9kYXRh4oCZIGlzIHJlcXVpcmVkIG9ubHkgd2hlbiBPRiBpcyBlbmFibGVk
LiBNb3ZlIGl0IHRvIGF2b2lkCnRoZSBmb2xsb3dpbmcgYnVpbGQgd2FybmluZzoKc291bmQvc29j
L3NhbXN1bmcvc21ka193bTg5OTQuYzo0NzozMjogd2FybmluZzog4oCYc21ka19ib2FyZF9kYXRh
4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC12YXJpYWJsZV0KClNpZ25lZC1vZmYt
Ynk6IFNhY2hpbiBLYW1hdCA8c2FjaGluLmthbWF0QGxpbmFyby5vcmc+Ci0tLQogc291bmQvc29j
L3NhbXN1bmcvc21ka193bTg5OTQuYyB8ICAgMTAgKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
c2Ftc3VuZy9zbWRrX3dtODk5NC5jIGIvc291bmQvc29jL3NhbXN1bmcvc21ka193bTg5OTQuYwpp
bmRleCAxZDk2NDFjYzE3MmEuLmEwMjY4ZmMwYTNkOSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3Nh
bXN1bmcvc21ka193bTg5OTQuYworKysgYi9zb3VuZC9zb2Mvc2Ftc3VuZy9zbWRrX3dtODk5NC5j
CkBAIC00MywxMSArNDMsNiBAQCBzdHJ1Y3Qgc21ka193bTg5OTRfZGF0YSB7CiAJaW50IG1jbGsx
X3JhdGU7CiB9OwogCi0vKiBEZWZhdWx0IFNNREtzICovCi1zdGF0aWMgc3RydWN0IHNtZGtfd204
OTk0X2RhdGEgc21ka19ib2FyZF9kYXRhID0gewotCS5tY2xrMV9yYXRlID0gU01ES19XTTg5OTRf
RlJFUSwKLX07Ci0KIHN0YXRpYyBpbnQgc21ka19od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0sCiAJc3RydWN0IHNuZF9wY21faHdfcGFyYW1zICpwYXJhbXMpCiB7
CkBAIC0xNTMsNiArMTQ4LDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIHNtZGsgPSB7
CiB9OwogCiAjaWZkZWYgQ09ORklHX09GCisvKiBEZWZhdWx0IFNNREtzICovCitzdGF0aWMgc3Ry
dWN0IHNtZGtfd204OTk0X2RhdGEgc21ka19ib2FyZF9kYXRhID0geworCS5tY2xrMV9yYXRlID0g
U01ES19XTTg5OTRfRlJFUSwKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IHNhbXN1bmdfd204OTk0X29mX21hdGNoW10gPSB7CiAJeyAuY29tcGF0aWJsZSA9ICJzYW1zdW5n
LHNtZGstd204OTk0IiwgLmRhdGEgPSAmc21ka19ib2FyZF9kYXRhIH0sCiAJe30sCi0tIAoxLjcu
OS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
