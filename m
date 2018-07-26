From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: trident: Suppress gcc string warning
Date: Thu, 26 Jul 2018 15:02:57 +0200
Message-ID: <20180726130257.30812-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 307D726739D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 15:02:59 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9CBC7AE8F
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 13:02:59 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

VGhlIG1lZGRsZXNvbWUgZ2NjIHdhcm5zIGFib3V0IHRoZSBwb3NzaWJsZSBzaG9ydG5hbWUgc3Ry
aW5nIGluCnRyaWRlbnQgZHJpdmVyIGNvZGU6CiAgc291bmQvcGNpL3RyaWRlbnQvdHJpZGVudC5j
OiBJbiBmdW5jdGlvbiDigJhzbmRfdHJpZGVudF9wcm9iZeKAmToKICBzb3VuZC9wY2kvdHJpZGVu
dC90cmlkZW50LmM6MTI2OjI6IHdhcm5pbmc6IOKAmHN0cmNhdOKAmSBhY2Nlc3NpbmcgMTcgb3Ig
bW9yZSBieXRlcyBhdCBvZmZzZXRzIDM2IGFuZCAyMCBtYXkgb3ZlcmxhcCAxIGJ5dGUgYXQgb2Zm
c2V0IDM2IFstV3Jlc3RyaWN0XQogIHN0cmNhdChjYXJkLT5zaG9ydG5hbWUsIGNhcmQtPmRyaXZl
cik7CgpJdCBoYXBwZW5zIHNpbmNlIGdjYyBjYWxjdWxhdGVzIHRoZSBwb3NzaWJsZSBzdHJpbmcg
c2l6ZSBmcm9tCmNhcmQtPmRyaXZlciwgYnV0IHRoaXMgY2FuJ3QgYmUgdHJ1ZSBzaW5jZSB3ZSBk
aWQgc2V0IHRoZSBzdHJpbmcganVzdApiZWZvcmUgdGhhdCwgYW5kIHRoZXkgYXJlIG11Y2ggc2hv
cnRlci4KCkZvciBzaHV0dGluZyBpdCB1cCwgdXNlIHRoZSBleGFjdGx5IHNhbWUgc3RyaW5nIHNl
dCB0byBjYXJkLT5kcml2ZXIKZm9yIHN0cmNhdCgpIHRvIGNhcmQtPnNob3J0bmFtZSwgdG9vLgoK
U2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgotLS0KIHNvdW5kL3Bj
aS90cmlkZW50L3RyaWRlbnQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS90cmlkZW50L3RyaWRlbnQu
YyBiL3NvdW5kL3BjaS90cmlkZW50L3RyaWRlbnQuYwppbmRleCBjZWRmMTNiNjQ4MDMuLjJmMThi
MWNkYzJjZCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL3RyaWRlbnQvdHJpZGVudC5jCisrKyBiL3Nv
dW5kL3BjaS90cmlkZW50L3RyaWRlbnQuYwpAQCAtMTIzLDcgKzEyMyw3IEBAIHN0YXRpYyBpbnQg
c25kX3RyaWRlbnRfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBjaSwKIAl9IGVsc2UgewogCQlzdHJj
cHkoY2FyZC0+c2hvcnRuYW1lLCAiVHJpZGVudCAiKTsKIAl9Ci0Jc3RyY2F0KGNhcmQtPnNob3J0
bmFtZSwgY2FyZC0+ZHJpdmVyKTsKKwlzdHJjYXQoY2FyZC0+c2hvcnRuYW1lLCBzdHIpOwogCXNw
cmludGYoY2FyZC0+bG9uZ25hbWUsICIlcyBQQ0kgQXVkaW8gYXQgMHglbHgsIGlycSAlZCIsCiAJ
CWNhcmQtPnNob3J0bmFtZSwgdHJpZGVudC0+cG9ydCwgdHJpZGVudC0+aXJxKTsKIAotLSAKMi4x
OC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
