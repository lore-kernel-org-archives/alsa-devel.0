From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: [PATCH] 0.9.7b doesn't compile with kernel 2.4.23-pre7
Date: Mon, 13 Oct 2003 07:20:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0310130719220.22491@dot.kde.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-1610666825-1066022451=:22491"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-1610666825-1066022451=:22491
Content-Type: TEXT/PLAIN; charset=US-ASCII

0.9.7b does a couple of type definitions etc. that are present in 
2.4.23-pre7 headers.

Patch to #if LINUX_VERSION_CODE them attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-1610666825-1066022451=:22491
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-driver-0.9.7b-kernel2.4.23.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0310130720510.22491@dot.kde.org>
Content-Description: 2.4.23-pre7 support
Content-Disposition: attachment; filename="alsa-driver-0.9.7b-kernel2.4.23.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS43Yi9pbmNsdWRlL2Fkcml2ZXIuaC5hcmsJ
MjAwMy0xMC0xMiAyMTo0NDo0NC4wMDAwMDAwMDAgKzAyMDANCisrKyBhbHNh
LWRyaXZlci0wLjkuN2IvaW5jbHVkZS9hZHJpdmVyLmgJMjAwMy0xMC0xMiAy
MTo0NTo0OC4wMDAwMDAwMDAgKzAyMDANCkBAIC0xMjksMTEgKzEyOSwxMyBA
QA0KICNlbmRpZg0KICNpZm5kZWYgQ09ORklHX0hBVkVfUERFDQogI2luY2x1
ZGUgPGxpbnV4L2ZzLmg+DQorI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IEtF
Uk5FTF9WRVJTSU9OKDIsIDQsIDIzKQ0KIHN0YXRpYyBpbmxpbmUgc3RydWN0
IHByb2NfZGlyX2VudHJ5ICpQREUoY29uc3Qgc3RydWN0IGlub2RlICppbm9k
ZSkNCiB7DQogCXJldHVybiAoc3RydWN0IHByb2NfZGlyX2VudHJ5ICopIGlu
b2RlLT51LmdlbmVyaWNfaXA7DQogfQ0KICNlbmRpZg0KKyNlbmRpZg0KICNp
Zm5kZWYgY29uZF9yZXNjaGVkDQogI2RlZmluZSBjb25kX3Jlc2NoZWQoKSBc
DQogCWRvIHsgXA0K

--658386544-1610666825-1066022451=:22491--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
