From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA - au88x0 - Define channel map for au88x0
Date: Thu, 14 Feb 2013 20:49:40 +0800
Message-ID: <CAN8cciYcvGuq+jRcSp_xJ3L5b6RTvJ9EseLVxQ-ULgmEoPWk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae93403e32d241504d5aeb12b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f173.google.com (mail-ia0-f173.google.com
 [209.85.210.173])
 by alsa0.perex.cz (Postfix) with ESMTP id D98042652EF
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 13:49:41 +0100 (CET)
Received: by mail-ia0-f173.google.com with SMTP id h37so2243584iak.4
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 04:49:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--14dae93403e32d241504d5aeb12b
Content-Type: text/plain; charset=UTF-8

Define channel map for playback, capture devices of au88x0

Signed-off-by: Raymond Yau <superquad.vortex2@gmail.com>

--14dae93403e32d241504d5aeb12b
Content-Type: application/octet-stream;
	name="0001-au88x0-Define-channel-map-for-au88x0.patch"
Content-Disposition: attachment;
	filename="0001-au88x0-Define-channel-map-for-au88x0.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hd5wmetb0

RnJvbSAxODRiMjY0OTBjNmM2M2E0YWFiNTgyYmY0YTgyYTRkZjg5ZTc4MTViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUaHUsIDE0IEZlYiAyMDEzIDIwOjM3OjIyICswODAwClN1YmplY3Q6IFtQQVRD
SF0gQUxTQSAtIGF1ODh4MCAtIERlZmluZSBjaGFubmVsIG1hcCBmb3IgYXU4OHgwCgpEZWZpbmUg
Y2hhbm5lbCBtYXAgZm9yIHBsYXliYWNrLCBjYXB0dXJlIGRldmljZXMgb2YgYXU4OHgwCgpTaWdu
ZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX3BjbS5jIGIvc291bmQvcGNpL2F1ODh4
MC9hdTg4eDBfcGNtLmMKaW5kZXggYTQxODRiYi4uZDFiNjQ0YiAxMDA2NDQKLS0tIGEvc291bmQv
cGNpL2F1ODh4MC9hdTg4eDBfcGNtLmMKKysrIGIvc291bmQvcGNpL2F1ODh4MC9hdTg4eDBfcGNt
LmMKQEAgLTY1MCw2ICs2NTAsMjkgQEAgc3RhdGljIGludCBzbmRfdm9ydGV4X25ld19wY20odm9y
dGV4X3QgKmNoaXAsIGludCBpZHgsIGludCBucikKIAkJCQkJICAgICAgc25kX2RtYV9wY2lfZGF0
YShjaGlwLT5wY2lfZGV2KSwKIAkJCQkJICAgICAgMHgxMDAwMCwgMHgxMDAwMCk7CiAKKwlzd2l0
Y2ggKFZPUlRFWF9QQ01fVFlQRShwY20pKSB7CisJY2FzZSBWT1JURVhfUENNX0FEQjoKKwkJZXJy
ID0gc25kX3BjbV9hZGRfY2htYXBfY3RscyhwY20sIFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0ss
CisJCQkJCSAgICAgc25kX3BjbV9zdGRfY2htYXBzLAorCQkJCQkgICAgIFZPUlRFWF9JU19RVUFE
KGNoaXApID8gNCA6IDIsCisJCQkJCSAgICAgMCwgTlVMTCk7CisJCWlmIChlcnIgPCAwKQorCQkJ
cmV0dXJuIGVycjsKKwkJZXJyID0gc25kX3BjbV9hZGRfY2htYXBfY3RscyhwY20sIFNORFJWX1BD
TV9TVFJFQU1fQ0FQVFVSRSwKKwkJCQkJICAgICBzbmRfcGNtX3N0ZF9jaG1hcHMsIDIsIDAsIE5V
TEwpOworCQlpZiAoZXJyIDwgMCkKKwkJCXJldHVybiBlcnI7CisJCWJyZWFrOworI2lmZGVmIENI
SVBfQVU4ODMwCisJY2FzZSBWT1JURVhfUENNX0EzRDoKKwkJZXJyID0gc25kX3BjbV9hZGRfY2ht
YXBfY3RscyhwY20sIFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0ssCisJCQkJCSAgICAgc25kX3Bj
bV9zdGRfY2htYXBzLCAxLCAwLCBOVUxMKTsKKwkJaWYgKGVyciA8IDApCisJCQlyZXR1cm4gZXJy
OworCQlicmVhazsKKyNlbmRpZgorCX07CisKIAlpZiAoVk9SVEVYX1BDTV9UWVBFKHBjbSkgPT0g
Vk9SVEVYX1BDTV9TUERJRikgewogCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzbmRfdm9y
dGV4X21peGVyX3NwZGlmKTsgaSsrKSB7CiAJCQlrY3RsID0gc25kX2N0bF9uZXcxKCZzbmRfdm9y
dGV4X21peGVyX3NwZGlmW2ldLCBjaGlwKTsKLS0gCjEuNy45LjUKCg==
--14dae93403e32d241504d5aeb12b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--14dae93403e32d241504d5aeb12b--
