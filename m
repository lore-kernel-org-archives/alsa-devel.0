From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] wm1133-ev1: fix init for multimachine kernel
Date: Thu, 21 Oct 2010 23:35:15 +0200
Message-ID: <1287696915-10392-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 63.mail-out.ovh.net (63.mail-out.ovh.net [91.121.185.56])
	by alsa0.perex.cz (Postfix) with SMTP id F0964103AC9
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 23:35:21 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

d2hlbiBydW5uaW5nIGEga2VybmVsIGJ1aWx0IHVzaW5nIG14M19kZWZjb25maWcsIEkgZ2V0IGFu
IGVycm9yIG1lc3NhZ2UKYmVjYXVzZSB3bTExMzMtZXYxIHRyaWVzIHRvIGFsbG9jIHNvYy1hdWRp
byBldmVuIGlmIG5vdCBydW5uaW5nIG9uIGFuCmlNWDMxYWRzIDoKc3lzZnM6IGNhbm5vdCBjcmVh
dGUgZHVwbGljYXRlIGZpbGVuYW1lICcvZGV2aWNlcy9wbGF0Zm9ybS9zb2MtYXVkaW8nCi4uLi8u
Li4Ka29iamVjdF9hZGRfaW50ZXJuYWwgZmFpbGVkIGZvciBzb2MtYXVkaW8gd2l0aCAtRUVYSVNU
LCBkb24ndCB0cnkgdG8gcmVnaXN0ZXIgdGhpbmdzIHdpdGggdGhlIHNhbWUgbmFtZSBpbiB0aGUg
c2FtZSBkaXJlY3RvcnkuCgpUaGlzIHBhdGNoIGZpeCB0aGlzIHByb2JsZW0uCgpTaWduZWQtb2Zm
LWJ5OiBFcmljIELDqW5hcmQgPGVyaWNAZXVrcmVhLmNvbT4KQ2M6IExpYW0gR2lyZHdvb2QgPGxy
Z0BzbGltbG9naWMuY28udWs+CkNjOiBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29s
ZnNvbm1pY3JvLmNvbT4KLS0tCiBzb3VuZC9zb2MvaW14L3dtMTEzMy1ldjEuYyB8ICAgIDUgKysr
KysKIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9pbXgvd20xMTMzLWV2MS5jIGIvc291bmQvc29jL2lteC93bTEx
MzMtZXYxLmMKaW5kZXggYTZlN2Q5NC4uZWYzNzQ0MCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2lt
eC93bTExMzMtZXYxLmMKKysrIGIvc291bmQvc29jL2lteC93bTExMzMtZXYxLmMKQEAgLTIwLDYg
KzIwLDcgQEAKICNpbmNsdWRlIDxzb3VuZC9wY21fcGFyYW1zLmg+CiAjaW5jbHVkZSA8c291bmQv
c29jLmg+CiAjaW5jbHVkZSA8c291bmQvc29jLWRhcG0uaD4KKyNpbmNsdWRlIDxhc20vbWFjaC10
eXBlcy5oPgogCiAjaW5jbHVkZSA8bWFjaC9hdWRtdXguaD4KIApAQCAtMjY5LDYgKzI3MCwxMCBA
QCBzdGF0aWMgaW50IF9faW5pdCB3bTExMzNfZXYxX2F1ZGlvX2luaXQodm9pZCkKIAlpbnQgcmV0
OwogCXVuc2lnbmVkIGludCBwdGNyLCBwZGNyOwogCisJaWYgKCFtYWNoaW5lX2lzX214MzFhZHMo
KSkKKwkJLyogcmV0dXJuIGhhcHB5LiBXZSBtaWdodCBydW4gb24gYSB0b3RhbGx5IGRpZmZlcmVu
dCBtYWNoaW5lICovCisJCXJldHVybiAwOworCiAJLyogU1NJMCBtYXN0ZXJlZCBieSBwb3J0IDUg
Ki8KIAlwdGNyID0gTVhDX0FVRE1VWF9WMl9QVENSX1NZTiB8CiAJCU1YQ19BVURNVVhfVjJfUFRD
Ul9URlNESVIgfAotLSAKMS43LjAuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
