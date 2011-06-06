From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix quirk for Dell Inspiron 910
Date: Mon, 6 Jun 2011 19:08:08 -0400
Message-ID: <BANLkTikeQW-RPczZ++MqYh7ao7gVpFZUTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30025bd8405e4204a5132d8c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 953E42439E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 01:08:09 +0200 (CEST)
Received: by wwf26 with SMTP id 26so3329309wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2011 16:08:09 -0700 (PDT)
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

--20cf30025bd8405e4204a5132d8c
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 git HEAD that resolves inaudible
audio from internal speakers on the reporter's Dell Inspiron 910.
Please apply.

Cheers,
-Dan

--20cf30025bd8405e4204a5132d8c
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-quirk-for-Dell-Inspiron-910.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-quirk-for-Dell-Inspiron-910.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gom1611o0

RnJvbSBhZjYzMjA3MzQ5NDc2NTc1YTEzYWU2YTBhODMwM2FlNDVkNDVmNjgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IE1vbiwgNiBKdW4gMjAxMSAxODo1NTozNCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogRml4IHF1aXJrIGZvciBEZWxsIEluc3Bpcm9uIDkxMAoKQnVnTGluazogaHR0cHM6Ly9s
YXVuY2hwYWQubmV0L2J1Z3MvNzkyNzEyCgpUaGUgb3JpZ2luYWwgcmVwb3J0ZXIgc3RhdGVzIHRo
YXQgc291bmQgZnJvbSB0aGUgaW50ZXJuYWwgc3BlYWtlcnMgaXMKaW5hdWRpYmxlIHVudGlsIHVz
aW5nIHRoZSBtb2RlbD1hdXRvIHF1aXJrLiBUaGlzIHN5bXB0b20gaXMgZHVlIHRvIGFuCmV4aXN0
aW5nIHF1aXJrIG1hc2sgZm9yIDB4MTAyODAyYiogdGhhdCB1c2VzIHRoZSBtb2RlbD1kZWxsIHF1
aXJrLiBUbwpsaW1pdCB0aGUgcG9zc2libGUgcmVncmVzc2lvbnMsIGxlYXZlIHRoZSBleGlzdGlu
ZyBxdWlyayBtYXNrIGJ1dCBhZGQKYSBoaWdoZXIgcHJpb3JpdHkgc3BlY2lmaWMgbWFzayBmb3Ig
dGhlIHJlcG9ydGVyJ3MgUENJIFNTSUQuCgpSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiByb2RuaSBo
aXBwCkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+IFsyLjYuMzgrXQpTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggNWM4YTRlYS4uODE4NzMyMCAxMDA2
NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKQEAgLTEzODYxLDYgKzEzODYxLDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzI2OF9jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygw
eDEwMjUsIDB4MDE1YiwgIkFjZXIgQXNwaXJlIE9uZSIsCiAJCQkJCQlBTEMyNjhfQUNFUl9BU1BJ
UkVfT05FKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwMjUzLCAiRGVsbCBPRU0iLCBBTEMy
NjhfREVMTCksCisJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDJiMCwgIkRlbGwgSW5zcGlyb24g
OTEwIiwgQUxDMjY4X0FVVE8pLAogCVNORF9QQ0lfUVVJUktfTUFTSygweDEwMjgsIDB4ZmZmMCwg
MHgwMmIwLAogCQkJIkRlbGwgSW5zcGlyb24gTWluaTkvVm9zdHJvIEE5MCIsIEFMQzI2OF9ERUxM
KSwKIAkvKiBhbG1vc3QgY29tcGF0aWJsZSB3aXRoIHRvc2hpYmEgYnV0IHdpdGggb3B0aW9uYWwg
ZGlnaXRhbCBvdXRzOwotLSAKMS43LjUuMwoK
--20cf30025bd8405e4204a5132d8c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf30025bd8405e4204a5132d8c--
