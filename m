From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/14] ASoC: topology: remove unused 'err'
Date: Thu,  8 Dec 2016 23:01:27 +0530
Message-ID: <1481218297-17568-5-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 30DCD2674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:23 +0100 (CET)
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

SW4gc29jX3RwbGdfcGNtX2VsZW1zX2xvYWQsIGEgdmFyaWFibGUgJ2VycicgaXMgaW5pdGlhbGl6
ZWQgYnV0IG5vdAp1c2VkLgoKSXQgaXMgYXNzaWduZWQgcmV0dXJuIHZhbHVlcyBmb3IgcGNtX25l
d192ZXIoKSBidXQgbmV2ZXIgY2hlY2tlZCwgc28KcmVtb3ZlIGl0LgoKc291bmQvc29jL3NvYy10
b3BvbG9neS5jOiBJbiBmdW5jdGlvbiDigJhzb2NfdHBsZ19wY21fZWxlbXNfbG9hZOKAmToKc291
bmQvc29jL3NvYy10b3BvbG9neS5jOjE4NjU6OTogd2FybmluZzogdmFyaWFibGUg4oCYZXJy4oCZ
IHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAgaW50IGksIGVy
cjsKClNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwgPHZpbm9kLmtvdWxAaW50ZWwuY29tPgotLS0K
IHNvdW5kL3NvYy9zb2MtdG9wb2xvZ3kuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29jLXRv
cG9sb2d5LmMgYi9zb3VuZC9zb2Mvc29jLXRvcG9sb2d5LmMKaW5kZXggMTFmZWIxOWU5NzMwLi44
OTBjZjg0NTE1YTkgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9zb2MtdG9wb2xvZ3kuYworKysgYi9z
b3VuZC9zb2Mvc29jLXRvcG9sb2d5LmMKQEAgLTE4NjIsNyArMTg2Miw3IEBAIHN0YXRpYyBpbnQg
c29jX3RwbGdfcGNtX2VsZW1zX2xvYWQoc3RydWN0IHNvY190cGxnICp0cGxnLAogewogCXN0cnVj
dCBzbmRfc29jX3RwbGdfcGNtICpwY20sICpfcGNtOwogCWludCBjb3VudCA9IGhkci0+Y291bnQ7
Ci0JaW50IGksIGVycjsKKwlpbnQgaTsKIAlib29sIGFiaV9tYXRjaDsKIAogCWlmICh0cGxnLT5w
YXNzICE9IFNPQ19UUExHX1BBU1NfUENNX0RBSSkKQEAgLTE4OTYsNyArMTg5Niw3IEBAIHN0YXRp
YyBpbnQgc29jX3RwbGdfcGNtX2VsZW1zX2xvYWQoc3RydWN0IHNvY190cGxnICp0cGxnLAogCQkJ
X3BjbSA9IHBjbTsKIAkJfSBlbHNlIHsKIAkJCWFiaV9tYXRjaCA9IGZhbHNlOwotCQkJZXJyID0g
cGNtX25ld192ZXIodHBsZywgcGNtLCAmX3BjbSk7CisJCQlwY21fbmV3X3Zlcih0cGxnLCBwY20s
ICZfcGNtKTsKIAkJfQogCiAJCS8qIGNyZWF0ZSB0aGUgRkUgREFJcyBhbmQgREFJIGxpbmtzICov
Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
