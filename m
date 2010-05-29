From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for a Shuttle device
Date: Sat, 29 May 2010 11:14:58 -0400
Message-ID: <AANLkTilAF7_JSrxjRxK2fjJO9_KQlTs2XwyMRMsVwhkB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0a80c40fa490487bd16e5
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E98FB1037F8
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 17:14:59 +0200 (CEST)
Received: by pvd12 with SMTP id 12so420008pvd.38
	for <alsa-devel@alsa-project.org>; Sat, 29 May 2010 08:14:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Christian Mehlis <mehlis@inf.fu-berlin.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0a80c40fa490487bd16e5
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch against current sound-2.6 master that
fixes audio anomalies and PulseAudio crashing by specifying LPIB
method explicitly. Please apply.

This patch is applicable to all 2.6.3x stable series.

Best,
-Dan

--001636e0a80c40fa490487bd16e5
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-a-Shuttle-device.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-a-Shuttle-device.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9sl07vn0

RnJvbSAzZjg4NDE4YjZkNDAwMjExNWRjNTljZmNmMTNiMDBlMTIxMzE5ZjljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMjkgTWF5IDIwMTAgMTE6MDQ6MTEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBhIFNodXR0bGUgZGV2aWNlCgpCdWdMaW5rOiBodHRwczovL2xh
dW5jaHBhZC5uZXQvYnVncy81NTE5NDkKClN5bXB0b206IE9uIHRoZSByZXBvcnRlcidzIFNodXR0
bGUgZGV2aWNlLCB1c2luZyBQdWxzZUF1ZGlvIGluIFVidW50dQoxMC4wNCBMVFMgcmVzdWx0cyBp
biAicG9wcGluZyBjbGlja2luZyIgYXVkaW8gd2l0aCB0aGUgUEEgY3Jhc2hpbmcKc2hvcnRseSB0
aGVyZWFmdGVyLgoKVGVzdCBjYXNlOiBVc2luZyBVYnVudHUgMTAuMDQgTFRTIChMaW51eCAyLjYu
MzIuMTIpLCBMaW51eCAyLjYuMzMsIG9yCkxpbnV4IDIuNi4zNCwgYWRqdXN0IHRoZSBIREEgZGV2
aWNlJ3Mgdm9sdW1lIHdpdGggUHVsc2VBdWRpby4KClJlc29sdXRpb246IGFkZCBTU0lEIGZvciB0
aGlzIG1hY2hpbmUgdG8gdGhlIHBvc2l0aW9uX2ZpeCBxdWlyayB0YWJsZSwKZXhwbGljaXRseSBz
cGVjaWZ5aW5nIHRoZSBMUElCIG1ldGhvZC4KClJlcG9ydGVkLWFuZC1UZXN0ZWQtQnk6IENocmlz
dGlhbiBNZWhsaXMgPG1laGxpc0BpbmYuZnUtYmVybGluLmRlPgpDYzogPHN0YWJsZUBrZXJuZWwu
b3JnPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0t
LQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAx
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9oZGFfaW50ZWwuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKaW5kZXggZTFmZjJiOC4u
ZGM3OTU2NCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9zb3Vu
ZC9wY2kvaGRhL2hkYV9pbnRlbC5jCkBAIC0yMjkxLDYgKzIyOTEsNyBAQCBzdGF0aWMgc3RydWN0
IHNuZF9wY2lfcXVpcmsgcG9zaXRpb25fZml4X2xpc3RbXSBfX2RldmluaXRkYXRhID0gewogCVNO
RF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwNjksICJTb255IFZQQ1MxMVY5RSIsIFBPU19GSVhfTFBJ
QiksCiAJU05EX1BDSV9RVUlSSygweDExMDYsIDB4MzI4OCwgIkFTVVMgTTJWLU1YIFNFIiwgUE9T
X0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTE3OSwgMHhmZjEwLCAiVG9zaGliYSBBMTAw
LTI1OSIsIFBPU19GSVhfTFBJQiksCisJU05EX1BDSV9RVUlSSygweDEyOTcsIDB4MzE2NiwgIlNo
dXR0bGUiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweGEwMjIsICJn
YS1tYTc3MC11ZDMiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxNDYyLCAweDEw
MDIsICJNU0kgV2luZCBVMTE1IiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTU2
NSwgMHg4MjBmLCAiQmlvc3RhciBNaWNyb3RlY2giLCBQT1NfRklYX0xQSUIpLAotLSAKMS43LjAu
NAoK
--001636e0a80c40fa490487bd16e5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0a80c40fa490487bd16e5--
