From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for an ASUS device
Date: Sun, 30 May 2010 01:24:23 -0400
Message-ID: <AANLkTikHAgZHU-1SVCXDSfYk7A7o2fnjISIz8_Rr-pxn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cc48fd4a770487c8f30b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ADE4103807
	for <alsa-devel@alsa-project.org>;
	Sun, 30 May 2010 07:24:24 +0200 (CEST)
Received: by pzk40 with SMTP id 40so1393360pzk.23
	for <alsa-devel@alsa-project.org>; Sat, 29 May 2010 22:24:23 -0700 (PDT)
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

--00504502cc48fd4a770487c8f30b
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master that enables the original
reporter to adjust capture volume through PulseAudio without the
daemon crashing.

This patch is applicable to all 2.6.3x stable series.

Best,
-Dan

--00504502cc48fd4a770487c8f30b
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-an-ASUS-device.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-an-ASUS-device.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9tfctfp0

RnJvbSBiNWViZDQyNWRhOTc2Zjc4NDhlY2Y2YzNmN2M2NWYwNWVkYjI5N2U3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMzAgTWF5IDIwMTAgMDE6MTc6MDMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBhbiBBU1VTIGRldmljZQoKQnVnTGluazogaHR0cHM6Ly9sYXVu
Y2hwYWQubmV0L2J1Z3MvNDY1OTQyCgpTeW1wdG9tOiBPbiB0aGUgcmVwb3J0ZXIncyBBU1VTIGRl
dmljZSwgdXNpbmcgUHVsc2VBdWRpbyBpbiBVYnVudHUgMTAuMDQKTFRTIHJlc3VsdHMgaW4gdGhl
IFBBIGRhZW1vbiBjcmFzaGluZyBzaG9ydGx5IGFmdGVyIGF0dGVtcHRpbmcgdG8gc2VsZWN0CmNh
cHR1cmUgb3IgdG8gY29uZmlndXJlIHRoZSBhdWRpbyBoYXJkd2FyZSBwcm9maWxlLgoKVGVzdCBj
YXNlOiBVc2luZyBVYnVudHUgMTAuMDQgTFRTIChMaW51eCAyLjYuMzIuMTIpLCBMaW51eCAyLjYu
MzMsIG9yCkxpbnV4IDIuNi4zNCwgYWRqdXN0IHRoZSBIREEgZGV2aWNlJ3MgY2FwdHVyZSB2b2x1
bWUgd2l0aCBQdWxzZUF1ZGlvLgoKUmVzb2x1dGlvbjogYWRkIFNTSUQgZm9yIHRoaXMgbWFjaGlu
ZSB0byB0aGUgcG9zaXRpb25fZml4IHF1aXJrIHRhYmxlLApleHBsaWNpdGx5IHNwZWNpZnlpbmcg
dGhlIExQSUIgbWV0aG9kLgoKUmVwb3J0ZWQtYW5kLVRlc3RlZC1CeTogSXJpaGFwZXRpCkNjOiA8
c3RhYmxlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5A
dWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIHwgICAgMSArCiAxIGZp
bGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpp
bmRleCBkYzc5NTY0Li43YzU0YTQwIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRl
bC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTIyODgsNiArMjI4OCw3IEBA
IHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBwb3NpdGlvbl9maXhfbGlzdFtdIF9fZGV2aW5p
dGRhdGEgPSB7CiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDFmNiwgIkRlbGwgTGF0aXR1ZGUg
MTMxTCIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MzA2ZCwgIkhQ
IGR2MyIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4ODEzZCwgIkFT
VVMgUDVBRDIiLCBQT1NfRklYX0xQSUIpLAorCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDgxYjMs
ICJBU1VTIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0ZCwgMHg5MDY5LCAi
U29ueSBWUENTMTFWOUUiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxMTA2LCAw
eDMyODgsICJBU1VTIE0yVi1NWCBTRSIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygw
eDExNzksIDB4ZmYxMCwgIlRvc2hpYmEgQTEwMC0yNTkiLCBQT1NfRklYX0xQSUIpLAotLSAKMS43
LjAuNAoK
--00504502cc48fd4a770487c8f30b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502cc48fd4a770487c8f30b--
