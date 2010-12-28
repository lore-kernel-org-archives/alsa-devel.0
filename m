From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB quirk for Dell Inspiron
	m101z/1120
Date: Tue, 28 Dec 2010 17:26:56 -0500
Message-ID: <AANLkTiktj+mFtVMd+RbzQeyM-29XS_hxb3od-NJmH_vk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016367b5e7048edb504987ff33d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CBCA24618
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 23:26:58 +0100 (CET)
Received: by wwe15 with SMTP id 15so9547597wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 14:26:56 -0800 (PST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0016367b5e7048edb504987ff33d
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against master HEAD resolving capture anomalies on
Sjoerd's Dell Inspiron m101z.

Thanks,
-Dan

--0016367b5e7048edb504987ff33d
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-quirk-for-Dell-Inspiron-m101z-1120.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-quirk-for-Dell-Inspiron-m101z-1120.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gi9d8lvh0

RnJvbSA3ZTU0ZWVjOWVhNGU0ZTg4ODRkNDUyMjFmYjUyZDQ1NTUwNmExZWY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFR1ZSwgMjggRGVjIDIwMTAgMTc6MjA6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIHF1aXJrIGZvciBEZWxsIEluc3Bpcm9uIG0xMDF6LzExMjAKClNqb2Vy
ZCBTaW1vbnMgcmVwb3J0cyB0aGF0LCB3aXRob3V0IHVzaW5nIHBvc2l0aW9uX2ZpeD0xLCByZWNv
cmRpbmcKZXhwZXJpZW5jZXMgb3ZlcnJ1bnMuIFdvcmsgYXJvdW5kIHRoYXQgYnkgYXBwbHlpbmcg
dGhlIExQSUIgcXVpcmsKZm9yIGhpcyBoYXJkd2FyZS4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6
IFNqb2VyZCBTaW1vbnMgPHNqb2VyZEBkZWJpYW4ub3JnPgpDYzogPHN0YWJsZUBrZXJuZWwub3Jn
PgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQog
c291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9o
ZGFfaW50ZWwuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKaW5kZXggZDllMTRmMS4uZDNk
MThiZSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9zb3VuZC9w
Y2kvaGRhL2hkYV9pbnRlbC5jCkBAIC0yMzAzLDYgKzIzMDMsNyBAQCBzdGF0aWMgc3RydWN0IHNu
ZF9wY2lfcXVpcmsgcG9zaXRpb25fZml4X2xpc3RbXSBfX2RldmluaXRkYXRhID0gewogCVNORF9Q
Q0lfUVVJUksoMHgxMDI4LCAweDAxY2MsICJEZWxsIEQ4MjAiLCBQT1NfRklYX0xQSUIpLAogCVNO
RF9QQ0lfUVVJUksoMHgxMDI4LCAweDAxZGUsICJEZWxsIFByZWNpc2lvbiAzOTAiLCBQT1NfRklY
X0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDAxZjYsICJEZWxsIExhdGl0dWRlIDEz
MUwiLCBQT1NfRklYX0xQSUIpLAorCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAweDA0NzAsICJEZWxs
IEluc3Bpcm9uIDExMjAiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAw
eDMwNmQsICJIUCBkdjMiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAw
eDgxM2QsICJBU1VTIFA1QUQyIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0
MywgMHg4MWIzLCAiQVNVUyIsIFBPU19GSVhfTFBJQiksCi0tIAoxLjcuMQoK
--0016367b5e7048edb504987ff33d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016367b5e7048edb504987ff33d--
