From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB and 6stack-dig for
	eMachines T5212
Date: Mon, 15 Mar 2010 15:33:07 -0400
Message-ID: <604760771003151233t2041ef50webb6ea8b41694fa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636d34bfe5c5f930481dbf33d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DBEC7103810
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 20:33:08 +0100 (CET)
Received: by pvg12 with SMTP id 12so1475576pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 12:33:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org, reuben.e.bailey@gmail.com
List-Id: alsa-devel@alsa-project.org

--001636d34bfe5c5f930481dbf33d
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD (applicable
also to 2.6.32.10 and 2.6.33.1) that corrects the model quirk for the
OR's machine and adds the LPIB quirk.

Best,
-Dan

--001636d34bfe5c5f930481dbf33d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-and-6stack-dig-for-eMachines-T5212.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-and-6stack-dig-for-eMachines-T5212.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6to6io90

RnJvbSAwZDMwNjI2NTE0OWVlNTdhNDYwZjhhY2I1ZGIzYWUyMTFkOTcyOGE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMTQgTWFyIDIwMTAgMjM6NDQ6MDMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGFuZCA2c3RhY2stZGlnIGZvciBlTWFjaGluZXMgVDUyMTIKCkJ1Z0xp
bms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvNTM4ODk1CgpUaGUgT1IgaGFzIHZl
cmlmaWVkIHRoYXQgYm90aCBwb3NpdGlvbl9maXg9MSBhbmQgbW9kZWw9NnN0YWNrLWRpZyBhcmUK
bmVjZXNzYXJ5IHRvIGhhdmUgY2FwdHVyZSBmdW5jdGlvbiBwcm9wZXJseS4gKFRoZSBleGlzdGlu
ZyAzc3RhY2stNmNoCm1vZGVsIHF1aXJrIHNlZW1zIHRvIGJlIGluY29ycmVjdC4pCgpSZXBvcnRl
ZC1ieTogUmV1YmVuIEJhaWxleSA8cmV1YmVuLmUuYmFpbGV5QGdtYWlsLmNvbT4KVGVzdGVkLWJ5
OiBSZXViZW4gQmFpbGV5IDxyZXViZW4uZS5iYWlsZXlAZ21haWwuY29tPgpDYzogPHN0YWJsZUBr
ZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5j
b20+Ci0tLQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyAgICAgfCAgICAxICsKIHNvdW5kL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFf
aW50ZWwuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKaW5kZXggMGY0NGE0Zi4uOGIyOTE1
NiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9zb3VuZC9wY2kv
aGRhL2hkYV9pbnRlbC5jCkBAIC0yMjcxLDYgKzIyNzEsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9w
Y2lfcXVpcmsgcG9zaXRpb25fZml4X2xpc3RbXSBfX2RldmluaXRkYXRhID0gewogCVNORF9QQ0lf
UVVJUksoMHgxMDQzLCAweDgxM2QsICJBU1VTIFA1QUQyIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRf
UENJX1FVSVJLKDB4MTQ2MiwgMHgxMDAyLCAiTVNJIFdpbmQgVTExNSIsIFBPU19GSVhfTFBJQiks
CiAJU05EX1BDSV9RVUlSSygweDE1NjUsIDB4ODIwZiwgIkJpb3N0YXIgTWljcm90ZWNoIiwgUE9T
X0ZJWF9MUElCKSwKKwlTTkRfUENJX1FVSVJLKDB4ODA4NiwgMHhkNjAxLCAiZU1hY2hpbmVzIFQ1
MjEyIiwgUE9TX0ZJWF9MUElCKSwKIAl7fQogfTsKIApkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCAw
NzYzN2M0Li40ZWM1NzYzIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtOTIzNyw3ICs5MjM3LDcg
QEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzg4Ml9jZmdfdGJsW10gPSB7CiAJU05E
X1BDSV9RVUlSSygweDgwODYsIDB4MDAyMiwgIkRYNThTTyIsIEFMQzg4OV9JTlRFTCksCiAJU05E
X1BDSV9RVUlSSygweDgwODYsIDB4MDAyMSwgIkludGVsIEliZXhQZWFrIiwgQUxDODg5QV9JTlRF
TCksCiAJU05EX1BDSV9RVUlSSygweDgwODYsIDB4M2I1NiwgIkludGVsIEliZXhQZWFrIiwgQUxD
ODg5QV9JTlRFTCksCi0JU05EX1BDSV9RVUlSSygweDgwODYsIDB4ZDYwMSwgIkQxMDJHR0MiLCBB
TEM4ODNfM1NUXzZjaCksCisJU05EX1BDSV9RVUlSSygweDgwODYsIDB4ZDYwMSwgIkQxMDJHR0Mi
LCBBTEM4ODJfNlNUX0RJRyksCiAKIAl7fQogfTsKLS0gCjEuNy4wCgo=
--001636d34bfe5c5f930481dbf33d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636d34bfe5c5f930481dbf33d--
