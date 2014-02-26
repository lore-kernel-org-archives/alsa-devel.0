From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Baytrail: Fix implicit
	declaration of function 'memcpy_fromio'
Date: Wed, 26 Feb 2014 15:12:21 +0200
Message-ID: <1393420341-31625-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E1F022655A0
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 14:12:29 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, kbuild test robot <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

U29tZSBrZXJuZWwgY29uZmlndXJhdGlvbnMgY2FuIGNhdXNlIGZvbGxvd2luZyBidWlsZCBlcnJv
cjoKCnNvdW5kL3NvYy9pbnRlbC9zc3QtYmF5dHJhaWwtaXBjLmM6IEluIGZ1bmN0aW9uIOKAmHNz
dF9ieXRfZ2V0X2RzcF9wb3NpdGlvbuKAmToKc291bmQvc29jL2ludGVsL3NzdC1iYXl0cmFpbC1p
cGMuYzo3NDQ6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmG1l
bWNweV9mcm9taW/igJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAg
bWVtY3B5X2Zyb21pbygmZndfdHN0YW1wLAogIF4KY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzCgpGaXggdGhpcyBieSBpbmNsdWRpbmcgPGFzbS9pby5oPiBleHBsaWNp
dGx5LgoKUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxmZW5nZ3Vhbmcud3VAaW50ZWwu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBKYXJra28gTmlrdWxhIDxqYXJra28ubmlrdWxhQGxpbnV4Lmlu
dGVsLmNvbT4KLS0tCkFsc28gc3N0LWRzcC4sIHNzdC1iYXl0cmFpbC1kc3AuYyBhbmQgc3N0LWhh
c3dlbGwtZHNwLmMgYXJlIHVzaW5nCm1lbWNweV9mcm9taW8vX3RvaW8gYnV0IHRoZXJlIDxhc20v
aW8uaD4gc2VlbXMgdG8gY29tZSB2aWEKPGxpbnV4L2RtYS1tYXBwaW5nLmg+IG9yIDxsaW51eC9p
by5oPiBzbyBJIGRpZG4ndCB0b3VjaCB0aGVtLgotLS0KIHNvdW5kL3NvYy9pbnRlbC9zc3QtYmF5
dHJhaWwtaXBjLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9pbnRlbC9zc3QtYmF5dHJhaWwtaXBjLmMgYi9zb3VuZC9zb2MvaW50
ZWwvc3N0LWJheXRyYWlsLWlwYy5jCmluZGV4IDhjOTFhNjhiOTBiYy4uOGIwNjdlMzQwOTRlIDEw
MDY0NAotLS0gYS9zb3VuZC9zb2MvaW50ZWwvc3N0LWJheXRyYWlsLWlwYy5jCisrKyBiL3NvdW5k
L3NvYy9pbnRlbC9zc3QtYmF5dHJhaWwtaXBjLmMKQEAgLTI3LDYgKzI3LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9rdGhyZWFkLmg+CiAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUuaD4KICNpbmNsdWRl
IDxhc20vZGl2NjQuaD4KKyNpbmNsdWRlIDxhc20vaW8uaD4KIAogI2luY2x1ZGUgInNzdC1iYXl0
cmFpbC1pcGMuaCIKICNpbmNsdWRlICJzc3QtZHNwLmgiCi0tIAoxLjguNS4zCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
