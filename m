From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB quirk for DG965OT board
	version AAD63733-203
Date: Thu, 22 Apr 2010 17:48:04 -0400
Message-ID: <u2l604760771004221448v3f194f17saf6cac245ea42579@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e1f846f6abc50484da433f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3616524431
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 23:48:07 +0200 (CEST)
Received: by pxi13 with SMTP id 13so667520pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 14:48:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, imwithid@yahoo.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e1f846f6abc50484da433f
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD that makes the OR's
audio work by default.

Best,
-Dan

--001636e1f846f6abc50484da433f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-quirk-for-DG965OT-board-version-AA.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-quirk-for-DG965OT-board-version-AA.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8c3rnsg0

RnJvbSA1MDNiZGM0ZDYyMTY5NjQyYzA5Nzg1ZTgzOGJmODlmNzUxOTQ5ZWE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMjEgQXByIDIwMTAgMTk6NTU6NDMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIHF1aXJrIGZvciBERzk2NU9UIGJvYXJkIHZlcnNpb24gQUFENjM3MzMt
MjAzCgpCdWdMaW5rOiBodHRwczovL2xhdW5jaHBhZC5uZXQvYnVncy80NTkwODMKClRoZSBPUiBo
YXMgdmVyaWZpZWQgd2l0aCAyLjYuMzIuMTEgYW5kIHRoZSBsYXRlc3QgYWxzYS1kcml2ZXIgc3Rh
YmxlCmRhaWx5IHNuYXBzaG90IHRoYXQgcG9zaXRpb25fZml4PTEgaXMgbmVjZXNzYXJ5IGZvciB0
aGUgZXh0ZXJuYWwgbWljCnRvIHdvcmsgYW5kIGZvciBQdWxzZUF1ZGlvIG5vdCB0byBjcmFzaCBj
b25zdGFudGx5LgoKVGhpcyBwYXRjaCBpcyBuZWNlc3NhcnkgYWxzbyBmb3IgMi42LjMyLjExIGFu
ZCAyLjYuMzMuMi4KClJlcG9ydGVkLWJ5OiA8aW13aXRoaWRAeWFob28uY29tPgpUZXN0ZWQtYnk6
IDxpbXdpdGhpZEB5YWhvby5jb20+CkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYt
Ynk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRh
L2hkYV9pbnRlbC5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIv
c291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCAyMzhlMGNhLi4xYTc5OGQ5IDEwMDY0NAot
LS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2lu
dGVsLmMKQEAgLTIyNDMsNiArMjI0Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBw
b3NpdGlvbl9maXhfbGlzdFtdIF9fZGV2aW5pdGRhdGEgPSB7CiAJU05EX1BDSV9RVUlSSygweDE0
NTgsIDB4YTAyMiwgImdhLW1hNzcwLXVkMyIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlS
SygweDE0NjIsIDB4MTAwMiwgIk1TSSBXaW5kIFUxMTUiLCBQT1NfRklYX0xQSUIpLAogCVNORF9Q
Q0lfUVVJUksoMHgxNTY1LCAweDgyMGYsICJCaW9zdGFyIE1pY3JvdGVjaCIsIFBPU19GSVhfTFBJ
QiksCisJU05EX1BDSV9RVUlSSygweDgwODYsIDB4MjUwMywgIkRHOTY1T1QgQUFENjM3MzMtMjAz
IiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4ODA4NiwgMHhkNjAxLCAiZU1hY2hp
bmVzIFQ1MjEyIiwgUE9TX0ZJWF9MUElCKSwKIAl7fQogfTsKLS0gCjEuNy4wLjQKCg==
--001636e1f846f6abc50484da433f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e1f846f6abc50484da433f--
