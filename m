From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap3pandora: Fix compilation error
Date: Tue, 5 Mar 2013 15:24:16 +0100
Message-ID: <1362493456-6674-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D73265253
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 15:24:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, notasas@gmail.com, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Rml4ZXM6CnNvdW5kL3NvYy9vbWFwL29tYXAzcGFuZG9yYS5jOiBJbiBmdW5jdGlvbiDigJhvbWFw
M3BhbmRvcmFfZGFjX2V2ZW504oCZOgpzb3VuZC9zb2Mvb21hcC9vbWFwM3BhbmRvcmEuYzo5Mjox
OTogZXJyb3I6IHJlcXVlc3QgZm9yIG1lbWJlciDigJhkZXbigJkgaW4gc29tZXRoaW5nIG5vdCBh
IHN0cnVjdHVyZSBvciB1bmlvbgptYWtlWzNdOiAqKiogW3NvdW5kL3NvYy9vbWFwL29tYXAzcGFu
ZG9yYS5vXSBFcnJvciAxCgpXaGljaCBpcyBpbnRyb2R1Y2VkIGJ5OgpkZDE5NGI0IEFTb0M6IG9t
YXA6IENoZWNrIHJlZ3VsYXRvciBlbmFibGUgZm9yIERBQyBvbiBQYW5kb3JhCgpTaWduZWQtb2Zm
LWJ5OiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lAdGkuY29tPgotLS0KIHNvdW5kL3Nv
Yy9vbWFwL29tYXAzcGFuZG9yYS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL29tYXAvb21hcDNwYW5k
b3JhLmMgYi9zb3VuZC9zb2Mvb21hcC9vbWFwM3BhbmRvcmEuYwppbmRleCAxMGNlZDlkLi45ZTQ2
ZTFkIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvb21hcC9vbWFwM3BhbmRvcmEuYworKysgYi9zb3Vu
ZC9zb2Mvb21hcC9vbWFwM3BhbmRvcmEuYwpAQCAtODksNyArODksNyBAQCBzdGF0aWMgaW50IG9t
YXAzcGFuZG9yYV9kYWNfZXZlbnQoc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKncsCiAJaWYg
KFNORF9TT0NfREFQTV9FVkVOVF9PTihldmVudCkpIHsKIAkJcmV0ID0gcmVndWxhdG9yX2VuYWJs
ZShvbWFwM3BhbmRvcmFfZGFjX3JlZyk7CiAJCWlmIChyZXQpIHsKLQkJCWRldl9lcnIody0+ZGFw
bS5kZXYsICJGYWlsZWQgdG8gcG93ZXIgREFDOiAlZFxuIiwgcmV0KTsKKwkJCWRldl9lcnIody0+
ZGFwbS0+ZGV2LCAiRmFpbGVkIHRvIHBvd2VyIERBQzogJWRcbiIsIHJldCk7CiAJCQlyZXR1cm4g
cmV0OwogCQl9CiAJCW1kZWxheSgxKTsKLS0gCjEuOC4xLjUKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
