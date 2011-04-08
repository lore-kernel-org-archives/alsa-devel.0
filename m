From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [RESEND for-2.6.40 PATCH] sst: fix compile error
Date: Fri, 08 Apr 2011 08:41:38 +0800
Message-ID: <20110408004138.8688.20592.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 6733924359
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 02:41:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

QWRkIHNldmVyYWwgaW5jbHVkZSBmaWxlcyB0byBmaXggdGhlIGJlbG93IGNvbXBpbGUgZXJyb3Iu
Cgpkcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVsbWlkLmM6IEluIGZ1bmN0aW9uIOKAmHNu
ZF9pbnRlbG1hZF9zc3RfcmVnaXN0ZXLigJk6CmRyaXZlcnMvc3RhZ2luZy9pbnRlbF9zc3QvaW50
ZWxtaWQuYzo4MDU6MjogZXJyb3I6IOKAmHNzdF9kcnZfY3R44oCZIHVuZGVjbGFyZWQgKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQpkcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVsbWlk
LmM6ODA1OjI6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9u
bHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCgpTaWduZWQtb2ZmLWJ5OiBM
dSBHdWFucXVuIDxndWFucXVuLmx1QGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3N0YWdpbmcvaW50
ZWxfc3N0L2ludGVsbWlkLmMgfCAgICAzICsrKwogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2ludGVs
X3NzdC9pbnRlbG1pZC5jIGIvZHJpdmVycy9zdGFnaW5nL2ludGVsX3NzdC9pbnRlbG1pZC5jCmlu
ZGV4IDFmYjM5ZDQuLjRlNGU0YTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9pbnRlbF9z
c3QvaW50ZWxtaWQuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVsbWlkLmMK
QEAgLTMyLDYgKzMyLDcgQEAKICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KICNp
bmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+CiAjaW5jbHVkZSA8c291bmQvY29udHJvbC5oPgogI2lu
Y2x1ZGUgPGFzbS9tcnN0Lmg+CiAjaW5jbHVkZSA8c291bmQvcGNtLmg+CkBAIC00MCw2ICs0MSw4
IEBACiAjaW5jbHVkZSA8c291bmQvaW5pdHZhbC5oPgogI2luY2x1ZGUgImludGVsX3NzdC5oIgog
I2luY2x1ZGUgImludGVsX3NzdF9pb2N0bC5oIgorI2luY2x1ZGUgImludGVsX3NzdF9md19pcGMu
aCIKKyNpbmNsdWRlICJpbnRlbF9zc3RfY29tbW9uLmgiCiAjaW5jbHVkZSAiaW50ZWxtaWRfc25k
X2NvbnRyb2wuaCIKICNpbmNsdWRlICJpbnRlbG1pZC5oIgogCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
