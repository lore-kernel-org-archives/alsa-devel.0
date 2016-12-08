From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/14] ASoC: hdac_hdmi: remove unused 'dai_map'
Date: Thu,  8 Dec 2016 23:01:28 +0530
Message-ID: <1481218297-17568-6-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E082674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:27 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SW4gaGRhY19oZG1pX3BsYXliYWNrX2NsZWFudXAoKSwgYSB2YXJpYWJsZSAnZGFpX21hcCcgaXMg
aW5pdGlhbGl6ZWQgYnV0IG5vdAp1c2VkLiBBbHNvIHdoaWxlIHJlbW92aW5nIHRoaXMgdHdvIG1h
cmUgdmFyaWFibGVzICdlZGV2JyBhbmQgJ2hkbWknIGJlY29tZQp1bnVzZWQsIHNvIHJlbW92ZSBh
bGwgdGhlc2UgYXMgd2VsbC4KCnNvdW5kL3NvYy9jb2RlY3MvaGRhY19oZG1pLmM6IEluIGZ1bmN0
aW9uIOKAmGhkYWNfaGRtaV9wbGF5YmFja19jbGVhbnVw4oCZOgpzb3VuZC9zb2MvY29kZWNzL2hk
YWNfaGRtaS5jOjQ3MDozMjogd2FybmluZzogdmFyaWFibGUg4oCYZGFpX21hcOKAmSBzZXQgYnV0
IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogIHN0cnVjdCBoZGFjX2hkbWlf
ZGFpX3Bpbl9tYXAgKmRhaV9tYXA7CgpTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5r
b3VsQGludGVsLmNvbT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL2hkYWNfaGRtaS5jIHwgNSAtLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2NvZGVjcy9oZGFjX2hkbWkuYyBiL3NvdW5kL3NvYy9jb2RlY3MvaGRhY19oZG1pLmMKaW5kZXgg
YzYwMmM0OTYwOTI0Li43OTNiYzg1M2RkZWYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mv
aGRhY19oZG1pLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9oZGFjX2hkbWkuYwpAQCAtNDY0LDEy
ICs0NjQsNyBAQCBzdGF0aWMgaW50IGhkYWNfaGRtaV9zZXRfaHdfcGFyYW1zKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogc3RhdGljIGludCBoZGFjX2hkbWlfcGxheWJhY2tf
Y2xlYW51cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIAkJc3RydWN0IHNu
ZF9zb2NfZGFpICpkYWkpCiB7Ci0Jc3RydWN0IGhkYWNfZXh0X2RldmljZSAqZWRldiA9IHNuZF9z
b2NfZGFpX2dldF9kcnZkYXRhKGRhaSk7CiAJc3RydWN0IGhkYWNfZXh0X2RtYV9wYXJhbXMgKmRk
OwotCXN0cnVjdCBoZGFjX2hkbWlfcHJpdiAqaGRtaSA9IGVkZXYtPnByaXZhdGVfZGF0YTsKLQlz
dHJ1Y3QgaGRhY19oZG1pX2RhaV9waW5fbWFwICpkYWlfbWFwOwotCi0JZGFpX21hcCA9ICZoZG1p
LT5kYWlfbWFwW2RhaS0+aWRdOwogCiAJZGQgPSAoc3RydWN0IGhkYWNfZXh0X2RtYV9wYXJhbXMg
KilzbmRfc29jX2RhaV9nZXRfZG1hX2RhdGEoZGFpLCBzdWJzdHJlYW0pOwogCi0tIAoxLjkuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
