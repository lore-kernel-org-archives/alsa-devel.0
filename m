From: Jerome Demange <jdemange@cict.fr>
Subject: Sound through laptop speakers for MSI 250
Date: Fri, 13 Oct 2006 23:59:09 +0200
Message-ID: <Pine.SGI.4.53.0610132340040.13657809@ondine.cict.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1008976892-233469292-1160776749=:13657809"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp1.cict.fr (smtp1.cict.fr [195.220.59.41])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 20576187
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Oct 2006 23:59:11 +0200 (MEST)
Received: from smtp1.cict.fr (localhost.localdomain [127.0.0.1])
	by smtp1.cict.fr (8.13.7/8.13.6) with ESMTP id k9DLxAhN030020
	for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2006 23:59:10 +0200
Received: from ondine.cict.fr (ondine.cict.fr [195.220.60.4])
	by smtp1.cict.fr (8.13.7/8.13.6) with ESMTP id k9DLxAmd030017
	for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2006 23:59:10 +0200
Received: from localhost (jdemange@localhost)
	by ondine.cict.fr (8.12.11/8.12.11) with ESMTP id k9DLxAUv14257138
	for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2006 23:59:10 +0200 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1008976892-233469292-1160776749=:13657809
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello, I am still newbie to hg, diff and patch commands, but someone asked
me to make a patch for my soundcard to work. So this patch will add a line
for MSI 250 speaker support ( with subsystem device id = 0061 ) just next
to the 3 already existing for MSI S270, L725 and LG K1 express. So it is
very similar to the 2 following recent patches

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=9233e1d82ed0;style=gitweb

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=3afd242c5c58;style=gitweb

I used diff against the lastest hg repisitory to build the patch.

Thank You.


---1008976892-233469292-1160776749=:13657809
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SGI.4.53.0610132359090.13657809@ondine.cict.fr>
Content-Description: 
Content-Disposition: attachment; filename=patch

LS0tIGEvcGNpL2FjOTcvYWM5N19wYXRjaC5jCTIwMDYtMTAtMTMgMjM6Mjc6
MDMuMDAwMDAwMDAwICswMjAwDQorKysgYi9wY2kvYWM5Ny9hYzk3X3BhdGNo
LmMJMjAwNi0xMC0xMyAyMzoyNzozOC4wMDAwMDAwMDAgKzAyMDANCkBAIC0y
MjYyLDcgKzIyNjIsOCBAQA0KIAkJaWYgKGFjOTctPnN1YnN5c3RlbV92ZW5k
b3IgPT0gMHgxNDYyICYmDQogCQkgICAgKGFjOTctPnN1YnN5c3RlbV9kZXZp
Y2UgPT0gMHgwMTMxIHx8IC8qIE1TSSBTMjcwIGxhcHRvcCAqLw0KIAkJICAg
ICBhYzk3LT5zdWJzeXN0ZW1fZGV2aWNlID09IDB4MDE2MSB8fCAvKiBMRyBL
MSBFeHByZXNzICovDQotCQkgICAgIGFjOTctPnN1YnN5c3RlbV9kZXZpY2Ug
PT0gMHgwMzUxKSkgIC8qIE1TSSBMNzI1IGxhcHRvcCAqLw0KKwkJICAgICBh
Yzk3LT5zdWJzeXN0ZW1fZGV2aWNlID09IDB4MDM1MSB8fCAvKiBNU0kgTDcy
NSBsYXB0b3AgKi8NCisJCSAgICAgYWM5Ny0+c3Vic3lzdGVtX2RldmljZSA9
PSAweDAwNjEpKSAgLyogTVNJIFMyNTAgbGFwdG9wICovDQogCQkJdmFsICY9
IH4oMSA8PCAxKTsgLyogUGluIDQ3IGlzIEVBUEQgKGZvciBpbnRlcm5hbCBz
cGVha2VyKSAqLw0KIAkJZWxzZQ0KIAkJCXZhbCB8PSAoMSA8PCAxKTsgLyog
UGluIDQ3IGlzIHNwZGlmIGlucHV0IHBpbiAqLw0K

---1008976892-233469292-1160776749=:13657809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
---1008976892-233469292-1160776749=:13657809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

---1008976892-233469292-1160776749=:13657809--
