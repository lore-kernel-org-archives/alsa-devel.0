From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: fsi: Move inline fsi_stream_is_play()
	before use
Date: Tue, 16 May 2017 19:20:00 +0200
Message-ID: <1494955200-1051-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF6B26751A
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 19:20:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

V2l0aCBnY2MgNC4xLjI6CgogICAgc291bmQvc29jL3NoL2ZzaS5jOjMwNDogd2FybmluZzog4oCY
ZnNpX3N0cmVhbV9pc19wbGF54oCZIGRlY2xhcmVkIGlubGluZSBhZnRlciBiZWluZyBjYWxsZWQK
ICAgIHNvdW5kL3NvYy9zaC9mc2kuYzozMDQ6IHdhcm5pbmc6IHByZXZpb3VzIGRlY2xhcmF0aW9u
IG9mIOKAmGZzaV9zdHJlYW1faXNfcGxheeKAmSB3YXMgaGVyZQoKTW92ZSBmc2lfc3RyZWFtX2lz
X3BsYXkoKSB1cCB0byBmaXggdGhpcywgcmVtb3ZpbmcgdGhlIG5lZWQgZm9yIGEKZm9yd2FyZCBk
ZWNsYXJhdGlvbiBhcyB3ZWxsLgoKU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydEBsaW51eC1tNjhrLm9yZz4KLS0tCiBzb3VuZC9zb2Mvc2gvZnNpLmMgfCAxMyArKysrKyst
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zaC9mc2kuYyBiL3NvdW5kL3NvYy9zaC9mc2kuYwppbmRl
eCBlYWQ1MjAxODJlMjY4NGZiLi43YzRiZGQ4MmJiOTU1YmJiIDEwMDY0NAotLS0gYS9zb3VuZC9z
b2Mvc2gvZnNpLmMKKysrIGIvc291bmQvc29jL3NoL2ZzaS5jCkBAIC0zMDEsNyArMzAxLDEyIEBA
IHN0cnVjdCBmc2lfbWFzdGVyIHsKIAlzcGlubG9ja190IGxvY2s7CiB9OwogCi1zdGF0aWMgaW50
IGZzaV9zdHJlYW1faXNfcGxheShzdHJ1Y3QgZnNpX3ByaXYgKmZzaSwgc3RydWN0IGZzaV9zdHJl
YW0gKmlvKTsKK3N0YXRpYyBpbmxpbmUgaW50IGZzaV9zdHJlYW1faXNfcGxheShzdHJ1Y3QgZnNp
X3ByaXYgKmZzaSwKKwkJCQkgICAgIHN0cnVjdCBmc2lfc3RyZWFtICppbykKK3sKKwlyZXR1cm4g
JmZzaS0+cGxheWJhY2sgPT0gaW87Cit9CisKIAogLyoKICAqCQliYXNpYyByZWFkIHdyaXRlIGZ1
bmN0aW9uCkBAIC00ODksMTIgKzQ5NCw2IEBAIHN0YXRpYyB2b2lkIGZzaV9jb3VudF9maWZvX2Vy
cihzdHJ1Y3QgZnNpX3ByaXYgKmZzaSkKIC8qCiAgKgkJZnNpX3N0cmVhbV94eCgpIGZ1bmN0aW9u
CiAgKi8KLXN0YXRpYyBpbmxpbmUgaW50IGZzaV9zdHJlYW1faXNfcGxheShzdHJ1Y3QgZnNpX3By
aXYgKmZzaSwKLQkJCQkgICAgIHN0cnVjdCBmc2lfc3RyZWFtICppbykKLXsKLQlyZXR1cm4gJmZz
aS0+cGxheWJhY2sgPT0gaW87Ci19Ci0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZzaV9zdHJlYW0g
KmZzaV9zdHJlYW1fZ2V0KHN0cnVjdCBmc2lfcHJpdiAqZnNpLAogCQkJCQlzdHJ1Y3Qgc25kX3Bj
bV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
