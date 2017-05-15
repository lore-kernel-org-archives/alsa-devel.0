From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] ALSA: firewire-tascam: Fix infinite loop
	in snd_tscm_stream_get_rate()
Date: Mon, 15 May 2017 10:19:09 +0200
Message-ID: <1494836350-28790-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB5526684C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:19:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

T2J2aW91c2x5IHRoZSBpbnRlbnRpb24gd2FzIHRvIHB1dCBhIGxpbWl0IG9uIHRoZSBtYXhpbXVt
IG51bWJlciBvZgpvcGVyYXRpb25zLiAgSG93ZXZlciwgZm9yIHRoaXMgdG8gd29yaywgdGhlIGNo
ZWNrIHNob3VsZCBiZQoiJiYgdHJpYWxzKysgPCA1Iiwgbm90ICJ8fCB0cmlhbHMrKyA8IDUiLgoK
Rml4ZXM6IDM1ZWZhNWM0ODlkZTYzYTkgKCJBTFNBOiBmaXJld2lyZS10YXNjYW06IGFkZCBzdHJl
YW1pbmcgZnVuY3Rpb25hbGl0eSIpClNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnRAbGludXgtbTY4ay5vcmc+Ci0tLQpDb21waWxlLXRlc3RlZCBvbmx5LgoKVHJpZ2dlcmVk
IGJ5IGEgZmFsc2UtcG9zaXRpdmUgd2FybmluZyBmcm9tIGdjYy00LjEuMjoKCiAgICB3YXJuaW5n
OiDigJhlcnLigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uCi0t
LQogc291bmQvZmlyZXdpcmUvdGFzY2FtL3Rhc2NhbS1zdHJlYW0uYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L2ZpcmV3aXJlL3Rhc2NhbS90YXNjYW0tc3RyZWFtLmMgYi9zb3VuZC9maXJld2lyZS90YXNjYW0v
dGFzY2FtLXN0cmVhbS5jCmluZGV4IGYxNjU3YTRlMDYyMWVmNDkuLmU0MzNiOTJhYzY5MDRkYjUg
MTAwNjQ0Ci0tLSBhL3NvdW5kL2ZpcmV3aXJlL3Rhc2NhbS90YXNjYW0tc3RyZWFtLmMKKysrIGIv
c291bmQvZmlyZXdpcmUvdGFzY2FtL3Rhc2NhbS1zdHJlYW0uYwpAQCAtODQsNyArODQsNyBAQCBp
bnQgc25kX3RzY21fc3RyZWFtX2dldF9yYXRlKHN0cnVjdCBzbmRfdHNjbSAqdHNjbSwgdW5zaWdu
ZWQgaW50ICpyYXRlKQogCXVuc2lnbmVkIGludCB0cmlhbHMgPSAwOwogCWludCBlcnI7CiAKLQl3
aGlsZSAoZGF0YSA9PSAweDAgfHwgdHJpYWxzKysgPCA1KSB7CisJd2hpbGUgKGRhdGEgPT0gMHgw
ICYmIHRyaWFscysrIDwgNSkgewogCQllcnIgPSBnZXRfY2xvY2sodHNjbSwgJmRhdGEpOwogCQlp
ZiAoZXJyIDwgMCkKIAkJCXJldHVybiBlcnI7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
