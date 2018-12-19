From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/4] ASoC: wm8904: save model id directly in
	of_device_id.data
Date: Wed, 19 Dec 2018 21:11:16 +0100
Message-ID: <30114be8a4e9eda7c6b2a6f555397f51f9a389f8.1545249666.git.mirq-linux@rere.qmqm.pl>
References: <cover.1545249666.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by alsa0.perex.cz (Postfix) with ESMTP id A65C6267B31
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 21:11:16 +0100 (CET)
In-Reply-To: <cover.1545249666.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

U2F2ZSAyeCB1bnNpZ25lZCBpbnQgb2YgLnJvZGF0YS4KClNpZ25lZC1vZmYtYnk6IE1pY2hhxYIg
TWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4KLS0tCiBzb3VuZC9zb2MvY29kZWNz
L3dtODkwNC5jIHwgOSArKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy93bTg5MDQuYyBi
L3NvdW5kL3NvYy9jb2RlY3Mvd204OTA0LmMKaW5kZXggZjhhMTdmY2RmZGViLi4yODEzYjdmNmE1
OGUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204OTA0LmMKKysrIGIvc291bmQvc29j
L2NvZGVjcy93bTg5MDQuYwpAQCAtMjEyMywxNiArMjEyMywxMyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHJlZ21hcF9jb25maWcgd204OTA0X3JlZ21hcCA9IHsKIH07CiAKICNpZmRlZiBDT05GSUdf
T0YKLXN0YXRpYyBlbnVtIHdtODkwNF90eXBlIHdtODkwNF9kYXRhID0gV004OTA0Owotc3RhdGlj
IGVudW0gd204OTA0X3R5cGUgd204OTEyX2RhdGEgPSBXTTg5MTI7Ci0KIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIHdtODkwNF9vZl9tYXRjaFtdID0gewogCXsKIAkJLmNvbXBhdGli
bGUgPSAid2xmLHdtODkwNCIsCi0JCS5kYXRhID0gJndtODkwNF9kYXRhLAorCQkuZGF0YSA9ICh2
b2lkICopV004OTA0LAogCX0sIHsKIAkJLmNvbXBhdGlibGUgPSAid2xmLHdtODkxMiIsCi0JCS5k
YXRhID0gJndtODkxMl9kYXRhLAorCQkuZGF0YSA9ICh2b2lkICopV004OTEyLAogCX0sIHsKIAkJ
Lyogc2VudGluZWwgKi8KIAl9CkBAIC0yMTczLDcgKzIxNzAsNyBAQCBzdGF0aWMgaW50IHdtODkw
NF9pMmNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmkyYywKIAkJbWF0Y2ggPSBvZl9tYXRjaF9u
b2RlKHdtODkwNF9vZl9tYXRjaCwgaTJjLT5kZXYub2Zfbm9kZSk7CiAJCWlmIChtYXRjaCA9PSBO
VUxMKQogCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCXdtODkwNC0+ZGV2dHlwZSA9ICooKGVudW0gd204
OTA0X3R5cGUgKiltYXRjaC0+ZGF0YSk7CisJCXdtODkwNC0+ZGV2dHlwZSA9IChlbnVtIHdtODkw
NF90eXBlKW1hdGNoLT5kYXRhOwogCX0gZWxzZSB7CiAJCXdtODkwNC0+ZGV2dHlwZSA9IGlkLT5k
cml2ZXJfZGF0YTsKIAl9Ci0tIAoyLjE5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
