From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2] ASoC: Intel: Atom: fix regression on
	compress DAI
Date: Tue,  2 Feb 2016 12:49:49 -0600
Message-ID: <1454438989-15003-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 390F5265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 19:49:54 +0100 (CET)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Q29tbWl0IGExMDY4MDQgKCJBU29DOiBjb21wcmVzczogRml4IGNvbXByZXNzIGRldmljZSBkaXJl
Y3Rpb24gY2hlY2siKQphZGRlZCBhIGRlcGVuZGVuY3kgb24gdGhlIGNvbXByZXNzLWNwdS1kYWkg
Y2hhbm5lbF9taW4gZmllbGQKd2hpY2ggd2FzIHJlbW92ZWQgZWFybGllciBieSBjb21taXQgNzcw
OTU3OTYKKCJBU29DOiBJbnRlbDogQXRvbTogY2xlYW4tdXAgY29tcHJlc3NlZCBEQUkgZGVmaW5p
dGlvbiIpCmFzIHBhcnQgb2YgdGhlIGJheXRyYWlsIGNsZWFudXBzLgoKVGhlIG5ldCByZXN1bHQg
d2FzIGEgcmVncmVzc2lvbiBhdCBwcm9iZSBvbiBhbGwgQXRvbSBwbGF0Zm9ybXMKd2l0aCBubyBz
b3VuZCBjYXJkIGNyZWF0ZWQuCgpGaXggYnkgYWRkaW5nIGV4cGxpY2l0IGluaXRpYWxpemF0aW9u
IGZvciBjaGFubmVsX21pbiB0byAxCmZvciB0aGUgY29tcHJlc3MtY3B1LWRhaS4KClJlcG9ydGVk
LWJ5OiBUb2JpYXMgTcOkZGVsIDxhbHNhLWRldmVsQHRic3BhY2UuZGU+ClNpZ25lZC1vZmYtYnk6
IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5j
b20+Ci0tLQpUaGlzIHNob3VsZCBiZSBhcHBsaWVkIGJlZm9yZSA0LjUgaXMgcmVsZWFzZWQKCiBz
b3VuZC9zb2MvaW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1wY20uYyB8IDEgKwogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ludGVsL2F0
b20vc3N0LW1mbGQtcGxhdGZvcm0tcGNtLmMgYi9zb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3QtbWZs
ZC1wbGF0Zm9ybS1wY20uYwppbmRleCA1NWMzM2RjLi41MmVkNDM0IDEwMDY0NAotLS0gYS9zb3Vu
ZC9zb2MvaW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1wY20uYworKysgYi9zb3VuZC9zb2Mv
aW50ZWwvYXRvbS9zc3QtbWZsZC1wbGF0Zm9ybS1wY20uYwpAQCAtNTI4LDYgKzUyOCw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyIHNzdF9wbGF0Zm9ybV9kYWlbXSA9IHsKIAku
b3BzID0gJnNzdF9jb21wcl9kYWlfb3BzLAogCS5wbGF5YmFjayA9IHsKIAkJLnN0cmVhbV9uYW1l
ID0gIkNvbXByZXNzIFBsYXliYWNrIiwKKwkJLmNoYW5uZWxzX21pbiA9IDEsCiAJfSwKIH0sCiAv
KiBCRSBDUFUgIERhaXMgKi8KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
