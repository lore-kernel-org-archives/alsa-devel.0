From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] Maestro2 hw volume fix
Date: Tue, 17 Feb 2004 08:20:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040217062041.GA6708@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch fixes hardware volume buttons on my Dell Inspiron 7000=
=20
laptop. The chip is ESS Maestro2 (0x125d:0x1968).

I have no idea if this will break things for someone else. Since the=20
datasheet didn't help me understand the registers involved I just printed=
=20
their contents and came up with the used bits.

All registers had the following values in my tests:
mute:     0x99
vol down: 0x77
vol up:   0xBB

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maestro_hwvol.patch"

--- alsa-driver-0.9.8/alsa-kernel/pci/es1968.c.orig	2003-10-14 16:59:20.000000000 +0300
+++ alsa-driver-0.9.8/alsa-kernel/pci/es1968.c	2004-02-17 08:06:22.000000000 +0200
@@ -1967,14 +1967,14 @@
 
 	/* FIXME: more clean up is needed.. */
 	val = chip->ac97->regs[AC97_MASTER];
-	if (x & 1) {
+	if (!(x & 2)) {
 		/* mute */
 		snd_ac97_write_cache(chip->ac97, AC97_MASTER, val ^ 0x8000);
 		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       &chip->master_switch->id);
 	} else {
 		val &= 0x7fff;
-		if (((x>>1) & 7) > 4) {
+		if (!(x & 4)) {
 			/* volume up */
 			if ((val & 0xff) > 0)
 				val--;

--IS0zKkzwUGydFO0o--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
