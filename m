From: =?utf-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] eukrea-tlv320: add support for cpuimx35sd
Date: Mon, 19 Jul 2010 10:40:32 +0200
Message-ID: <1279528832-7916-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 78D852438B
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 10:40:38 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogRXJpYyBCw6luYXJkIDxlcmljQGV1a3JlYS5jb20+Ci0tLQogc291bmQv
c29jL2lteC9LY29uZmlnICAgICAgICAgfCAgICAyICstCiBzb3VuZC9zb2MvaW14L2V1a3JlYS10
bHYzMjAuYyB8ICAgIDMgKystCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW14L0tjb25maWcgYi9zb3VuZC9z
b2MvaW14L0tjb25maWcKaW5kZXggMmYwZDZkMy4uNTJkYWM1ZSAxMDA2NDQKLS0tIGEvc291bmQv
c29jL2lteC9LY29uZmlnCisrKyBiL3NvdW5kL3NvYy9pbXgvS2NvbmZpZwpAQCAtMzIsNiArMzIs
NiBAQCBjb25maWcgU05EX1NPQ19FVUtSRUFfVExWMzIwCiAJc2VsZWN0IFNORF9TT0NfVExWMzIw
QUlDMjMKIAloZWxwCiAJICBFbmFibGUgSTJTIGJhc2VkIGFjY2VzcyB0byB0aGUgVExWMzIwQUlD
MjNCIGNvZGVjIGF0dGFjaGVkCi0JICB0byB0aGUgU1NJNCBpbnRlcmZhY2UKKwkgIHRvIHRoZSBT
U0kgaW50ZXJmYWNlCiAKIGVuZGlmCSMgU05EX0lNWF9TT0MKZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9pbXgvZXVrcmVhLXRsdjMyMC5jIGIvc291bmQvc29jL2lteC9ldWtyZWEtdGx2MzIwLmMKaW5k
ZXggNDVmNWU0Yi4uZjE1ZGZiZCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2lteC9ldWtyZWEtdGx2
MzIwLmMKKysrIGIvc291bmQvc29jL2lteC9ldWtyZWEtdGx2MzIwLmMKQEAgLTEwMSw3ICsxMDEs
OCBAQCBzdGF0aWMgaW50IF9faW5pdCBldWtyZWFfdGx2MzIwX2luaXQodm9pZCkKIHsKIAlpbnQg
cmV0OwogCi0JaWYgKCFtYWNoaW5lX2lzX2V1a3JlYV9jcHVpbXgyNygpICYmICFtYWNoaW5lX2lz
X2V1a3JlYV9jcHVpbXgyNXNkKCkpCisJaWYgKCFtYWNoaW5lX2lzX2V1a3JlYV9jcHVpbXgyNygp
ICYmICFtYWNoaW5lX2lzX2V1a3JlYV9jcHVpbXgyNXNkKCkKKwkJJiYgIW1hY2hpbmVfaXNfZXVr
cmVhX2NwdWlteDM1c2QoKSkKIAkJLyogcmV0dXJuIGhhcHB5LiBXZSBtaWdodCBydW4gb24gYSB0
b3RhbGx5IGRpZmZlcmVudCBtYWNoaW5lICovCiAJCXJldHVybiAwOwogCi0tIAoxLjYuMy4zCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
