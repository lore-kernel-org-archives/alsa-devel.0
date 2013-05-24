From: =?UTF-8?q?Juho=20H=C3=A4m=C3=A4l=C3=A4inen?= <juho.hamalainen@tieto.com>
Subject: [PATCH] ucm: Fix segfault when device argument is
	missing from _sw{dev, mod}
Date: Fri, 24 May 2013 14:01:25 +0300
Message-ID: <1369393285-25963-1-git-send-email-juho.hamalainen@tieto.com>
References: <s5hobc0tzx2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ebb05.tieto.com (ebb05.tieto.com [131.207.168.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 109592650B9
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 13:01:38 +0200 (CEST)
In-Reply-To: <s5hobc0tzx2.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogSnVobyBIw6Rtw6Rsw6RpbmVuIDxqdWhvLmhhbWFsYWluZW5AdGlldG8u
Y29tPgotLS0KIHNyYy91Y20vbWFpbi5jIHwgICAgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvdWNtL21haW4uYyBi
L3NyYy91Y20vbWFpbi5jCmluZGV4IGQzOGI3ZmEuLjA0OTQ3MjggMTAwNjQ0Ci0tLSBhL3NyYy91
Y20vbWFpbi5jCisrKyBiL3NyYy91Y20vbWFpbi5jCkBAIC0xNjQ3LDcgKzE2NDcsOCBAQCBpbnQg
c25kX3VzZV9jYXNlX3NldChzbmRfdXNlX2Nhc2VfbWdyX3QgKnVjX21nciwKICAgICAgICAgICAg
ICAgICAJCWdvdG8gX19lbmQ7CiAgICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAg
ICAgICAgfSBlbHNlIHsKLSAgICAgICAgICAgICAgICAgICAgICAgIHN0ciA9IE5VTEw7CisgICAg
ICAgICAgICAgICAgICAgICAgICBlcnIgPSAtRUlOVkFMOworICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBfX2VuZDsKICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgaWYgKGNo
ZWNrX2lkZW50aWZpZXIoaWRlbnRpZmllciwgIl9zd2RldiIpKQogICAgICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gc3dpdGNoX2RldmljZSh1Y19tZ3IsIHN0ciwgdmFsdWUpOwotLSAKMS43LjEw
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
