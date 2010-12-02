From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use "alienware" model quirk for
	another SSID
Date: Wed, 1 Dec 2010 19:22:31 -0500
Message-ID: <AANLkTinh=7JWr67TVH131Rvs_uo2WshnMX3Fmbk9sUVF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d2f3fe5307d0496626a25
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id D84B824479
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 01:22:31 +0100 (CET)
Received: by wyi11 with SMTP id 11so7570564wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 16:22:31 -0800 (PST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--0016364d2f3fe5307d0496626a25
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD (also
applicable to all supported/maintained stable kernels inclusive of
2.6.32 and newer) that adds a bug reporter's SSID to the appropriate
quirk table so that headphones and mics are usable.  Please apply.

Best,
-Dan

--0016364d2f3fe5307d0496626a25
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-alienware-model-quirk-for-another-SSID.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-alienware-model-quirk-for-another-SSID.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh6wghrr0

RnJvbSA4MGRmYTQyMzUyYTE0NTRiOTk0NDU5ZDExODgxZDM3NTM0MjE3NDcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMSBEZWMgMjAxMCAxOToxNjowNyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlICJhbGllbndhcmUiIG1vZGVsIHF1aXJrIGZvciBhbm90aGVyIFNTSUQKCkJ1Z0xp
bms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzY4MzY5NQoKVGhlIG9yaWdpbmFsIHJlcG9y
dGVyIHN0YXRlcyB0aGF0IGhlYWRwaG9uZSBqYWNrcyBkbyBub3QgYXBwZWFyIHRvCndvcmsuICBV
cG9uIGluc3BlY3RpbmcgaGlzIGNvZGVjIGR1bXAsIGFuZCB1cG9uIGZ1cnRoZXIgdGVzdGluZywg
aXQgaXMKY29uZmlybWVkIHRoYXQgdGhlICJhbGllbndhcmUiIG1vZGVsIHF1aXJrIGlzIGNvcnJl
Y3QuCgpSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiBDb2R5IFRoaWVyYXVmCkNjOiA8c3RhYmxlQGtl
cm5lbC5vcmc+IFsyLjYuMzIrXQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3Vu
QHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jIHwgICAgMiAr
KwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jIGIvc291bmQvcGNpL2hkYS9w
YXRjaF9zaWdtYXRlbC5jCmluZGV4IDVjNzEwODAuLmVmYTQyMjUgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21h
dGVsLmMKQEAgLTE2MjcsNiArMTYyNyw4IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBz
dGFjOTJoZDczeHhfY2ZnX3RibFtdID0gewogc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIHN0
YWM5MmhkNzN4eF9jb2RlY19pZF9jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVO
RE9SX0lEX0RFTEwsIDB4MDJhMSwKIAkJICAgICAgIkFsaWVud2FyZSBNMTd4IiwgU1RBQ19BTElF
TldBUkVfTTE3WCksCisJU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsIDB4MDQzYSwK
KwkJICAgICAgIkFsaWVud2FyZSBNMTd4IiwgU1RBQ19BTElFTldBUkVfTTE3WCksCiAJe30gLyog
dGVybWluYXRvciAqLwogfTsKIAotLSAKMS43LjEKCg==
--0016364d2f3fe5307d0496626a25
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016364d2f3fe5307d0496626a25--
