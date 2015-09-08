From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 3/5] topology: data: Fix wrong size check
	in tplg_parse_data_hex()
Date: Tue,  8 Sep 2015 22:21:39 +0200
Message-ID: <1441743701-28165-4-git-send-email-tiwai@suse.de>
References: <1441743701-28165-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 11A2B265176
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 22:21:45 +0200 (CEST)
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

QSB3cm9uZywgdW5pbml0aWFsaXplZCB2YXJpYWJsZSBpcyByZWZlcnJlZCBhcyB0aGUgc2l6ZSB0
byBjaGVjayBpbgp0cGxnX3BhcnNlX2RhdGFfaGV4KCkuICBTcG90dGVkIGJ5IGdjYyB3YXJuaW5n
OgogIGRhdGEuYzogSW4gZnVuY3Rpb24g4oCYdHBsZ19wYXJzZV9kYXRhX2hleOKAmToKICBkYXRh
LmM6MjI4OjU6IHdhcm5pbmc6IOKAmGVzaXpl4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQg
aW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQogICAgaWYgKGVzaXplID4g
VFBMR19NQVhfUFJJVl9TSVpFKSB7CiAgICAgICAgXgogIGRhdGEuYzoyMTE6MTI6IG5vdGU6IOKA
mGVzaXpl4oCZIHdhcyBkZWNsYXJlZCBoZXJlCiAgICBpbnQgc2l6ZSwgZXNpemUsIG9mZiwgbnVt
OwogICAgICAgICAgICAgIF4KClNpZ25lZC1vZmYtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3Vz
ZS5kZT4KLS0tCiBzcmMvdG9wb2xvZ3kvZGF0YS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy90b3BvbG9n
eS9kYXRhLmMgYi9zcmMvdG9wb2xvZ3kvZGF0YS5jCmluZGV4IDRlZTFmOGExNWY5NS4uMzcwYzBm
YWVhZDM2IDEwMDY0NAotLS0gYS9zcmMvdG9wb2xvZ3kvZGF0YS5jCisrKyBiL3NyYy90b3BvbG9n
eS9kYXRhLmMKQEAgLTIyNSw4ICsyMjUsOCBAQCBzdGF0aWMgaW50IHRwbGdfcGFyc2VfZGF0YV9o
ZXgoc25kX2NvbmZpZ190ICpjZmcsIHN0cnVjdCB0cGxnX2VsZW0gKmVsZW0sCiAJc2l6ZSA9IG51
bSAqIHdpZHRoOwogCXByaXYgPSBlbGVtLT5kYXRhOwogCi0JaWYgKGVzaXplID4gVFBMR19NQVhf
UFJJVl9TSVpFKSB7Ci0JCVNOREVSUigiZXJyb3I6IGRhdGEgdG9vIGJpZyAlZFxuIiwgZXNpemUp
OworCWlmIChzaXplID4gVFBMR19NQVhfUFJJVl9TSVpFKSB7CisJCVNOREVSUigiZXJyb3I6IGRh
dGEgdG9vIGJpZyAlZFxuIiwgc2l6ZSk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAotLSAKMi41
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
