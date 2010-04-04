From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Add model quirk for Sony VAIO
	VGN-SZ650N
Date: Sun, 4 Apr 2010 15:25:05 -0400
Message-ID: <y2h604760771004041225z65c88e47t71e063801d1950f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd32f547c326204836e2bf3
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 2857224444
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 21:25:07 +0200 (CEST)
Received: by pzk8 with SMTP id 8so315425pzk.16
	for <alsa-devel@alsa-project.org>; Sun, 04 Apr 2010 12:25:06 -0700 (PDT)
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

--000e0cd32f547c326204836e2bf3
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 (applicable to both 2.6.32.11
and 2.6.33.2) that adds the original reporter's SSID for a quirk
entry, allowing for reliably audible sound.

Best,
-Dan

--000e0cd32f547c326204836e2bf3
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Add-model-quirk-for-Sony-VAIO-VGN-SZ650N.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Add-model-quirk-for-Sony-VAIO-VGN-SZ650N.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7m8pqxm0

RnJvbSA1NjgyZGE0YTdiNTg3NGNmNGNiZmIxZDVlNTI1N2Y3NGMyYTBmN2RlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgNCBBcHIgMjAxMCAxNToxOToxMyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogQWRkIG1vZGVsIHF1aXJrIGZvciBTb255IFZBSU8gVkdOLVNaNjUwTgoKQnVnTGluazog
aHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNTU0NDg4CgpUaGUgT1IgaGFzIHZlcmlmaWVkIHRo
YXQgdGhpcyBtb2RlbCBxdWlyayBpcyBuZWNlc3NhcnkgZm9yIHNvdW5kIHRvIGJlCmF1ZGlibGUg
cmVsaWFibHkgd2l0aGluIGJvdGggYSBsaXZlIENEIGFuZCBhbiBIRCBpbnN0YWxsLgoKUmVwb3J0
ZWQtYnk6IE1pY2hhZWwgRG91YmUKVGVzdGVkLWJ5OiBNaWNoYWVsIERvdWJlCkNjOiA8c3RhYmxl
QGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1
LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMgfCAgICAyICsrCiAxIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Np
Z21hdGVsLmMKaW5kZXggYzRiZTNmYS4uYTNjOTQ0YSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hk
YS9wYXRjaF9zaWdtYXRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwpA
QCAtNjE0OCw2ICs2MTQ4LDggQEAgc3RhdGljIHVuc2lnbmVkIGludCAqc3RhYzk4NzJfYnJkX3Ri
bFtTVEFDXzk4NzJfTU9ERUxTXSA9IHsKIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBzdGFj
OTg3Ml9jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSS19NQVNLKDB4MTA0ZCwgMHhmZmYwLCAw
eDgxZTAsCiAJCQkgICAiU29ueSBWQUlPIEYvUyIsIFNUQUNfOTg3Ml9WQUlPKSwKKwlTTkRfUENJ
X1FVSVJLKDB4MTA0ZCwgMHg5MDA4LCAiU29ueSBWQUlPIFZHTi1TWjY1ME4iLAorCQkJICAgU1RB
Q185ODcyX1ZBSU8pLAogCXt9IC8qIHRlcm1pbmF0b3IgKi8KIH07CiAKLS0gCjEuNy4wCgo=
--000e0cd32f547c326204836e2bf3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd32f547c326204836e2bf3--
