From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 7/9] alsactl: handle disconnection
	of sound card
Date: Sun, 14 Oct 2018 23:36:32 +0900
Message-ID: <20181014143634.26066-8-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 845C5267985
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:56 +0200 (CEST)
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so7928764pgq.9
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:56 -0700 (PDT)
In-Reply-To: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T25jZSBzb3VuZCBjYXJkIGJlY29tZXMgZGlzY29ubmVjdGlvbiBzdGF0ZSwgY29ycmVzcG9uZGlu
ZyBjb250cm9sIG5vZGUKYmVjb21lcyB0byBlbWl0IGVycm9yIGV2ZW50IGZvciBsaXN0ZW5lcnMu
IFdoZW4gY2F0Y2hpbmcgdGhpcyB0eXBlIG9mCmV2ZW50LCBldmVudCBkaXNwYXRjaGVyIHNob3Vs
ZCBzdG9wIG9ic2VydmF0aW9uIG9mIHRoZSBub2RlLiBIb3dldmVyLAphdCBwcmVzZW50LCBhIG1v
ZGUgb2YgbW9uaXRvciBjYW4ndCBoYW5kbGUgdGhpcyBjb3JyZWN0bHkuIEFzIGEgcmVzdWx0LApw
b2xsKDIpIGlzIGV4ZWN1dGVkIHF1aXRlIGZyZXF1ZW50bHkgaW4gbG9vcCB3aXRoIG5vIHdhaXQu
IFRoaXMgcmVzdWx0cwoxMDAlIGNvbnN1bXB0aW9uIG9mIENQVSB0aW1lLgoKVGhpcyBjb21taXQg
dGFrZXMgdGhlIGRpc3BhdGNoZXIgdG8gcmVtb3ZlIHRoZSBub2RlIGZyb20gb2JzZXJ2YXRpb24K
bGlzdCB3aGVuIGRldGVjdGluZyB0aGUgZGlzY29ubmVjdGlvbiBzdGF0ZS4KClJlcG9ydGVkLWJ5
OiBUaG9tYXMgR2zDpMOfbGUgPHRob21hc0Bjb2xkZml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBUYWth
c2hpIFNha2Ftb3RvIDxvLXRha2FzaGlAc2FrYW1vY2NoaS5qcD4KLS0tCiBhbHNhY3RsL21vbml0
b3IuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2Fsc2FjdGwvbW9uaXRvci5jIGIvYWxzYWN0bC9tb25pdG9yLmMKaW5kZXggMDllZjYzYy4u
NTU5ZmI0YyAxMDA2NDQKLS0tIGEvYWxzYWN0bC9tb25pdG9yLmMKKysrIGIvYWxzYWN0bC9tb25p
dG9yLmMKQEAgLTI4NSw2ICsyODUsMTAgQEAgc3RhdGljIGludCBydW5fZGlzcGF0Y2hlcihpbnQg
ZXBmZCwgc3RydWN0IGxpc3RfaGVhZCAqc3JjcykKIAkJCXN0cnVjdCBzcmNfZW50cnkgKmVudHJ5
ID0gKHN0cnVjdCBzcmNfZW50cnkgKilldi0+ZGF0YS5wdHI7CiAJCQlpZiAoZXYtPmV2ZW50cyAm
IEVQT0xMSU4pCiAJCQkJcHJpbnRfZXZlbnQoZW50cnktPmhhbmRsZSwgZW50cnktPm5hbWUpOwor
CQkJaWYgKGV2LT5ldmVudHMgJiBFUE9MTEVSUikgeworCQkJCW9wZXJhdGVfZGlzcGF0Y2hlcihl
cGZkLCBFUE9MTF9DVExfREVMLCBOVUxMLCBlbnRyeSk7CisJCQkJcmVtb3ZlX3NvdXJjZV9lbnRy
eShlbnRyeSk7CisJCQl9CiAJCX0KIAl9CiAKLS0gCjIuMTkuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
