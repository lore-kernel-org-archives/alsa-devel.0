From: pizza@fucktheusers.org
Subject: intel8x0 broken in cvs head
Date: Fri, 6 Sep 2002 00:35:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020906043550.GA15677@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a Dell Inspiron 4100; it has an i830M chipset with a CS4205 hanging =
off
the side:

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2485=
 (rev 01)
        Subsystem: Cirrus Logic: Unknown device 5959
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at d800 [size=3D256]
        I/O ports at dc80 [size=3D64]

alsa 0.9.0rc3 worked most of the time, with occasional stuttering.  hence t=
he=20
experimental upgrade.   I'm running kernel 2.4.20-pre5.

I installed the CVS head, and this is what happens on module load:

PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
PCI: Sharing IRQ 11 with 02:03.0
PCI: Setting latency timer of device 00:1f.5 to 64
Intel ICH soundcard not found or device busy

And that's it.  It also does this on a cold boot.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
I'm not broke, but I'm badly bent.                         ICQ #1318344
Patience comes to those who wait.                         Melbourne, FL
               Quidquid latine dictum sit, altum viditur

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9eDCmPuLgii2759ARAlmeAJ4hbEdhisGe8SlF9v6HMvBR4Ur2WQCgvn5f
YJWrmkO9LBH9oVEXfx8540s=
=jbpI
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
