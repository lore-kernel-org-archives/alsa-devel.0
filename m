From: Nico Schottelius <nico-linux-alsa@schottelius.org>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Wed, 21 Apr 2004 14:04:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040421120454.GC2295@schottelius.org>
References: <200404171945.35824.bero@arklinux.org> <s5hd663q6fs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scice.schottelius.org (pD9E358BC.dip.t-dialin.net [217.227.88.188])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id OAA32075
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2004 14:03:26 +0200
Content-Disposition: inline
In-Reply-To: <s5hd663q6fs.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai [Tue, Apr 20, 2004 at 12:39:35PM +0200]:
> At Sat, 17 Apr 2004 19:45:35 +0200,
> Bernhard Rosenkraenzer wrote:
> >=20
> > Hi,
> > On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID 1019:0f22),=
=20
> > snd_ali5451 loads and can adjust mixer settings (except for PCM volume,=
 but I=20
> > think that's a limitation of the hardware), but doesn't make any noise =
-=20
> > apparently PCM is always muted (volume fixed at 0?).
>=20
> there is no PCM volume on CM9739.  it has only PCM mute switch.
> you can mute on/off via 'M' key of alsamixer.

Does that mean I have _no_ possibility to adjust the volume?

How do I find out if I got the CM9739? This is what lspci shows:

-------------------- snip ----------------

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Cont=
roller Au
dio Device (rev 02)
        Subsystem: Elitegroup Computer Systems: Unknown device 0f22
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping
- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <M
Abort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=3D256]
        Region 1: Memory at effac000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: <available only to root>


-------------------- snap ----------------

Greetings,

Nico


--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhmNlzGnTqo0OJ6QRAqIEAJ40SVs4BvWLYAGkXurVnenTDJ2aZQCeMdH+
XokbxzqqKfCqvYvYMiMDR2w=
=MiwD
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
