From: =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <soulsonceonfire@gmail.com>
Subject: [PATCH] ALSA: line6: Use correct endpoint type for
	midi output
Date: Thu, 12 Apr 2018 00:37:35 -0300
Message-ID: <CAN0YATNkVQM_4NgLCWiVGmH9y0jiRrBEx+n8H7hWDFPXqxe_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5236726718D
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 05:37:37 +0200 (CEST)
Received: by mail-it0-f65.google.com with SMTP id m134-v6so5553861itb.3
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 20:37:37 -0700 (PDT)
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

SGksCgpTZW5kaW5nIE1JREkgbWVzc2FnZXMgdG8gYSBQT0R4dCB0aHJvdWdoIHRoZSBVU0IgY29u
bmVjdGlvbiBzaG93cwoidXNiX3N1Ym1pdF91cmIgZmFpbGVkIiBpbiBkbWVzZyBhbmQgdGhlIG1l
c3NhZ2UgaXMgbm90IHJlY2VpdmVkIGJ5CnRoZSBQT0QuCgpUaGUgZXJyb3IgaXMgY2F1c2VkIGJl
Y2F1c2UgaW4gdGhlIGZ1bmNpb24gc2VuZF9taWRpX2FzeW5jKCkgaW4gbWlkaS5jCnRoZXJlIGlz
IGEgY2FsbCB0byB1c2Jfc25kYnVsa3BpcGUoKSBmb3IgZW5kcG9pbnQgMyBPVVQsIGJ1dCB0aGUg
UE9EeHQKVVNCIGRlc2NyaXB0b3Igc2hvd3MgdGhhdCB0aGlzIGVuZHBvaW50IGl0J3MgYW4gaW50
ZXJydXB0IGVuZHBvaW50LgoKUGF0Y2ggdGVzdGVkIHdpdGggUE9EeHQgb25seS4KClNpZ25lZC1v
ZmYtYnk6IEZhYmnDoW4gSW5vc3Ryb3phIDxmYWJpYW5pbm9zdHJvemFAdWRlYy5jbD4KLS0tCiBz
b3VuZC91c2IvbGluZTYvbWlkaS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL2xpbmU2L21pZGkuYyBi
L3NvdW5kL3VzYi9saW5lNi9taWRpLmMKaW5kZXggNmQ3Y2RlNTYuLmUyY2Y1NWM1IDEwMDY0NAot
LS0gYS9zb3VuZC91c2IvbGluZTYvbWlkaS5jCisrKyBiL3NvdW5kL3VzYi9saW5lNi9taWRpLmMK
QEAgLTEyNSw3ICsxMjUsNyBAQCBzdGF0aWMgaW50IHNlbmRfbWlkaV9hc3luYyhzdHJ1Y3QgdXNi
X2xpbmU2CipsaW5lNiwgdW5zaWduZWQgY2hhciAqZGF0YSwKICAgICB9CgogICAgIHVzYl9maWxs
X2ludF91cmIodXJiLCBsaW5lNi0+dXNiZGV2LAotICAgICAgICAgICAgIHVzYl9zbmRidWxrcGlw
ZShsaW5lNi0+dXNiZGV2LAorICAgICAgICAgICAgIHVzYl9zbmRpbnRwaXBlKGxpbmU2LT51c2Jk
ZXYsCiAgICAgICAgICAgICAgICAgICAgICBsaW5lNi0+cHJvcGVydGllcy0+ZXBfY3RybF93KSwK
ICAgICAgICAgICAgICB0cmFuc2Zlcl9idWZmZXIsIGxlbmd0aCwgbWlkaV9zZW50LCBsaW5lNiwK
ICAgICAgICAgICAgICBsaW5lNi0+aW50ZXJ2YWwpOwotLSAKMi4xNi4zCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
