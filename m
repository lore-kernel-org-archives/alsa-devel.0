From: wwp <subscript@free.fr>
Subject: Audigy4 support
Date: Wed, 22 Feb 2006 19:40:29 +0100
Message-ID: <20060222194029.1709b043@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_38nbkflWN2y=HlFdlpxfuA6";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

--Sig_38nbkflWN2y=HlFdlpxfuA6
Content-Type: multipart/mixed; boundary=MP_baPVuew5ZC3t0Ga9jvQGeFw

--MP_baPVuew5ZC3t0Ga9jvQGeFw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,


I've got a brand new Audigy4 PCI sound-card, running on Debian unstable
(kernel 2.6.15, feat. Alsa 1.0.10+1.0.11-rc2-2).

I'm able to get PCM out but can't get line-in to work: the alsa mixer allows
un-muting line-in but I can't get the input selector in audacity for instan=
ce.


The exact model is a Creative SoundBlaster Audigy 4 retail (purchase date:
20060219, UK) w/ remote controler RM-1500.

0000:00:0a.0 0401: 1102:0008
Here was lspci says:

0000:00:0a.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
         Subsystem: Creative Labs: Unknown device 1021
		 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
		 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
		 Latency: 32 (500ns min, 5000ns max)
		 Interrupt: pin A routed to IRQ 12
		 Region 0: I/O ports at d400 [size=3D64]
		 Capabilities: [dc] Power Management version 2
				 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3=
cold-)
				 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


I've found that the emu10k1 sources (checked at 1.0.11-rc3) don't include t=
he
card IDs, would the attached patch do it? Would that one be enough to get
proper line-in support?

BTW, is it normal that the chip_detail table shows .id Audigy2 for Audigy4
cards? Is emu10k1 falling back to Audigy2 Value when it doesn't know the
exact card IDs?


Here are some references more:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1868
http://www.creative.com/products/product.asp?category=3D1&subcategory=3D434=
&product=3D14103


Regards,

--=20
wwp

--MP_baPVuew5ZC3t0Ga9jvQGeFw
Content-Type: text/x-patch; name=alsa-driver-1.0.11rc3-audigy4-sb0400.diff
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=alsa-driver-1.0.11rc3-audigy4-sb0400.diff

--- emu10k1_main.c.orig	2006-02-22 18:24:06.000000000 +0100
+++ emu10k1_main.c	2006-02-22 18:24:12.000000000 +0100
@@ -824,6 +824,16 @@
 	 .emu10k2_chip =3D 1,
 	 .ca0102_chip =3D 1,
 	 .emu1212m =3D 1} ,
+	/* Tested by claws 22nd February 2006 */
+	{.vendor =3D 0x1102, .device =3D 0x0004, .subsystem =3D 0x20081102,
+	 .driver =3D "Audigy2", .name =3D "Audigy 4 [SB0400]",=20
+	 .id =3D "Audigy2",
+	 .emu10k2_chip =3D 1,
+	 .ca0102_chip =3D 1,
+	 .ca0151_chip =3D 1,
+	 .spk71 =3D 1,
+	 .spdif_bug =3D 1,
+	 .ac97_chip =3D 1} ,
 	/* Tested by James@superbug.co.uk 3rd July 2005 */
 	{.vendor =3D 0x1102, .device =3D 0x0004, .subsystem =3D 0x20071102,
 	 .driver =3D "Audigy2", .name =3D "Audigy 4 PRO [SB0380]",=20
--- p16v.c.orig	2005-12-22 18:01:20.000000000 +0100
+++ p16v.c	2006-02-22 18:24:46.000000000 +0100
@@ -118,6 +118,7 @@
  * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:1007 -> Audigy2 6.1    M=
odel:SB0240
  * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:1002 -> Audigy2 Platinum=
  Model:SB msb0240230009266
  * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:2007 -> Audigy4 Pro Mode=
l:SB0380 M1SB0380472001901E
+ * Class 0401: 1102:0004 (rev 04) Subsystem: 1102:2008 -> Audigy4 Model:SB=
0400
  *
  */
=20

--MP_baPVuew5ZC3t0Ga9jvQGeFw--

--Sig_38nbkflWN2y=HlFdlpxfuA6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFD/LAhadgnuQFKG88RAuUaAJoClzgln9zpVVgzvm1GkXUY0mHg5QCdFtVl
XJGjrk5tpegV0vBVaHsc0I8=
=/T9M
-----END PGP SIGNATURE-----

--Sig_38nbkflWN2y=HlFdlpxfuA6--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
