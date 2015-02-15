From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Subject: [PATCH] ASoC: sta32x: fix register range in regmap.
Date: Sun, 15 Feb 2015 16:53:36 +0100
Message-ID: <1424015616-31309-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 729362605B1
 for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2015 16:51:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, zonque@gmail.com, brandau@gmx.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

VGhlIFNUQTMyWF9BVVRPMyBpcyBhIHdyaXRhYmxlIHJlZ2lzdGVyIHRoYXQgY3VycmVudGx5IGRv
ZXMgbm90IGFwcGVhcgppbiB0aGUgcmVnbWFwIHJhbmdlcyhuZWl0aGVyIHJlYWQgbm9yIHdyaXRl
KS4gQnkgYWRkaW5nIHRoaXMgcmVnaXN0ZXIKdG8gdGhlIHJlZ2lzdGVyIHJhbmdlcyB0aGVyZSBp
cyBubyBnYXAgYW55bW9yZSBhbmQgdGhlIGV4aXN0aW5nCnJlZ2lzdGVyIHJhbmdlcyBjYW4gYmUg
am9pbmVkLiBUaGlzIGZpeGVzIGEgcmVncmVzc2lvbiB0aGF0IG1hZGUgaXQKaW1wb3NzaWJsZSB0
byBjaG9vc2UgdGhlIHByZXNldCBFUSBtb2RlIHNldCB0aHJvdWdoIHRoZSBTVEEzMlhfQVVUTzMK
cmVnaXN0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgTmllZGVycHLDvG0gPG5pZWRlcnBAcGh5
c2lrLnVuaS1rbC5kZT4KLS0tCkkgcmVhbGl6ZWQgdGhhdCBJIG1pc3NlZCBvbmUgcmVnaXN0ZXIg
aW4gdGhlIERUIGVuYWJsaW5nIHBhdGNoc2V0LApzbyBoZXJlIEkgc2VuZCBhIHBhdGNoIHRvIGNs
ZWFuIHVwIG15IG1lc3MgOikKClRob21hcwoKIHNvdW5kL3NvYy9jb2RlY3Mvc3RhMzJ4LmMgfCA2
ICsrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3N0YTMyeC5jIGIvc291bmQvc29jL2NvZGVj
cy9zdGEzMnguYwppbmRleCBiYzZlZGIxLi5kMzIwMjI3IDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mv
Y29kZWNzL3N0YTMyeC5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvc3RhMzJ4LmMKQEAgLTEwNywx
MyArMTA3LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnX2RlZmF1bHQgc3RhMzJ4X3JlZ3Nb
XSA9IHsKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX3JhbmdlIHN0YTMyeF93cml0
ZV9yZWdzX3JhbmdlW10gPSB7Ci0JcmVnbWFwX3JlZ19yYW5nZShTVEEzMlhfQ09ORkEsICBTVEEz
MlhfQVVUTzIpLAotCXJlZ21hcF9yZWdfcmFuZ2UoU1RBMzJYX0MxQ0ZHLCAgU1RBMzJYX0ZEUkMy
KSwKKwlyZWdtYXBfcmVnX3JhbmdlKFNUQTMyWF9DT05GQSwgIFNUQTMyWF9GRFJDMiksCiB9Owog
CiBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9yYW5nZSBzdGEzMnhfcmVhZF9yZWdzX3Jhbmdl
W10gPSB7Ci0JcmVnbWFwX3JlZ19yYW5nZShTVEEzMlhfQ09ORkEsICBTVEEzMlhfQVVUTzIpLAot
CXJlZ21hcF9yZWdfcmFuZ2UoU1RBMzJYX0MxQ0ZHLCAgU1RBMzJYX1NUQVRVUyksCisJcmVnbWFw
X3JlZ19yYW5nZShTVEEzMlhfQ09ORkEsICBTVEEzMlhfU1RBVFVTKSwKIH07CiAKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgcmVnbWFwX3JhbmdlIHN0YTMyeF92b2xhdGlsZV9yZWdzX3JhbmdlW10gPSB7
Ci0tIAoyLjEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
