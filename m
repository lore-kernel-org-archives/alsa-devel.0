From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 8/9] alsactl: handle
	disconnection of sound card
Date: Fri,  5 Oct 2018 23:47:28 +0900
Message-ID: <20181005144729.21388-9-o-takashi@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A2B4267956
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:53 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so5164987pfb.13
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:53 -0700 (PDT)
In-Reply-To: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, thomas@coldfix.de
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
dCBhL2Fsc2FjdGwvbW9uaXRvci5jIGIvYWxzYWN0bC9tb25pdG9yLmMKaW5kZXggODA3OTYzYy4u
NGViMWFkMSAxMDA2NDQKLS0tIGEvYWxzYWN0bC9tb25pdG9yLmMKKysrIGIvYWxzYWN0bC9tb25p
dG9yLmMKQEAgLTMxMiw2ICszMTIsMTAgQEAgc3RhdGljIGludCBydW5fZGlzcGF0Y2hlcihpbnQg
ZXBmZCwgc3RydWN0IHNyY19lbnRyeSAqc3JjcykKIAkJCXN0cnVjdCBzcmNfZW50cnkgKnNyYyA9
IChzdHJ1Y3Qgc3JjX2VudHJ5ICopZXYtPmRhdGEucHRyOwogCQkJaWYgKGV2LT5ldmVudHMgJiBF
UE9MTElOKQogCQkJCXByaW50X2V2ZW50KHNyYy0+aGFuZGxlLCBzcmMtPm5hbWUpOworCQkJaWYg
KGV2LT5ldmVudHMgJiBFUE9MTEVSUikgeworCQkJCW9wZXJhdGVfZGlzcGF0Y2hlcihlcGZkLCBF
UE9MTF9DVExfREVMLCBOVUxMLCBzcmMpOworCQkJCXJlbW92ZV9zb3VyY2VfZW50cnkoc3JjKTsK
KwkJCX0KIAkJfQogCX0KIAotLSAKMi4xOS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
