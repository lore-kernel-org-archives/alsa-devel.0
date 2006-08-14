From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] sparc dbri removal of DBRI_NO_INTS
Date: Mon, 14 Aug 2006 19:09:59 +0200
Message-ID: <44e0ae67443c5@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part44e0ae6746ac6"
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

--part44e0ae6746ac6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt (krzysztof.h1@wp.pl)

This patch removes define DBR_NO_INTS and all code related to
handling more than one dbri irq statuses block.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---

There is no reason for additional complexity of handling more
than one irq statuses block. One block stores up to 63 statuses
of not handled interrupts. Anyway, it has been set to one in the
driver for long time (since beginning?).

Regards,
Krzysztof Helt

----------------------------------------------------
Najnowsze odkrycie =B6wiatowej muzyki- smacznej i snobistycznej.
Wschodz=B1ca gwiazda, wybitnie utalentowana Sophie Solomon
wraz z zespo=B3em w Warszawie!!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fsophie_sol=
omon_w_fabryce_trzciny.html&sid=3D846

--part44e0ae6746ac6
Content-Type: application/octet-stream; name="dbri-patch2.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch2.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0xNCAwOTo0NDozNS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMTQgMDk6NDU6NDAuMDAwMDAwMDAwICswMjAwCkBAIC0yMzgsMTIg
KzIzOCw2IEBAIHN0YXRpYyBzdHJ1Y3QgewogI2RlZmluZSBSRUc5CTB4MjRVTAkJLyogSW50ZXJy
dXB0IFF1ZXVlIFBvaW50ZXIgKi8KIAogI2RlZmluZSBEQlJJX05PX0NNRFMJNjQKLSNkZWZpbmUg
REJSSV9OT19JTlRTCTEJLyogTm90ZTogdGhlIHZhbHVlIG9mIHRoaXMgZGVmaW5lIHdhcwotCQkJ
CSAqIG9yaWdpbmFsbHkgMi4gIFRoZSByaW5nYnVmZmVyIHRvIHN0b3JlCi0JCQkJICogaW50ZXJy
dXB0cyBpbiBkbWEgaXMgY3VycmVudGx5IGJyb2tlbi4KLQkJCQkgKiBUaGlzIGlzIGEgdGVtcG9y
YXJ5IGZpeCB1bnRpbCB0aGUgcmluZ2J1ZmZlcgotCQkJCSAqIGlzIGZpeGVkLgotCQkJCSAqLwog
I2RlZmluZSBEQlJJX0lOVF9CTEsJNjQKICNkZWZpbmUgREJSSV9OT19ERVNDUwk2NAogI2RlZmlu
ZSBEQlJJX05PX1BJUEVTCTMyCkBAIC0yNjgsNyArMjYyLDcgQEAgc3RydWN0IGRicmlfbWVtIHsK
ICAqLwogc3RydWN0IGRicmlfZG1hIHsKIAl2b2xhdGlsZSBzMzIgY21kW0RCUklfTk9fQ01EU107
CS8qIFBsYWNlIGZvciBjb21tYW5kcyAgICAgICAqLwotCXZvbGF0aWxlIHMzMiBpbnRyW0RCUklf
Tk9fSU5UUyAqIERCUklfSU5UX0JMS107CS8qIEludGVycnVwdCBmaWVsZCAgKi8KKwl2b2xhdGls
ZSBzMzIgaW50cltEQlJJX0lOVF9CTEtdOwkvKiBJbnRlcnJ1cHQgZmllbGQgICovCiAJc3RydWN0
IGRicmlfbWVtIGRlc2NbREJSSV9OT19ERVNDU107CS8qIFhtaXQvcmVjZWl2ZSBkZXNjcmlwdG9y
cyAqLwogfTsKIApAQCAtNzQxLDE4ICs3MzUsNiBAQCBzdGF0aWMgdm9pZCBkYnJpX2luaXRpYWxp
emUoc3RydWN0IHNuZF9kCiAJZHByaW50ayhEX0dFTiwgImluaXQ6IGNtZDogJXAsIGludDogJXBc
biIsCiAJCSZkYnJpLT5kbWEtPmNtZFswXSwgJmRicmktPmRtYS0+aW50clswXSk7CiAKLQkvKgot
CSAqIEluaXRpYWxpemUgdGhlIGludGVycnVwdCByaW5nYnVmZmVyLgotCSAqLwotCWZvciAobiA9
IDA7IG4gPCBEQlJJX05PX0lOVFMgLSAxOyBuKyspIHsKLQkJZG1hX2FkZHIgPSBkYnJpLT5kbWFf
ZHZtYTsKLQkJZG1hX2FkZHIgKz0gZGJyaV9kbWFfb2ZmKGludHIsICgobiArIDEpICogREJSSV9J
TlRfQkxLKSk7Ci0JCWRicmktPmRtYS0+aW50cltuICogREJSSV9JTlRfQkxLXSA9IGRtYV9hZGRy
OwotCX0KLQlkbWFfYWRkciA9IGRicmktPmRtYV9kdm1hICsgZGJyaV9kbWFfb2ZmKGludHIsIDAp
OwotCWRicmktPmRtYS0+aW50cltuICogREJSSV9JTlRfQkxLXSA9IGRtYV9hZGRyOwotCWRicmkt
PmRicmlfaXJxcCA9IDE7Ci0KIAkvKiBJbml0aWFsaXplIHBpcGVzICovCiAJZm9yIChuID0gMDsg
biA8IERCUklfTk9fUElQRVM7IG4rKykKIAkJZGJyaS0+cGlwZXNbbl0uZGVzYyA9IGRicmktPnBp
cGVzW25dLmZpcnN0X2Rlc2MgPSAtMTsKQEAgLTc2NSw5ICs3NDcsMTQgQEAgc3RhdGljIHZvaWQg
ZGJyaV9pbml0aWFsaXplKHN0cnVjdCBzbmRfZAogCXNidXNfd3JpdGVsKHRtcCwgZGJyaS0+cmVn
cyArIFJFRzApOwogCiAJLyoKLQkgKiBTZXQgdXAgdGhlIGludGVycnVwdCBxdWV1ZQorCSAqIElu
aXRpYWxpemUgdGhlIGludGVycnVwdCByaW5nYnVmZmVyLgogCSAqLwogCWRtYV9hZGRyID0gZGJy
aS0+ZG1hX2R2bWEgKyBkYnJpX2RtYV9vZmYoaW50ciwgMCk7CisJZGJyaS0+ZG1hLT5pbnRyWzBd
ID0gZG1hX2FkZHI7CisJZGJyaS0+ZGJyaV9pcnFwID0gMTsKKwkvKgorCSAqIFNldCB1cCB0aGUg
aW50ZXJydXB0IHF1ZXVlCisJICovCiAJKihjbWQrKykgPSBEQlJJX0NNRChEX0lJUSwgMCwgMCk7
CiAJKihjbWQrKykgPSBkbWFfYWRkcjsKIApAQCAtMTk1MSwxMCArMTkzOCw4IEBAIHN0YXRpYyB2
b2lkIGRicmlfcHJvY2Vzc19pbnRlcnJ1cHRfYnVmZmUKIAl3aGlsZSAoKHggPSBkYnJpLT5kbWEt
PmludHJbZGJyaS0+ZGJyaV9pcnFwXSkgIT0gMCkgewogCQlkYnJpLT5kbWEtPmludHJbZGJyaS0+
ZGJyaV9pcnFwXSA9IDA7CiAJCWRicmktPmRicmlfaXJxcCsrOwotCQlpZiAoZGJyaS0+ZGJyaV9p
cnFwID09IChEQlJJX05PX0lOVFMgKiBEQlJJX0lOVF9CTEspKQorCQlpZiAoZGJyaS0+ZGJyaV9p
cnFwID09IERCUklfSU5UX0JMSykKIAkJCWRicmktPmRicmlfaXJxcCA9IDE7Ci0JCWVsc2UgaWYg
KChkYnJpLT5kYnJpX2lycXAgJiAoREJSSV9JTlRfQkxLIC0gMSkpID09IDApCi0JCQlkYnJpLT5k
YnJpX2lycXArKzsKIAogCQlkYnJpX3Byb2Nlc3Nfb25lX2ludGVycnVwdChkYnJpLCB4KTsKIAl9
Cg==

--part44e0ae6746ac6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part44e0ae6746ac6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part44e0ae6746ac6--
