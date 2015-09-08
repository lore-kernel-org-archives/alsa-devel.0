From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 5/5] topology: pcm: Remove unused variables
Date: Tue,  8 Sep 2015 22:21:41 +0200
Message-ID: <1441743701-28165-6-git-send-email-tiwai@suse.de>
References: <1441743701-28165-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D29B72650F7
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 22:21:44 +0200 (CEST)
In-Reply-To: <1441743701-28165-1-git-send-email-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Rml4IGdjYyB3YXJuaW5nczoKICBwY20uYzogSW4gZnVuY3Rpb24g4oCYdHBsZ19wYXJzZV9zdHJl
YW1fY2Zn4oCZOgogIHBjbS5jOjE2MDo2OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYcmV0
4oCZIFstV3VudXNlZC12YXJpYWJsZV0KICAgIGludCByZXQ7CiAgICAgICAgXgogIHBjbS5jOiBJ
biBmdW5jdGlvbiDigJhzcGxpdF9mb3JtYXTigJk6CiAgcGNtLmM6MjY3OjEzOiB3YXJuaW5nOiB1
bnVzZWQgdmFyaWFibGUg4oCYcmV04oCZIFstV3VudXNlZC12YXJpYWJsZV0KICAgIGludCBpID0g
MCwgcmV0OwogICAgICAgICAgICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRp
d2FpQHN1c2UuZGU+Ci0tLQogc3JjL3RvcG9sb2d5L3BjbS5jIHwgMyArLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvdG9w
b2xvZ3kvcGNtLmMgYi9zcmMvdG9wb2xvZ3kvcGNtLmMKaW5kZXggNmU0MmFhMThiOTliLi4xOGQ1
ZjBiMWIwNDAgMTAwNjQ0Ci0tLSBhL3NyYy90b3BvbG9neS9wY20uYworKysgYi9zcmMvdG9wb2xv
Z3kvcGNtLmMKQEAgLTE1Nyw3ICsxNTcsNiBAQCBzdGF0aWMgaW50IHRwbGdfcGFyc2Vfc3RyZWFt
X2NmZyhzbmRfdHBsZ190ICp0cGxnIEFUVFJJQlVURV9VTlVTRUQsCiAJc3RydWN0IHNuZF9zb2Nf
dHBsZ19zdHJlYW0gKnN0cmVhbTsKIAljb25zdCBjaGFyICppZCwgKnZhbDsKIAlzbmRfcGNtX2Zv
cm1hdF90IGZvcm1hdDsKLQlpbnQgcmV0OwogCiAJc25kX2NvbmZpZ19nZXRfaWQoY2ZnLCAmaWQp
OwogCkBAIC0yNjQsNyArMjYzLDcgQEAgc3RhdGljIGludCBzcGxpdF9mb3JtYXQoc3RydWN0IHNu
ZF9zb2NfdHBsZ19zdHJlYW1fY2FwcyAqY2FwcywgY2hhciAqc3RyKQogewogCWNoYXIgKnMgPSBO
VUxMOwogCXNuZF9wY21fZm9ybWF0X3QgZm9ybWF0OwotCWludCBpID0gMCwgcmV0OworCWludCBp
ID0gMDsKIAogCXMgPSBzdHJ0b2soc3RyLCAiLCIpOwogCXdoaWxlICgocyAhPSBOVUxMKSAmJiAo
aSA8IFNORF9TT0NfVFBMR19NQVhfRk9STUFUUykpIHsKLS0gCjIuNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
