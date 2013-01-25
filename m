From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: dwc: fix support for more than two
	channels
Date: Fri, 25 Jan 2013 09:43:43 +0300
Message-ID: <20130125064343.GE4882@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 37DCB261717
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 07:43:55 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

VGhlcmUgd2VyZSBtaXNzaW5nIGJyZWFrIHN0YXRlbWVudHMgc28gZXZlcnl0aGluZyB1c2VkClRX
T19DSEFOTkVMX1NVUFBPUlQuCgpBbHNvIEkgYWRkZWQgYSByZXR1cm4gc3RhdGVtZW50IHRvIHNp
bGVuY2UgYSBHQ0Mgd2FybmluZzoKCglzb3VuZC9zb2MvZHdjL2Rlc2lnbndhcmVfaTJzLmM6IElu
IGZ1bmN0aW9uIOKAmGR3X2kyc19od19wYXJhbXPigJk6Cglzb3VuZC9zb2MvZHdjL2Rlc2lnbndh
cmVfaTJzLmM6MjM2OjMyOiB3YXJuaW5nOiDigJhjaF9yZWfigJkgbWF5IGJlCgkJdXNlZCB1bmlu
aXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24KCQlbLVdtYXliZS11bmluaXRpYWxpemVkXQoKU2ln
bmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgotLS0K
U3RhdGljIGFuYWx5c2lzLiAgVW50ZXN0ZWQuCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2R3Yy9k
ZXNpZ253YXJlX2kycy5jIGIvc291bmQvc29jL2R3Yy9kZXNpZ253YXJlX2kycy5jCmluZGV4IDFh
YTUxMzAuLmRlYjMwZDUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9kd2MvZGVzaWdud2FyZV9pMnMu
YworKysgYi9zb3VuZC9zb2MvZHdjL2Rlc2lnbndhcmVfaTJzLmMKQEAgLTIxMCwxNSArMjEwLDE5
IEBAIHN0YXRpYyBpbnQgZHdfaTJzX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0g
KnN1YnN0cmVhbSwKIAlzd2l0Y2ggKGNvbmZpZy0+Y2hhbl9ucikgewogCWNhc2UgRUlHSFRfQ0hB
Tk5FTF9TVVBQT1JUOgogCQljaF9yZWcgPSAzOworCQlicmVhazsKIAljYXNlIFNJWF9DSEFOTkVM
X1NVUFBPUlQ6CiAJCWNoX3JlZyA9IDI7CisJCWJyZWFrOwogCWNhc2UgRk9VUl9DSEFOTkVMX1NV
UFBPUlQ6CiAJCWNoX3JlZyA9IDE7CisJCWJyZWFrOwogCWNhc2UgVFdPX0NIQU5ORUxfU1VQUE9S
VDoKIAkJY2hfcmVnID0gMDsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJZGV2X2VycihkZXYtPmRl
diwgImNoYW5uZWwgbm90IHN1cHBvcnRlZFxuIik7CisJCXJldHVybiAtRUlOVkFMOwogCX0KIAog
CWkyc19kaXNhYmxlX2NoYW5uZWxzKGRldiwgc3Vic3RyZWFtLT5zdHJlYW0pOwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
