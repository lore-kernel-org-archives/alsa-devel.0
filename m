From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] - ALSA emu10k1 - Remove "Front Playback
 Volume" and "Front Playback Switch" only for STAC9758/59
Date: Fri, 15 Apr 2011 13:16:54 +0800
Message-ID: <BANLkTimpfWh7rwz4u7tgi5THWYKGsUQBJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a59f78f34c04a0ee26da
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 547EB243E9
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 07:16:55 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1941711fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2011 22:16:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Rolf Stefan Wilke <stefan.wilke@uni-ulm.de>, Mikael Magnusson <mikma@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--20cf3054a59f78f34c04a0ee26da
Content-Type: text/plain; charset=ISO-8859-1

Remove "Front Playback Volume" and "Front Playback Switch" from emu10k1 only
for STAC9758/59

Since commit 7eae36fbd5ea9db3d3fe0d671199121be782a5b3 "Fix the confliction
of 'Front' control"

The "Front Playback Volume" control created by commit
edf8e4565c44bffbb4d09e8984df941d0ae9e6e8
"emu10k1: Front channels via fxbus 8 and 9" was removed

"Front Playback Volume" and "Surround Playback Volume" have same dB range
since I2S DAC of SB Live! and SB Live! Platinum does not has any hardware
volume control


The remain problem is how to solve the lock when applications such as
"pulseaudio"  use "front" device for playback and capture at same time since
"EMU10K1 PCM Send Volume" is locked


aplay -v -Dfront:0 any.wav
Playing WAVE 'any.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Hooks PCM



 arecord -v -f cd -Dfront:0 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
ALSA lib setup.c:96:(snd_sctl_install) Cannot lock ctl elem EMU10K1 PCM Send
Volume
arecord: set_params:1123: Unable to install hw params:

--20cf3054a59f78f34c04a0ee26da
Content-Type: application/octet-stream;
	name="0001-Remove-Front-Playback-Volume-and-Front-Playback-Switch.patch"
Content-Disposition: attachment;
	filename="0001-Remove-Front-Playback-Volume-and-Front-Playback-Switch.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmildfj70

RnJvbSBlYTk5ODY0ODljY2ZmYTA4MGIzYzkyZmE3YzM0NjA0MjZkMDk5NmNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDE1IEFwciAyMDExIDExOjQyOjQyICswODAwClN1YmplY3Q6IFtQQVRD
SCBBTFNBIC0gZW11MTBrMSAzLzNdIFJlbW92ZSAiRnJvbnQgUGxheWJhY2sgVm9sdW1lIiBhbmQg
IkZyb250IFBsYXliYWNrIFN3aXRjaCIgb25seSBmb3IgU1RBQzk3NTgvNTkKCgpTaWduZWQtb2Zm
LWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlmZiAtLWdp
dCBhL3NvdW5kL3BjaS9lbXUxMGsxL2VtdW1peGVyLmMgYi9zb3VuZC9wY2kvZW11MTBrMS9lbXVt
aXhlci5jCmluZGV4IDA1YWZlMDYuLmZmOGU1YWEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9lbXUx
MGsxL2VtdW1peGVyLmMKKysrIGIvc291bmQvcGNpL2VtdTEwazEvZW11bWl4ZXIuYwpAQCAtMTcy
OSw4ICsxNzI5LDYgQEAgaW50IF9fZGV2aW5pdCBzbmRfZW11MTBrMV9taXhlcihzdHJ1Y3Qgc25k
X2VtdTEwazEgKmVtdSwKIAkJIk1hc3RlciBNb25vIFBsYXliYWNrIFZvbHVtZSIsCiAJCSJQQ00g
T3V0IFBhdGggJiBNdXRlIiwKIAkJIk1vbm8gT3V0cHV0IFNlbGVjdCIsCi0JCSJGcm9udCBQbGF5
YmFjayBTd2l0Y2giLAotCQkiRnJvbnQgUGxheWJhY2sgVm9sdW1lIiwKIAkJIlN1cnJvdW5kIFBs
YXliYWNrIFN3aXRjaCIsCiAJCSJTdXJyb3VuZCBQbGF5YmFjayBWb2x1bWUiLAogCQkiQ2VudGVy
IFBsYXliYWNrIFN3aXRjaCIsCkBAIC0xODc5LDYgKzE4NzcsOCBAQCBpbnQgX19kZXZpbml0IHNu
ZF9lbXUxMGsxX21peGVyKHN0cnVjdCBzbmRfZW11MTBrMSAqZW11LAogCQkJCWVtdS0+cmVhcl9h
Yzk3ID0gMTsKIAkJCQlzbmRfZW11MTBrMV9wdHJfd3JpdGUoZW11LCBBQzk3U0xPVCwgMCwgQUM5
N1NMT1RfQ05UUnxBQzk3U0xPVF9MRkV8QUM5N1NMT1RfUkVBUl9MRUZUfEFDOTdTTE9UX1JFQVJf
UklHSFQpOwogCQkJCXNuZF9hYzk3X3dyaXRlX2NhY2hlKGVtdS0+YWM5NywgQUM5N19IRUFEUEhP
TkUsIDB4MDIwMik7CisJCQkJcmVtb3ZlX2N0bChjYXJkLCJGcm9udCBQbGF5YmFjayBWb2x1bWUi
KTsKKwkJCQlyZW1vdmVfY3RsKGNhcmQsIkZyb250IFBsYXliYWNrIFN3aXRjaCIpOwogCQkJfQog
CQkJLyogcmVtb3ZlIHVudXNlZCBBQzk3IGNvbnRyb2xzICovCiAJCQlzbmRfYWM5N193cml0ZV9j
YWNoZShlbXUtPmFjOTcsIEFDOTdfU1VSUk9VTkRfTUFTVEVSLCAweDAyMDIpOwotLSAKMS42LjAu
NgoK
--20cf3054a59f78f34c04a0ee26da
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf3054a59f78f34c04a0ee26da--
