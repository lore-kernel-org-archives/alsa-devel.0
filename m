From: Andreas Schwab <schwab@suse.de>
Subject: [PPC,SOUND] Fix audio gpio state detection
Date: Sat, 11 Feb 2006 17:10:29 +0100
Message-ID: <jehd7527wq.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D2A31A9
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2006 17:10:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

When booting with line out or headphone plugged, you won't hear anything.
The problem is that after reset all channels are muted, but the actual
value of the gpio port doesn't exactly match the active_val settings as
expected by check_audio_gpio.  For example, the line_mute port is set to
7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
indicates that it is not active, even though it is.  AFAICS only looking
at the low bit is enough to determine whether the port is active.

Signed-off-by: Andreas Schwab <schwab@suse.de>

Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.0000000=
00 +0100
+++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0=
100
@@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
=20
 	ret =3D do_gpio_read(gp);
=20
-	return (ret & 0xd) =3D=3D (gp->active_val & 0xd);
+	return (ret & 0x1) =3D=3D (gp->active_val & 0x1);
 }
=20
 static int read_audio_gpio(struct pmac_gpio *gp)

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED=
5
"And now for something completely different."


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
