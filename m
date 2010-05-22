From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for Toshiba A100-259
Date: Sat, 22 May 2010 13:25:26 -0400
Message-ID: <AANLkTikdfY6kUNYqlXCKRgUjystXVoPyYqviryMCrHjk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0b9c9f07e31048732176b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0A3052499D
	for <alsa-devel@alsa-project.org>;
	Sat, 22 May 2010 19:25:27 +0200 (CEST)
Received: by pwj9 with SMTP id 9so1006994pwj.38
	for <alsa-devel@alsa-project.org>; Sat, 22 May 2010 10:25:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, davide.molteni@gmail.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0b9c9f07e31048732176b
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch for sound-2.6 based on my previous patch
(ALSA: hda: Use LPIB for Acer Aspire 5110) specifying the LPIB quirk
for an additional SSID to make capture work correctly in an installed
distribution.

This patch is applicable to 2.6.32, 2.6.33, and 2.6.34 stable trees
(some with fuzz).

Best,
-Dan

--001636e0b9c9f07e31048732176b
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-Toshiba-A100-259.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-Toshiba-A100-259.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9ipjhso0

RnJvbSBjNDA2MWU1MzcwZGQ0N2MxNzJkNTViY2NmMWE4NmYwYzQ0NTJiN2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMjIgTWF5IDIwMTAgMTM6MTI6MjIgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBUb3NoaWJhIEExMDAtMjU5CgpCdWdMaW5rOiBodHRwczovL2xh
dW5jaHBhZC5uZXQvYnVncy81NDk1NjAKClN5bXB0b206IG9uIGEgc2lnbmlmaWNhbnQgbnVtYmVy
IG9mIGhhcmR3YXJlLCBib290aW5nIGZyb20gYSBsaXZlIGNkCnJlc3VsdHMgaW4gY2FwdHVyZSB3
b3JraW5nIGNvcnJlY3RseSwgYnV0IG9uY2UgdGhlIGRpc3RyaWJ1dGlvbiBpcwppbnN0YWxsZWQs
IGJvb3RpbmcgZnJvbSB0aGUgaW5zdGFsbCByZXN1bHRzIGluIGNhcHR1cmUgbm90IHdvcmtpbmcu
CgpUZXN0IGNhc2U6IGJvb3QgZnJvbSBVYnVudHUgMTAuMDQgTFRTIGxpdmUgY2Q7IGNhcHR1cmUg
d29ya3MgY29ycmVjdGx5LgpJbnN0YWxsIHRvIEhEIGFuZCByZWJvb3Q7IGNhcHR1cmUgZG9lcyBu
b3Qgd29yay4gUmVwcm9kdWNlZCB3aXRoIDIuNi4zMgptYWlubGluZSBidWlsZCAodmFuaWxsYSBr
ZXJuZWwub3JnIGNvbXBpbGUpCgpSZXNvbHV0aW9uOiBhZGQgU1NJRCBmb3IgVG9zaGliYSBBMTAw
LTI1OSB0byB0aGUgcG9zaXRpb25fZml4IHF1aXJrCnRhYmxlLCBleHBsaWNpdGx5IHNwZWNpZnlp
bmcgdGhlIExQSUIgbWV0aG9kLgoKSSdsbCBiZSBzZW5kaW5nIGFkZGl0aW9uYWwgcGF0Y2hlcyBm
b3IgdGhlc2UgU1NJRHMgYXMgYnVnIHJlcG9ydHMgYXJlCmNvbmZpcm1lZC4KClRoaXMgcGF0Y2gg
YWxzbyB0cml2aWFsbHkgc29ydHMgdGhlIHF1aXJrIHRhYmxlIGluIGFzY2VuZGluZyBvcmRlciBi
eQpzdWJzeXN0ZW0gdmVuZG9yLgoKUmVwb3J0ZWQtYW5kLVRlc3RlZC1ieTogPGRhdmlkZS5tb2x0
ZW5pQGdtYWlsLmNvbT4KQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFu
aWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2lu
dGVsLmMgfCAgICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyBiL3NvdW5k
L3BjaS9oZGEvaGRhX2ludGVsLmMKaW5kZXggZWM1NTRmYy4uMTRkODk1YiAxMDA2NDQKLS0tIGEv
c291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5j
CkBAIC0yMjg0LDggKzIyODQsOSBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgcG9zaXRp
b25fZml4X2xpc3RbXSBfX2RldmluaXRkYXRhID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDI4LCAw
eDAxZGUsICJEZWxsIFByZWNpc2lvbiAzOTAiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJ
UksoMHgxMDI4LCAweDAxZjYsICJEZWxsIExhdGl0dWRlIDEzMUwiLCBQT1NfRklYX0xQSUIpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDMwNmQsICJIUCBkdjMiLCBQT1NfRklYX0xQSUIpLAot
CVNORF9QQ0lfUVVJUksoMHgxMTA2LCAweDMyODgsICJBU1VTIE0yVi1NWCBTRSIsIFBPU19GSVhf
TFBJQiksCiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4ODEzZCwgIkFTVVMgUDVBRDIiLCBQT1Nf
RklYX0xQSUIpLAorCVNORF9QQ0lfUVVJUksoMHgxMTA2LCAweDMyODgsICJBU1VTIE0yVi1NWCBT
RSIsIFBPU19GSVhfTFBJQiksCisJU05EX1BDSV9RVUlSSygweDExNzksIDB4ZmYxMCwgIlRvc2hp
YmEgQTEwMC0yNTkiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweGEw
MjIsICJnYS1tYTc3MC11ZDMiLCBQT1NfRklYX0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHgxNDYy
LCAweDEwMDIsICJNU0kgV2luZCBVMTE1IiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTU2NSwgMHg4MjBmLCAiQmlvc3RhciBNaWNyb3RlY2giLCBQT1NfRklYX0xQSUIpLAotLSAK
MS43LjAuNAoK
--001636e0b9c9f07e31048732176b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0b9c9f07e31048732176b--
