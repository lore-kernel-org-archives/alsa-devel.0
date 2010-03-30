From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix 0 dB offset for Lenovo Thinkpad
	models using AD1981
Date: Tue, 30 Mar 2010 15:08:15 -0700
Message-ID: <604760771003301508y214ab9cco7eb8e8935cbb5119@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e90a21c4f4a804830bddd1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 89A63103801
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Mar 2010 00:08:16 +0200 (CEST)
Received: by pwj7 with SMTP id 7so8895938pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2010 15:08:15 -0700 (PDT)
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

--001636e90a21c4f4a804830bddd1
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD (applicable to
2.6.32.y and 2.6.33.y) that clamps the 0 dB offset accordingly.

Best,
-Dan

--001636e90a21c4f4a804830bddd1
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-0-dB-offset-for-Lenovo-Thinkpad-models-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-0-dB-offset-for-Lenovo-Thinkpad-models-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7f9b6f90

RnJvbSBmZGY2YTg3MjdkYTcxODlmMjNlM2NmZTk0MTQwZjM4NTEzMTQ0NDY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFR1ZSwgMzAgTWFyIDIwMTAgMTM6Mjk6MjggLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCAwIGRCIG9mZnNldCBmb3IgTGVub3ZvIFRoaW5rcGFkIG1vZGVscyB1c2luZyBB
RDE5ODEKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzU1MTYwNgoKVGhlIE9S
J3MgaGFyZHdhcmUgZGlzdG9ydHMgYXQgUENNIDEwMCUgYmVjYXVzZSBpdCBkb2VzIG5vdCBjb3Jy
ZXNwb25kIHRvCjAgZEIuIEZpeCB0aGlzIGluIHBhdGNoX2FkMTk4MSgpIGZvciBhbGwgbW9kZWxz
IHVzaW5nIHRoZSBUaGlua3BhZApxdWlyay4KClJlcG9ydGVkLWJ5OiBKYW5lIFNpbGJlcgpDYzog
PHN0YWJsZUBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3Vu
QHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYyB8ICAgIDggKysr
KysrKysKIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfYW5hbG9nLmMgYi9zb3VuZC9wY2kvaGRh
L3BhdGNoX2FuYWxvZy5jCmluZGV4IDI2MmY1YjUuLjljYmQ4MGMgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfYW5hbG9nLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cu
YwpAQCAtMTkwNCw2ICsxOTA0LDE0IEBAIHN0YXRpYyBpbnQgcGF0Y2hfYWQxOTgxKHN0cnVjdCBo
ZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgQUQxOTgxX1RISU5LUEFEOgogCQlzcGVjLT5taXhlcnNb
MF0gPSBhZDE5ODFfdGhpbmtwYWRfbWl4ZXJzOwogCQlzcGVjLT5pbnB1dF9tdXggPSAmYWQxOTgx
X3RoaW5rcGFkX2NhcHR1cmVfc291cmNlOworCQkvKiBzZXQgdGhlIHVwcGVyLWxpbWl0IGZvciBt
aXhlciBhbXAgdG8gMGRCIGZvciBhdm9pZGluZyB0aGUKKwkJICogcG9zc2libGUgZGFtYWdlIGJ5
IG92ZXJsb2FkaW5nCisJCSAqLworCQlzbmRfaGRhX292ZXJyaWRlX2FtcF9jYXBzKGNvZGVjLCAw
eDExLCBIREFfSU5QVVQsCisJCQkJCSAgKDB4MTcgPDwgQUNfQU1QQ0FQX09GRlNFVF9TSElGVCkg
fAorCQkJCQkgICgweDE3IDw8IEFDX0FNUENBUF9OVU1fU1RFUFNfU0hJRlQpIHwKKwkJCQkJICAo
MHgwNSA8PCBBQ19BTVBDQVBfU1RFUF9TSVpFX1NISUZUKSB8CisJCQkJCSAgKDEgPDwgQUNfQU1Q
Q0FQX01VVEVfU0hJRlQpKTsKIAkJYnJlYWs7CiAJY2FzZSBBRDE5ODFfVE9TSElCQToKIAkJc3Bl
Yy0+bWl4ZXJzWzBdID0gYWQxOTgxX2hwX21peGVyczsKLS0gCjEuNy4wCgo=
--001636e90a21c4f4a804830bddd1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e90a21c4f4a804830bddd1--
