From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tpa6130a2: Get rid of compile warning
	from tpa6130a2_power
Date: Wed,  3 Nov 2010 16:39:00 +0200
Message-ID: <1288795140-18563-1-git-send-email-jhnikula@gmail.com>
References: <s5hpqumqzgz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id C8CC8243E6
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 15:38:59 +0100 (CET)
Received: by ewy22 with SMTP id 22so282928ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 07:38:59 -0700 (PDT)
In-Reply-To: <s5hpqumqzgz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

UGF0Y2ggIkFTb0M6IHRwYTYxMzBhMjogRml4IHVuYmFsYW5jZWQgcmVndWxhdG9yIGRpc2FibGVz
IiBpbnRyb2R1Y2VkIGEKY29tcGlsZXIgd2FybmluZyAi4oCYcmV04oCZIG1heSBiZSB1c2VkIHVu
aW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiIuCkluaXRpYWxpemUgcmV0IHRvIHplcm8gdG8g
Z2V0IHJpZCBvZiBpdCBhbmQgbWFraW5nIHN1cmUgdGhhdCB0aGUgZnVuY3Rpb24KZG9lcyBub3Qg
cmV0dXJuIGFueSByYW5kb20gZXJyb3IgY29kZSB3aGVuIHRoZSBjb2RlIGlzIGZhbGxpbmcgdGhy
b3VnaC4KClNpZ25lZC1vZmYtYnk6IEphcmtrbyBOaWt1bGEgPGpobmlrdWxhQGdtYWlsLmNvbT4K
LS0tCiBzb3VuZC9zb2MvY29kZWNzL3RwYTYxMzBhMi5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2NvZGVjcy90cGE2MTMwYTIuYyBiL3NvdW5kL3NvYy9jb2RlY3MvdHBhNjEzMGEyLmMKaW5k
ZXggODNiNTYzMS4uZWU0ZmIyMCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy90cGE2MTMw
YTIuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL3RwYTYxMzBhMi5jCkBAIC0xMTksNyArMTE5LDcg
QEAgc3RhdGljIGludCB0cGE2MTMwYTJfcG93ZXIoaW50IHBvd2VyKQogewogCXN0cnVjdAl0cGE2
MTMwYTJfZGF0YSAqZGF0YTsKIAl1OAl2YWw7Ci0JaW50CXJldDsKKwlpbnQJcmV0ID0gMDsKIAog
CUJVR19PTih0cGE2MTMwYTJfY2xpZW50ID09IE5VTEwpOwogCWRhdGEgPSBpMmNfZ2V0X2NsaWVu
dGRhdGEodHBhNjEzMGEyX2NsaWVudCk7Ci0tIAoxLjcuMi4zCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
