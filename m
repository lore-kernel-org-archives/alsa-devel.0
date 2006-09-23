From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: ALC260 (Re:  ALSA 1.0.13rc2 release)
Date: Sat, 23 Sep 2006 23:59:30 +0200
Message-ID: <1159048770.20808.4.camel@osmosis>
References: <Pine.LNX.4.61.0609151756270.7856@tm8103.perex-int.cz>
	<s5h7izzj4bt.wl%tiwai@suse.de>
	<1158702611.2360.4.camel@osmosis.gnet.eu>
	<s5h3bamhovj.wl%tiwai@suse.de>
	<1158746209.12107.9.camel@osmosis.gnet.eu>
	<s5h4pv2fpfp.wl%tiwai@suse.de>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1011721950=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4pv2fpfp.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1011721950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-r9TX9bdYPv7cO+6KenL2"


--=-r9TX9bdYPv7cO+6KenL2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm sorry to bother you again but every time I try to set an option on
snd-hda-intel I get this in syslog:

Sep 23 22:31:33 stariez kernel:
ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/../../alsa-kernel/pci/hda/=
patch_realtek.c:4059: hda_codec: Unknown model for ALC260, trying auto-prob=
e from BIOS...
Sep 23 22:31:33 stariez kernel:
ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2150:
autoconfig: line_outs=3D1 (0xf/0x0/0x0/0x0/0x0)
Sep 23 22:31:33 stariez kernel:
ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2154:
speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Sep 23 22:31:33 stariez kernel:
ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2156:
hp=3D0x0, dig_out=3D0x18, din_in=3D0x0
Sep 23 22:31:33 stariez kernel:
ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2164:
inputs: mic=3D0x12, fmic=3D0x0, line=3D0x14, fline=3D0x0, cd=3D0x16, aux=3D=
0x0

Is it normal?


On Wed, 2006-09-20 at 18:55 +0200, Takashi Iwai wrote:
> At Wed, 20 Sep 2006 11:56:49 +0200,
> Andrea Gozzi wrote:
> >=20
> > On Wed, 2006-09-20 at 11:24 +0200, Takashi Iwai wrote:
> > > At Tue, 19 Sep 2006 23:50:11 +0200,
> > > Andrea Gozzi wrote:
> > > >=20
> > > > Setting the disable_msi=3D1 option changed nothing.
> > > > My soundcard didn't work before and neither now.
> > >=20
> > > That's another problem.  We handle here only regressions.
> > > (And describe "doesn't work" more exactly, please...)
> > >=20
> >=20
> > Sorry, I tried :)
> >=20
> > Basically, the problem is that no sound comes out of the speakers and
> > you can only hear something from the S/PDIF plug at a very low volume.
> > The hardware is an Intel ICH7 with ALC260 chipset on a PB V7900 laptop.
> > I tried every possible configuration but still nothing, so I'm just
> > waiting for the ALSA release that will fix this.
>=20
> Ah, this beast...  Yeah, I know this problem still remains.
>=20
> Still wondering whether you get any reasonable I/Os by using
> model=3Dtest (after compiling with debug option).  Fortunately, ALC260
> has this option.  Usually you get most of I/Os by tuning up this.
>=20
> Once after you find out the good setting, write up the static table
> according to the test result.
>=20
>=20
> Takashi

--=20
Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>

--=-r9TX9bdYPv7cO+6KenL2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFFa5CoIXRn+fZcV0RAlHWAJ484QtIwpgKnKOO7oXrECEcfuDNFgCgn4Lu
YPZFW3rfgQ1o4wNYRkpYwFc=
=tO/z
-----END PGP SIGNATURE-----

--=-r9TX9bdYPv7cO+6KenL2--



--===============1011721950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1011721950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1011721950==--
