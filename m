From: =?utf-8?q?Diego=20E=2E=20=27Flameeyes=27=20Petten=C3=B2?=
	<flameeyes@gmail.com>
Subject: [PATCH 1/2] Remove definition for surround sound
	devices on ICE1712.
Date: Tue, 20 Jan 2009 13:37:54 +0100
Message-ID: <1232455075-27712-2-git-send-email-flameeyes@gmail.com>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 211B424345
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:36:37 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so1556650fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 04:36:37 -0800 (PST)
In-Reply-To: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "=?utf-8?q?Diego=20E.=20'Flameeyes'=20Petten=C3=B2?=" <flameeyes@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGhlIElDRTE3MTItYmFzZWQgY2FyZHMgYXJlIG5vbi1zdXJyb3VuZCBjYXJkcyB3aXRoIG9ubHkg
c3RlcmVvIGZpbmFsCm91dHB1dC4gSXQncyBub3QgcG9zc2libGUgdG8gdXNlIHRoZW0gYXMgc3Vy
cm91bmQgY2FyZHMsIHNvIHRoZXNlIGRldmljZXMKZG9uJ3QgbWFrZSBzZW5zZS4KClRoZXkgYWxz
byBkb24ndCB3b3JrIHNpbmNlIG9wZW5pbmcgdGhvc2UgZGV2aWNlcyB3aXRoIGxlc3MgdGhhbiB0
aGUgYW1vdW50Cm9mIGNoYW5uZWxzIHdpbGwgZmFpbC4KClNpZ25lZC1vZmYtYnk6IERpZWdvIEUu
ICdGbGFtZWV5ZXMnIFBldHRlbsOyIDxmbGFtZWV5ZXNAZ21haWwuY29tPgotLS0KIHNyYy9jb25m
L2NhcmRzL0lDRTE3MTIuY29uZiB8ICAgNDAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb25mL2NhcmRzL0lDRTE3MTIuY29uZiBiL3NyYy9jb25m
L2NhcmRzL0lDRTE3MTIuY29uZgppbmRleCAwMWU1MGQyLi41NDQ1OTIwIDEwMDY0NAotLS0gYS9z
cmMvY29uZi9jYXJkcy9JQ0UxNzEyLmNvbmYKKysrIGIvc3JjL2NvbmYvY2FyZHMvSUNFMTcxMi5j
b25mCkBAIC0zOSw0NiArMzksNiBAQCBJQ0UxNzEyLnBjbS5mcm9udC4wIHsKIAkJdHlwZSBodwog
CQljYXJkICRDQVJECiAJfQotfQkKLQotPGNvbmZkaXI6cGNtL3N1cnJvdW5kNDAuY29uZj4KLQot
SUNFMTcxMi5wY20uc3Vycm91bmQ0MC4wIHsKLQlAYXJncyBbIENBUkQgXQotCUBhcmdzLkNBUkQg
ewotCQl0eXBlIHN0cmluZwotCX0KLQl0eXBlIHJvdXRlCi0JdHRhYmxlLjAuMCAxCi0JdHRhYmxl
LjEuMSAxCi0JdHRhYmxlLjIuMiAxCi0JdHRhYmxlLjMuMyAxCi0Jc2xhdmUucGNtIHsKLQkJdHlw
ZSBodwotCQljYXJkICRDQVJECi0JfQotfQkKLQotPGNvbmZkaXI6cGNtL3N1cnJvdW5kNDEuY29u
Zj4KLTxjb25mZGlyOnBjbS9zdXJyb3VuZDUwLmNvbmY+Ci08Y29uZmRpcjpwY20vc3Vycm91bmQ1
MS5jb25mPgotCi1JQ0UxNzEyLnBjbS5zdXJyb3VuZDUxLjAgewotCUBhcmdzIFsgQ0FSRCBdCi0J
QGFyZ3MuQ0FSRCB7Ci0JCXR5cGUgc3RyaW5nCi0JfQotCXR5cGUgcm91dGUKLQl0dGFibGUuMC4w
IDEKLQl0dGFibGUuMS4xIDEKLQl0dGFibGUuMi4yIDEKLQl0dGFibGUuMy4zIDEKLQl0dGFibGUu
NC40IDEKLQl0dGFibGUuNS41IDEKLQlzbGF2ZS5wY20gewotCQl0eXBlIGh3Ci0JCWNhcmQgJENB
UkQKLQl9CiB9CiAKIDxjb25mZGlyOnBjbS9pZWM5NTguY29uZj4KLS0gCjEuNi4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
