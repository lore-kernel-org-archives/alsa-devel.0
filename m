From: James Stafford <jstafford@ampltd.com>
Subject: [PATCH] Envy24HT
Date: Mon, 27 Jan 2003 13:31:38 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4.2.2.20030127132410.00c878f0@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_18007123==_"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=====================_18007123==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

One of the attached patches correct a problem with the surround speakers 
with the AUDIO2000 Envy24HT based board. The other patch adds the 
ICE1724.conf file to the alsa-lib/src/conf/cards directory.

--=====================_18007123==_
Content-Type: application/octet-stream; name="patch-envy24ht-surroundfix.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-envy24ht-surroundfix.diff"

LS0tIGFsc2Eta2VybmVsL3BjaS9pY2UxNzEyL2FtcC5jCTMgRGVjIDIwMDIgMTc6NTM6NDMgLTAw
MDAJMS4xCisrKyBhbHNhLWtlcm5lbC9wY2kvaWNlMTcxMi9hbXAuYwk0IERlYyAyMDAyIDE1OjA0
OjA1IC0wMDAwCkBAIC00Miw2ICs0MiwxMiBAQAogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50
IF9fZGV2aW5pdCBzbmRfdnQxNzI0X2FtcF9hZGRfY29udHJvbHMoaWNlMTcxMl90ICppY2UpCit7
CisJLyogd2UgdXNlIHBpbnMgMzkgYW5kIDQxIG9mIHRoZSBWVDE2MTYgZm9yIGxlZnQgYW5kIHJp
Z2h0IHJlYWQgb3V0cHV0cyAqLworCXNuZF9hYzk3X3dyaXRlX2NhY2hlKGljZS0+YWM5NywgMHg1
YSwgc25kX2FjOTdfcmVhZChpY2UtPmFjOTcsIDB4NWEpICYgfjB4ODAwMCk7Cit9CisKIAogLyog
ZW50cnkgcG9pbnQgKi8KIHN0cnVjdCBzbmRfaWNlMTcxMl9jYXJkX2luZm8gc25kX3Z0MTcyNF9h
bXBfY2FyZHNbXSBfX2RldmluaXRkYXRhID0gewpAQCAtNDksNiArNTUsNyBAQAogCQlWVDE3MjRf
U1VCREVWSUNFX0FVRElPMjAwMCwKIAkJIkFNUCBMdGQgQVVESU8yMDAwIiwKIAkJc25kX3Z0MTcy
NF9hbXBfaW5pdCwKKwkJc25kX3Z0MTcyNF9hbXBfYWRkX2NvbnRyb2xzLAogCX0sCiAJeyB9IC8q
IHRlcm1pbmF0b3IgKi8KIH07Cg==
--=====================_18007123==_
Content-Type: application/octet-stream; name="patch-envy24ht-addconf.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-envy24ht-addconf.diff"

LS0tIGFsc2EtbGliL3NyYy9jb25mL2NhcmRzL01ha2VmaWxlLmFtCTI5IE5vdiAyMDAyIDE0OjUw
OjAzIC0wMDAwCTEuOQorKysgYWxzYS1saWIvc3JjL2NvbmYvY2FyZHMvTWFrZWZpbGUuYW0JNCBE
ZWMgMjAwMiAxNTowNDoxOSAtMDAwMApAQCAtMTAsNiArMTAsNyBAQAogCUZNODAxLmNvbmYgXAog
CUdVUy5jb25mIFwKIAlJQ0UxNzEyLmNvbmYgXAorCUlDRTE3MjQuY29uZiBcCiAJSUNILmNvbmYg
XAogCVJNRTk2MzYuY29uZiBcCiAJUk1FOTY1Mi5jb25mIFwKCgpkaWZmIC11IC1OIC1yIGN2czIv
YWxzYS1saWIvc3JjL2NvbmYvY2FyZHMvSUNFMTcyNC5jb25mCmN2cy1lbnZ5MjRodC9hbHNhLWxp
Yi9zcmMvY29uZi9jYXJkcy9JQ0UxNzI0LmNvbmYKLS0tIGN2czIvYWxzYS1saWIvc3JjL2NvbmYv
Y2FyZHMvSUNFMTcyNC5jb25mCVRodSBKYW4gIDEgMDE6MDA6MDAgMTk3MAorKysgY3ZzLWVudnky
NGh0L2Fsc2EtbGliL3NyYy9jb25mL2NhcmRzL0lDRTE3MjQuY29uZglXZWQgRGVjICA0IDE1OjM0
OjI2IDIwMDIKQEAgLTAsMCArMSwxMDAgQEAKKyMKKyMgQ29uZmlndXJhdGlvbiBmb3IgdGhlIElD
RTE3MjQgKEVudnkyNEhUKSBjaGlwCisjCisKKzxjb25mZGlyOnBjbS9mcm9udC5jb25mPgorCitJ
Q0UxNzI0LnBjbS5mcm9udC4wIHsKKwlAYXJncyBbIENBUkQgXQorCUBhcmdzLkNBUkQgeworCQl0
eXBlIHN0cmluZworCX0KKwl0eXBlIHJvdXRlCisJdHRhYmxlLjAuMCAxCisJdHRhYmxlLjEuMSAx
CisJc2xhdmUucGNtIHsKKwkJdHlwZSBodworCQljYXJkICRDQVJECisJfQorfQkKKworPGNvbmZk
aXI6cGNtL3N1cnJvdW5kNDAuY29uZj4KKworSUNFMTcyNC5wY20uc3Vycm91bmQ0MC4wIHsKKwlA
YXJncyBbIENBUkQgXQorCUBhcmdzLkNBUkQgeworCQl0eXBlIHN0cmluZworCX0KKwl0eXBlIHJv
dXRlCisJdHRhYmxlLjAuMCAxCisJdHRhYmxlLjEuMSAxCisJdHRhYmxlLjIuNCAxCisJdHRhYmxl
LjMuNSAxCisJc2xhdmUucGNtIHsKKwkJdHlwZSBodworCQljYXJkICRDQVJECisJfQorfQkKKwor
PGNvbmZkaXI6cGNtL3N1cnJvdW5kNTEuY29uZj4KKworSUNFMTcyNC5wY20uc3Vycm91bmQ1MS4w
IHsKKwlAYXJncyBbIENBUkQgXQorCUBhcmdzLkNBUkQgeworCQl0eXBlIHN0cmluZworCX0KKwl0
eXBlIHJvdXRlCisJdHRhYmxlLjAuMCAxCisJdHRhYmxlLjEuMSAxCisJdHRhYmxlLjIuNCAxCisJ
dHRhYmxlLjMuNSAxCisJdHRhYmxlLjQuMiAxCisJdHRhYmxlLjUuMyAxCisJc2xhdmUucGNtIHsK
KwkJdHlwZSBodworCQljYXJkICRDQVJECisJfQorfQorCis8Y29uZmRpcjpwY20vaWVjOTU4LmNv
bmY+CisKK0lDRTE3MjQucGNtLmllYzk1OC4wIHsKKwlAYXJncyBbIENBUkQgQUVTMCBBRVMxIEFF
UzIgQUVTMyBdCisJQGFyZ3MuQ0FSRCB7CisJCXR5cGUgc3RyaW5nCisJfQorCUBhcmdzLkFFUzAg
eworCQl0eXBlIGludGVnZXIKKwl9CisJQGFyZ3MuQUVTMSB7CisJCXR5cGUgaW50ZWdlcgorCX0K
KwlAYXJncy5BRVMyIHsKKwkJdHlwZSBpbnRlZ2VyCisJfQorCUBhcmdzLkFFUzMgeworCQl0eXBl
IGludGVnZXIKKwl9CisJdHlwZSBob29rcworCXNsYXZlLnBjbSB7CisJCXR5cGUgcm91dGUKKwkJ
dHRhYmxlLjAuNiAxCisJCXR0YWJsZS4xLjcgMQorCQlzbGF2ZS5wY20geworCQkJdHlwZSBodwor
CQkJY2FyZCAkQ0FSRAorCQl9CisJfQorCWhvb2tzLjAgeworCQl0eXBlIGN0bF9lbGVtcworCQlo
b29rX2FyZ3MgWworCQkJeworCQkJCWludGVyZmFjZSBQQ00KKwkJCQluYW1lICJJRUM5NTggUGxh
eWJhY2sgUENNIFN0cmVhbSIKKwkJCQlsb2NrIHRydWUKKwkJCQlwcmVzZXJ2ZSB0cnVlCisJCQkJ
dmFsdWUgWyAkQUVTMCAkQUVTMSAkQUVTMiAkQUVTMyBdCisJCQl9CisJCV0KKwl9Cit9
--=====================_18007123==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

--
James Stafford


mailto:jstafford@ampltd.com

Advanced Micro Peripherals Ltd
Unit 17
Sedgeway Business Park
Witchford
Cambridge
CB6 2HY

Tel: +44 1353 659 500
Fax:+44 1353 659 600

--=====================_18007123==_--




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
