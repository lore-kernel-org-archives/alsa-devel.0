From: Dan Chen <crimsunkg@yahoo.com>
Subject: [PATCH] ALSA: hda: Fix max PCM level to 0 dB for
	AD1981_HP
Date: Sun, 13 Dec 2009 13:32:56 -0800 (PST)
Message-ID: <290497.87649.qm@web112612.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-177302244-1260739976=:87649"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web112612.mail.gq1.yahoo.com (web112612.mail.gq1.yahoo.com
	[98.137.27.192]) by alsa0.perex.cz (Postfix) with SMTP id 6C110103812
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 22:32:58 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-177302244-1260739976=:87649
Content-Type: text/plain; charset=us-ascii

Hi, Takashi,

Attached is a patch against sound-2.6 (master) HEAD capping PCM at 0 dB
for the AD1981_HP model.

Thanks,
Dan


      
--0-177302244-1260739976=:87649
Content-Type: application/octet-stream; name="0001-ALSA-hda-Fix-max-PCM-level-to-0-dB-for-AD1981_HP.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ALSA-hda-Fix-max-PCM-level-to-0-dB-for-AD1981_HP.patch"

RnJvbSA1MWMzNzQ1NGFlYjE2YTdlNmU0NTQ5MjdjNDg4ZTdhNjMwNzYwYjQx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFN1biwgMTMgRGVjIDIwMDkg
MTY6MjI6NTggLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBoZGE6IEZp
eCBtYXggUENNIGxldmVsIHRvIDAgZEIgZm9yIEFEMTk4MV9IUAoKQnVnTGlu
azogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvYnVncy80NjEwNjIKClRo
ZSBvcmlnaW5hbCByZXBvcnRlciBzdGF0ZXMgdGhhdCBQQ00gbWF4ZXMgYXQg
KzEyIGRCIGFuZCByZXN1bHRzIGluCnZlcnkgYmFkIGRpc3RvcnRpb24uICBD
YXAgUENNIGF0IDAgZEIgdG8gcmVzb2x2ZSB0aGlzIHN5bXB0b20uCgpTaWdu
ZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+
Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYyB8ICAgIDggKysr
KysrKysKIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
YW5hbG9nLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCmluZGV4
IDQ0N2VkYTEuLjFhMzYxMzcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfYW5hbG9nLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9hbmFs
b2cuYwpAQCAtMTc4OSw2ICsxNzg5LDE0IEBAIHN0YXRpYyBpbnQgcGF0Y2hf
YWQxOTgxKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCiAJCWNvZGVjLT5w
YXRjaF9vcHMuaW5pdCA9IGFkMTk4MV9ocF9pbml0OwogCQljb2RlYy0+cGF0
Y2hfb3BzLnVuc29sX2V2ZW50ID0gYWQxOTgxX2hwX3Vuc29sX2V2ZW50Owor
CQkvKiBzZXQgdGhlIHVwcGVyLWxpbWl0IGZvciBtaXhlciBhbXAgdG8gMGRC
IGZvciBhdm9pZGluZyB0aGUKKwkJICogcG9zc2libGUgZGFtYWdlIGJ5IG92
ZXJsb2FkaW5nCisJCSAqLworCQlzbmRfaGRhX292ZXJyaWRlX2FtcF9jYXBz
KGNvZGVjLCAweDExLCBIREFfSU5QVVQsCisJCQkJCSAgKDB4MTcgPDwgQUNf
QU1QQ0FQX09GRlNFVF9TSElGVCkgfAorCQkJCQkgICgweDE3IDw8IEFDX0FN
UENBUF9OVU1fU1RFUFNfU0hJRlQpIHwKKwkJCQkJICAoMHgwNSA8PCBBQ19B
TVBDQVBfU1RFUF9TSVpFX1NISUZUKSB8CisJCQkJCSAgKDEgPDwgQUNfQU1Q
Q0FQX01VVEVfU0hJRlQpKTsKIAkJYnJlYWs7CiAJY2FzZSBBRDE5ODFfVEhJ
TktQQUQ6CiAJCXNwZWMtPm1peGVyc1swXSA9IGFkMTk4MV90aGlua3BhZF9t
aXhlcnM7Ci0tIAoxLjYuMy4zCgo=

--0-177302244-1260739976=:87649
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-177302244-1260739976=:87649--
