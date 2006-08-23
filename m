From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] dbri sparc: fixes TS leak
Date: Wed, 23 Aug 2006 20:12:10 +0200
Message-ID: <44ec9a7aa3a04@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part44ec9a7aa8855"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--part44ec9a7aa8855
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt (krzysztof.h1@wp.pl)

This patch fixes time slot leak in the dbri driver.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---


----------------------------------------------------
Nic nie musisz zamawia=E6, nic nie musisz kupowa=E6!
Po prostu odszukaj obrazek i wygraj nagrody:
http://klik.wp.pl/?adr=3Dwww.pasaz.wp.pl%2Fkonkurs.html&sid=3D853

--part44ec9a7aa8855
Content-Type: application/octet-stream; name="dbri-patch12.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch12.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0yMyAxOTo1NjozMy4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMjMgMDA6Mzg6MDUuMDAwMDAwMDAwICswMjAwCkBAIC0xMDQ1LDcg
KzEwNDUsNyBAQCBzdGF0aWMgaW50IHNldHVwX2Rlc2NzKHN0cnVjdCBzbmRfZGJyaSAqCiB7CiAJ
c3RydWN0IGRicmlfc3RyZWFtaW5mbyAqaW5mbyA9ICZkYnJpLT5zdHJlYW1faW5mb1tzdHJlYW1u
b107CiAJX191MzIgZHZtYV9idWZmZXI7Ci0JaW50IGRlc2MgPSAwOworCWludCBkZXNjOwogCWlu
dCBsZW47CiAJaW50IGZpcnN0X2Rlc2MgPSAtMTsKIAlpbnQgbGFzdF9kZXNjID0gLTE7CkBAIC0x
MDg4LDYgKzEwODgsMTggQEAgc3RhdGljIGludCBzZXR1cF9kZXNjcyhzdHJ1Y3Qgc25kX2Ricmkg
KgogCQlsZW4gJj0gfjM7CiAJfQogCisJLyogRnJlZSBkZXNjcmlwdG9ycyBpZiBwaXBlIGhhcyBh
bnkgKi8KKwlkZXNjID0gZGJyaS0+cGlwZXNbaW5mby0+cGlwZV0uZmlyc3RfZGVzYzsKKwlpZiAo
IGRlc2MgPj0gMCkKKwkJZG8geworCQkJZGJyaS0+ZG1hLT5kZXNjW2Rlc2NdLm5kYSA9IGRicmkt
PmRtYS0+ZGVzY1tkZXNjXS5iYSA9IDA7CisJCQlkZXNjID0gZGJyaS0+bmV4dF9kZXNjW2Rlc2Nd
OworCQl9IHdoaWxlIChkZXNjICE9IC0xICYmIGRlc2MgIT0gZGJyaS0+cGlwZXNbaW5mby0+cGlw
ZV0uZmlyc3RfZGVzYyk7CisKKwlkYnJpLT5waXBlc1tpbmZvLT5waXBlXS5kZXNjID0gLTE7CisJ
ZGJyaS0+cGlwZXNbaW5mby0+cGlwZV0uZmlyc3RfZGVzYyA9IC0xOworCisJZGVzYyA9IDA7CiAJ
d2hpbGUgKGxlbiA+IDApIHsKIAkJaW50IG15bGVuOwogCkBAIC0yMDU1LDYgKzIwNzIsNyBAQCBz
dGF0aWMgaW50IHNuZF9kYnJpX2h3X2ZyZWUoc3RydWN0IHNuZF9wCiAJc3RydWN0IHNuZF9kYnJp
ICpkYnJpID0gc25kX3BjbV9zdWJzdHJlYW1fY2hpcChzdWJzdHJlYW0pOwogCXN0cnVjdCBkYnJp
X3N0cmVhbWluZm8gKmluZm8gPSBEQlJJX1NUUkVBTShkYnJpLCBzdWJzdHJlYW0pOwogCWludCBk
aXJlY3Rpb247CisKIAlkcHJpbnRrKERfVVNSLCAiaHdfZnJlZS5cbiIpOwogCiAJLyogaHdfZnJl
ZSBjYW4gZ2V0IGNhbGxlZCBtdWx0aXBsZSB0aW1lcy4gT25seSB1bm1hcCB0aGUgRE1BIG9uY2Uu
CkBAIC0yMDY5LDcgKzIwODcsMTAgQEAgc3RhdGljIGludCBzbmRfZGJyaV9od19mcmVlKHN0cnVj
dCBzbmRfcAogCQkJCSAgc3Vic3RyZWFtLT5ydW50aW1lLT5idWZmZXJfc2l6ZSwgZGlyZWN0aW9u
KTsKIAkJaW5mby0+ZHZtYV9idWZmZXIgPSAwOwogCX0KLQlpbmZvLT5waXBlID0gLTE7CisJaWYg
KGluZm8tPnBpcGUgIT0gLTEpIHsKKwkJcmVzZXRfcGlwZShkYnJpLCBpbmZvLT5waXBlKTsKKwkJ
aW5mby0+cGlwZSA9IC0xOworCX0KIAogCXJldHVybiBzbmRfcGNtX2xpYl9mcmVlX3BhZ2VzKHN1
YnN0cmVhbSk7CiB9CiAK

--part44ec9a7aa8855
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part44ec9a7aa8855
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part44ec9a7aa8855--
