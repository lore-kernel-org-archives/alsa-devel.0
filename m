From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/5] cplay: remove dead code
	check_codec_format_supported()
Date: Thu, 19 Apr 2018 12:06:18 +0530
Message-ID: <1524119780-21206-3-git-send-email-vinod.koul@intel.com>
References: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B2326732A
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 08:31:54 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

VGhlIGNoZWNrX2NvZGVjX2Zvcm1hdF9zdXBwb3J0ZWQoKSB3YXMgYWRkZWQgYnV0IG5ldmVyIHVz
ZWQgc28gcmVtb3ZlCml0IGFuZCBlbGltaW5hdGUgdW51c2VkIGZ1bmN0aW9uIHdhcm5pbmcKCmNw
bGF5LmM6MTAzOjIwOiB3YXJuaW5nOiDigJhjb2RlY19uYW1lX2Zyb21faWTigJkgZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQoKV2UgY2FuIHRha2UgZnJvbSBnaXQgaWYg
dXNlciBhcHBlYXJzCgpTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5rb3VsQGludGVs
LmNvbT4KLS0tCkNDOiBLYXRzdWhpcm8gU3V6dWtpIDxzdXp1a2kua2F0c3VoaXJvQHNvY2lvbmV4
dC5jb20+Cgogc3JjL3V0aWxzL2NwbGF5LmMgfCA5IC0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3V0aWxzL2NwbGF5LmMgYi9zcmMvdXRp
bHMvY3BsYXkuYwppbmRleCBiMDI2NDRhM2YyZWEuLmQyYzYwZjk3NmM2YyAxMDA2NDQKLS0tIGEv
c3JjL3V0aWxzL2NwbGF5LmMKKysrIGIvc3JjL3V0aWxzL2NwbGF5LmMKQEAgLTE2NSwxNSArMTY1
LDYgQEAgc3RhdGljIGludCBwYXJzZV9tcDNfaGVhZGVyKHN0cnVjdCBtcDNfaGVhZGVyICpoZWFk
ZXIsIHVuc2lnbmVkIGludCAqbnVtX2NoYW5uZWwKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGlu
dCBjaGVja19jb2RlY19mb3JtYXRfc3VwcG9ydGVkKHVuc2lnbmVkIGludCBjYXJkLCB1bnNpZ25l
ZCBpbnQgZGV2aWNlLCBzdHJ1Y3Qgc25kX2NvZGVjICpjb2RlYykKLXsKLQlpZiAoaXNfY29kZWNf
c3VwcG9ydGVkKGNhcmQsIGRldmljZSwgQ09NUFJFU1NfSU4sIGNvZGVjKSA9PSBmYWxzZSkgewot
CQlmcHJpbnRmKHN0ZGVyciwgIkVycm9yOiBUaGlzIGNvZGVjIG9yIGZvcm1hdCBpcyBub3Qgc3Vw
cG9ydGVkIGJ5IERTUFxuIik7Ci0JCXJldHVybiAtMTsKLQl9Ci0JcmV0dXJuIDA7Ci19Ci0KIHN0
YXRpYyBpbnQgcHJpbnRfdGltZShzdHJ1Y3QgY29tcHJlc3MgKmNvbXByZXNzKQogewogCXVuc2ln
bmVkIGludCBhdmFpbDsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
