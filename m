From: =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH] ASoC: imx-mc13783 cleanup
Date: Wed, 16 May 2012 12:48:24 +0200
Message-ID: <1337165304-22686-1-git-send-email-philippe.retornaz@epfl.ch>
References: <20120515183035.GG19592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.218])
	by alsa0.perex.cz (Postfix) with SMTP id DA8C624566
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 12:47:02 +0200 (CEST)
In-Reply-To: <20120515183035.GG19592@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, torbenh@linutronix.de, sameo@linux.intel.com, s.hauer@pengutronix.de, philippe.retornaz@epfl.ch, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFLDqXRvcm5heiA8cGhpbGlwcGUucmV0b3JuYXpAZXBm
bC5jaD4KLS0tCiBzb3VuZC9zb2MvZnNsL2lteC1tYzEzNzgzLmMgfCAgICA5ICstLS0tLS0tLQog
MSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL2ZzbC9pbXgtbWMxMzc4My5jIGIvc291bmQvc29jL2ZzbC9pbXgtbWMx
Mzc4My5jCmluZGV4IGE3YjcxNzAuLmY1OWMzNDkgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9mc2wv
aW14LW1jMTM3ODMuYworKysgYi9zb3VuZC9zb2MvZnNsL2lteC1tYzEzNzgzLmMKQEAgLTM3LDE0
ICszNyw2IEBAIHN0YXRpYyBpbnQgaW14X21jMTM3ODNfaGlmaV9od19wYXJhbXMoc3RydWN0IHNu
ZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19k
YWkgPSBydGQtPmNvZGVjX2RhaTsKIAlpbnQgcmV0OwogCi0JcmV0ID0gc25kX3NvY19kYWlfc2V0
X2ZtdChjb2RlY19kYWksIEZNVF9TU0kpOwotCWlmIChyZXQpCi0JCXJldHVybiByZXQ7Ci0KLQly
ZXQgPSBzbmRfc29jX2RhaV9zZXRfZm10KGNwdV9kYWksIEZNVF9TU0kpOwotCWlmIChyZXQpCi0J
CXJldHVybiByZXQ7Ci0KIAlyZXQgPSBzbmRfc29jX2RhaV9zZXRfdGRtX3Nsb3QoY29kZWNfZGFp
LCAweGZmZmZmZmZjLCAweGZmZmZmZmZjLAogCQkJCQk0LCAxNik7CiAJaWYgKHJldCkKQEAgLTc1
LDYgKzY3LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGlteF9tYzEzNzgzX2Rh
aV9tYzEzNzgzW10gPSB7CiAJCS5wbGF0Zm9ybV9uYW1lCSA9ICJpbXgtcGNtLWF1ZGlvLjAiLAog
CQkub3BzCQkgPSAmaW14X21jMTM3ODNfaGlmaV9vcHMsCiAJCS5zeW1tZXRyaWNfcmF0ZXMgPSAx
LAorCQkuZGFpX2ZtdCAJID0gRk1UX1NTSSwKIAl9LAogfTsKIAotLSAKMS43LjAuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
