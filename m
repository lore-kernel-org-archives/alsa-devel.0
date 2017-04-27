From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Fix unused variable
	warning
Date: Thu, 27 Apr 2017 12:21:21 +0530
Message-ID: <1493275882-27708-2-git-send-email-vinod.koul@intel.com>
References: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B4C1E26719B
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 08:49:48 +0200 (CEST)
In-Reply-To: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

V2l0aCBjb21waWxlciBvcHRpb24gVz0xLCB3ZSBoYXZlIG9uZSBtb3JlIHdhcm5pbmcgaW4gdGhl
IGRyaXZlciBmb3IKJ3NldCBidXQgdW51c2VkIHZhcmlhYmxlJywgc28gcmVtb3ZlIHRoZSB1bnVz
ZWQgdmFyaWFibGUgdG8gZml4IGl0LgoKc291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXBjbS5j
OiBJbiBmdW5jdGlvbiDigJhza2xfcGxhdGZvcm1fb3BlbuKAmToKc291bmQvc29jL2ludGVsL3Nr
eWxha2Uvc2tsLXBjbS5jOjk1NDoyNjogd2FybmluZzogdmFyaWFibGUg4oCYcnVudGltZeKAmSBz
ZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogIHN0cnVjdCBzbmRf
cGNtX3J1bnRpbWUgKnJ1bnRpbWU7CgpTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5r
b3VsQGludGVsLmNvbT4KLS0tCiBzb3VuZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wtcGNtLmMgfCAy
IC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9z
b2MvaW50ZWwvc2t5bGFrZS9za2wtcGNtLmMgYi9zb3VuZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wt
cGNtLmMKaW5kZXggZDQzZDE5NzZkZDNiLi5lOTFiYmNmZmM4NTYgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3NvYy9pbnRlbC9za3lsYWtlL3NrbC1wY20uYworKysgYi9zb3VuZC9zb2MvaW50ZWwvc2t5bGFr
ZS9za2wtcGNtLmMKQEAgLTk1MSwxNCArOTUxLDEyIEBAIHN0YXRpYyBpbnQgc2tsX2xpbmtfaHdf
ZnJlZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIAogc3RhdGljIGludCBz
a2xfcGxhdGZvcm1fb3BlbihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKIHsK
LQlzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lOwogCXN0cnVjdCBzbmRfc29jX3BjbV9y
dW50aW1lICpydGQgPSBzdWJzdHJlYW0tPnByaXZhdGVfZGF0YTsKIAlzdHJ1Y3Qgc25kX3NvY19k
YWlfbGluayAqZGFpX2xpbmsgPSBydGQtPmRhaV9saW5rOwogCiAJZGV2X2RiZyhydGQtPmNwdV9k
YWktPmRldiwgIkluICVzOiVzXG4iLCBfX2Z1bmNfXywKIAkJCQkJZGFpX2xpbmstPmNwdV9kYWlf
bmFtZSk7CiAKLQlydW50aW1lID0gc3Vic3RyZWFtLT5ydW50aW1lOwogCXNuZF9zb2Nfc2V0X3J1
bnRpbWVfaHdwYXJhbXMoc3Vic3RyZWFtLCAmYXp4X3BjbV9odyk7CiAKIAlyZXR1cm4gMDsKLS0g
CjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
