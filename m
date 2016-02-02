From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH 1/4] ASoC: adau17x1: Fix incorrect BCLK ratio
	definitions
Date: Tue,  2 Feb 2016 15:31:47 +0100
Message-ID: <1454423510-1330-2-git-send-email-andire@axis.com>
References: <1454423510-1330-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 4490A265196
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id E805A1811A
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id S0ROtCvaHGKL for <alsa-devel@alsa-project.org>;
 Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 528AF1807F
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 1FF4B161C
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 13E5514E9
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
In-Reply-To: <1454423510-1330-1-git-send-email-andire@axis.com>
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
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogQW5kcmVhcyBJcmVzdMOlbCA8YW5kaXJlQGF4aXMuY29tPgotLS0KIHNv
dW5kL3NvYy9jb2RlY3MvYWRhdTE3eDEuaCB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2Rl
Y3MvYWRhdTE3eDEuaCBiL3NvdW5kL3NvYy9jb2RlY3MvYWRhdTE3eDEuaAppbmRleCBlMTM1ODNl
Li41YWU4N2EwIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL2FkYXUxN3gxLmgKKysrIGIv
c291bmQvc29jL2NvZGVjcy9hZGF1MTd4MS5oCkBAIC0xMDMsOSArMTAzLDkgQEAgYm9vbCBhZGF1
MTd4MV9oYXNfZHNwKHN0cnVjdCBhZGF1ICphZGF1KTsKICNkZWZpbmUgQURBVTE3WDFfQ0xPQ0tf
Q09OVFJPTF9DT1JFQ0xLX1NSQ19QTEwJQklUKDMpCiAjZGVmaW5lIEFEQVUxN1gxX0NMT0NLX0NP
TlRST0xfU1lTQ0xLX0VOCUJJVCgwKQogCi0jZGVmaW5lIEFEQVUxN1gxX1NFUklBTF9QT1JUMV9C
Q0xLMzIJCSgweDAgPDwgNSkKLSNkZWZpbmUgQURBVTE3WDFfU0VSSUFMX1BPUlQxX0JDTEs0OAkJ
KDB4MSA8PCA1KQotI2RlZmluZSBBREFVMTdYMV9TRVJJQUxfUE9SVDFfQkNMSzY0CQkoMHgyIDw8
IDUpCisjZGVmaW5lIEFEQVUxN1gxX1NFUklBTF9QT1JUMV9CQ0xLNjQJCSgweDAgPDwgNSkKKyNk
ZWZpbmUgQURBVTE3WDFfU0VSSUFMX1BPUlQxX0JDTEszMgkJKDB4MSA8PCA1KQorI2RlZmluZSBB
REFVMTdYMV9TRVJJQUxfUE9SVDFfQkNMSzQ4CQkoMHgyIDw8IDUpCiAjZGVmaW5lIEFEQVUxN1gx
X1NFUklBTF9QT1JUMV9CQ0xLMTI4CQkoMHgzIDw8IDUpCiAjZGVmaW5lIEFEQVUxN1gxX1NFUklB
TF9QT1JUMV9CQ0xLMjU2CQkoMHg0IDw8IDUpCiAjZGVmaW5lIEFEQVUxN1gxX1NFUklBTF9QT1JU
MV9CQ0xLX01BU0sJCSgweDcgPDwgNSkKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
