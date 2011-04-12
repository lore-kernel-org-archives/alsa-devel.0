From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH alsa-lib emu10k1.conf 1/1] Fix "front" device
	of SB Live! Platinum
Date: Tue, 12 Apr 2011 10:17:32 +0800
Message-ID: <BANLkTintENV=X7VGyratXNYLOGRGQrp84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a88775a81304a0af4ba6
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AE52810382A
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 04:17:34 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4620459fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 19:17:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, mikma@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--20cf3054a88775a81304a0af4ba6
Content-Type: text/plain; charset=ISO-8859-1

Since commit 148c2b8e7c12b4ab8a039995fa9904e7e1300cc4. Front channels via
fxbus 8 and 9

No sound from the front jack of SB Live! platinum CT4760P when the
application using "front" device but sound from front jack when application
using hw:0,0 and /dev/dsp

Error message " I: (alsa-lib)setup.c: Cannot lock ctl elem*"* when
Pulseaudio server open "front" device for playback and capture at the same
time because of locked "EMU10K1 Send PCM Volume"

--20cf3054a88775a81304a0af4ba6
Content-Type: application/octet-stream;
	name="0001-Fix-front-device-of-SB-Live-Platinum.patch"
Content-Disposition: attachment;
	filename="0001-Fix-front-device-of-SB-Live-Platinum.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gme6u8am0

RnJvbSBiYTRmNTY1OWQ5OGQ0MzY3MGIxOWU5MTM1YzFjOGViYjc4ZTY0ZTVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDEyIEFwciAyMDExIDA5OjQ1OjQ5ICswODAwClN1YmplY3Q6IFtQQVRD
SCBhbHNhLWxpYiBlbXUxMGsxLmNvbmYgMS8xXSBGaXggImZyb250IiBkZXZpY2Ugb2YgU0IgTGl2
ZSEgUGxhdGludW0KClNpbmNlIGNvbW1pdCAxNDhjMmI4ZTdjMTJiNGFiOGEwMzk5OTVmYTk5MDRl
N2UxMzAwY2M0LiBGcm9udCBjaGFubmVscyB2aWEgZnhidXMgOCBhbmQgOQpubyBzb3VuZCBmcm9t
IHRoZSBmcm9udCBqYWNrIG9mIFNCIExpdmUhIHBsYXRpbnVtIHdoZW4gdGhlIGFwcGxpY2F0aW9u
IHVzaW5nICJmcm9udCIgZGV2aWNlIGJ1dCBzb3VuZCBmcm9tIGZyb250IGphY2sgd2hlbiBhcHBs
aWNhdGlvbiB1c2luZyBodzowLDAgYW5kIC9kZXYvZHNwCgpFcnJvciBtZXNzYWdlICJjYW5ub3Qg
bG9jayBjdGwgZWxlbSIgd2hlbiBQdWxzZWF1ZGlvIHNlcnZlciBvcGVuICJmcm9udCIgZGV2aWNl
IGZvciBwbGF5YmFjayBhbmQgY2FwdHVyZSBiZWNhdXNlIG9mIGxvY2tlZCAiRU1VMTBLMSBTZW5k
IFBDTSBWb2x1bWUiCgpTaWduZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRl
eDJAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3NyYy9jb25mL2NhcmRzL0VNVTEwSzEuY29uZiBi
L3NyYy9jb25mL2NhcmRzL0VNVTEwSzEuY29uZgppbmRleCA5NTZlMTYzLi41NDQ1ZjZmIDEwMDY0
NAotLS0gYS9zcmMvY29uZi9jYXJkcy9FTVUxMEsxLmNvbmYKKysrIGIvc3JjL2NvbmYvY2FyZHMv
RU1VMTBLMS5jb25mCkBAIC05LDQ4ICs5LDggQEAgRU1VMTBLMS5wY20uZnJvbnQuMCB7CiAJQGFy
Z3MuQ0FSRCB7CiAJCXR5cGUgc3RyaW5nCiAJfQotCXR5cGUgaG9va3MKLQlzbGF2ZS5wY20gewot
CQl0eXBlIGh3Ci0JCWNhcmQgJENBUkQKLQl9Ci0JaG9va3MuMCB7Ci0JCXR5cGUgY3RsX2VsZW1z
Ci0JCWhvb2tfYXJncyBbCi0JCQl7Ci0JCQkJaW50ZXJmYWNlIFBDTQotCQkJCW5hbWUgIkVNVTEw
SzEgUENNIFNlbmQgVm9sdW1lIgotCQkJCWluZGV4IHsgQGZ1bmMgcHJpdmF0ZV9wY21fc3ViZGV2
aWNlIH0KLQkJCQlsb2NrIHRydWUKLQkJCQlvcHRpb25hbCB0cnVlCi0JCQkJdmFsdWUgWyAyNTUg
MjU1IDAgMCAyNTUgMCAwIDAgMCAyNTUgMCAwIF0KLQkJCX0KLQkJCXsKLQkJCQkjIGZvciBjb21w
YXRpYmlsaXR5IHdpdGggb2xkZXIgZHJpdmVycwotCQkJCW5hbWUgIkVNVTEwSzEgUENNIFNlbmQg
Vm9sdW1lIgotCQkJCWluZGV4IHsgQGZ1bmMgcHJpdmF0ZV9wY21fc3ViZGV2aWNlIH0KLQkJCQls
b2NrIHRydWUKLQkJCQlvcHRpb25hbCB0cnVlCi0JCQkJdmFsdWUgWyAyNTUgMjU1IDAgMCAyNTUg
MCAwIDAgMCAyNTUgMCAwIF0KLQkJCX0KLQkJCXsKLQkJCQlpbnRlcmZhY2UgUENNCi0JCQkJbmFt
ZSAiRU1VMTBLMSBQQ00gU2VuZCBSb3V0aW5nIgotCQkJCWluZGV4IHsgQGZ1bmMgcHJpdmF0ZV9w
Y21fc3ViZGV2aWNlIH0KLQkJCQlsb2NrIHRydWUKLQkJCQlvcHRpb25hbCB0cnVlCi0JCQkJdmFs
dWUgWyA4IDkgMCAwIDggOSAwIDAgOCA5IDAgMCBdCi0JCQl9Ci0JCQl7Ci0JCQkJIyBmb3IgY29t
cGF0aWJpbGl0eSB3aXRoIG9sZGVyIGRyaXZlcnMKLQkJCQluYW1lICJFTVUxMEsxIFBDTSBTZW5k
IFJvdXRpbmciCi0JCQkJaW5kZXggeyBAZnVuYyBwcml2YXRlX3BjbV9zdWJkZXZpY2UgfQotCQkJ
CWxvY2sgdHJ1ZQotCQkJCW9wdGlvbmFsIHRydWUKLQkJCQl2YWx1ZSBbIDggOSAwIDAgOCA5IDAg
MCA4IDkgMCAwIF0KLQkJCX0KLQkJXQotCX0KKwl0eXBlIGh3CisJY2FyZCAkQ0FSRAogfQkKIAog
PGNvbmZkaXI6cGNtL3JlYXIuY29uZj4KLS0gCjEuNi4wLjYKCg==
--20cf3054a88775a81304a0af4ba6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--20cf3054a88775a81304a0af4ba6--
