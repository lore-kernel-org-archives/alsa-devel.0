From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [RFC Patch] ALSA - EMU10K1 - Remove Center LFE Wave
 Center and Wave LFE control for SB Live! Platinum
Date: Wed, 30 Mar 2011 20:50:51 +0800
Message-ID: <AANLkTikxq8K=91jGGqKsmb=0A8tELF_d_wH7O05sjwRr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a6976dfc79049fb2a0d6
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A8D052415E
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 14:50:52 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1080799fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2011 05:50:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--20cf3054a6976dfc79049fb2a0d6
Content-Type: text/plain; charset=ISO-8859-1

SB Live! Platinum CT4760P is just a 4 channels sound card with STAC9721 and
Philips UDA1334 DAC

Is it feasible to remove "Center" , "LFE", "Wave Cetner" and "Wave LFE"
Playback Volume control ?

or add a bitmap to disable the creation of those controls

Anyone know whether this patch has any side effect for the user with  Live
Drive

AFAIK, speaker-test will fail

speaker-test -d -c 6 -t wav -Dsurround51:1

speaker-test 1.0.24.2

Playback device is surround51:1
Stream parameters are 48000Hz, S16_LE, 6 channels
WAV file(s)
ALSA lib setup.c:565:(add_elem) Cannot obtain info for CTL elem
(MIXER,'Headphone Center Playback Switch',1,0,0): No such file or directory
Playback open error: -2,No such file or directory

--20cf3054a6976dfc79049fb2a0d6
Content-Type: application/octet-stream;
	name="Patch-ALSA-EMU10K1-Remove-Center-LFE-Wave-Center-and-Wave-LFE.patch"
Content-Disposition: attachment;
	filename="Patch-ALSA-EMU10K1-Remove-Center-LFE-Wave-Center-and-Wave-LFE.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_glw8ipno0

RnJvbSAzY2MxM2UwYjJhYWZhOWM3YzJiMjdmNDUyM2Q5ZTRhYjQwYWI3ZGE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDMwIE1hciAyMDExIDIwOjAwOjM5ICswODAwClN1YmplY3Q6IFtbUkZD
IFBBVENIXSAzLzNdIFtSRkMgUGF0Y2hdIC0gUmVtb3ZlIENlbnRlciAsIExGRSAsIFdhdmUgQ2Vu
dGVyIGFuZCBXYXZlIExGRSBjb250cm9sIGZvciBTQiBMaXZlISBQbGF0aW51bSBDVDQ3NjBQCgoK
U2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWlsLmNvbT4K
CmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvZW11MTBrMS9lbXVtaXhlci5jIGIvc291bmQvcGNpL2Vt
dTEwazEvZW11bWl4ZXIuYwppbmRleCAwNWFmZTA2Li4xYjUwYTIzIDEwMDY0NAotLS0gYS9zb3Vu
ZC9wY2kvZW11MTBrMS9lbXVtaXhlci5jCisrKyBiL3NvdW5kL3BjaS9lbXUxMGsxL2VtdW1peGVy
LmMKQEAgLTE5MTMsNiArMTkxMywxMiBAQCBpbnQgX19kZXZpbml0IHNuZF9lbXUxMGsxX21peGVy
KHN0cnVjdCBzbmRfZW11MTBrMSAqZW11LAogCWZvciAoOyAqYzsgYyArPSAyKQogCQlyZW5hbWVf
Y3RsKGNhcmQsIGNbMF0sIGNbMV0pOwogCisJaWYgKGVtdS0+Y2FyZF9jYXBhYmlsaXRpZXMtPnN1
YnN5c3RlbSA9PSAweDgwNDAxMTAyKSB7IC8qIFNCIExpdmUhIFBsYXRpbnVtIENUNDc2MFAgKi8K
KwkJcmVtb3ZlX2N0bChjYXJkLCAiQ2VudGVyIFBsYXliYWNrIFZvbHVtZSIpOworCQlyZW1vdmVf
Y3RsKGNhcmQsICJMRkUgUGxheWJhY2sgVm9sdW1lIik7CisJCXJlbW92ZV9jdGwoY2FyZCwgIldh
dmUgQ2VudGVyIFBsYXliYWNrIFZvbHVtZSIpOworCQlyZW1vdmVfY3RsKGNhcmQsICJXYXZlIExG
RSBQbGF5YmFjayBWb2x1bWUiKTsKKwl9CiAJaWYgKGVtdS0+Y2FyZF9jYXBhYmlsaXRpZXMtPnN1
YnN5c3RlbSA9PSAweDIwMDcxMTAyKSB7ICAvKiBBdWRpZ3kgNCBQcm8gKi8KIAkJcmVuYW1lX2N0
bChjYXJkLCAiTGluZTIgQ2FwdHVyZSBWb2x1bWUiLCAiTGluZTEvTWljIENhcHR1cmUgVm9sdW1l
Iik7CiAJCXJlbmFtZV9jdGwoY2FyZCwgIkFuYWxvZyBNaXggQ2FwdHVyZSBWb2x1bWUiLCAiTGlu
ZTIgQ2FwdHVyZSBWb2x1bWUiKTsKLS0gCjEuNi4wLjYKCg==
--20cf3054a6976dfc79049fb2a0d6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--20cf3054a6976dfc79049fb2a0d6--
