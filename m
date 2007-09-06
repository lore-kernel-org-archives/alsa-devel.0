From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: (no subject)
Date: Thu, 06 Sep 2007 07:57:54 +0200
Message-ID: <46df96e29fca2@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46df96e2a23b1"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 18E6E1038CE
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 07:59:31 +0200 (CEST)
Received: from poczta-6.free.wp-sa.pl (HELO localhost) ([10.1.1.13])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 6 Sep 2007 07:57:54 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--part46df96e2a23b1
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The linux/of.h header should be used instead of asm/prom.h.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Stephen Rothwell's post to the LKLM pointed that asm/prom.h
is replaced by linux/of*.h headers from the new OpenFirmware=20
framework .

In case this post got malformed, the patch is attached too.

--- old/sound/sparc/dbri.c	2007-09-04 18:38:20.000000000 +0200
+++ new/sound/sparc/dbri.c	2007-09-06 07:24:46.188427350 +0200
@@ -66,7 +66,7 @@
 #include <sound/control.h>
 #include <sound/initval.h>
=20
-#include <asm/prom.h>
+#include <linux/of.h>
 #include <asm/sbus.h>
 #include <asm/atomic.h>
=20


----------------------------------------------------
Podr=F3=BF w przesz=B3o=B6=E6 - tysi=B1ce atrakcji w ca=B3ej Polsce,
tylko we wrze=B6niu - Zajrzyj na stron=EA Edd.com.pl - Kliknij:
http://klik.wp.pl/?adr=3Dwww.edd.com.pl&sid=3D9

--part46df96e2a23b1
Content-Type: application/octet-stream; name="dbri-include.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-include.diff"

LS0tIG9sZC9zb3VuZC9zcGFyYy9kYnJpLmMJMjAwNy0wOS0wNCAxODozODoyMC4wMDAwMDAwMDAg
KzAyMDAKKysrIG5ldy9zb3VuZC9zcGFyYy9kYnJpLmMJMjAwNy0wOS0wNiAwNzoyNDo0Ni4xODg0
MjczNTAgKzAyMDAKQEAgLTY2LDcgKzY2LDcgQEAKICNpbmNsdWRlIDxzb3VuZC9jb250cm9sLmg+
CiAjaW5jbHVkZSA8c291bmQvaW5pdHZhbC5oPgogCi0jaW5jbHVkZSA8YXNtL3Byb20uaD4KKyNp
bmNsdWRlIDxsaW51eC9vZi5oPgogI2luY2x1ZGUgPGFzbS9zYnVzLmg+CiAjaW5jbHVkZSA8YXNt
L2F0b21pYy5oPgogCg==

--part46df96e2a23b1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--part46df96e2a23b1--
