From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: [PATCH] 0.9.7b doesn't compile with [p]ac series kernels
Date: Mon, 13 Oct 2003 07:23:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0310130722050.22491@dot.kde.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-1758202847-1066022617=:22491"
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

--658386544-1758202847-1066022617=:22491
Content-Type: TEXT/PLAIN; charset=US-ASCII

Since the -[p]ac kernel patch series make tty counts atomic, ALSA's 
serialmidi.c fails to compile.

Patch attached; this breaks "normal" kernels though [guess we need a 
configure check for atomic tty->count; I haven't done that yet]

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-1758202847-1066022617=:22491
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-0.9.7b-ac.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0310130723370.22491@dot.kde.org>
Content-Description: -[p]ac kernel patch
Content-Disposition: attachment; filename="alsa-0.9.7b-ac.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS43Yi9kcml2ZXJzL3NlcmlhbG1pZGkuYy5i
ZXJvCTIwMDMtMDQtMTUgMDE6MDg6NDEuMDAwMDAwMDAwICswMjAwDQorKysg
YWxzYS1kcml2ZXItMC45LjdiL2RyaXZlcnMvc2VyaWFsbWlkaS5jCTIwMDMt
MDQtMTUgMDE6MDg6NTIuMDAwMDAwMDAwICswMjAwDQpAQCAtMTU1LDcgKzE1
NSw3IEBADQogCQlyZXR2YWwgPSAtRUlPOw0KIAkJZ290byBfX2VuZDsNCiAJ
fQ0KLQlpZiAodHR5LT5jb3VudCA+IDEpIHsNCisJaWYgKGF0b21pY19yZWFk
KCZ0dHktPmNvdW50KSA+IDEpIHsNCiAJCXNuZF9wcmludGsoS0VSTl9FUlIg
InR0eSAlcyBpcyBhbHJlYWR5IHVzZWQiLCBzZXJpYWwtPnNkZXYpOw0KIAkJ
cmV0dmFsID0gLUVCVVNZOw0KIAkJZ290byBfX2VuZDsNCg==

--658386544-1758202847-1066022617=:22491--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
