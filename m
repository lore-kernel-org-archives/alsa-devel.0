From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] sparc dbri: info->offset is now zeroed
Date: Thu, 24 Aug 2006 20:55:38 +0200
Message-ID: <44edf62ae7198@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part44edf62aebeac"
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

--part44edf62aebeac
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt (krzysztof.h1@wp.pl)

This patch fixes two issues:
1. The info->offset is not zeroed when new stream is prepared to
be played or recorded.
2. Incorrect modulo value used in pointer function (pointed out
by Takashi Iwai).

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---


----------------------------------------------------
Nic nie musisz zamawia=E6, nic nie musisz kupowa=E6!
Po prostu odszukaj obrazek i wygraj nagrody:
http://klik.wp.pl/?adr=3Dwww.pasaz.wp.pl%2Fkonkurs.html&sid=3D853

--part44edf62aebeac
Content-Type: application/octet-stream; name="dbri-patch13.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch13.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0yNCAyMDozMzozNS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMjQgMjA6MjE6NDAuMDAwMDAwMDAwICswMjAwCkBAIC02MjgsNyAr
NjI4LDcgQEAgdG8gc2VuZCB0aGVtIHRvIHRoZSBEQlJJLgogCiAqLwogCi0jZGVmaW5lIE1BWExP
T1BTIDEwCisjZGVmaW5lIE1BWExPT1BTIDIwCiAvKgogICogV2FpdCBmb3IgdGhlIGN1cnJlbnQg
Y29tbWFuZCBzdHJpbmcgdG8gZXhlY3V0ZQogICovCkBAIC0yMTEwLDEyICsyMTE4LDEzIEBAIHN0
YXRpYyBpbnQgc25kX2RicmlfcHJlcGFyZShzdHJ1Y3Qgc25kX3AKIAkgKi8KIAlyZXQgPSBzZXR1
cF9kZXNjcyhkYnJpLCBEQlJJX1NUUkVBTU5PKHN1YnN0cmVhbSksCiAJCQkgIHNuZF9wY21fbGli
X3BlcmlvZF9ieXRlcyhzdWJzdHJlYW0pKTsKKwlpbmZvLT5vZmZzZXQgPSAwOwogCiAJcnVudGlt
ZS0+c3RvcF90aHJlc2hvbGQgPSBEQlJJX1REX01BWENOVCAvIHJ1bnRpbWUtPmNoYW5uZWxzOwog
CiAJc3Bpbl91bmxvY2tfaXJxKCZkYnJpLT5sb2NrKTsKIAotCWRwcmludGsoRF9VU1IsICJwcmVw
YXJlIGF1ZGlvIG91dHB1dC4gJWQgYnl0ZXNcbiIsIGluZm8tPnNpemUpOworCWRwcmludGsoRF9V
U1IsICJwcmVwYXJlIGF1ZGlvIG91dHB1dC4gcGlwZSAlZCwgJWQgYnl0ZXNcbiIsIGluZm8tPnBp
cGUsIGluZm8tPnNpemUpOwogCXJldHVybiByZXQ7CiB9CiAKQEAgLTIxNTAsNyArMjE1OSw3IEBA
IHN0YXRpYyBzbmRfcGNtX3VmcmFtZXNfdCBzbmRfZGJyaV9wb2ludGUKIAlzbmRfcGNtX3VmcmFt
ZXNfdCByZXQ7CiAKIAlyZXQgPSBieXRlc190b19mcmFtZXMoc3Vic3RyZWFtLT5ydW50aW1lLCBp
bmZvLT5vZmZzZXQpCi0JCSUgKHN1YnN0cmVhbS0+cnVudGltZS0+YnVmZmVyX3NpemUgKyAxKTsK
KwkJJSBzdWJzdHJlYW0tPnJ1bnRpbWUtPmJ1ZmZlcl9zaXplOwogCWRwcmludGsoRF9VU1IsICJJ
L08gcG9pbnRlcjogJWxkIGZyYW1lcyBvZiAlbGQuXG4iLAogCQlyZXQsIHN1YnN0cmVhbS0+cnVu
dGltZS0+YnVmZmVyX3NpemUpOwogCXJldHVybiByZXQ7Cg==

--part44edf62aebeac
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part44edf62aebeac
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part44edf62aebeac--
