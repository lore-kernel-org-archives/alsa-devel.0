From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] sparc dbri: fixed setting of burst size after
	reset
Date: Thu, 17 Aug 2006 22:08:28 +0200
Message-ID: <44e4ccbc60677@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part44e4ccbc6344f"
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

--part44e4ccbc6344f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt (krzysztof.h1@wp.pl)

A proper way to set DBRI's burst size. The size must be set after
each chip reset.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---


----------------------------------------------------
Najnowsze odkrycie =B6wiatowej muzyki- smacznej i snobistycznej.
Wschodz=B1ca gwiazda, wybitnie utalentowana Sophie Solomon
wraz z zespo=B3em w Warszawie!!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fsophie_sol=
omon_w_fabryce_trzciny.html&sid=3D846

--part44e4ccbc6344f
Content-Type: application/octet-stream; name="dbri-patch7.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch7.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0xNyAyMToyNzozNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMTcgMjE6Mjc6NTMuMDAwMDAwMDAwICswMjAwCkBAIC02OTAsNiAr
NjkwLDcgQEAgc3RhdGljIHZvaWQgZGJyaV9jbWRzZW5kKHN0cnVjdCBzbmRfZGJyaQogc3RhdGlj
IHZvaWQgZGJyaV9yZXNldChzdHJ1Y3Qgc25kX2RicmkgKiBkYnJpKQogewogCWludCBpOworCXUz
MiB0bXA7CiAKIAlkcHJpbnRrKERfR0VOLCAicmVzZXQgMDoleCAyOiV4IDg6JXggOToleFxuIiwK
IAkJc2J1c19yZWFkbChkYnJpLT5yZWdzICsgUkVHMCksCkBAIC02OTksMTMgKzcwMCwyMCBAQCBz
dGF0aWMgdm9pZCBkYnJpX3Jlc2V0KHN0cnVjdCBzbmRfZGJyaSAqCiAJc2J1c193cml0ZWwoRF9S
LCBkYnJpLT5yZWdzICsgUkVHMCk7CS8qIFNvZnQgUmVzZXQgKi8KIAlmb3IgKGkgPSAwOyAoc2J1
c19yZWFkbChkYnJpLT5yZWdzICsgUkVHMCkgJiBEX1IpICYmIGkgPCA2NDsgaSsrKQogCQl1ZGVs
YXkoMTApOworCisJLyogQSBicnV0ZSBhcHByb2FjaCAtIERCUkkgZmFsbHMgYmFjayB0byB3b3Jr
aW5nIGJ1cnN0IHNpemUgYnkgaXRzZWxmCisJICogT24gU1MyMCBEX1MgZG9lcyBub3Qgd29yaywg
c28gZG8gbm90IHRyeSBzbyBoaWdoLiAqLworCXRtcCA9IHNidXNfcmVhZGwoZGJyaS0+cmVncyAr
IFJFRzApOworCXRtcCB8PSBEX0cgfCBEX0U7CisJdG1wICY9IH5EX1M7CisJc2J1c193cml0ZWwo
dG1wLCBkYnJpLT5yZWdzICsgUkVHMCk7CiB9CiAKIC8qIExvY2sgbXVzdCBub3QgYmUgaGVsZCBi
ZWZvcmUgY2FsbGluZyB0aGlzICovCiBzdGF0aWMgdm9pZCBkYnJpX2luaXRpYWxpemUoc3RydWN0
IHNuZF9kYnJpICogZGJyaSkKIHsKIAl2b2xhdGlsZSBzMzIgKmNtZDsKLQl1MzIgZG1hX2FkZHIs
IHRtcDsKKwl1MzIgZG1hX2FkZHI7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlpbnQgbjsKIApA
QCAtNzIxLDEzICs3MjksNiBAQCBzdGF0aWMgdm9pZCBkYnJpX2luaXRpYWxpemUoc3RydWN0IHNu
ZF9kCiAJZm9yIChuID0gMDsgbiA8IERCUklfTk9fUElQRVM7IG4rKykKIAkJZGJyaS0+cGlwZXNb
bl0uZGVzYyA9IGRicmktPnBpcGVzW25dLmZpcnN0X2Rlc2MgPSAtMTsKIAotCS8qIEEgYnJ1dGUg
YXBwcm9hY2ggLSBEQlJJIGZhbGxzIGJhY2sgdG8gd29ya2luZyBidXJzdCBzaXplIGJ5IGl0c2Vs
ZgotCSAqIE9uIFNTMjAgRF9TIGRvZXMgbm90IHdvcmssIHNvIGRvIG5vdCB0cnkgc28gaGlnaC4g
Ki8KLQl0bXAgPSBzYnVzX3JlYWRsKGRicmktPnJlZ3MgKyBSRUcwKTsKLQl0bXAgfD0gRF9HIHwg
RF9FOwotCXRtcCAmPSB+RF9TOwotCXNidXNfd3JpdGVsKHRtcCwgZGJyaS0+cmVncyArIFJFRzAp
OwotCiAJLyoKIAkgKiBJbml0aWFsaXplIHRoZSBpbnRlcnJ1cHQgcmluZ2J1ZmZlci4KIAkgKi8K

--part44e4ccbc6344f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part44e4ccbc6344f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part44e4ccbc6344f--
