From: "Stephen Warren" <SWarren@nvidia.com>
Subject: Fix for CVS not compiling against 2.6.9 (init.patch failed)
Date: Wed, 15 Dec 2004 12:20:12 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE409@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4E2E3.7C0B46E3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4E2E3.7C0B46E3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In the latest (anon) CVS, I find that alsa-driver/acore/init.patch
doesn't apply cleanly.

Here's an updated version of init.patch that does apply, and yields a
version of init.c that I can build. See attachment.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html

------_=_NextPart_001_01C4E2E3.7C0B46E3
Content-Type: application/octet-stream;
	name="init.patch"
Content-Transfer-Encoding: base64
Content-Description: init.patch
Content-Disposition: attachment;
	filename="init.patch"

LS0tIC4uL2Fsc2Eta2VybmVsL2NvcmUvaW5pdC5jCTIwMDQtMTEtMjkgMDc6MDk6NDQuMDAwMDAw
MDAwIC0wNzAwCisrKyBpbml0LmMJMjAwNC0xMi0xNSAwNzo1NDoyNS4wNDcxNTA0MzIgLTA3MDAK
QEAgLTEsMyArMSw0IEBACisjZGVmaW5lIF9fTk9fVkVSU0lPTl9fCiAvKgogICogIEluaXRpYWxp
emF0aW9uIHJvdXRpbmVzCiAgKiAgQ29weXJpZ2h0IChjKSBieSBKYXJvc2xhdiBLeXNlbGEgPHBl
cmV4QHN1c2UuY3o+CkBAIC0xOTYsNyArMTk3LDkgQEAKIAkJZl9vcHMgPSAmc19mX29wcy0+Zl9v
cHM7CiAKIAkJbWVtc2V0KGZfb3BzLCAwLCBzaXplb2YoKmZfb3BzKSk7CisjaWZuZGVmIExJTlVY
XzJfMgogCQlmX29wcy0+b3duZXIgPSBmaWxlLT5mX29wLT5vd25lcjsKKyNlbmRpZgogCQlmX29w
cy0+cmVsZWFzZSA9IGZpbGUtPmZfb3AtPnJlbGVhc2U7CiAJCWZfb3BzLT5wb2xsID0gc25kX2Rp
c2Nvbm5lY3RfcG9sbDsKIApAQCAtNzc4LDYgKzc4MSwzOSBAQAogfQogCiAjaWZkZWYgQ09ORklH
X1BDSQorI2lmbmRlZiBDT05GSUdfSEFWRV9QQ0lfU0FWRURfQ09ORklHCitzdGF0aWMgdW5zaWdu
ZWQgaW50IHBjaV9zYXZlZF9jb25maWdbU05EUlZfQ0FSRFNdWzE2XTsKKyNlbmRpZgorI2lmZGVm
IFBDSV9PTERfU1VTUEVORAordm9pZCBzbmRfY2FyZF9wY2lfc3VzcGVuZChzdHJ1Y3QgcGNpX2Rl
diAqZGV2KQoreworCXNuZF9jYXJkX3QgKmNhcmQgPSBwY2lfZ2V0X2RydmRhdGEoZGV2KTsKKwlp
ZiAoISBjYXJkIHx8ICEgY2FyZC0+cG1fc3VzcGVuZCkKKwkJcmV0dXJuOworCWlmIChjYXJkLT5w
b3dlcl9zdGF0ZSA9PSBTTkRSVl9DVExfUE9XRVJfRDNob3QpCisJCXJldHVybjsKKwkvKiBGSVhN
RTogY29ycmVjdCBzdGF0ZSB2YWx1ZT8gKi8KKwljYXJkLT5wbV9zdXNwZW5kKGNhcmQsIDApOwor
CXBjaV9zYXZlX3N0YXRlKGRldiwgJnBjaV9zYXZlZF9jb25maWdbY2FyZC0+bnVtYmVyXVswXSk7
CisJc25kX3Bvd2VyX2NoYW5nZV9zdGF0ZShjYXJkLCBTTkRSVl9DVExfUE9XRVJfRDNob3QpOwor
fQorCit2b2lkIHNuZF9jYXJkX3BjaV9yZXN1bWUoc3RydWN0IHBjaV9kZXYgKmRldikKK3sKKwlz
bmRfY2FyZF90ICpjYXJkID0gcGNpX2dldF9kcnZkYXRhKGRldik7CisJaWYgKCEgY2FyZCB8fCAh
IGNhcmQtPnBtX3Jlc3VtZSkKKwkJcmV0dXJuOworCWlmIChjYXJkLT5wb3dlcl9zdGF0ZSA9PSBT
TkRSVl9DVExfUE9XRVJfRDApCisJCXJldHVybjsKKwkvKiByZXN0b3JlIHRoZSBQQ0kgY29uZmln
IHNwYWNlICovCisJcGNpX3Jlc3RvcmVfc3RhdGUoZGV2LCAmcGNpX3NhdmVkX2NvbmZpZ1tjYXJk
LT5udW1iZXJdWzBdKTsKKwkvKiBGSVhNRTogY29ycmVjdCBzdGF0ZSB2YWx1ZT8gKi8KKwljYXJk
LT5wbV9yZXN1bWUoY2FyZCwgMCk7CisJc25kX3Bvd2VyX2NoYW5nZV9zdGF0ZShjYXJkLCBTTkRS
Vl9DVExfUE9XRVJfRDApOworfQorCisjZWxzZSAvKiBuZXcgc3VzcGVuZCAqLworCiBpbnQgc25k
X2NhcmRfcGNpX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKmRldiwgdTMyIHN0YXRlKQogewogCXNu
ZF9jYXJkX3QgKmNhcmQgPSBwY2lfZ2V0X2RydmRhdGEoZGV2KTsKQEAgLTc4OCw3ICs4MjQsMTIg
QEAKIAkJcmV0dXJuIDA7CiAJLyogRklYTUU6IGNvcnJlY3Qgc3RhdGUgdmFsdWU/ICovCiAJZXJy
ID0gY2FyZC0+cG1fc3VzcGVuZChjYXJkLCAwKTsKKyNpZm5kZWYgQ09ORklHX0hBVkVfUENJX1NB
VkVEX0NPTkZJRworCXBjaV9zYXZlX3N0YXRlKGRldiwgJnBjaV9zYXZlZF9jb25maWdbY2FyZC0+
bnVtYmVyXVswXSk7CisjZWxpZiBMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04o
MiwgNiwgMTApCiAJcGNpX3NhdmVfc3RhdGUoZGV2KTsKKyNlbmRpZgorCiAJcmV0dXJuIGVycjsK
IH0KIApAQCAtODAwLDEwICs4NDEsMTggQEAKIAlpZiAoY2FyZC0+cG93ZXJfc3RhdGUgPT0gU05E
UlZfQ1RMX1BPV0VSX0QwKQogCQlyZXR1cm4gMDsKIAkvKiByZXN0b3JlIHRoZSBQQ0kgY29uZmln
IHNwYWNlICovCisjaWZuZGVmIENPTkZJR19IQVZFX1BDSV9TQVZFRF9DT05GSUcKKwlwY2lfcmVz
dG9yZV9zdGF0ZShkZXYsICZwY2lfc2F2ZWRfY29uZmlnW2NhcmQtPm51bWJlcl1bMF0pOworI2Vs
aWYgZGVmaW5lZChDT05GSUdfSEFWRV9ORVdfUENJX1NBVkVfU1RBVEUpCiAJcGNpX3Jlc3RvcmVf
c3RhdGUoZGV2KTsKKyNlbHNlCisJcGNpX3Jlc3RvcmVfc3RhdGUoZGV2LCBkZXYtPnNhdmVkX2Nv
bmZpZ19zcGFjZSk7CisjZW5kaWYKIAkvKiBGSVhNRTogY29ycmVjdCBzdGF0ZSB2YWx1ZT8gKi8K
IAlyZXR1cm4gY2FyZC0+cG1fcmVzdW1lKGNhcmQsIDApOwogfQotI2VuZGlmCisKKyNlbmRpZiAv
KiBQQ0lfT0xEX1NVU1BFTkQgKi8KKyNlbmRpZiAvKiBDT05GSUdfUENJICovCiAKICNlbmRpZiAv
KiBDT05GSUdfUE0gKi8K

------_=_NextPart_001_01C4E2E3.7C0B46E3--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
