From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/5] cplay: fix incorrect print specifier
	warning
Date: Thu, 19 Apr 2018 12:06:19 +0530
Message-ID: <1524119780-21206-4-git-send-email-vinod.koul@intel.com>
References: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B253267265
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 08:31:55 +0200 (CEST)
In-Reply-To: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

V2UgZ2V0IGEgd2FybmluZyBpbiBjcGxheSBmb3IgaW5jb3JyZWN0IHByaW50IHNwZWNpZmllciwg
Zml4IGl0IGJ5IHVzaW5nCnJpZ2h0IG9uZSAlbGQgZm9yIGxvbmcgdW5zaWduZWQgaW50LgoKY3Bs
YXkuYzozMjc6MTk6IHdhcm5pbmc6IGZvcm1hdCDigJglZOKAmSBleHBlY3RzIGFyZ3VtZW50IG9m
IHR5cGUg4oCYaW504oCZLCBidXQgYXJndW1lbnQgMyBoYXMgdHlwZSDigJhsb25nIHVuc2lnbmVk
IGludOKAmSBbLVdmb3JtYXQ9XQogICBmcHJpbnRmKHN0ZGVyciwgImNvZGVjIElEICVkIGlzIG5v
dCBzdXBwb3J0ZWRcbiIsIGNvZGVjX2lkKTsKClNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwgPHZp
bm9kLmtvdWxAaW50ZWwuY29tPgotLS0KIHNyYy91dGlscy9jcGxheS5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L3V0aWxzL2NwbGF5LmMgYi9zcmMvdXRpbHMvY3BsYXkuYwppbmRleCBkMmM2MGY5NzZjNmMuLmVh
MzZiODc3MWNhZiAxMDA2NDQKLS0tIGEvc3JjL3V0aWxzL2NwbGF5LmMKKysrIGIvc3JjL3V0aWxz
L2NwbGF5LmMKQEAgLTMyNCw3ICszMjQsNyBAQCB2b2lkIHBsYXlfc2FtcGxlcyhjaGFyICpuYW1l
LCB1bnNpZ25lZCBpbnQgY2FyZCwgdW5zaWduZWQgaW50IGRldmljZSwKIAkJZ2V0X2NvZGVjX2ll
YyhmaWxlLCAmY29uZmlnLCAmY29kZWMpOwogCQlicmVhazsKIAlkZWZhdWx0OgotCQlmcHJpbnRm
KHN0ZGVyciwgImNvZGVjIElEICVkIGlzIG5vdCBzdXBwb3J0ZWRcbiIsIGNvZGVjX2lkKTsKKwkJ
ZnByaW50ZihzdGRlcnIsICJjb2RlYyBJRCAlbGQgaXMgbm90IHN1cHBvcnRlZFxuIiwgY29kZWNf
aWQpOwogCQlleGl0KEVYSVRfRkFJTFVSRSk7CiAJfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
