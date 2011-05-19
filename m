From: Adrian <adrian.wilkins@gmail.com>
Subject: [PATCH - hda / AD1988 ;
 1/1] Compare pin type enum to the pin type and not the array index
Date: Thu, 19 May 2011 22:20:10 +0100
Message-ID: <BANLkTimOPej31W9yywnrPdkiw5g=WN8hNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636833c5aef5faa04a3a7913e
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001636833c5aef5faa04a3a7913e
Content-Type: text/plain; charset=ISO-8859-1

Fixes bug#0005368

--001636833c5aef5faa04a3a7913e
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Compare-pin-type-enum-to-the-pin-type-and-not-the-ar.patch"
Content-Disposition: attachment;
	filename="0001-Compare-pin-type-enum-to-the-pin-type-and-not-the-ar.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnw7czao0

RnJvbSA5NjdjNjQxZmFhNGFkMmY1MGM3ODgyZjI5YmRiZWZiZWUwOGQxYWMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBZHJpYW4gV2lsa2lucyA8YWRyaWFuLndpbGtpbnNAbmhzLm5l
dD4KRGF0ZTogVGh1LCAxOSBNYXkgMjAxMSAyMTo1MjozOCArMDEwMApTdWJqZWN0OiBbUEFUQ0gg
LSBoZGEgLyBBRDE5ODggOyAgMS8xXSBDb21wYXJlIHBpbiB0eXBlIGVudW0gdG8gdGhlIHBpbiB0
eXBlIGFuZCBub3QgdGhlIGFycmF5IGluZGV4CgoKU2lnbmVkLW9mZi1ieTogQWRyaWFuIFdpbGtp
bnMgPGFkcmlhbi53aWxraW5zQG5ocy5uZXQ+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9w
YXRjaF9hbmFsb2cuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfYW5hbG9nLmMKaW5kZXggNzM0YzZl
ZS4uZGJmNDBiNyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYworKysg
Yi9zb3VuZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCkBAIC0zMDcwLDYgKzMwNzAsNyBAQCBzdGF0
aWMgdm9pZCBhZDE5ODhfYXV0b19pbml0X2FuYWxvZ19pbnB1dChzdHJ1Y3QgaGRhX2NvZGVjICpj
b2RlYykKIAogCWZvciAoaSA9IDA7IGkgPCBjZmctPm51bV9pbnB1dHM7IGkrKykgewogCQloZGFf
bmlkX3QgbmlkID0gY2ZnLT5pbnB1dHNbaV0ucGluOworCQlpbnQgdHlwZSA9IGNmZy0+aW5wdXRz
W2ldLnR5cGU7CiAJCXN3aXRjaCAobmlkKSB7CiAJCWNhc2UgMHgxNTogLyogcG9ydC1DICovCiAJ
CQlzbmRfaGRhX2NvZGVjX3dyaXRlKGNvZGVjLCAweDMzLCAwLCBBQ19WRVJCX1NFVF9DT05ORUNU
X1NFTCwgMHgwKTsKQEAgLTMwNzksNyArMzA4MCw3IEBAIHN0YXRpYyB2b2lkIGFkMTk4OF9hdXRv
X2luaXRfYW5hbG9nX2lucHV0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCQkJYnJlYWs7CiAJ
CX0KIAkJc25kX2hkYV9jb2RlY193cml0ZShjb2RlYywgbmlkLCAwLCBBQ19WRVJCX1NFVF9QSU5f
V0lER0VUX0NPTlRST0wsCi0JCQkJICAgIGkgPT0gQVVUT19QSU5fTUlDID8gUElOX1ZSRUY4MCA6
IFBJTl9JTik7CisJCQkJICAgIHR5cGUgPT0gQVVUT19QSU5fTUlDID8gUElOX1ZSRUY4MCA6IFBJ
Tl9JTik7CiAJCWlmIChuaWQgIT0gQUQxOTg4X1BJTl9DRF9OSUQpCiAJCQlzbmRfaGRhX2NvZGVj
X3dyaXRlKGNvZGVjLCBuaWQsIDAsIEFDX1ZFUkJfU0VUX0FNUF9HQUlOX01VVEUsCiAJCQkJCSAg
ICBBTVBfT1VUX01VVEUpOwotLSAKMS43LjQuMQoK
--001636833c5aef5faa04a3a7913e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001636833c5aef5faa04a3a7913e--
