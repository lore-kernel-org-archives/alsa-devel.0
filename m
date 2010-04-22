From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use STAC_DELL_M6_BOTH quirk for
	Dell Studio 1558
Date: Thu, 22 Apr 2010 17:59:52 -0400
Message-ID: <j2v604760771004221459xb3b3f654z1e3137a3924f27c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0b92a1e59580484da6e2a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 529C52443F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 23:59:53 +0200 (CEST)
Received: by pvh11 with SMTP id 11so933250pvh.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 14:59:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Andy Ross <andy@plausible.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0b92a1e59580484da6e2a
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD making audio work by
default for the OR's Dell Studio 1558.

Best,
-Dan

--001636e0b92a1e59580484da6e2a
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-STAC_DELL_M6_BOTH-quirk-for-Dell-Studio.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-STAC_DELL_M6_BOTH-quirk-for-Dell-Studio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8c47eia0

RnJvbSAyYjFlYTQwMGYwMmQyYmJhNGVmOGFiYmYzNjYxOWZjZDI0MjA0NDA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMjIgQXByIDIwMTAgMTc6NTQ6NDUgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBTVEFDX0RFTExfTTZfQk9USCBxdWlyayBmb3IgRGVsbCBTdHVkaW8gMTU1OAoK
QnVnTGluazogaHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNTY4NjAwCgpUaGUgT1IgaGFzIHZl
cmlmaWVkIHRoYXQgdGhlIGRlbGwtbTYgbW9kZWwgcXVpcmsgaXMgbmVjZXNzYXJ5IGZvciBhdWRp
bwp0byBiZSBhdWRpYmxlIGJ5IGRlZmF1bHQgb24gdGhlIERlbGwgU3R1ZGlvIFhQUyAxNjQ1LgoK
VGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5IGZvciAyLjYuMzIuMTEgYW5kIDIuNi4zMy4yIGFsaWtl
LgoKUmVwb3J0ZWQtYnk6IEFuZHkgUm9zcyA8YW5keUBwbGF1c2libGUub3JnPgpUZXN0ZWQtYnk6
IEFuZHkgUm9zcyA8YW5keUBwbGF1c2libGUub3JnPgpDYzogPHN0YWJsZUBrZXJuZWwub3JnPgpT
aWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291
bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jIHwgICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9wYXRjaF9zaWdtYXRlbC5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCmluZGV4
IDgxZWNkOTMuLjdmYjdkMDEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0
ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKQEAgLTE2MDksNiArMTYw
OSw4IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBzdGFjOTJoZDczeHhfY2ZnX3RibFtd
ID0gewogCQkJCSJEZWxsIFN0dWRpbyAxNTU3IiwgU1RBQ19ERUxMX002X0RNSUMpLAogCVNORF9Q
Q0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAweDAyZmUsCiAJCQkJIkRlbGwgU3R1ZGlvIFhQ
UyAxNjQ1IiwgU1RBQ19ERUxMX002X0JPVEgpLAorCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9J
RF9ERUxMLCAweDA0MTMsCisJCQkJIkRlbGwgU3R1ZGlvIDE1NTgiLCBTVEFDX0RFTExfTTZfQk9U
SCksCiAJe30gLyogdGVybWluYXRvciAqLwogfTsKIAotLSAKMS43LjAuNAoK
--001636e0b92a1e59580484da6e2a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0b92a1e59580484da6e2a--
