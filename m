From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] sun-cs4231: improved waiting after MCE down
Date: Tue, 11 Sep 2007 00:46:47 +0200
Message-ID: <20070911004647.b1f1810a.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Tue__11_Sep_2007_00_46_47_+0200_UxLXKkzKJ3lHBBiS"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id D4ED9103803
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 00:39:56 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so1233865nfb
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 15:39:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Tue__11_Sep_2007_00_46_47_+0200_UxLXKkzKJ3lHBBiS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch sync sparc driver with x86 isa cs4231 driver patches.
It fixes wrong waiting for the auto calibration bit and makes
further waiting use much finer granularity.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

--Multipart=_Tue__11_Sep_2007_00_46_47_+0200_UxLXKkzKJ3lHBBiS
Content-Type: application/octet-stream;
 name="sun-cs4231-wait.diff"
Content-Disposition: attachment;
 filename="sun-cs4231-wait.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4yMi9zb3VuZC9zcGFyYy9jczQyMzEuYwkyMDA3LTA5LTExIDAwOjE5OjQz
LjU0NjE5NzM4MiArMDIwMAorKysgbGludXgtMi42LjIzL3NvdW5kL3NwYXJjL2NzNDIzMS5jCTIw
MDctMDktMTEgMDA6NDA6NTcuNjE4ODAyNjQyICswMjAwCkBAIC00MjIsNDQgKzQyMiwzOSBAQCBz
dGF0aWMgdm9pZCBzbmRfY3M0MjMxX21jZV9kb3duKHN0cnVjdCBzCiAJCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmNoaXAtPmxvY2ssIGZsYWdzKTsKIAkJcmV0dXJuOwogCX0KLQlzbmRfY3M0MjMx
X2J1c3lfd2FpdChjaGlwKTsKIAotCS8qIGNhbGlicmF0aW9uIHByb2Nlc3MgKi8KKwkvKgorCSAq
IFdhaXQgZm9yIChwb3NzaWJsZSAtLSBkdXJpbmcgaW5pdCBhdXRvLWNhbGlicmF0aW9uIG1heSBu
b3QgYmUgc2V0KQorCSAqIGNhbGlicmF0aW9uIHByb2Nlc3MgdG8gc3RhcnQuIE5lZWRzIHVwdG8g
NSBzYW1wbGUgcGVyaW9kcyBvbiBBRDE4NDgKKwkgKiB3aGljaCBhdCB0aGUgc2xvd2VzdCBwb3Nz
aWJsZSByYXRlIG9mIDUuNTEyNSBrSHogbWVhbnMgOTA3IHVzLgorCSAqLworCW1zbGVlcCgxKTsK
IAotCXNuZF9jczQyMzFfcmVhZHkoY2hpcCk7Ci0Jc25kX2NzNDIzMV9yZWFkeShjaGlwKTsKLQl0
aW1lb3V0ID0gc25kX2NzNDIzMV9pbihjaGlwLCBDUzQyMzFfVEVTVF9JTklUKTsKLQlpZiAoKHRp
bWVvdXQgJiBDUzQyMzFfQ0FMSUJfSU5fUFJPR1JFU1MpID09IDApIHsKLQkJc25kX3ByaW50ZCgi
Y3M0MjMxX21jZV9kb3duIC0gYXV0byBjYWxpYnJhdGlvbiB0aW1lIG91dCAoMSlcbiIpOwotCQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZjaGlwLT5sb2NrLCBmbGFncyk7Ci0JCXJldHVybjsKLQl9
Ci0KLQkvKiBpbiAxMG1zIGluY3JlbWVudHMsIGNoZWNrIGNvbmRpdGlvbiwgdXAgdG8gMjUwbXMg
Ki8KLQl0aW1lb3V0ID0gMjU7CisJLyogY2hlY2sgY29uZGl0aW9uIHVwIHRvIDI1MG1zICovCisJ
dGltZW91dCA9IG1zZWNzX3RvX2ppZmZpZXMoMjUwKTsKIAl3aGlsZSAoc25kX2NzNDIzMV9pbihj
aGlwLCBDUzQyMzFfVEVTVF9JTklUKSAmCiAJCUNTNDIzMV9DQUxJQl9JTl9QUk9HUkVTUykgewog
CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNoaXAtPmxvY2ssIGZsYWdzKTsKLQkJaWYgKC0t
dGltZW91dCA8IDApIHsKKwkJaWYgKHRpbWVvdXQgPD0gMCkgewogCQkJc25kX3ByaW50aygibWNl
X2Rvd24gLSAiCiAJCQkJICAgImF1dG8gY2FsaWJyYXRpb24gdGltZSBvdXQgKDIpXG4iKTsKIAkJ
CXJldHVybjsKIAkJfQotCQltc2xlZXAoMTApOworCQl0aW1lb3V0ID0gc2NoZWR1bGVfdGltZW91
dCh0aW1lb3V0KTsKIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPmxvY2ssIGZsYWdzKTsKIAl9
CiAKLQkvKiBpbiAxMG1zIGluY3JlbWVudHMsIGNoZWNrIGNvbmRpdGlvbiwgdXAgdG8gMTAwbXMg
Ki8KLQl0aW1lb3V0ID0gMTA7CisJLyogY2hlY2sgY29uZGl0aW9uIHVwIHRvIDEwMG1zICovCisJ
dGltZW91dCA9IG1zZWNzX3RvX2ppZmZpZXMoMTAwKTsKIAl3aGlsZSAoX19jczQyMzFfcmVhZGIo
Y2hpcCwgQ1M0MjMxVShjaGlwLCBSRUdTRUwpKSAmIENTNDIzMV9JTklUKSB7CiAJCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmNoaXAtPmxvY2ssIGZsYWdzKTsKLQkJaWYgKC0tdGltZW91dCA8IDAp
IHsKKwkJaWYgKHRpbWVvdXQgPD0gMCkgewogCQkJc25kX3ByaW50aygibWNlX2Rvd24gLSAiCiAJ
CQkJICAgImF1dG8gY2FsaWJyYXRpb24gdGltZSBvdXQgKDMpXG4iKTsKIAkJCXJldHVybjsKIAkJ
fQotCQltc2xlZXAoMTApOworCQl0aW1lb3V0ID0gc2NoZWR1bGVfdGltZW91dCh0aW1lb3V0KTsK
IAkJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPmxvY2ssIGZsYWdzKTsKIAl9CiAJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmY2hpcC0+bG9jaywgZmxhZ3MpOwo=

--Multipart=_Tue__11_Sep_2007_00_46_47_+0200_UxLXKkzKJ3lHBBiS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Multipart=_Tue__11_Sep_2007_00_46_47_+0200_UxLXKkzKJ3lHBBiS--
