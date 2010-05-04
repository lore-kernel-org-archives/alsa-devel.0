From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use olpc-xo-1_5 quirk for Toshiba
	Satellite Pro T130-15F
Date: Mon, 3 May 2010 23:36:17 -0400
Message-ID: <t2m604760771005032036w7ecb21f8v130a3fb81342cc85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0a8f0815b6d0485bc69ee
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CAF52447C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 05:36:19 +0200 (CEST)
Received: by pzk40 with SMTP id 40so1536665pzk.23
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 20:36:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Andy Couldrake <acouldrake@googlemail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0a8f0815b6d0485bc69ee
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD that makes the OR's
machine have audible sound by default. Please apply.

Best,
-Dan

--001636e0a8f0815b6d0485bc69ee
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-olpc-xo-1_5-quirk-for-Toshiba-Satellite.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-olpc-xo-1_5-quirk-for-Toshiba-Satellite.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8s630fr0

RnJvbSA4MTRjMmE2NDg3MDFlNmQ2MDlkNmE3ZjE3MmRjMGRkZDA2OWVkYWUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IE1vbiwgMyBNYXkgMjAxMCAyMDozOTozMSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlIG9scGMteG8tMV81IHF1aXJrIGZvciBUb3NoaWJhIFNhdGVsbGl0ZSBQcm8gVDEz
MC0xNUYKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzU3MzI4NAoKVGhlIE9S
IHZlcmlmaWVkIHRoYXQgdXNpbmcgdGhlIG9scGMteG8tMV81IG1vZGVsIHF1aXJrIGFsbG93cyB0
aGUKaGVhZHBob25lcyB0byBiZSBhdWRpYmxlIHdoZW4gaW5zZXJ0ZWQgaW50byB0aGUgamFjay4g
Q2FwdHVyZSB3YXMKYWxzbyB2ZXJpZmllZCB0byB3b3JrIGNvcnJlY3RseS4KClJlcG9ydGVkLWJ5
OiBBbmR5IENvdWxkcmFrZSA8YWNvdWxkcmFrZUBnb29nbGVtYWlsLmNvbT4KVGVzdGVkLWJ5OiBB
bmR5IENvdWxkcmFrZSA8YWNvdWxkcmFrZUBnb29nbGVtYWlsLmNvbT4KQ2M6IDxzdGFibGVAa2Vy
bmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29t
PgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyB8ICAgIDEgKwogMSBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFu
dC5jCmluZGV4IDUwOWExMDQuLmZiNDJjMmEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfY29uZXhhbnQuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKQEAgLTI5
NjcsNiArMjk2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBjeHQ1MDY2X2NmZ190
YmxbXSA9IHsKIAkJICAgICAgQ1hUNTA2Nl9ERUxMX0xBUFRPUCksCiAJU05EX1BDSV9RVUlSSygw
eDE1MmQsIDB4MDgzMywgIk9MUEMgWE8tMS41IiwgQ1hUNTA2Nl9PTFBDX1hPXzFfNSksCiAJU05E
X1BDSV9RVUlSSygweDEwMjgsIDB4MDQwMiwgIkRlbGwgVm9zdHJvIiwgQ1hUNTA2Nl9ERUxMX1ZP
U1RPKSwKKwlTTkRfUENJX1FVSVJLKDB4MTE3OSwgMHhmZmUwLCAiVG9zaGliYSBTYXRlbGxpdGUg
UHJvIFQxMzAtMTVGIiwgQ1hUNTA2Nl9PTFBDX1hPXzFfNSksCiAJU05EX1BDSV9RVUlSSygweDE3
YWEsIDB4M2EwZCwgImlkZWFwYWQiLCBDWFQ1MDY2X0lERUFQQUQpLAogCVNORF9QQ0lfUVVJUkso
MHgxN2FhLCAweDIxNWUsICJMZW5vdm8gVGhpbmtwYWQiLCBDWFQ1MDY2X1RISU5LUEFEKSwKIAl7
fQotLSAKMS43LjAuNAoK
--001636e0a8f0815b6d0485bc69ee
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0a8f0815b6d0485bc69ee--
