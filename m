From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: qcom: Return an error for invalid PCM
	trigger command
Date: Mon, 13 Apr 2015 14:23:29 +0200
Message-ID: <1428927809-4919-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 790C5261B36
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:23:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rml4IGEgY29tcGlsZSB3YXJuaW5nCiAgc291bmQvc29jL3Fjb20vbHBhc3MtY3B1LmM6IEluIGZ1
bmN0aW9uIOKAmGxwYXNzX2NwdV9kYWlvcHNfdHJpZ2dlcuKAmToKICBzb3VuZC9zb2MvcWNvbS9s
cGFzcy1jcHUuYzoyMjQ6Mjogd2FybmluZzog4oCYcmV04oCZIG1heSBiZSB1c2VkIHVuaW5pdGlh
bGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQogICAgcmV0dXJu
IHJldDsKICAgICAgXgpBbHRob3VnaCBzd2l0Y2ggKCkgbGlzdHMgdGhlIG1vc3Qgb2YgZXhpc3Rp
bmcgY2FzZXMsIGl0J3Mgc3RpbGwgYmV0dGVyCnRvIGNvdmVyIHRoZSByZXN0IGFzIGFuIGVycm9y
IHByb3Blcmx5LgoKU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgot
LS0KIHNvdW5kL3NvYy9xY29tL2xwYXNzLWNwdS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3Fjb20v
bHBhc3MtY3B1LmMgYi9zb3VuZC9zb2MvcWNvbS9scGFzcy1jcHUuYwppbmRleCA2Njk4ZDA1OGRl
MjkuLmRjNzkwYWJhYTMzMSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3Fjb20vbHBhc3MtY3B1LmMK
KysrIGIvc291bmQvc29jL3Fjb20vbHBhc3MtY3B1LmMKQEAgLTE5NCw3ICsxOTQsNyBAQCBzdGF0
aWMgaW50IGxwYXNzX2NwdV9kYWlvcHNfdHJpZ2dlcihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0g
KnN1YnN0cmVhbSwKIAkJaW50IGNtZCwgc3RydWN0IHNuZF9zb2NfZGFpICpkYWkpCiB7CiAJc3Ry
dWN0IGxwYXNzX2RhdGEgKmRydmRhdGEgPSBzbmRfc29jX2RhaV9nZXRfZHJ2ZGF0YShkYWkpOwot
CWludCByZXQ7CisJaW50IHJldCA9IC1FSU5WQUw7CiAKIAlzd2l0Y2ggKGNtZCkgewogCWNhc2Ug
U05EUlZfUENNX1RSSUdHRVJfU1RBUlQ6Ci0tIAoyLjMuNQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
