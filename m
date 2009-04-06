From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [PATCH] ASoC: correct s6000 I2S clock polarity
Date: Mon,  6 Apr 2009 11:50:22 +0200
Message-ID: <1239011422-23249-1-git-send-email-dg@emlix.com>
References: <49D9D001.7070901@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 36D1D243CE
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 11:50:23 +0200 (CEST)
In-Reply-To: <49D9D001.7070901@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

QWNjb3JkaW5nIHRvIHRoZSBkYXRhIHNoZWV0IGRhdGEgaXMgY2xvY2tlZCBvdXQgb24gdGhlIGZh
bGxpbmcgZWRnZQphbmQgbGF0Y2hlZCBvbiB0aGUgcmlzaW5nIGVkZ2Ugb2YgdGhlIGJpdCBjbG9j
ay4gV2hpbGUgdGhlIGxlZnQgc2FtcGxlCmlzIHRyYW5zbWl0dGVkIHRoZSB3b3JkIGNsb2NrIGxp
bmUgaXMgbG93LgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdsw7Zja25lciA8ZGdAZW1saXguY29t
PgotLS0KIHNvdW5kL3NvYy9zNjAwMC9zNjAwMC1pMnMuYyAgIHwgICAgNCArKy0tCiBzb3VuZC9z
b2MvczYwMDAvczYxMDUtaXBjYW0uYyB8ICAgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zNjAwMC9z
NjAwMC1pMnMuYyBiL3NvdW5kL3NvYy9zNjAwMC9zNjAwMC1pMnMuYwppbmRleCBkY2M3OTA0Li5j
NWNkYTE4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvczYwMDAvczYwMDAtaTJzLmMKKysrIGIvc291
bmQvc29jL3M2MDAwL3M2MDAwLWkycy5jCkBAIC0yNTIsMTAgKzI1MiwxMCBAQCBzdGF0aWMgaW50
IHM2MDAwX2kyc19zZXRfZGFpX2ZtdChzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWksCiAJfQog
CiAJc3dpdGNoIChmbXQgJiBTTkRfU09DX0RBSUZNVF9JTlZfTUFTSykgewotCWNhc2UgU05EX1NP
Q19EQUlGTVRfSUJfSUY6CisJY2FzZSBTTkRfU09DX0RBSUZNVF9OQl9ORjoKIAkJdyB8PSBTNl9J
MlNfTEVGVF9GSVJTVDsKIAkJYnJlYWs7Ci0JY2FzZSBTTkRfU09DX0RBSUZNVF9JQl9ORjoKKwlj
YXNlIFNORF9TT0NfREFJRk1UX05CX0lGOgogCQl3IHw9IFM2X0kyU19SSUdIVF9GSVJTVDsKIAkJ
YnJlYWs7CiAJZGVmYXVsdDoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zNjAwMC9zNjEwNS1pcGNh
bS5jIGIvc291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKaW5kZXggMjFjNGY1NS4uYjVmOTVm
OSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKKysrIGIvc291bmQv
c29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKQEAgLTQzLDcgKzQzLDcgQEAgc3RhdGljIGludCBzNjEw
NV9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAKIAkvKiBz
ZXQgY3B1IERBSSBjb25maWd1cmF0aW9uICovCiAJcmV0ID0gc25kX3NvY19kYWlfc2V0X2ZtdChj
cHVfZGFpLCBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNIHwKLQkJCQkJICAgU05EX1NPQ19EQUlGTVRf
SUJfSUYpOworCQkJCQkgICBTTkRfU09DX0RBSUZNVF9OQl9ORik7CiAJaWYgKHJldCA8IDApCiAJ
CXJldHVybiByZXQ7CiAKLS0gCjEuNi4xLjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
