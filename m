From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix inaudible internal speakers on
 CyberpowerPC Gamer Xplorer N57001 laptop
Date: Wed, 8 Jun 2011 17:25:05 -0400
Message-ID: <BANLkTinHXyDWKQAEOWf9z1DhKj=XCmxUNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30025bd85e223c04a539f8a9
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 09A4F103974
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 23:25:06 +0200 (CEST)
Received: by wwf26 with SMTP id 26so768200wwf.20
	for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2011 14:25:05 -0700 (PDT)
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

--20cf30025bd85e223c04a539f8a9
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD that
resolves the original reporter's inaudible internal speakers by using
the model=asus quirk. Please apply.

Cheers,
-Dan

--20cf30025bd85e223c04a539f8a9
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-inaudible-internal-speakers-on-Cyberpow.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-inaudible-internal-speakers-on-Cyberpow.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gooscs770

RnJvbSBjZDllYzIzNTFkNDc5ODU2ZDgxNjY2ZjlkNjExZWQ2OTJjOGZjZWQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgOCBKdW4gMjAxMSAxNzoxNTo1MiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogRml4IGluYXVkaWJsZSBpbnRlcm5hbCBzcGVha2VycyBvbiBDeWJlcnBvd2VyUEMKIEdh
bWVyIFhwbG9yZXIgTjU3MDAxIGxhcHRvcAoKQnVnTGluazogaHR0cHM6Ly9sYXVuY2hwYWQubmV0
L2J1Z3MvNzYxMTcxCgpUaGUgb3JpZ2luYWwgcmVwb3J0ZXIgbmVlZHMgdGhlIG1vZGVsPWFzdXMg
cXVpcmsgZm9yIGhpcyBpbnRlcm5hbApzcGVha2VycyB0byBiZSBhdWRpYmxlLCBzbyBhZGQgYW4g
ZW50cnkgaW4gdGhlIHF1aXJrIHRhYmxlIGZvciBoaXMgUENJClNTSUQuCgpSZXBvcnRlZC1hbmQt
dGVzdGVkLWJ5OiB0b21kZWVyaW5nNwpDYzogPHN0YWJsZUBrZXJuZWwub3JnPiBbMi42LjM4K10K
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNv
dW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAx
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9wYXRjaF9jb25leGFudC5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCmluZGV4
IDIxN2NhOWUuLjYyOTdlMjMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhh
bnQuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKQEAgLTMxMDMsNiArMzEw
Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBjeHQ1MDY2X2NmZ190Ymxb
XSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzOGFmLCAiTGVub3ZvIEc1NjAiLCBDWFQ1
MDY2X0FTVVMpLAogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDM5MzgsICJMZW5vdm8gRzU2NSIs
IENYVDUwNjZfQVVUTyksCiAJU05EX1BDSV9RVUlSS19WRU5ET1IoMHgxN2FhLCAiTGVub3ZvIiwg
Q1hUNTA2Nl9JREVBUEFEKSwgLyogRmFsbGJhY2sgZm9yIExlbm92b3Mgd2l0aG91dCBkb2NrIG1p
YyAqLworCVNORF9QQ0lfUVVJUksoMHgxYjBhLCAweDIwOTIsICJDeWJlcnBvd2VyUEMgR2FtZXIg
WHBsb3JlciBONTcwMDEiLCBDWFQ1MDY2X0FTVVMpLAogCXt9CiB9OwogCi0tIAoxLjcuNS4zCgo=
--20cf30025bd85e223c04a539f8a9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf30025bd85e223c04a539f8a9--
