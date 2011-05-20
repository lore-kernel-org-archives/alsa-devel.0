From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] - ALSA - HDA - Remove "PCM Playback Volume"
 and "PCM Playback Switch" from Virtual Master of realtek codec
Date: Fri, 20 May 2011 14:07:39 +0800
Message-ID: <BANLkTinUhxBBPZ+MTxPvS3YX4CuDVZu5KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151747698065559604a3aef0ef
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E27BC10381B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 08:07:41 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2807180fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 23:07:39 -0700 (PDT)
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

--00151747698065559604a3aef0ef
Content-Type: text/plain; charset=ISO-8859-1

Afer commit aa202455eec51699e44f658530728162cefa1307 , none of realtek
codec has hardware volume control "PCM Playback Volume" and "PCM
Playback Switch"

As Virtual Master require all slave controls must have same number of
step and dB range

--00151747698065559604a3aef0ef
Content-Type: application/octet-stream;
	name="0001-Remove-PCM-Playback-Volume-and-Switch-from-Virtual-Master.patch"
Content-Disposition: attachment;
	filename="0001-Remove-PCM-Playback-Volume-and-Switch-from-Virtual-Master.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnwq8niv0

RnJvbSA4NjQ3MTZmNjI2ODY5MWY0YzRlNGMzZDQwNWQ0MTZmM2E5YjgwZTJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDIwIE1heSAyMDExIDEzOjA0OjA0ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gLSBBTFNBIC0gSERBIC0gUmVtb3ZlICJQQ00gUGxheWJhY2sgVm9sdW1lIiBhbmQgIlBDTSBQ
bGF5YmFjayBTd2l0Y2giIGZyb20gVmlydHVhbCBNYXN0ZXIgb2YgcmVhbHRlawoKQWZlciBjb21t
aXQgYWEyMDI0NTVlZWM1MTY5OWU0NGY2NTg1MzA3MjgxNjJjZWZhMTMwNyAsIG5vbmUgb2YgcmVh
bHRlayBjb2RlYyBoYXMgaGFyZHdhcmUgdm9sdW1lIGNvbnRyb2wgIlBDTSBQbGF5YmFjayBWb2x1
bWUiIGFuZCAiUENNIFBsYXliYWNrIFN3aXRjaCIKCkFzIFZpcnR1YWwgTWFzdGVyIHJlcXVpcmUg
YWxsIHNsYXZlIGNvbnRyb2xzIG11c3QgaGF2ZSBzYW1lIG51bWJlciBvZiBzdGVwIGFuZCBkQiBy
YW5nZQoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWls
LmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDQ5YzYwNjIuLmM5ZmRmOGQgMTAwNjQ0Ci0t
LSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfcmVhbHRlay5jCkBAIC0zMjM2LDcgKzMyMzYsNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IGFsY19zbGF2ZV92b2xzW10gPSB7CiAJIlNwZWFrZXIgUGxheWJhY2sgVm9sdW1lIiwKIAki
TW9ubyBQbGF5YmFjayBWb2x1bWUiLAogCSJMaW5lLU91dCBQbGF5YmFjayBWb2x1bWUiLAotCSJQ
Q00gUGxheWJhY2sgVm9sdW1lIiwKIAlOVUxMLAogfTsKIApAQCAtMzI1MSw3ICszMjUwLDYgQEAg
c3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBhbGNfc2xhdmVfc3dzW10gPSB7CiAJIk1vbm8gUGxh
eWJhY2sgU3dpdGNoIiwKIAkiSUVDOTU4IFBsYXliYWNrIFN3aXRjaCIsCiAJIkxpbmUtT3V0IFBs
YXliYWNrIFN3aXRjaCIsCi0JIlBDTSBQbGF5YmFjayBTd2l0Y2giLAogCU5VTEwsCiB9OwogCi0t
IAoxLjYuMC42Cgo=
--00151747698065559604a3aef0ef
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00151747698065559604a3aef0ef--
