From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 4/5] topology: parser: Add missing return
	value to snd_tplg_set_manifest_data()
Date: Tue,  8 Sep 2015 22:21:40 +0200
Message-ID: <1441743701-28165-5-git-send-email-tiwai@suse.de>
References: <1441743701-28165-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DCFB626516A
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 22:21:44 +0200 (CEST)
In-Reply-To: <1441743701-28165-1-git-send-email-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

U3BvdHRlZCBieSBnY2Mgd2FybmluZzoKICBwYXJzZXIuYzogSW4gZnVuY3Rpb24g4oCYc25kX3Rw
bGdfc2V0X21hbmlmZXN0X2RhdGHigJk6CiAgcGFyc2VyLmM6MzYxOjE6IHdhcm5pbmc6IGNvbnRy
b2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rpb24gWy1XcmV0dXJuLXR5cGVdCiAgIH0K
ICAgXgoKU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgotLS0KIHNy
Yy90b3BvbG9neS9wYXJzZXIuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
CgpkaWZmIC0tZ2l0IGEvc3JjL3RvcG9sb2d5L3BhcnNlci5jIGIvc3JjL3RvcG9sb2d5L3BhcnNl
ci5jCmluZGV4IGNhN2RlMDY4OWNlYS4uNDRjNjE0NmIyMmYyIDEwMDY0NAotLS0gYS9zcmMvdG9w
b2xvZ3kvcGFyc2VyLmMKKysrIGIvc3JjL3RvcG9sb2d5L3BhcnNlci5jCkBAIC0zNTgsNiArMzU4
LDcgQEAgaW50IHNuZF90cGxnX3NldF9tYW5pZmVzdF9kYXRhKHNuZF90cGxnX3QgKnRwbGcsIGNv
bnN0IHZvaWQgKmRhdGEsIGludCBsZW4pCiB7CiAJdHBsZy0+bWFuaWZlc3QucHJpdi5zaXplID0g
bGVuOwogCXRwbGctPm1hbmlmZXN0X3BkYXRhID0gZGF0YTsKKwlyZXR1cm4gMDsKIH0KIAogdm9p
ZCBzbmRfdHBsZ192ZXJib3NlKHNuZF90cGxnX3QgKnRwbGcsIGludCB2ZXJib3NlKQotLSAKMi41
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
