From: =?UTF-8?q?Juho=20H=C3=A4m=C3=A4l=C3=A4inen?= <juho.hamalainen@tieto.com>
Subject: [PATCH] ucm: Fix segfault when device argument is
	missing from _sw{dev, mod}
Date: Fri, 24 May 2013 11:12:57 +0300
Message-ID: <1369383177-19489-1-git-send-email-juho.hamalainen@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ebb06.tieto.com (ebb06.tieto.com [131.207.168.38])
 by alsa0.perex.cz (Postfix) with ESMTP id C1F39261A48
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 10:13:02 +0200 (CEST)
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
Y29tPgotLS0KIHNyYy91Y20vbWFpbi5jIHwgICAgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc3JjL3VjbS9tYWluLmMgYi9zcmMvdWNtL21haW4u
YwppbmRleCBkMzhiN2ZhLi43NGUxNTMwIDEwMDY0NAotLS0gYS9zcmMvdWNtL21haW4uYworKysg
Yi9zcmMvdWNtL21haW4uYwpAQCAtMTY0OSw2ICsxNjQ5LDEwIEBAIGludCBzbmRfdXNlX2Nhc2Vf
c2V0KHNuZF91c2VfY2FzZV9tZ3JfdCAqdWNfbWdyLAogICAgICAgICAgICAgICAgIH0gZWxzZSB7
CiAgICAgICAgICAgICAgICAgICAgICAgICBzdHIgPSBOVUxMOwogICAgICAgICAgICAgICAgIH0K
KyAgICAgICAgICAgICAgICBpZiAoIXN0cikgeworICAgICAgICAgICAgICAgICAgICBlcnIgPSAt
RUlOVkFMOworICAgICAgICAgICAgICAgICAgICBnb3RvIF9fZW5kOworICAgICAgICAgICAgICAg
IH0KICAgICAgICAgICAgICAgICBpZiAoY2hlY2tfaWRlbnRpZmllcihpZGVudGlmaWVyLCAiX3N3
ZGV2IikpCiAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBzd2l0Y2hfZGV2aWNlKHVjX21n
ciwgc3RyLCB2YWx1ZSk7CiAgICAgICAgICAgICAgICAgZWxzZSBpZiAoY2hlY2tfaWRlbnRpZmll
cihpZGVudGlmaWVyLCAiX3N3bW9kIikpCi0tIAoxLjcuMTAuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
