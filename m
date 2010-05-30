From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use mbp31 quirk for an iMac model
Date: Sun, 30 May 2010 10:02:57 -0400
Message-ID: <AANLkTilBxctBVkkyQd1vexXn3JzLWofHPUL5a4IOjOx4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e90a21822f750487d0320a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 713EA24565
	for <alsa-devel@alsa-project.org>;
	Sun, 30 May 2010 16:02:58 +0200 (CEST)
Received: by pzk40 with SMTP id 40so1572285pzk.23
	for <alsa-devel@alsa-project.org>; Sun, 30 May 2010 07:02:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e90a21822f750487d0320a
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master enabling audible playback
and capture for the original reporter's iMac. Please apply.

This patch is applicable to all 2.6.3x stable series.

Best,
-Dan

--001636e90a21822f750487d0320a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-mbp31-quirk-for-an-iMac-model.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-mbp31-quirk-for-an-iMac-model.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9txw9580

RnJvbSA2ZTAyNjFkNWZiMDY0ODI5OTc4OTc2YjYzOWU5NGVjZjFmOTYzNzZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMzAgTWF5IDIwMTAgMDk6NTU6MjMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBtYnAzMSBxdWlyayBmb3IgYW4gaU1hYyBtb2RlbAoKQnVnTGluazogaHR0cHM6
Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNTQyNTUwCgpTeW1wdG9tOiBPbiB0aGUgcmVwb3J0ZXIncyBp
TWFjLCBpbiBVYnVudHUgMTAuMDQgTFRTIG5laXRoZXIgcGxheWJhY2sKbm9yIGNhcHR1cmUgYXBw
ZWFyIGF1ZGlibGUgb3V0LW9mLXRoZS1ib3guCgpUZXN0IGNhc2U6IEJvb3QgZnJvbSBhbiBVYnVu
dHUgMTAuMDQgTFRTIGxpdmUgY2Qgb3IgZnJvbSBhbiBpbnN0YWxsZWQKY29uZmlndXJhdGlvbiBh
bmQgYXR0ZW1wdCB0byBwbGF5IG9yIGNhcHR1cmUgYXVkaW8uCgpSZXNvbHV0aW9uOiBTcGVjaWZ5
IHRoZSBtYnAzMSBxdWlyayBmb3IgdGhpcyBtYWNoaW5lIGluIHRoZSBjb2RlYyBTU0lECnRhYmxl
LgoKUmVwb3J0ZWQtYW5kLVRlc3RlZC1CeTogZjNhOTcKQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4K
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDE3
ZDQ1NDguLmQ3OTJjZGQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5j
CisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC05NDc2LDYgKzk0NzYsNyBA
QCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgyX3NzaWRfY2ZnX3RibFtdID0gewog
CVNORF9QQ0lfUVVJUksoMHgxMDZiLCAweDEwMDAsICJpTWFjIDI0IiwgQUxDODg1X0lNQUMyNCks
CiAJU05EX1BDSV9RVUlSSygweDEwNmIsIDB4MjgwMCwgIkFwcGxlVFYiLCBBTEM4ODVfSU1BQzI0
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgyYzAwLCAiTWFjYm9va1BybyByZXYzIiwgQUxD
ODg1X01CUDMpLAorCVNORF9QQ0lfUVVJUksoMHgxMDZiLCAweDMwMDAsICJpTWFjIiwgQUxDODg5
QV9NQjMxKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgzNjAwLCAiTWFjYm9vayAzLDEiLCBB
TEM4ODlBX01CMzEpLAogCVNORF9QQ0lfUVVJUksoMHgxMDZiLCAweDM4MDAsICJNYWNib29rUHJv
IDQsMSIsIEFMQzg4NV9NQlAzKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgzZTAwLCAiaU1h
YyAyNCBBbHVtaW51bSIsIEFMQzg4NV9JTUFDMjQpLAotLSAKMS43LjAuNAoK
--001636e90a21822f750487d0320a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e90a21822f750487d0320a--
