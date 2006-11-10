From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: SB16 ISA max frequency bump to 48kHz
Date: Fri, 10 Nov 2006 07:47:28 +0100
Message-ID: <455420809a154@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part455420809c851"
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

--part455420809c851
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This patch  bumps maximum frequency for ISA SB16 to 48kHz. I
tested it on three cards: SB16 non-pnp, SB16 pnp and SB AWE64
(all ISA boards).

Regards,
Krzysztof Helt

----------------------------------------------------
Champions On Ice - Olimpijscy mistrzowie ta=F1ca na lodzie!
Zobacz spektakularne widowisko - Kliknij:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd33.html&s=
id=3D927

--part455420809c851
Content-Type: text/x-patch; name="sb.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sb.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4xOC5vbGQvc291bmQvaXNhL3NiL3NiMTZfbWFpbi5jIGxpbnV4
LTIuNi4xOC9zb3VuZC9pc2Evc2Ivc2IxNl9tYWluLmMKLS0tIGxpbnV4LTIuNi4xOC5vbGQvc291
bmQvaXNhL3NiL3NiMTZfbWFpbi5jCTIwMDYtMTEtMDkgMTk6MzE6MTkuMDAwMDAwMDAwICswMTAw
CisrKyBsaW51eC0yLjYuMTgvc291bmQvaXNhL3NiL3NiMTZfbWFpbi5jCTIwMDYtMTEtMDkgMTk6
MzQ6NTYuMDAwMDAwMDAwICswMTAwCkBAIC00NzgsOSArNDc4LDkgQEAgc3RhdGljIHN0cnVjdCBz
bmRfcGNtX2hhcmR3YXJlIHNuZF9zYjE2XwogCS5pbmZvID0JCQkoU05EUlZfUENNX0lORk9fTU1B
UCB8IFNORFJWX1BDTV9JTkZPX0lOVEVSTEVBVkVEIHwKIAkJCQkgU05EUlZfUENNX0lORk9fTU1B
UF9WQUxJRCksCiAJLmZvcm1hdHMgPQkJMCwKLQkucmF0ZXMgPQkJU05EUlZfUENNX1JBVEVfQ09O
VElOVU9VUyB8IFNORFJWX1BDTV9SQVRFXzgwMDBfNDQxMDAsCisJLnJhdGVzID0JCVNORFJWX1BD
TV9SQVRFX0NPTlRJTlVPVVMgfCBTTkRSVl9QQ01fUkFURV84MDAwXzQ4MDAwLAogCS5yYXRlX21p
biA9CQk0MDAwLAotCS5yYXRlX21heCA9CQk0NDEwMCwKKwkucmF0ZV9tYXggPQkJNDgwMDAsCiAJ
LmNoYW5uZWxzX21pbiA9CQkxLAogCS5jaGFubmVsc19tYXggPQkJMiwKIAkuYnVmZmVyX2J5dGVz
X21heCA9CSgxMjgqMTAyNCksCkBAIC00OTYsOSArNDk2LDkgQEAgc3RhdGljIHN0cnVjdCBzbmRf
cGNtX2hhcmR3YXJlIHNuZF9zYjE2XwogCS5pbmZvID0JCQkoU05EUlZfUENNX0lORk9fTU1BUCB8
IFNORFJWX1BDTV9JTkZPX0lOVEVSTEVBVkVEIHwKIAkJCQkgU05EUlZfUENNX0lORk9fTU1BUF9W
QUxJRCksCiAJLmZvcm1hdHMgPQkJMCwKLQkucmF0ZXMgPQkJU05EUlZfUENNX1JBVEVfQ09OVElO
VU9VUyB8IFNORFJWX1BDTV9SQVRFXzgwMDBfNDQxMDAsCisJLnJhdGVzID0JCVNORFJWX1BDTV9S
QVRFX0NPTlRJTlVPVVMgfCBTTkRSVl9QQ01fUkFURV84MDAwXzQ4MDAwLAogCS5yYXRlX21pbiA9
CQk0MDAwLAotCS5yYXRlX21heCA9CQk0NDEwMCwKKwkucmF0ZV9tYXggPQkJNDgwMDAsCiAJLmNo
YW5uZWxzX21pbiA9CQkxLAogCS5jaGFubmVsc19tYXggPQkJMiwKIAkuYnVmZmVyX2J5dGVzX21h
eCA9CSgxMjgqMTAyNCksCg==

--part455420809c851
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part455420809c851
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part455420809c851--
