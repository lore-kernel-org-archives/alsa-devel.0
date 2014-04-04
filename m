From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] ASoC: pcm512x: Use CONFIG_PM_RUNTIME macro
Date: Fri,  4 Apr 2014 11:29:08 +0530
Message-ID: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id EDCE726572A
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 07:59:42 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ma3so2949079pbc.41
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 22:59:41 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyBjb21waWxhdGlvbiB3YXJuaW5nczoKc291bmQvc29jL2NvZGVj
cy9wY201MTJ4LmM6NTIwOjEyOiB3YXJuaW5nOiDigJhwY201MTJ4X3N1c3BlbmTigJkgZGVmaW5l
ZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQpzb3VuZC9zb2MvY29kZWNzL3BjbTUx
MnguYzo1NDU6MTI6IHdhcm5pbmc6IOKAmHBjbTUxMnhfcmVzdW1l4oCZIGRlZmluZWQgYnV0IG5v
dCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0KClNpZ25lZC1vZmYtYnk6IFNhY2hpbiBLYW1hdCA8
c2FjaGluLmthbWF0QGxpbmFyby5vcmc+Ci0tLQogc291bmQvc29jL2NvZGVjcy9wY201MTJ4LmMg
fCAgICAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy9wY201MTJ4LmMgYi9zb3VuZC9zb2MvY29kZWNzL3BjbTUxMnguYwpp
bmRleCA0YjRjMGM3Li41MTEyNDIwIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3BjbTUx
MnguYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3BjbTUxMnguYwpAQCAtNTE3LDYgKzUxNyw3IEBA
IHZvaWQgcGNtNTEyeF9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQogfQogRVhQT1JUX1NZTUJP
TF9HUEwocGNtNTEyeF9yZW1vdmUpOwogCisjaWZkZWYgQ09ORklHX1BNX1JVTlRJTUUKIHN0YXRp
YyBpbnQgcGNtNTEyeF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgcGNt
NTEyeF9wcml2ICpwY201MTJ4ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CkBAIC01NzgsNiArNTc5
LDcgQEAgc3RhdGljIGludCBwY201MTJ4X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAKIAly
ZXR1cm4gMDsKIH0KKyNlbmRpZgogCiBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBwY201MTJ4X3Bt
X29wcyA9IHsKIAlTRVRfUlVOVElNRV9QTV9PUFMocGNtNTEyeF9zdXNwZW5kLCBwY201MTJ4X3Jl
c3VtZSwgTlVMTCkKLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
