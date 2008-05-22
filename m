From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Kernel crash in snd-aloop (2)
Date: Thu, 22 May 2008 15:02:02 +0200
Message-ID: <d5eabee70805220602p73154e2buc1bd9e38d0c314e3@mail.gmail.com>
References: <d5eabee70805210741p256d4b3dmaa15fbd39df7c53f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2892_4568445.1211461322817"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id DC74324338
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 15:02:04 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so26592rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 22 May 2008 06:02:02 -0700 (PDT)
In-Reply-To: <d5eabee70805210741p256d4b3dmaa15fbd39df7c53f@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

------=_Part_2892_4568445.1211461322817
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

So after much experimentation and thinking, I think I can come up with the
following scenario why the kernel crashes:

When the aloop soundcard is closed by jackd, all data structures are freed.
This is OK, but the code forgets to check if any timers are still running.
Most of the time this goes well and nothing bad happens. But sometimes the
dpcm->timer.function fires after all data is cleaned up/freed. And that is
of course not very desirable.

I've attached a patch to the alsa-driver-hg20080516 version of
drivers/aloop-kernel.c This patch does a del_timer() in three places, I
would love to hear feedback from you guys on the list if some del_timers can
be eliminated? It seems a bit paranoia but it works perfectly in my test
setup.

So what do you guys think? I've never submitted patches before so I'm not
sure if this is the correct procedure. Please correct me if necessary...

Kind regards,
Benjamin van den Hout

------=_Part_2892_4568445.1211461322817
Content-Type: text/x-patch; name=aloop-del_timer.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fgjcr9mm
Content-Disposition: attachment; filename=aloop-del_timer.patch

LS0tIGFsc2EtZHJpdmVyLWhnMjAwODA1MTYvZHJpdmVycy9hbG9vcC1rZXJuZWwuYwkyMDA4LTA1
LTIyIDEzOjM3OjA5LjAwMDAwMDAwMCArMDIwMAorKysgYWxzYS1kcml2ZXItaGcyMDA4MDUxNi5w
YXRjaC9kcml2ZXJzL2Fsb29wLWtlcm5lbC5jCTIwMDgtMDUtMjIgMTQ6NDk6MTIuMDAwMDAwMDAw
ICswMjAwCkBAIC0yMzIsNiArMjMyLDggQEAKIHN0YXRpYyB2b2lkIHNuZF9jYXJkX2xvb3BiYWNr
X3J1bnRpbWVfZnJlZShzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lKQogewogCXNuZF9j
YXJkX2xvb3BiYWNrX3BjbV90ICpkcGNtID0gcnVudGltZS0+cHJpdmF0ZV9kYXRhOworCXNuZF9h
c3NlcnQoZHBjbSAhPSBOVUxMLCByZXR1cm4pOworCWRlbF90aW1lcigmZHBjbS0+dGltZXIpOwog
CWtmcmVlKGRwY20pOwogfQogCkBAIC0yNjUsNiArMjY3LDkgQEAKIAlzbmRfY2FyZF9sb29wYmFj
a19wY21fdCAqZHBjbSA9IHJ1bnRpbWUtPnByaXZhdGVfZGF0YTsKIAlzbmRfY2FyZF9sb29wYmFj
a19jYWJsZV90ICpjYWJsZSA9IGRwY20tPmNhYmxlOwogCisJc25kX2Fzc2VydChkcGNtICE9IE5V
TEwsIHJldHVybiAtRUlOVkFMKTsKKwlkZWxfdGltZXIoJmRwY20tPnRpbWVyKTsKKwogCXNuZF9w
Y21fc2V0X3J1bnRpbWVfYnVmZmVyKHN1YnN0cmVhbSwgTlVMTCk7CiAKIAlpZiAoU05EUlZfUENN
X1NUUkVBTV9QTEFZQkFDSyA9PSBzdWJzdHJlYW0tPnN0cmVhbSkgewpAQCAtMzQ5LDYgKzM1NCwx
MCBAQAogewogCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1
bnRpbWU7CiAJc25kX2NhcmRfbG9vcGJhY2tfcGNtX3QgKmRwY20gPSBydW50aW1lLT5wcml2YXRl
X2RhdGE7CisKKwlzbmRfYXNzZXJ0KGRwY20gIT0gTlVMTCwgcmV0dXJuIC1FSU5WQUwpOworCWRl
bF90aW1lcigmZHBjbS0+dGltZXIpOworCiAJaWYgKFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0sg
PT0gc3Vic3RyZWFtLT5zdHJlYW0pIHsKIAkJZHBjbS0+Y2FibGUtPnBsYXliYWNrX3ZhbGlkID0g
MDsKIAkJZHBjbS0+Y2FibGUtPnBsYXliYWNrX3J1bm5pbmcgPSAwOwo=
------=_Part_2892_4568445.1211461322817
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_2892_4568445.1211461322817--
