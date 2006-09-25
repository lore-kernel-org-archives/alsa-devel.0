From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: :  ALC260 (Re:  ALSA 1.0.13rc2 release)
Date: Mon, 25 Sep 2006 19:55:33 +0200
Message-ID: <1159206933.14557.3.camel@osmosis>
References: <200609250128.k8P1SLth010255@auster.physics.adelaide.edu.au>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1460197062=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609250128.k8P1SLth010255@auster.physics.adelaide.edu.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1460197062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6PrVTj/s2KdUxU4/sZKl"


--=-6PrVTj/s2KdUxU4/sZKl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

> Hi Andrea
>=20
> > I'm sorry to bother you again but every time I try to set an option on
> > snd-hda-intel I get this in syslog:
> >=20
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/../../alsa-kernel/pci/=
hda/patch_realtek.c:4059: hda_codec: Unknown model for ALC260, trying auto-=
probe from BIOS...
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2150:
> > autoconfig: line_outs=3D1 (0xf/0x0/0x0/0x0/0x0)
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2154:
> > speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2156:
> > hp=3D0x0, dig_out=3D0x18, din_in=3D0x0
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2164:
> > inputs: mic=3D0x12, fmic=3D0x0, line=3D0x14, fline=3D0x0, cd=3D0x16, au=
x=3D0x0
> >=20
> > Is it normal?
>=20
> Which options are you trying?  What command line(s) are you using?  If
> you're trying to use the "model=3Dtest" option to modprobe, have you firs=
t
> configured ALSA with the "--enable-debug" option and recompiled/reinstall=
ed?
> If testing alsa from within a standard kernel tree there's a similarly na=
med
> configuration option in the alsa section of "make menuconfig".
>=20
> As Takashi said, the "test" model is only available if debugging has been
> enabled.

My bad, something must have gone wrong and ALSA didn't compile
correctly.
Now snd_hda_intel is loaded with options "disable_msi=3D1 model=3Dtest"

After rebooting I have 8 options that can be set:
* HP-OUT pin mode
* Input source
* Input source
* LINE-OUT pin mode
* LINE1 pin mode
* LINE2 pin mode
* MIC1 pin mode
* MIC2 pin mode

And also 4 switches:
* GPIO pin 0
* GPIO pin 1
* GPIO pin 2
* GPIO pin 3



The only way I could get sound to work (at a normal volume) was with
headphones (connected to the line in plug) and setting "LINE1 pin mode"
to "Line out".
Only that option is needed to be set, any other value in the fields
doesn't change anything and neither do switches.
Attached to this e-mail are outputs of /proc/asound/card0/codec#0/1 and
aplay.

I really hope we get to solve this problem.
Bye.

Andrea


--=20
Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>

--=-6PrVTj/s2KdUxU4/sZKl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGBgVoIXRn+fZcV0RAr+hAKC2LE4WdsussUxgPPpOJ9EGVp6pAgCfSV3+
o1xmDm7RQFL4f8j+B0hHAGE=
=m1kY
-----END PGP SIGNATURE-----

--=-6PrVTj/s2KdUxU4/sZKl--



--===============1460197062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1460197062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1460197062==--
