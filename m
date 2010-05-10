From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix 0 dB for Lenovo models using
	Conexant CX20549 (Venice)
Date: Mon, 10 May 2010 21:56:36 +0200
Message-ID: <AANLkTimww81u3UFflXTW-akNDJ5aBMXyFI6p7P4-sgSX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0b9297bead8048642ce0b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 383422485B
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 21:56:38 +0200 (CEST)
Received: by pvg4 with SMTP id 4so459162pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 12:56:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Tim Starling <tstarling@wikimedia.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0b9297bead8048642ce0b
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch against sound-2.6 (also applicable to
stable trees) that fixes the reported distortion for Lenovo models on
CX20549.

Best,
-Dan

--001636e0b9297bead8048642ce0b
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-0-dB-for-Lenovo-models-using-Conexant-C.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-0-dB-for-Lenovo-models-using-Conexant-C.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g91pqkr50

RnJvbSAxZTdjOWY1MTg4YzhlMTEwYjkwZTQyZjgyMGIxNWY0YzNjNzAzNGIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IE1vbiwgMTAgTWF5IDIwMTAgMjE6NTA6MDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCAwIGRCIGZvciBMZW5vdm8gbW9kZWxzIHVzaW5nIENvbmV4YW50IENYMjA1NDkg
KFZlbmljZSkKClJlZmVyZW5jZTogaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBl
cm1haWwvYWxzYS1kZXZlbC8yMDEwLU1heS8wMjc1MjUuaHRtbAoKQXMgcmVwb3J0ZWQgb24gdGhl
IG1haWxpbmcgbGlzdCwgd2UgYWxzbyBuZWVkIHRvIGNhcCB0byB0aGUgMCBkQiBvZmZzZXQKZm9y
IExlbm92byBtb2RlbHMsIGVsc2UgdGhlIHNvdW5kIHdpbGwgYmUgZGlzdG9ydGVkLgoKUmVwb3J0
ZWQtYW5kLVRlc3RlZC1ieTogVGltIFN0YXJsaW5nIDx0c3RhcmxpbmdAd2lraW1lZGlhLm9yZz4K
Q2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3Jp
bXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyB8ICAg
IDcgKysrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9jb25leGFudC5jCmluZGV4IGM4ZTgzZjUuLmU4NjM2NDkgMTAwNjQ0Ci0t
LSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYworKysgYi9zb3VuZC9wY2kvaGRhL3Bh
dGNoX2NvbmV4YW50LmMKQEAgLTExOTgsOSArMTE5OCwxMCBAQCBzdGF0aWMgaW50IHBhdGNoX2N4
dDUwNDUoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJY2FzZSAweDEwM2M6CiAJY2FzZSAweDE2
MzE6CiAJY2FzZSAweDE3MzQ6Ci0JCS8qIEhQLCBQYWNrYXJkIEJlbGwsICYgRnVqaXRzdS1TaWVt
ZW5zIGxhcHRvcHMgaGF2ZSByZWFsbHkgYmFkCi0JCSAqIHNvdW5kIG92ZXIgMGRCIG9uIE5JRCAw
eDE3LiBGaXggbWF4IFBDTSBsZXZlbCB0byAwIGRCCi0JCSAqIChvcmlnaW5hbGx5IGl0IGhhcyAw
eDJiIHN0ZXBzIHdpdGggMGRCIG9mZnNldCAweDE0KQorCWNhc2UgMHgxN2FhOgorCQkvKiBIUCwg
UGFja2FyZCBCZWxsLCBGdWppdHN1LVNpZW1lbnMgJiBMZW5vdm8gbGFwdG9wcyBoYXZlCisJCSAq
IHJlYWxseSBiYWQgc291bmQgb3ZlciAwZEIgb24gTklEIDB4MTcuIEZpeCBtYXggUENNIGxldmVs
IHRvCisJCSAqIDAgZEIgKG9yaWdpbmFsbHkgaXQgaGFzIDB4MmIgc3RlcHMgd2l0aCAwZEIgb2Zm
c2V0IDB4MTQpCiAJCSAqLwogCQlzbmRfaGRhX292ZXJyaWRlX2FtcF9jYXBzKGNvZGVjLCAweDE3
LCBIREFfSU5QVVQsCiAJCQkJCSAgKDB4MTQgPDwgQUNfQU1QQ0FQX09GRlNFVF9TSElGVCkgfAot
LSAKMS43LjAuNAoK
--001636e0b9297bead8048642ce0b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0b9297bead8048642ce0b--
