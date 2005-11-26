From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: About my Live! 5.1
Date: Sat, 26 Nov 2005 10:40:37 +0100
Message-ID: <200511261040.47678.alien999999999@users.sourceforge.net>
References: <43875FC3.9040408@demiart.ru> <1132950843.20390.62.camel@mindpipe> <438801BA.4050504@demiart.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1291587.sItPUp2WRr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <438801BA.4050504@demiart.ru>
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
Cc: Alexandr <spiro@demiart.ru>, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

--nextPart1291587.sItPUp2WRr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I too have the SB0220

[]$ lspci -vvv
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs: Unknown device 8066
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at ec00 [size=3D32]
        Capabilities: <available only to root>

00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
=20
0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at b000 [size=3D8]
        Capabilities: <available only to root>

[]$lspci -vvvn
00:0d.0 Class 0401: 1102:0002 (rev 0a)
        Subsystem: 1102:8066
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at ec00 [size=3D32]
        Capabilities: <available only to root>

00:0d.1 Class 0980: 1102:7002 (rev 0a)
        Subsystem: 1102:0020
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at b000 [size=3D8]
        Capabilities: <available only to root>



Op zaterdag 26 november 2005 07:33, schreef Alexandr:
> Lee Revell wrote:
> >On Fri, 2005-11-25 at 21:02 +0200, Alexandr wrote:
> >>Hi, Lee !
> >>
> >>
> >>Model is "sb0220" correctly
> >
> >OK try this patch.
> >
> >---
> > /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-11=
=2D0
> >5 16:25:13.000000000 -0500 +++
> > /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-=
25
> > 15:28:47.000000000 -0500 @@ -752,9 +752,16 @@
> > 	 .emu10k1_chip =3D 1,
> > 	 .ac97_chip =3D 1,
> > 	 .sblive51 =3D 1} ,
> >+	/* Tested by Alexandr 25th Nov 2005 */
> >+	{.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x80661102,
> >+	 .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0220]",
> >+	 .id =3D "Live",
> >+	 .emu10k1_chip =3D 1,
> >+	 .ac97_chip =3D 1,
> >+	 .sblive51 =3D 1} ,
> > 	/* Tested by Thomas Zehetbauer 27th Aug 2005 */
> > 	{.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x80651102,
> >-	 .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0220]",
> >+	 .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0222]",
> > 	 .id =3D "Live",
> > 	 .emu10k1_chip =3D 1,
> > 	 .ac97_chip =3D 1,
>
> Ok. Right now it detect correctly:
>
> bash-3.00# cat /proc/asound/cards
> 0 [Live           ]: EMU10K1 - SB Live 5.1 [SB0220]
>                      SB Live 5.1 [SB0220] (rev.10, serial:0x80661102) at
> 0xd000, irq 5
>
> Tnx !
>
>  But still problem with alsamixer:
>
> bash-3.00# alsamixer
> ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
> Volume',0,0,0) appears twice or more
>
> alsamixer: function snd_mixer_load failed: Invalid argument

--nextPart1291587.sItPUp2WRr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDiC2fuBWKXETrtdcRAilTAJ9c9tY+DxyGM3o536FXYLsXQVc9wQCgrxYr
rULGbTgROJTUVej9WZgJ45g=
=MoAZ
-----END PGP SIGNATURE-----

--nextPart1291587.sItPUp2WRr--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
