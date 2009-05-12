From: =?UTF-8?B?UmFwaGHDq2wgRG91cnNlbmF1ZA==?= <rdoursenaud@free.fr>
Subject: [PATCH 1/1] hdsp: allow firmware loading from inside
	the kernel
Date: Tue, 12 May 2009 08:16:08 +0200
Message-ID: <4A091428.2000106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.infomaniak.ch (smtp2.infomaniak.ch [84.16.68.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E1671037F7
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 08:16:12 +0200 (CEST)
Received: from [192.168.1.20] (149.141.207-77.rev.gaoland.net [77.207.141.149]
	(may be forged)) (authenticated bits=0)
	by smtp2.infomaniak.ch (8.14.2/8.14.2) with ESMTP id n4C6G90g019716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 08:16:12 +0200
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
List-Id: alsa-devel@alsa-project.org

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEExCgpGcm9tOiBSYXBo
YcOrbCBEb3Vyc2VuYXVkIDxyZG91cnNlbmF1ZEBmcmVlLmZyPgoKQWxsb3cgdGhlIHVzZSBvZiAg
dGhlIEZJUk1XQVJFX0lOX0tFUk5FTCBvcHRpb24gd2l0aCBoZHNwIGNhcmRzIGFuZAppbi1rZXJu
ZWwgZHJpdmVyLgpBbHNvIGNvcnJlY3RlZCBhIHR5cG8gaW4gdGhlIGNvbW1lbnQuCgpTaWduZWQt
b2ZmLWJ5OiBSYXBoYWVsIERvdXJzZW5hdWQgPHJkb3Vyc2VuYXVkQGZyZWUuZnI+Ci0gLS0tCiBz
b3VuZC9wY2kvcm1lOTY1Mi9oZHNwLmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9ybWU5
NjUyL2hkc3AuYyBiL3NvdW5kL3BjaS9ybWU5NjUyL2hkc3AuYwppbmRleCAzMTRlNzM1Li5kMGQ0
NjI5IDEwMDY0NAotIC0tLSBhL3NvdW5kL3BjaS9ybWU5NjUyL2hkc3AuYworKysgYi9zb3VuZC9w
Y2kvcm1lOTY1Mi9oZHNwLmMKQEAgLTQwMiw5ICs0MDIsOSBAQCBNT0RVTEVfRklSTVdBUkUoImRp
Z2lmYWNlX2Zpcm13YXJlX3JldjExLmJpbiIpOwogI2RlZmluZSBIRFNQX0RNQV9BUkVBX0JZVEVT
ICgoSERTUF9NQVhfQ0hBTk5FTFMrMSkgKgpIRFNQX0NIQU5ORUxfQlVGRkVSX0JZVEVTKQogI2Rl
ZmluZSBIRFNQX0RNQV9BUkVBX0tJTE9CWVRFUyAoSERTUF9ETUFfQVJFQV9CWVRFUy8xMDI0KQoK
LSAtLyogdXNlIGhvdHBsdWcgZmlybWVhcmUgbG9hZGVyPyAqLworLyogdXNlIGhvdHBsdWcgZmly
bXdhcmUgbG9hZGVyPyAqLwogI2lmIGRlZmluZWQoQ09ORklHX0ZXX0xPQURFUikgfHwgZGVmaW5l
ZChDT05GSUdfRldfTE9BREVSX01PRFVMRSkKLSAtI2lmICFkZWZpbmVkKEhEU1BfVVNFX0hXREVQ
X0xPQURFUikgJiYgIWRlZmluZWQoQ09ORklHX1NORF9IRFNQKQorI2lmICFkZWZpbmVkKEhEU1Bf
VVNFX0hXREVQX0xPQURFUikKICNkZWZpbmUgSERTUF9GV19MT0FERVIKICNlbmRpZgogI2VuZGlm
CgotIC0tClJhcGhhw6tsIERvdXJzZW5hdWQKCi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0t
ClZlcnNpb246IEdudVBHIHYxLjQuOSAoR05VL0xpbnV4KQpDb21tZW50OiBVc2luZyBHbnVQRyB3
aXRoIE1vemlsbGEgLSBodHRwOi8vZW5pZ21haWwubW96ZGV2Lm9yZwoKaUVZRUFSRUNBQVlGQWtv
SkZDUUFDZ2tRYVpLbU5BZFhhVlZsaUFDYUE1Qk1rbk1BWGdPRU4vN1lRbVdHUHdVaAp1UmdBbjBC
aUl3QXRHVS9BT2krUVJuODFrOGFwdkhmaQo9KzRLdwotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0t
LS0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
