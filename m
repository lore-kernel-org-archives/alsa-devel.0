From: Andreas Schwab <schwab@suse.de>
Subject: snd-aoa: Add sound-layout-36 alias
Date: Fri, 07 Jul 2006 19:18:28 +0200
Message-ID: <jed5chjpuj.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A960287
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 19:18:29 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.17-git13/sound/aoa/fabrics/snd-aoa-fabric-layout.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17-git13.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-=
06-29 00:59:52.000000000 +0200
+++ linux-2.6.17-git13/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-06-29=
 01:06:02.000000000 +0200
@@ -77,6 +77,7 @@ struct layout {
 	int pcmid;
 };
 =

+MODULE_ALIAS("sound-layout-36");
 MODULE_ALIAS("sound-layout-41");
 MODULE_ALIAS("sound-layout-45");
 MODULE_ALIAS("sound-layout-51");

Andreas.

-- =

Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
