From: Vinod Koul <vinod.koul@intel.com>
Subject: =?utf-8?q?=5BPATCH_09/14=5D_ASoC=3A_max9867=3A_remov?=
	=?utf-8?b?ZSB1bnVzZWQg4oCYcmV04oCZ?=
Date: Thu,  8 Dec 2016 23:01:32 +0530
Message-ID: <1481218297-17568-10-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C4F26751A
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:38 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SW4gbWF4OTg2N19kYWlfc2V0X2ZtdCgpLCAncmV0JyBpcyBpbml0aWFsaXplZCBhcyByZXR1cm4g
dmFsdWUgb2YKcmVnbWFwX3Jhd193cml0ZSgpIGJ1dCBuZXZlciBjaGVja2VkLCBzbyByZW1vdmUg
dGhpcyBhbmQgYXNzaWduZW1lbnQuCgpzb3VuZC9zb2MvY29kZWNzL21heDk4NjcuYzogSW4gZnVu
Y3Rpb24g4oCYbWF4OTg2N19kYWlfc2V0X2ZtdOKAmToKc291bmQvc29jL2NvZGVjcy9tYXg5ODY3
LmM6MzEyOjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJldOKAmSBzZXQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogIGludCByZXQ7CgpTaWduZWQtb2ZmLWJ5OiBWaW5v
ZCBLb3VsIDx2aW5vZC5rb3VsQGludGVsLmNvbT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL21heDk4
NjcuYyB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9tYXg5ODY3LmMgYi9zb3VuZC9z
b2MvY29kZWNzL21heDk4NjcuYwppbmRleCA0MmUyZTQwN2UyODcuLjZjZGYxNWFiNDZkZSAxMDA2
NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9tYXg5ODY3LmMKKysrIGIvc291bmQvc29jL2NvZGVj
cy9tYXg5ODY3LmMKQEAgLTMwOSw3ICszMDksNiBAQCBzdGF0aWMgaW50IG1heDk4NjdfZGFpX3Nl
dF9mbXQoc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19kYWksCiAJc3RydWN0IHNuZF9zb2NfY29k
ZWMgKmNvZGVjID0gY29kZWNfZGFpLT5jb2RlYzsKIAlzdHJ1Y3QgbWF4OTg2N19wcml2ICptYXg5
ODY3ID0gc25kX3NvY19jb2RlY19nZXRfZHJ2ZGF0YShjb2RlYyk7CiAJdTggaWZhY2UxQSA9IDAs
IGlmYWNlMUIgPSAwOwotCWludCByZXQ7CiAKIAlzd2l0Y2ggKGZtdCAmIFNORF9TT0NfREFJRk1U
X01BU1RFUl9NQVNLKSB7CiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOgpAQCAtMzQ2LDgg
KzM0NSw4IEBAIHN0YXRpYyBpbnQgbWF4OTg2N19kYWlfc2V0X2ZtdChzdHJ1Y3Qgc25kX3NvY19k
YWkgKmNvZGVjX2RhaSwKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JcmV0ID0gcmVnbWFwX3dy
aXRlKG1heDk4NjctPnJlZ21hcCwgTUFYOTg2N19JRkMxQSwgaWZhY2UxQSk7Ci0JcmV0ID0gcmVn
bWFwX3dyaXRlKG1heDk4NjctPnJlZ21hcCwgTUFYOTg2N19JRkMxQiwgaWZhY2UxQik7CisJcmVn
bWFwX3dyaXRlKG1heDk4NjctPnJlZ21hcCwgTUFYOTg2N19JRkMxQSwgaWZhY2UxQSk7CisJcmVn
bWFwX3dyaXRlKG1heDk4NjctPnJlZ21hcCwgTUFYOTg2N19JRkMxQiwgaWZhY2UxQik7CiAJcmV0
dXJuIDA7CiB9CiAKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
