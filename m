From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2 6/6] ASoC: Samsung: smdk_wm8994: Fix build
	error
Date: Wed, 22 Jan 2014 17:30:43 +0530
Message-ID: <1390392043-24387-7-git-send-email-sachin.kamat@linaro.org>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F88B265132
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 13:05:32 +0100 (CET)
Received: by mail-pd0-f182.google.com with SMTP id v10so290585pde.13
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 04:05:31 -0800 (PST)
In-Reply-To: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvciBhbmQgd2FybmluZyB3aGVuIE9GIGlzIG5v
dCBkZWZpbmVkOgpzb3VuZC9zb2Mvc2Ftc3VuZy9zbWRrX3dtODk5NC5jOjE5MToyMzogZXJyb3I6
IOKAmHNhbXN1bmdfd204OTk0X29mX21hdGNo4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQpzb3VuZC9zb2Mvc2Ftc3VuZy9zbWRrX3dtODk5NC5jOjQ3OjMyOiB3YXJu
aW5nOiDigJhzbWRrX2JvYXJkX2RhdGHigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LXZhcmlhYmxlXQoKb2ZfbWF0Y2hfcHRyKCkgaXMgdXNlZCBzbyB0aGF0IHNhbXN1bmdfd204OTk0
X29mX21hdGNoIGdldHMgZHJvcHBlZCAoYXMgdW51c2VkKQpieSB0aGUgY29tcGlsZXIgd2hlbiBP
RiBpcyBub3QgZGVmaW5lZC4KClNpZ25lZC1vZmYtYnk6IFNhY2hpbiBLYW1hdCA8c2FjaGluLmth
bWF0QGxpbmFyby5vcmc+Ci0tLQogc291bmQvc29jL3NhbXN1bmcvc21ka193bTg5OTQuYyB8ICAg
IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zYW1zdW5nL3NtZGtfd204OTk0LmMgYi9zb3VuZC9zb2Mv
c2Ftc3VuZy9zbWRrX3dtODk5NC5jCmluZGV4IGIwNzJiZDEwN2IzMS4uZDM4YWU5OGUyZjMyIDEw
MDY0NAotLS0gYS9zb3VuZC9zb2Mvc2Ftc3VuZy9zbWRrX3dtODk5NC5jCisrKyBiL3NvdW5kL3Nv
Yy9zYW1zdW5nL3NtZGtfd204OTk0LmMKQEAgLTE1MiwxMyArMTUyLDExIEBAIHN0YXRpYyBzdHJ1
Y3Qgc25kX3NvY19jYXJkIHNtZGsgPSB7CiAJLm51bV9saW5rcyA9IEFSUkFZX1NJWkUoc21ka19k
YWkpLAogfTsKIAotI2lmZGVmIENPTkZJR19PRgogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgc2Ftc3VuZ193bTg5OTRfb2ZfbWF0Y2hbXSA9IHsKIAl7IC5jb21wYXRpYmxlID0gInNh
bXN1bmcsc21kay13bTg5OTQiLCAuZGF0YSA9ICZzbWRrX2JvYXJkX2RhdGEgfSwKIAl7fSwKIH07
CiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBzYW1zdW5nX3dtODk5NF9vZl9tYXRjaCk7Ci0jZW5k
aWYgLyogQ09ORklHX09GICovCiAKIHN0YXRpYyBpbnQgc21ka19hdWRpb19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewpAQCAtMTg4LDcgKzE4Niw3IEBAIHN0YXRpYyBpbnQg
c21ka19hdWRpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlzbWRrX2Rh
aVswXS5wbGF0Zm9ybV9vZl9ub2RlID0gc21ka19kYWlbMF0uY3B1X29mX25vZGU7CiAJfQogCi0J
aWQgPSBvZl9tYXRjaF9kZXZpY2Uoc2Ftc3VuZ193bTg5OTRfb2ZfbWF0Y2gsICZwZGV2LT5kZXYp
OworCWlkID0gb2ZfbWF0Y2hfZGV2aWNlKG9mX21hdGNoX3B0cihzYW1zdW5nX3dtODk5NF9vZl9t
YXRjaCksICZwZGV2LT5kZXYpOwogCWlmIChpZCkKIAkJKmJvYXJkID0gKigoc3RydWN0IHNtZGtf
d204OTk0X2RhdGEgKilpZC0+ZGF0YSk7CiAKLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
