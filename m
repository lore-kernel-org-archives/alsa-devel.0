From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 01/12] pcm: hw: fix to initialize
	function local variable
Date: Fri, 30 Jun 2017 08:58:17 +0900
Message-ID: <20170629235828.18076-2-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 163142673F4
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:32 +0200 (CEST)
In-Reply-To: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBjb21taXQgaXMgdG8gZml4IGJlbG93IHdhcm5pbmcuCgpwY21faHcuYzogSW4gZnVuY3Rp
b24g4oCYc25kMV9wY21faHdfb3Blbl9mZOKAmToKcGNtX2h3LmM6OTU1OjMzOiB3YXJuaW5nOiDi
gJhtbWFwX2NvbnRyb2zigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0
aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdCiAgaWYgKG1tYXBfY29udHJvbCA9PSBNQVBfRkFJ
TEVEIHx8IG1tYXBfY29udHJvbCA9PSBOVUxMKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KcGNtX2h3LmM6OTQ2OjMxOiBub3RlOiDigJhtbWFwX2NvbnRyb2zigJkgd2FzIGRl
Y2xhcmVkIGhlcmUKICBzdHJ1Y3Qgc25kX3BjbV9tbWFwX2NvbnRyb2wgKm1tYXBfY29udHJvbDsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fgoKU2lnbmVkLW9mZi1i
eTogVGFrYXNoaSBTYWthbW90byA8by10YWthc2hpQHNha2Ftb2NjaGkuanA+Ci0tLQogc3JjL3Bj
bS9wY21faHcuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0t
Z2l0IGEvc3JjL3BjbS9wY21faHcuYyBiL3NyYy9wY20vcGNtX2h3LmMKaW5kZXggNjQxODhiMjIu
LmUwOTMxNTc3IDEwMDY0NAotLS0gYS9zcmMvcGNtL3BjbV9ody5jCisrKyBiL3NyYy9wY20vcGNt
X2h3LmMKQEAgLTkwNCw2ICs5MDQsNyBAQCBzdGF0aWMgYm9vbCBtYXBfY29udHJvbF9kYXRhKHNu
ZF9wY21faHdfdCAqaHcsCiAJc3RydWN0IHNuZF9wY21fbW1hcF9jb250cm9sICptbWFwX2NvbnRy
b2w7CiAJYm9vbCBmYWxsYmFja2VkOwogCisJbW1hcF9jb250cm9sID0gTUFQX0ZBSUxFRDsKIAlp
ZiAoIWZvcmNlX2ZhbGxiYWNrKSB7CiAJCW1tYXBfY29udHJvbCA9IG1tYXAoTlVMTCwgcGFnZV9h
bGlnbihzaXplb2YoKm1tYXBfY29udHJvbCkpLAogCQkJCSAgICBQUk9UX1JFQUR8UFJPVF9XUklU
RSwgTUFQX0ZJTEV8TUFQX1NIQVJFRCwKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
