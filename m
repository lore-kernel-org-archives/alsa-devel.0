From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/7] ASoC: Samsung: smdk_wm8994: Fix build error
Date: Wed, 22 Jan 2014 11:43:32 +0530
Message-ID: <1390371213-21643-7-git-send-email-sachin.kamat@linaro.org>
References: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 12CF6265038
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 07:18:28 +0100 (CET)
Received: by mail-pd0-f172.google.com with SMTP id p10so4938103pdj.31
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 22:18:28 -0800 (PST)
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvciB3aGVuIE9GIGlzIG5vdCBkZWZpbmVkOgpz
b3VuZC9zb2Mvc2Ftc3VuZy9zbWRrX3dtODk5NC5jOjE5MToyMzogZXJyb3I6IOKAmHNhbXN1bmdf
d204OTk0X29mX21hdGNo4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQoKU2lnbmVkLW9mZi1ieTogU2FjaGluIEthbWF0IDxzYWNoaW4ua2FtYXRAbGluYXJvLm9yZz4K
LS0tCiBzb3VuZC9zb2Mvc2Ftc3VuZy9zbWRrX3dtODk5NC5jIHwgICAgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQv
c29jL3NhbXN1bmcvc21ka193bTg5OTQuYyBiL3NvdW5kL3NvYy9zYW1zdW5nL3NtZGtfd204OTk0
LmMKaW5kZXggYjA3MmJkMTA3YjMxLi4xZDk2NDFjYzE3MmEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Nv
Yy9zYW1zdW5nL3NtZGtfd204OTk0LmMKKysrIGIvc291bmQvc29jL3NhbXN1bmcvc21ka193bTg5
OTQuYwpAQCAtMTg4LDcgKzE4OCw3IEBAIHN0YXRpYyBpbnQgc21ka19hdWRpb19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlzbWRrX2RhaVswXS5wbGF0Zm9ybV9vZl9ub2Rl
ID0gc21ka19kYWlbMF0uY3B1X29mX25vZGU7CiAJfQogCi0JaWQgPSBvZl9tYXRjaF9kZXZpY2Uo
c2Ftc3VuZ193bTg5OTRfb2ZfbWF0Y2gsICZwZGV2LT5kZXYpOworCWlkID0gb2ZfbWF0Y2hfZGV2
aWNlKG9mX21hdGNoX3B0cihzYW1zdW5nX3dtODk5NF9vZl9tYXRjaCksICZwZGV2LT5kZXYpOwog
CWlmIChpZCkKIAkJKmJvYXJkID0gKigoc3RydWN0IHNtZGtfd204OTk0X2RhdGEgKilpZC0+ZGF0
YSk7CiAKLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
