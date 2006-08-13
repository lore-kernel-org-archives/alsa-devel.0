From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] dbri driver cleanup
Date: Sun, 13 Aug 2006 16:14:54 +0200
Message-ID: <44df33de13c52@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part44df33de18a70"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--part44df33de18a70
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a small clean up of the dbri driver for sparc machines.=20

It contains also a fix to DBRI interrupt queue initialization.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)

---

This is the first patch for the dbri driver. I plan to rework
this driver at least to the level of OSS dbri driver (16-bit
stereo PCM and no annoying noises during playback).

Regards,
Krzysztof Helt




----------------------------------------------------
Gooor=B1ce Last Minute! Egipt, Tunezja, Turcja... Kliknij i zarezerwuj:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fwycieczki.pasaz.wp.pl&sid=3D844

--part44df33de18a70
Content-Type: application/octet-stream; name="dbri-patch1.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch1.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0wNCAxNDo0MToyOC4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMTMgMTU6NTQ6NDQuMDAwMDAwMDAwICswMjAwCkBAIC0xMDQsMTcg
KzEwNCwxNSBAQCBzdGF0aWMgY2hhciAqY21kc1tdID0gewogCiAjZGVmaW5lIGRwcmludGsoYSwg
eC4uLikgaWYoZGJyaV9kZWJ1ZyAmIGEpIHByaW50ayhLRVJOX0RFQlVHIHgpCiAKLSNkZWZpbmUg
REJSSV9DTUQoY21kLCBpbnRyLCB2YWx1ZSkgKChjbWQgPDwgMjgpIHwJCQlcCi0JCQkJICAgICgx
IDw8IDI3KSB8IFwKLQkJCQkgICAgdmFsdWUpCiAjZWxzZQogI2RlZmluZSBkcHJpbnRrKGEsIHgu
Li4pCiAKLSNkZWZpbmUgREJSSV9DTUQoY21kLCBpbnRyLCB2YWx1ZSkgKChjbWQgPDwgMjgpIHwJ
CQlcCi0JCQkJICAgIChpbnRyIDw8IDI3KSB8IFwKLQkJCQkgICAgdmFsdWUpCiAjZW5kaWYJCQkJ
LyogREJSSV9ERUJVRyAqLwogCisjZGVmaW5lIERCUklfQ01EKGNtZCwgaW50ciwgdmFsdWUpICgo
Y21kIDw8IDI4KSB8CVwKKwkJCQkgICAgKGludHIgPDwgMjcpIHwJXAorCQkJCSAgICB2YWx1ZSkK
KwogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgogCUNTNDIxNSBzcGVjaWZpYyBkZWZpbml0aW9ucyBhbmQg
c3RydWN0dXJlcwogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KQEAgLTY5MCw3ICs2ODgsNiBAQCBzdGF0
aWMgdm9sYXRpbGUgczMyICpkYnJpX2NtZGxvY2soc3RydWN0CiBzdGF0aWMgdm9pZCBkYnJpX2Nt
ZHNlbmQoc3RydWN0IHNuZF9kYnJpICogZGJyaSwgdm9sYXRpbGUgczMyICogY21kKQogewogCXZv
bGF0aWxlIHMzMiAqcHRyOwotCXUzMglyZWc7CiAKIAlmb3IgKHB0ciA9ICZkYnJpLT5kbWEtPmNt
ZFswXTsgcHRyIDwgY21kOyBwdHIrKykgewogCQlkcHJpbnRrKERfQ01ELCAiY21kOiAlbHg6JTA4
eFxuIiwgKHVuc2lnbmVkIGxvbmcpcHRyLCAqcHRyKTsKQEAgLTcwOSw5ICs3MDYsNiBAQCBzdGF0
aWMgdm9pZCBkYnJpX2NtZHNlbmQoc3RydWN0IHNuZF9kYnJpCiAKIAkvKiBTZXQgY29tbWFuZCBw
b2ludGVyIGFuZCBzaWduYWwgaXQgaXMgdmFsaWQuICovCiAJc2J1c193cml0ZWwoZGJyaS0+ZG1h
X2R2bWEsIGRicmktPnJlZ3MgKyBSRUc4KTsKLQlyZWcgPSBzYnVzX3JlYWRsKGRicmktPnJlZ3Mg
KyBSRUcwKTsKLQlyZWcgfD0gRF9QOwotCXNidXNfd3JpdGVsKHJlZywgZGJyaS0+cmVncyArIFJF
RzApOwogCiAJLypzcGluX3VubG9jaygmZGJyaS0+bG9jayk7ICovCiB9CkBAIC03NTIsNyArNzQ2
LDcgQEAgc3RhdGljIHZvaWQgZGJyaV9pbml0aWFsaXplKHN0cnVjdCBzbmRfZAogCSAqLwogCWZv
ciAobiA9IDA7IG4gPCBEQlJJX05PX0lOVFMgLSAxOyBuKyspIHsKIAkJZG1hX2FkZHIgPSBkYnJp
LT5kbWFfZHZtYTsKLQkJZG1hX2FkZHIgKz0gZGJyaV9kbWFfb2ZmKGludHIsICgobiArIDEpICYg
REJSSV9JTlRfQkxLKSk7CisJCWRtYV9hZGRyICs9IGRicmlfZG1hX29mZihpbnRyLCAoKG4gKyAx
KSAqIERCUklfSU5UX0JMSykpOwogCQlkYnJpLT5kbWEtPmludHJbbiAqIERCUklfSU5UX0JMS10g
PSBkbWFfYWRkcjsKIAl9CiAJZG1hX2FkZHIgPSBkYnJpLT5kbWFfZHZtYSArIGRicmlfZG1hX29m
ZihpbnRyLCAwKTsK

--part44df33de18a70
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part44df33de18a70
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part44df33de18a70--
