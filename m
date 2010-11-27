From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use BIOS auto-parsing instead of
 existing model quirk for MEDION MD2
Date: Sat, 27 Nov 2010 14:12:06 -0500
Message-ID: <AANLkTik8fBTwMo=7vyFU1Z6OxGREwqvvrCU9s3ctf1Dv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00221597499e634e6b04960d9d9d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 82AF724501
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 20:12:06 +0100 (CET)
Received: by wyi11 with SMTP id 11so3050786wyi.38
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 11:12:06 -0800 (PST)
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

--00221597499e634e6b04960d9d9d
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6.git master HEAD that
resolves a regression from 2.6.32 for the user's machine.  Briefly,
the existing quirk entry, ALC883_MEDION_MD2, is no longer necessary
for the user's machine; we can use BIOS auto-parsing successfully.
Please apply.

Thanks,
-Dan

--00221597499e634e6b04960d9d9d
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-BIOS-auto-parsing-instead-of-existing-m.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-BIOS-auto-parsing-instead-of-existing-m.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh0vlncb0

RnJvbSA1NTUzMjBiYzk3ZjQzYzMyNDAwMWY2N2NiNmMyNjFmMzM5NTRkZjcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMjcgTm92IDIwMTAgMTM6NTg6MDQgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBCSU9TIGF1dG8tcGFyc2luZyBpbnN0ZWFkIG9mIGV4aXN0aW5nIG1vZGVsIHF1
aXJrIGZvciBNRURJT04gTUQyCgpCdWdMaW5rOiBodHRwczovL2xhdW5jaHBhZC5uZXQvYnVncy82
ODIxOTkKCkEgMi42LjM1IChVYnVudHUgTWF2ZXJpY2spIHVzZXIsIGJ1cm5pbmdwaGFudG9tMSwg
cmVwb3J0ZWQgYSByZWdyZXNzaW9uCmluIGF1ZGlvOiBwbGF5YmFjayB3YXMgaW5hdWRpYmxlIHRo
cm91Z2ggYm90aCBzcGVha2VycyBhbmQgaGVhZHBob25lcy4KSW4gY29tbWl0IDI3MmE1MjdjMDQg
b2Ygc291bmQtMi42LmdpdCwgYSBuZXcgbW9kZWwgd2FzIGFkZGVkIHdpdGggdGhpcwptYWNoaW5l
J3MgUENJIFNTSUQuICBGb3J0dW5hdGVseSwgaXQgaXMgbm93IHN1ZmZpY2llbnQgdG8gdXNlIHRo
ZSBhdXRvCm1vZGVsIGZvciBCSU9TIGF1dG8tcGFyc2luZyBpbnN0ZWFkIG9mIHRoZSBleGlzdGlu
ZyBxdWlyay4KClBsYXliYWNrLCBjYXB0dXJlLCBhbmQgamFjayBzZW5zZSB3ZXJlIHZlcmlmaWVk
IHdvcmtpbmcgZm9yIGJvdGgKMi42LjM1IGFuZCB0aGUgYWxzYS1kcml2ZXIgc25hcHNob3QgZnJv
bSAyMDEwLTExLTI3IHdoZW4gbW9kZWw9YXV0byBpcwp1c2VkLgoKUmVwb3J0ZWQtYW5kLXRlc3Rl
ZC1ieTogYnVybmluZ3BoYW50b20xCkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+IFsyLjYuMzUrXQpT
aWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgfCAgICAxIC0KIDEgZmlsZXMgY2hhbmdlZCwgMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggOTVi
MTM4ZC4uZjBhZjhjZiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
KysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTk4NzQsNyArOTg3NCw2IEBA
IHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM4ODJfY2ZnX3RibFtdID0gewogCVNORF9Q
Q0lfUVVJUksoMHgxN2FhLCAweDNiZmMsICJMZW5vdm8gTkIwNzYzIiwgQUxDODgzX0xFTk9WT19O
QjA3NjMpLAogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDNiZmQsICJMZW5vdm8gTkIwNzYzIiwg
QUxDODgzX0xFTk9WT19OQjA3NjMpLAogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDEwMWQsICJM
ZW5vdm8gU2t5IiwgQUxDODg4X0xFTk9WT19TS1kpLAotCVNORF9QQ0lfUVVJUksoMHgxN2MwLCAw
eDQwNzEsICJNRURJT04gTUQyIiwgQUxDODgzX01FRElPTl9NRDIpLAogCVNORF9QQ0lfUVVJUkso
MHgxN2MwLCAweDQwODUsICJNRURJT04gTUQ5NjYzMCIsIEFMQzg4OF9MRU5PVk9fTVM3MTk1X0RJ
RyksCiAJU05EX1BDSV9RVUlSSygweDE3ZjIsIDB4NTAwMCwgIkFsYmF0cm9uIEtJNjkwLUFNMiIs
IEFMQzg4M182U1RfRElHKSwKIAlTTkRfUENJX1FVSVJLKDB4MTk5MSwgMHg1NjI1LCAiSGFpZXIg
VzY2IiwgQUxDODgzX0hBSUVSX1c2NiksCi0tIAoxLjcuMQoK
--00221597499e634e6b04960d9d9d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00221597499e634e6b04960d9d9d--
