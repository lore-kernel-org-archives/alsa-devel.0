From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix model quirk for Dell M1730
Date: Sun, 23 May 2010 20:56:16 -0400
Message-ID: <AANLkTilBaPoK2ro-kWOfW3H2LeZz2tZlLP0nnkwAKazC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502b172100fa004874c8206
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3A4BA24339
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 02:56:17 +0200 (CEST)
Received: by pwj9 with SMTP id 9so2044270pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 23 May 2010 17:56:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, picdragon99@msn.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00504502b172100fa004874c8206
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch for sound-2.6 master HEAD that fixes
capture out-of-the-box for Dell M1730.

This patch is applicable to all 2.6.32, 2.6.33, and 2.6.34 stable trees.

Best,
-Dan

--00504502b172100fa004874c8206
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-model-quirk-for-Dell-M1730.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-model-quirk-for-Dell-M1730.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9kl571p0

RnJvbSA2OGY0MTQ1NDE5ZWNlMDVlYzJiYmM3Y2Y5MWRiNDMzNzkzZTU3ZTAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjMgTWF5IDIwMTAgMjA6NDc6NDUgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCBtb2RlbCBxdWlyayBmb3IgRGVsbCBNMTczMAoKQnVnTGluazogaHR0cHM6Ly9s
YXVuY2hwYWQubmV0L2J1Z3MvNTc2MTYwCgpTeW1wdG9tOiBDdXJyZW50bHkgKDIuNi4zMi4xMikg
dGhlIERlbGwgTTE3MzAgdXNlcyB0aGUgM3N0YWNrIG1vZGVsCnF1aXJrLiBVbmZvcnR1bmF0ZWx5
IHRoaXMgbWVhbnMgdGhhdCBjYXB0dXJlIGlzIG5vdCBmdW5jdGlvbmFsIG91dC0Kb2YtdGhlLWJv
eCBkZXNwaXRlIGVuc3VyaW5nIHRoYXQgY2FwdHVyZSBzZXR0aW5ncyBhcmUgdW5tdXRlZCBhbmQK
cmFpc2VkIGZ1bGx5LgoKVGVzdCBjYXNlOiBib290IGZyb20gVWJ1bnR1IDEwLjA0IExUUyBsaXZl
IGNkOyBjYXB0dXJlIGRvZXMgbm90CndvcmsuCgpSZXNvbHV0aW9uOiBDb3JyZWN0IHRoZSBtb2Rl
bCBxdWlyayBmb3IgRGVsbCBNMTczMCB0byByZWx5IG9uIHRoZQpCSU9TIGNvbmZpZ3VyYXRpb24u
CgpUaGlzIHBhdGNoIGFsc28gdHJpdmlhbGx5IHNvcnRzIHRoZSBxdWlyayBpbnRvIHRoZSBjb3Jy
ZWN0IHNlY3Rpb24KYmFzZWQgb24gdGhlIGNvbW1lbnRzLgoKUmVwb3J0ZWQtYW5kLVRlc3RlZC1C
eTogPHBpY2RyYWdvbjk5QG1zbi5jb20+ClRlc3RlZC1CeTogRGFyZW4gSGF5d2FyZApUZXN0ZWQt
Qnk6IFRvYmlhcyBLcmFpcwpDYzogPHN0YWJsZUBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRj
aF9zaWdtYXRlbC5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRl
bC5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCmluZGV4IGEwZTA2ZDguLmYxZTdi
YWIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYworKysgYi9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKQEAgLTIwNzgsMTIgKzIwNzgsMTIgQEAgc3RhdGlj
IHN0cnVjdCBzbmRfcGNpX3F1aXJrIHN0YWM5Mjd4X2NmZ190YmxbXSA9IHsKIAlTTkRfUENJX1FV
SVJLX01BU0soUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhmZjAwLCAweDIwMDAsCiAJCQkgICAiSW50
ZWwgRDk2NSIsIFNUQUNfRDk2NV8zU1QpLAogCS8qIERlbGwgMyBzdGFjayBzeXN0ZW1zICovCi0J
U05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAxZjcsICJEZWxsIFhQUyBNMTcz
MCIsIFNUQUNfREVMTF8zU1QpLAogCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAg
MHgwMWRkLCAiRGVsbCBEaW1lbnNpb24gRTUyMCIsIFNUQUNfREVMTF8zU1QpLAogCVNORF9QQ0lf
UVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMWVkLCAiRGVsbCAgICAgIiwgU1RBQ19ERUxM
XzNTVCksCiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAxZjQsICJEZWxs
ICAgICAiLCBTVEFDX0RFTExfM1NUKSwKIAkvKiBEZWxsIDMgc3RhY2sgc3lzdGVtcyB3aXRoIHZl
cmIgdGFibGUgaW4gQklPUyAqLwogCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAg
MHgwMWYzLCAiRGVsbCBJbnNwaXJvbiAxNDIwIiwgU1RBQ19ERUxMX0JJT1MpLAorCVNORF9QQ0lf
UVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMWY3LCAiRGVsbCBYUFMgTTE3MzAiLCBTVEFD
X0RFTExfQklPUyksCiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAyMjcs
ICJEZWxsIFZvc3RybyAxNDAwICAiLCBTVEFDX0RFTExfQklPUyksCiAJU05EX1BDSV9RVUlSSyhQ
Q0lfVkVORE9SX0lEX0RFTEwsICAweDAyMmUsICJEZWxsICAgICAiLCBTVEFDX0RFTExfQklPUyks
CiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAyMmYsICJEZWxsIEluc3Bp
cm9uIDE1MjUiLCBTVEFDX0RFTExfQklPUyksCi0tIAoxLjcuMC40Cgo=
--00504502b172100fa004874c8206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502b172100fa004874c8206--
