From: shal@free.fr
Subject: Some information about UsbPre2 UAC2 support
Date: Sat, 26 Jan 2013 18:50:07 +0100 (CET)
Message-ID: <199306935.463022264.1359222606997.JavaMail.root@spooler2-g27.priv.proxad.net>
References: <1897855798.462977802.1359220888088.JavaMail.root@spooler2-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_463022261_7786149.1359222606995"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 21DE2261640
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 18:50:11 +0100 (CET)
Received: from spooler2-g27.priv.proxad.net (unknown [172.20.243.240])
 by smtp5-g21.free.fr (Postfix) with ESMTP id 36B8BD480D6
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 18:50:07 +0100 (CET)
In-Reply-To: <1897855798.462977802.1359220888088.JavaMail.root@spooler2-g27.priv.proxad.net>
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

------=_Part_463022261_7786149.1359222606995
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

The Sound Devices USBPre2 is an UAC2 device but recognized as a UAC1 device=
 by Linux.

I have spend some time in order to found a solution.
I have successfully setup my sound card as a UAC2 mode and I can play/recor=
d a 24/192khz without problem.

But my solution is very ugly and cannot be considered as a real solution.
Perhaps alsa developers have an idea to integrated UAC2 support for the USB=
PRe2 in the standard stack....

There is two distinct problems:
- The sound card recognizes Linux as a Windows OS and send a incorrect devi=
ce descriptor.
- The USB stack choose the bad configuration descriptor.


More details on first problem:

For some compatibility raison, Sound device developer want only send a UAC1=
 configuration when the Operating system is Windows.
The used method is based on the length of the  setup packet during the devi=
ce get_descriptor function.
If the length is 64, the OS is considered as Windows.
Linux have choosen also this value.=20
Extract of kernel source code:
" NOTE:  If USE_NEW_SCHEME() is true we will start by issuing
  a 64-byte GET_DESCRIPTOR request.  This is what Windows does,
  so it may help with some non-standards-compliant devices."

So I have patched my kernel. In driver/usb/core/hub.c: #define GET_DESCRIPT=
OR_BUFSIZE 65 (instead 64)

This solve the first problem.


More details on the second problem:

Now, the USB device descriptor has two configuration descriptors :the first=
 is a UAC1 and the second is a UAC2.
My "lsusb -v -d 0926:" can be view at:=C2=A0http://pastebin.com/nFTN2E04

As UAC1 is a valid configuration descriptor, the usb stack choose this conf=
iguration.

I have patched the usb_choose_configuration() function in file driver/usb/c=
ore/generic.c for overwrite the value with the good one.

That all, no other problem was detected. The Linux UAC2 stack seems to be O=
K with this sound card.

I joined (ugly) patches , built on linux 3.7.1.


If you have an idea about how have a standard support of UAC2 for the Sound=
 Devices USBPRe2, I (and a lot of people) will be happy.

Thanks
Olivier

PS:
A thread exists on LAU : http://lists.linuxaudio.org/pipermail/linux-audio-=
user/2013-January/089199.html

------=_Part_463022261_7786149.1359222606995
Content-Type: text/x-patch; name=choose_configuration.patch
Content-Disposition: attachment; filename=choose_configuration.patch
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTMuNy4xL2RyaXZlcnMvdXNiL2NvcmUvZ2VuZXJpYy5jCTIwMTItMTItMTcgMjA6
MTQ6NTQuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0zLjcuMS1zaGFsL2RyaXZlcnMvdXNiL2Nv
cmUvZ2VuZXJpYy5jCTIwMTMtMDEtMjYgMTg6MDk6MTQuMzYzNzg5OTg2ICswMTAwCkBAIC0xNTAs
NiArMTUwLDE0IEBACiAJCQkibm8gY29uZmlndXJhdGlvbiBjaG9zZW4gZnJvbSAlZCBjaG9pY2Ul
c1xuIiwKIAkJCW51bV9jb25maWdzLCBwbHVyYWwobnVtX2NvbmZpZ3MpKTsKIAl9CisJCisJaWYo
dWRldi0+cHJvZHVjdCAhPSBOVUxMKQorCSBpZihzdHJsZW4odWRldi0+cHJvZHVjdCkgPj0gNykK
KwkgIGlmKHN0cm5jbXAodWRldi0+cHJvZHVjdCwiVVNCUHJlMiIsNykgPT0gMCkKKwkJeworCQkJ
aSsrOworCQkJcHJpbnRrKCJPdmVyd3JpdGUgdGhlIGNob29zZW4gY29uZmlndXJhdGlvbiB0byB0
aGUgZm9sbG93ZXIgOiVkIGluIG9yZGVyIHRvIHN1cHBvcnQgVVNCUHJlMiBpbiBVQUMyXG4iLGkp
OworCQl9CiAJcmV0dXJuIGk7CiB9CiAK
------=_Part_463022261_7786149.1359222606995
Content-Type: text/x-patch; name=get_descriptor_bufsize.patch
Content-Disposition: attachment; filename=get_descriptor_bufsize.patch
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTMuNy4xL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMJMjAxMi0xMi0xNyAyMDoxNDo1
NC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTMuNy4xLXNoYWwvZHJpdmVycy91c2IvY29yZS9o
dWIuYwkyMDEzLTAxLTI2IDE4OjA4OjIyLjU1MjMxOTQ4MCArMDEwMApAQCAtMzg2NSw3ICszODY1
LDkgQEAKIAkJCXN0cnVjdCB1c2JfZGV2aWNlX2Rlc2NyaXB0b3IgKmJ1ZjsKIAkJCWludCByID0g
MDsKIAotI2RlZmluZSBHRVRfREVTQ1JJUFRPUl9CVUZTSVpFCTY0CisvLyNkZWZpbmUgR0VUX0RF
U0NSSVBUT1JfQlVGU0laRQk2NAorI2RlZmluZSBHRVRfREVTQ1JJUFRPUl9CVUZTSVpFCTY1CisK
IAkJCWJ1ZiA9IGttYWxsb2MoR0VUX0RFU0NSSVBUT1JfQlVGU0laRSwgR0ZQX05PSU8pOwogCQkJ
aWYgKCFidWYpIHsKIAkJCQlyZXR2YWwgPSAtRU5PTUVNOwo=
------=_Part_463022261_7786149.1359222606995
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_463022261_7786149.1359222606995--
