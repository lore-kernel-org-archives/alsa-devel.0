From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for ASUS M2V
Date: Mon, 31 May 2010 23:20:45 -0400
Message-ID: <AANLkTiloy_Xa4Hi7aRpMTVL9aAPTFt1raao8HC7o7v04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636ed62f88ab9260487ef7548
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE7BD24682
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 05:20:47 +0200 (CEST)
Received: by pwj9 with SMTP id 9so1943130pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 20:20:45 -0700 (PDT)
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

--001636ed62f88ab9260487ef7548
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master that resolves the
original reporter's symptom of the PulseAudio daemon crashing during
playback. Please apply.

This patch is applicable to all 2.6.3x stable series.

Best,
-Dan

--001636ed62f88ab9260487ef7548
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-ASUS-M2V.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-ASUS-M2V.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9w5uf8p0

RnJvbSAyMzI0NjNhNGFjZGRlYzQ5NzJhNGQ4YWU0MDVlNmNkMjU3YThjZTM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMzAgTWF5IDIwMTAgMTM6MDg6NDEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBBU1VTIE0yVgoKQnVnTGluazogaHR0cHM6Ly9sYXVuY2hwYWQu
bmV0L2J1Z3MvNTg3NTQ2CgpTeW1wdG9tOiBPbiB0aGUgcmVwb3J0ZXIncyBBU1VTIE0yViwgdXNp
bmcgUHVsc2VBdWRpbyBpbiBVYnVudHUgMTAuMDQgTFRTCnJlc3VsdHMgaW4gdGhlIFBBIGRhZW1v
biBjcmFzaGluZyBzaG9ydGx5IGFmdGVyIGF0dGVtcHRpbmcgcGxheWJhY2sgb2YgYW4KYXVkaW8g
ZmlsZS4KClRlc3QgY2FzZTogVXNpbmcgVWJ1bnR1IDEwLjA0IExUUyAoTGludXggMi42LjMyLjEy
KSwgTGludXggMi42LjMzLCBvcgpMaW51eCAyLjYuMzQsIGF0dGVtcHQgcGxheWJhY2sgb2YgYW4g
YXVkaW8gZmlsZSB3aGlsZSBQdWxzZUF1ZGlvIGlzCmFjdGl2ZS4KClJlc29sdXRpb246IGFkZCBT
U0lEIGZvciB0aGlzIG1hY2hpbmUgdG8gdGhlIHBvc2l0aW9uX2ZpeCBxdWlyayB0YWJsZSwKZXhw
bGljaXRseSBzcGVjaWZ5aW5nIHRoZSBMUElCIG1ldGhvZC4KClJlcG9ydGVkLWFuZC1UZXN0ZWQt
Qnk6IEQgVGFuZ21hbgpDYzogPHN0YWJsZUBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9oZGFfaW50
ZWwuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyBiL3NvdW5kL3Bj
aS9oZGEvaGRhX2ludGVsLmMKaW5kZXggMTY0MDAwNS4uZTQyYWI5OSAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCkBA
IC0yMjg5LDYgKzIyODksNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgcG9zaXRpb25f
Zml4X2xpc3RbXSBfX2RldmluaXRkYXRhID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDMw
NmQsICJIUCBkdjMiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDgx
M2QsICJBU1VTIFA1QUQyIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0Mywg
MHg4MWIzLCAiQVNVUyIsIFBPU19GSVhfTFBJQiksCisJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4
ODFlNywgIkFTVVMgTTJWIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0ZCwg
MHg5MDY5LCAiU29ueSBWUENTMTFWOUUiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUkso
MHgxMTA2LCAweDMyODgsICJBU1VTIE0yVi1NWCBTRSIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BD
SV9RVUlSSygweDExNzksIDB4ZmYxMCwgIlRvc2hpYmEgQTEwMC0yNTkiLCBQT1NfRklYX0xQSUIp
LAotLSAKMS43LjAuNAoK
--001636ed62f88ab9260487ef7548
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636ed62f88ab9260487ef7548--
