From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] sst: fix compile error
Date: Thu, 07 Apr 2011 10:18:13 +0800
Message-ID: <20110407021813.5372.82489.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 62DCC1039EB
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 04:17:47 +0200 (CEST)
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
ZWxtaWQuYzo2MTI6MjogZXJyb3I6IOKAmHNzdF9kcnZfY3R44oCZIHVuZGVjbGFyZWQgKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQpkcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVsbWlk
LmM6NjEyOjI6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9u
bHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCgpTaWduZWQtb2ZmLWJ5OiBM
dSBHdWFucXVuIDxndWFucXVuLmx1QGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3N0YWdpbmcvaW50
ZWxfc3N0L2ludGVsbWlkLmMgfCAgICAzICsrKwogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2ludGVs
X3NzdC9pbnRlbG1pZC5jIGIvZHJpdmVycy9zdGFnaW5nL2ludGVsX3NzdC9pbnRlbG1pZC5jCmlu
ZGV4IDMyZGVkMTQuLmJiZGEzMGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9pbnRlbF9z
c3QvaW50ZWxtaWQuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVsbWlkLmMK
QEAgLTM3LDggKzM3LDExIEBACiAjaW5jbHVkZSA8c291bmQvcGNtX3BhcmFtcy5oPgogI2luY2x1
ZGUgPHNvdW5kL2luaXR2YWwuaD4KICNpbmNsdWRlIDxsaW51eC9ncGlvLmg+CisjaW5jbHVkZSA8
bGludXgvZmlybXdhcmUuaD4KICNpbmNsdWRlICJpbnRlbF9zc3QuaCIKICNpbmNsdWRlICJpbnRl
bF9zc3RfaW9jdGwuaCIKKyNpbmNsdWRlICJpbnRlbF9zc3RfZndfaXBjLmgiCisjaW5jbHVkZSAi
aW50ZWxfc3N0X2NvbW1vbi5oIgogI2luY2x1ZGUgImludGVsbWlkX3NuZF9jb250cm9sLmgiCiAj
aW5jbHVkZSAiaW50ZWxtaWRfYWRjX2NvbnRyb2wuaCIKICNpbmNsdWRlICJpbnRlbG1pZC5oIgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
