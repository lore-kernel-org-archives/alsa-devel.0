From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add ASUS G751 quirk model entry
Date: Sun,  7 Oct 2018 09:53:41 +0200
Message-ID: <20181007075341.12412-2-tiwai@suse.de>
References: <20181007075341.12412-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8538F26778C
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2018 09:53:46 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D2492AC8D
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2018 07:53:45 +0000 (UTC)
In-Reply-To: <20181007075341.12412-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QWRkIGEgY29ycmVzcG9uZGluZyBtb2RlbCBsaXN0IGVudHJ5IGZvciBBU1VTIEc3NTEgc28gdGhh
dCB1c2VyIGNhbgp0ZXN0IHRoZSBxdWlyayBmb3IgYW5vdGhlciBjb21wYXRpYmxlIG1hY2hpbmVz
IG1vcmUgZWFzaWx5LgoKUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogSMOldmFyZCA8aG92YXJkc2xp
bGxAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+
Ci0tLQogRG9jdW1lbnRhdGlvbi9zb3VuZC9oZC1hdWRpby9tb2RlbHMucnN0IHwgMiArKwogc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgICAgICAgICAgIHwgMSArCiAyIGZpbGVzIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc291bmQvaGQt
YXVkaW8vbW9kZWxzLnJzdCBiL0RvY3VtZW50YXRpb24vc291bmQvaGQtYXVkaW8vbW9kZWxzLnJz
dAppbmRleCBlMDYyMzgxMzFmNzcuLjM2OGEwN2ExNjVmNSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRh
dGlvbi9zb3VuZC9oZC1hdWRpby9tb2RlbHMucnN0CisrKyBiL0RvY3VtZW50YXRpb24vc291bmQv
aGQtYXVkaW8vbW9kZWxzLnJzdApAQCAtMzA5LDYgKzMwOSw4IEBAIGFzdXMtbng1MAogICAgIEFT
VVMgTng1MCBmaXh1cHMKIGFzdXMtbng1MQogICAgIEFTVVMgTng1MSBmaXh1cHMKK2FzdXMtZzc1
MQorICAgIEFTVVMgRzc1MSBmaXh1cHMKIGFsYzg5MS1oZWFkc2V0CiAgICAgSGVhZHNldCBtb2Rl
IHN1cHBvcnQgb24gQUxDODkxCiBhbGM4OTEtaGVhZHNldC1tdWx0aQpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwppbmRleCAzODllOGU5OTY1ODkuLjNiZTdkNzY0OTUyNSAxMDA2NDQKLS0tIGEvc291bmQvcGNp
L2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
QEAgLTgxOTQsNiArODE5NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX21vZGVsX2ZpeHVw
IGFsYzY2Ml9maXh1cF9tb2RlbHNbXSA9IHsKIAl7LmlkID0gQUxDNjY4X0ZJWFVQX0RFTExfWFBT
MTMsIC5uYW1lID0gImRlbGwteHBzMTMifSwKIAl7LmlkID0gQUxDNjYyX0ZJWFVQX0FTVVNfTng1
MCwgLm5hbWUgPSAiYXN1cy1ueDUwIn0sCiAJey5pZCA9IEFMQzY2OF9GSVhVUF9BU1VTX054NTEs
IC5uYW1lID0gImFzdXMtbng1MSJ9LAorCXsuaWQgPSBBTEM2NjhfRklYVVBfQVNVU19HNzUxLCAu
bmFtZSA9ICJhc3VzLWc3NTEifSwKIAl7LmlkID0gQUxDODkxX0ZJWFVQX0hFQURTRVRfTU9ERSwg
Lm5hbWUgPSAiYWxjODkxLWhlYWRzZXQifSwKIAl7LmlkID0gQUxDODkxX0ZJWFVQX0RFTExfTUlD
X05PX1BSRVNFTkNFLCAubmFtZSA9ICJhbGM4OTEtaGVhZHNldC1tdWx0aSJ9LAogCXsuaWQgPSBB
TEM2NjJfRklYVVBfQUNFUl9WRVJJVE9OLCAubmFtZSA9ICJhY2VyLXZlcml0b24ifSwKLS0gCjIu
MTguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
