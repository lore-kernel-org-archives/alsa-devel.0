From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/7] ASoC: Samsung: s3c-i2s-v2: Fix build error
Date: Wed, 22 Jan 2014 11:43:28 +0530
Message-ID: <1390371213-21643-3-git-send-email-sachin.kamat@linaro.org>
References: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB5C261B20
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 07:18:14 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id ld10so7205882pab.10
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 22:18:14 -0800 (PST)
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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@linaro.org, sbkim73@samsung.com, lgirdwood@gmail.com, tiwai@suse.de, broonie@kernel.org, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyBlcnJvciBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCBlY2EzYjAxZDA4
ODUKKCJBU29DOiBzd2l0Y2ggb3ZlciB0byB1c2Ugc25kX3NvY19yZWdpc3Rlcl9jb21wb25lbnQo
KSBvbiBzM2MgaTJzIik6CnNvdW5kL3NvYy9zYW1zdW5nL3MzYy1pMnMtdjIuYzo3MzI6MzI6IGVy
cm9yOiDigJhkcnbigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCgpT
aWduZWQtb2ZmLWJ5OiBTYWNoaW4gS2FtYXQgPHNhY2hpbi5rYW1hdEBsaW5hcm8ub3JnPgpDYzog
S3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3JpLm1vcmltb3RvLmd4QHJlbmVzYXMuY29tPgotLS0K
IHNvdW5kL3NvYy9zYW1zdW5nL3MzYy1pMnMtdjIuYyB8ICAgIDYgKysrLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9zYW1zdW5nL3MzYy1pMnMtdjIuYyBiL3NvdW5kL3NvYy9zYW1zdW5nL3MzYy1pMnMtdjIu
YwppbmRleCBmZWZjNTYxMDAzNDkuLjc5ZTdlZmI5MjgzYyAxMDA2NDQKLS0tIGEvc291bmQvc29j
L3NhbXN1bmcvczNjLWkycy12Mi5jCisrKyBiL3NvdW5kL3NvYy9zYW1zdW5nL3MzYy1pMnMtdjIu
YwpAQCAtNzI5LDcgKzcyOSw3IEBAIGludCBzM2NfaTJzdjJfcmVnaXN0ZXJfY29tcG9uZW50KHN0
cnVjdCBkZXZpY2UgKmRldiwgaW50IGlkLAogCQkJICAgc3RydWN0IHNuZF9zb2NfY29tcG9uZW50
X2RyaXZlciAqY21wX2RydiwKIAkJCSAgIHN0cnVjdCBzbmRfc29jX2RhaV9kcml2ZXIgKmRhaV9k
cnYpCiB7Ci0Jc3RydWN0IHNuZF9zb2NfZGFpX29wcyAqb3BzID0gZHJ2LT5vcHM7CisJc3RydWN0
IHNuZF9zb2NfZGFpX29wcyAqb3BzID0gZGFpX2Rydi0+b3BzOwogCiAJb3BzLT50cmlnZ2VyID0g
czNjMjQxMl9pMnNfdHJpZ2dlcjsKIAlpZiAoIW9wcy0+aHdfcGFyYW1zKQpAQCAtNzQyLDggKzc0
Miw4IEBAIGludCBzM2NfaTJzdjJfcmVnaXN0ZXJfY29tcG9uZW50KHN0cnVjdCBkZXZpY2UgKmRl
diwgaW50IGlkLAogCWlmICghb3BzLT5kZWxheSkKIAkJb3BzLT5kZWxheSA9IHMzYzI0MTJfaTJz
X2RlbGF5OwogCi0JZHJ2LT5zdXNwZW5kID0gczNjMjQxMl9pMnNfc3VzcGVuZDsKLQlkcnYtPnJl
c3VtZSA9IHMzYzI0MTJfaTJzX3Jlc3VtZTsKKwlkYWlfZHJ2LT5zdXNwZW5kID0gczNjMjQxMl9p
MnNfc3VzcGVuZDsKKwlkYWlfZHJ2LT5yZXN1bWUgPSBzM2MyNDEyX2kyc19yZXN1bWU7CiAKIAly
ZXR1cm4gc25kX3NvY19yZWdpc3Rlcl9jb21wb25lbnQoZGV2LCBjbXBfZHJ2LCBkYWlfZHJ2LCAx
KTsKIH0KLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
