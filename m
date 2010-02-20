From: Daniel Chen <seven.steps@gmail.com>
Subject: [RESEND] [PATCH] ALSA: hda: Use 3stack quirk for
	Toshiba Satellite L40-10Q
Date: Sat, 20 Feb 2010 11:28:12 -0500
Message-ID: <604760771002200828m539fe45ds66bc5c1197722008@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e21febafc5404800aaff1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f204.google.com (mail-px0-f204.google.com
	[209.85.216.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 25A1024151
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 17:28:13 +0100 (CET)
Received: by pxi42 with SMTP id 42so608794pxi.5
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 08:28:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Lasse Havelund <lasse@havelund.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--0016368e21febafc5404800aaff1
Content-Type: text/plain; charset=UTF-8

Attached the actual patch this time.

-Dan

--0016368e21febafc5404800aaff1
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-3stack-quirk-for-Toshiba-Satellite-L40-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-3stack-quirk-for-Toshiba-Satellite-L40-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5wmhabr0

RnJvbSA5YmMzNDE2ZWFmMDlhODQ2MTg1ZWE1ZDlmYTY1ZjBkYWYzOGU3MDJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMjAgRmViIDIwMTAgMTE6MTY6MzAgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSAzc3RhY2sgcXVpcmsgZm9yIFRvc2hpYmEgU2F0ZWxsaXRlIEw0MC0xMFEKCkJ1
Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvNTI0OTQ4CgpUaGUgT1IgaGFz
IHZlcmlmaWVkIHRoYXQgdGhlIGV4aXN0aW5nIG1vZGVsPWxhcHRvcC1lYXBkIHF1aXJrIGRvZXMg
bm90CmZ1bmN0aW9uIGNvcnJlY3RseSBidXQgaW5zdGVhZCBuZWVkcyBtb2RlbD0zc3RhY2suICBN
YWtlIHRoaXMgY2hhbmdlCnNvIHRoYXQgbWFudWFsIGNvcnJlY3Rpb25zIHRvIG1vZHVsZS1pbml0
LXRvb2xzIGZpbGUocykgYXJlIG5vdApyZXF1aXJlZC4KClJlcG9ydGVkLWJ5OiBMYXNzZSBIYXZl
bHVuZCA8bGFzc2VAaGF2ZWx1bmQub3JnPgpDQzogPHN0YWJsZUBrZXJuZWwub3JnPgpTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNp
L2hkYS9wYXRjaF9hbmFsb2cuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
YW5hbG9nLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCmluZGV4IDIxNDMwMWQuLmU2
ZDFiZGYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfYW5hbG9nLmMKKysrIGIvc291
bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYwpAQCAtMTA5OCw3ICsxMDk4LDcgQEAgc3RhdGljIHN0
cnVjdCBzbmRfcGNpX3F1aXJrIGFkMTk4NmFfY2ZnX3RibFtdID0gewogCVNORF9QQ0lfUVVJUkso
MHgxMDQzLCAweDgxY2IsICJBU1VTIE0yTiIsIEFEMTk4NkFfM1NUQUNLKSwKIAlTTkRfUENJX1FV
SVJLKDB4MTA0MywgMHg4MjM0LCAiQVNVUyBNMk4iLCBBRDE5ODZBXzNTVEFDSyksCiAJU05EX1BD
SV9RVUlSSygweDEwZGUsIDB4Y2I4NCwgIkFTVVMgQThOLVZNIiwgQUQxOTg2QV8zU1RBQ0spLAot
CVNORF9QQ0lfUVVJUksoMHgxMTc5LCAweGZmNDAsICJUb3NoaWJhIiwgQUQxOTg2QV9MQVBUT1Bf
RUFQRCksCisJU05EX1BDSV9RVUlSSygweDExNzksIDB4ZmY0MCwgIlRvc2hpYmEgU2F0ZWxsaXRl
IEw0MC0xMFEiLCBBRDE5ODZBXzNTVEFDSyksCiAJU05EX1BDSV9RVUlSSygweDE0NGQsIDB4YjAz
YywgIlNhbXN1bmcgUjU1IiwgQUQxOTg2QV8zU1RBQ0spLAogCVNORF9QQ0lfUVVJUksoMHgxNDRk
LCAweGMwMWUsICJGU0MgVjIwNjAiLCBBRDE5ODZBX0xBUFRPUCksCiAJU05EX1BDSV9RVUlSSygw
eDE0NGQsIDB4YzAyNCwgIlNhbXN1bmcgUDUwIiwgQUQxOTg2QV9TQU1TVU5HX1A1MCksCi0tIAox
LjcuMAoK
--0016368e21febafc5404800aaff1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016368e21febafc5404800aaff1--
