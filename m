From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] sparc dbri: OSS layer fix
Date: Sat, 26 Aug 2006 07:27:13 +0200
Message-ID: <44efdbb1ab1ce@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part44efdbb1ad8c7"
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

--part44efdbb1ad8c7
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt (krzysztof.h1@wp.pl)

This patch removes setting of incorrect stop_threshold value
inside the driver. After the change, playback through the OSS
layer works correctly.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---

----------------------------------------------------
Radio Zet Platinum - Blue Eyes to dwup=B3ytowy zestaw=20
utwor=F3w przywo=B3uj=B1cy nastr=F3j wakacyjnego lenistwa.
Ju=BF w sprzeda=BFy!!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fradio_zet_=
platinum.html&sid=3D855

--part44efdbb1ad8c7
Content-Type: application/octet-stream; name="dbri-patch14.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch14.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0yNSAyMzo1Nzo0OS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMjUgMjM6NTE6NTAuMDAwMDAwMDAwICswMjAwCkBAIC0yMTExLDgg
KzIxMTEsNiBAQCBzdGF0aWMgaW50IHNuZF9kYnJpX3ByZXBhcmUoc3RydWN0IHNuZF9wCiAJcmV0
ID0gc2V0dXBfZGVzY3MoZGJyaSwgREJSSV9TVFJFQU1OTyhzdWJzdHJlYW0pLAogCQkJICBzbmRf
cGNtX2xpYl9wZXJpb2RfYnl0ZXMoc3Vic3RyZWFtKSk7CiAKLQlydW50aW1lLT5zdG9wX3RocmVz
aG9sZCA9IERCUklfVERfTUFYQ05UIC8gcnVudGltZS0+Y2hhbm5lbHM7Ci0KIAlzcGluX3VubG9j
a19pcnEoJmRicmktPmxvY2spOwogCiAJZHByaW50ayhEX1VTUiwgInByZXBhcmUgYXVkaW8gb3V0
cHV0LiAlZCBieXRlc1xuIiwgaW5mby0+c2l6ZSk7Cg==

--part44efdbb1ad8c7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--part44efdbb1ad8c7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--part44efdbb1ad8c7--
