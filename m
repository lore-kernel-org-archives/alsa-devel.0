From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] cs4231-lib: improved waiting after
 mce_down (2nd rev)
Date: Tue, 11 Sep 2007 00:40:10 +0200
Message-ID: <20070911004010.b9114b3e.krzysztof.h1@gmail.com>
References: <20070909221131.06372eb2.krzysztof.h1@gmail.com>
	<s5hbqcaqkb8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Tue__11_Sep_2007_00_40_10_+0200_xxr7ff=fnmARtP+7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4271038E6
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 00:33:25 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so1232503nfb
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 15:33:22 -0700 (PDT)
In-Reply-To: <s5hbqcaqkb8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Tue__11_Sep_2007_00_40_10_+0200_xxr7ff=fnmARtP+7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1 at wp.pl>

This patch replaces long msleeps in waiting loops
with schedule_timeout() calls.

Signed-off-by: Krzysztof Helt <krzysztof.h1 at wp.pl>
---

This is done against tree with Rene's patches.

Regards,
Krzysztof

--Multipart=_Tue__11_Sep_2007_00_40_10_+0200_xxr7ff=fnmARtP+7
Content-Type: application/octet-stream;
 name="cs4231-wait.diff"
Content-Disposition: attachment;
 filename="cs4231-wait.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMi9zb3VuZC9pc2EvY3M0MjN4L2NzNDIzMV9saWIuYyBsaW51
eC0yLjYuMjMvc291bmQvaXNhL2NzNDIzeC9jczQyMzFfbGliLmMKLS0tIGxpbnV4LTIuNi4yMi9z
b3VuZC9pc2EvY3M0MjN4L2NzNDIzMV9saWIuYwkyMDA3LTA5LTExIDAwOjAyOjE1LjAwMDAwMDAw
MCArMDIwMAorKysgbGludXgtMi42LjIzL3NvdW5kL2lzYS9jczQyM3gvY3M0MjMxX2xpYi5jCTIw
MDctMDktMTEgMDA6Mzc6NTAuOTY4MTY2MDI4ICswMjAwCkBAIC0zNDMsMjYgKzM0MywyOSBAQCB2
b2lkIHNuZF9jczQyMzFfbWNlX2Rvd24oc3RydWN0IHNuZF9jczQyCiAKIAlzbmRfcHJpbnRkZCgi
KDEpIGppZmZpZXMgPSAlbHVcbiIsIGppZmZpZXMpOwogCi0JLyogaW4gMTAgbXMgaW5jcmVtZW50
cywgY2hlY2sgY29uZGl0aW9uLCB1cCB0byAyNTAgbXMgKi8KLQl0aW1lb3V0ID0gMjU7Ci0Jd2hp
bGUgKHNuZF9jczQyMzFfaW4oY2hpcCwgQ1M0MjMxX1RFU1RfSU5JVCkgJiBDUzQyMzFfQ0FMSUJf
SU5fUFJPR1JFU1MpIHsKLQkJaWYgKC0tdGltZW91dCA8IDApIHsKLQkJCXNuZF9wcmludGsoIm1j
ZV9kb3duIC0gYXV0byBjYWxpYnJhdGlvbiB0aW1lIG91dCAoMilcbiIpOworCS8qIGNoZWNrIGNv
bmRpdGlvbiB1cCB0byAyNTAgbXMgKi8KKwl0aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcygyNTAp
OworCXdoaWxlIChzbmRfY3M0MjMxX2luKGNoaXAsIENTNDIzMV9URVNUX0lOSVQpICYKKwkJQ1M0
MjMxX0NBTElCX0lOX1BST0dSRVNTKSB7CisKKwkJaWYgKHRpbWVvdXQgPD0gMCkgeworCQkJc25k
X3ByaW50ayhLRVJOX0VSUiAibWNlX2Rvd24gLSAiCisJCQkJCSJhdXRvIGNhbGlicmF0aW9uIHRp
bWUgb3V0ICgyKVxuIik7CiAJCQlyZXR1cm47CiAJCX0KLQkJbXNsZWVwKDEwKTsKKwkJdGltZW91
dCA9IHNjaGVkdWxlX3RpbWVvdXQodGltZW91dCk7CiAJfQogCiAJc25kX3ByaW50ZGQoIigyKSBq
aWZmaWVzID0gJWx1XG4iLCBqaWZmaWVzKTsKIAotCS8qIGluIDEwIG1zIGluY3JlbWVudHMsIGNo
ZWNrIGNvbmRpdGlvbiwgdXAgdG8gMTAwIG1zICovCi0JdGltZW91dCA9IDEwOworCS8qIGNoZWNr
IGNvbmRpdGlvbiB1cCB0byAxMDAgbXMgKi8KKwl0aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcygx
MDApOwogCXdoaWxlIChjczQyMzFfaW5iKGNoaXAsIENTNDIzMVAoUkVHU0VMKSkgJiBDUzQyMzFf
SU5JVCkgewotCQlpZiAoLS10aW1lb3V0IDwgMCkgeworCQlpZiAodGltZW91dCA8PSAwKSB7CiAJ
CQlzbmRfcHJpbnRrKEtFUk5fRVJSICJtY2VfZG93biAtIGF1dG8gY2FsaWJyYXRpb24gdGltZSBv
dXQgKDMpXG4iKTsKIAkJCXJldHVybjsKIAkJfQotCQltc2xlZXAoMTApOworCQl0aW1lb3V0ID0g
c2NoZWR1bGVfdGltZW91dCh0aW1lb3V0KTsKIAl9CiAKIAlzbmRfcHJpbnRkZCgiKDMpIGppZmZp
ZXMgPSAlbHVcbiIsIGppZmZpZXMpOwo=

--Multipart=_Tue__11_Sep_2007_00_40_10_+0200_xxr7ff=fnmARtP+7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Multipart=_Tue__11_Sep_2007_00_40_10_+0200_xxr7ff=fnmARtP+7--
