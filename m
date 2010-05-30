From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for another mainboard
Date: Sun, 30 May 2010 19:38:19 -0400
Message-ID: <AANLkTil6znQbBPDgpSc_-vqapn1lfGr3kGXxGyXYgIu7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0a76e3b189e0487d83c27
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 357FE246D8
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 01:38:21 +0200 (CEST)
Received: by pxi3 with SMTP id 3so1375975pxi.38
	for <alsa-devel@alsa-project.org>; Sun, 30 May 2010 16:38:20 -0700 (PDT)
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

--001636e0a76e3b189e0487d83c27
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against my latest LPIB patches that makes the
original reporter's playback and capture audible by default. Please
apply.

This patch is applicable to all 2.6.3x stable series.

Best,
-Dan

--001636e0a76e3b189e0487d83c27
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-ALSA-hda-Use-LPIB-for-another-mainboard.patch"
Content-Disposition: attachment;
	filename="0002-ALSA-hda-Use-LPIB-for-another-mainboard.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9uif5cc0

RnJvbSA0Yzc4MWI3MmY1Y2Q3YjM3OWQzZTNhYTgxOGVkZmU5MzY5YTAxMDBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMzAgTWF5IDIwMTAgMTk6MzE6NDEgLTA0MDAKU3ViamVjdDogW1BBVENIIDIvMl0g
QUxTQTogaGRhOiBVc2UgTFBJQiBmb3IgYW5vdGhlciBtYWluYm9hcmQKCkJ1Z0xpbms6IGh0dHBz
Oi8vbGF1bmNocGFkLm5ldC9idWdzLzU4MDc0OQoKU3ltcHRvbTogb24gdGhlIG9yaWdpbmFsIHJl
cG9ydGVyJ3MgVklBIFZUMTcwOC1iYXNlZCBib2FyZCwgdGhlClB1bHNlQXVkaW8gZGFlbW9uIGRp
ZXMgc2hvcnRseSBhZnRlciB0aGUgdXNlciBhdHRlbXB0cyB0byBwbGF5IGFuIGF1ZGlvCmZpbGUu
CgpUZXN0IGNhc2U6IGJvb3QgZnJvbSBVYnVudHUgMTAuMDQgTFRTIGxpdmUgY2Q7IGF0dGVtcHQg
dG8gcGxheSBhbiBhdWRpbwpmaWxlLgoKUmVzb2x1dGlvbjogYWRkIFNTSUQgZm9yIHRoZSBvcmln
aW5hbCByZXBvcnRlcidzIGhhcmR3YXJlIHRvIHRoZQpwb3NpdGlvbl9maXggcXVpcmsgdGFibGUs
IGV4cGxpY2l0bHkgc3BlY2lmeWluZyB0aGUgTFBJQiBtZXRob2QuCgpSZXBvcnRlZC1hbmQtVGVz
dGVkLUJ5OiBIYXJhbGQKQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFu
aWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2lu
dGVsLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9w
Y2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IGRjNzk1NjQuLjhmM2E4ZGQgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpA
QCAtMjI5Niw2ICsyMjk2LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIHBvc2l0aW9u
X2ZpeF9saXN0W10gX19kZXZpbml0ZGF0YSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTQ2MiwgMHgx
MDAyLCAiTVNJIFdpbmQgVTExNSIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDE1
NjUsIDB4ODIwZiwgIkJpb3N0YXIgTWljcm90ZWNoIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJ
X1FVSVJLKDB4MTU2NSwgMHg4MjE4LCAiQmlvc3RhciBNaWNyb3RlY2giLCBQT1NfRklYX0xQSUIp
LAorCVNORF9QQ0lfUVVJUksoMHgxODQ5LCAweDA4ODgsICI3NzVEdWFsLVZTVEEiLCBQT1NfRklY
X0xQSUIpLAogCVNORF9QQ0lfUVVJUksoMHg4MDg2LCAweDI1MDMsICJERzk2NU9UIEFBRDYzNzMz
LTIwMyIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDgwODYsIDB4ZDYwMSwgImVN
YWNoaW5lcyBUNTIxMiIsIFBPU19GSVhfTFBJQiksCiAJe30KLS0gCjEuNy4wLjQKCg==
--001636e0a76e3b189e0487d83c27
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0a76e3b189e0487d83c27--
