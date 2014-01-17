From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8804: Allow control of master
 clock divider in PLL generation
Date: Fri, 17 Jan 2014 00:54:37 +0000
Message-ID: <20140117005437.GQ17314@sirena.org.uk>
References: <alpine.DEB.2.02.1401142030110.23472@parallels-Parallels-Virtual-Platform>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1638346888527606248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D220C264F8F
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 01:54:47 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1401142030110.23472@parallels-Parallels-Virtual-Platform>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Matuschek <daniel@matuschek.net>
Cc: alsa-devel@alsa-project.org, Dimitris.Papastamos@wolfsonmicro.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1638346888527606248==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SlnaBQtdWG0gYnqZ"
Content-Disposition: inline


--SlnaBQtdWG0gYnqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 08:34:10PM +0100, Daniel Matuschek wrote:
> WM8804 can run with PLL frequencies of 256xfs and 128xfs for
> most sample rates. At 192kHz only 128xfs is supported. The
> existing driver selects 128xfs automatically for some lower

Charles (or someone else from Wolfson), you commented on previous
versions of this - are you still OK with it?

--SlnaBQtdWG0gYnqZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2H9KAAoJELSic+t+oim9W0wQAIWi+Mk+3vMrY7U7262sZkkZ
25sCTTTfuvDXcEqt3DmnTfhNWALWBEUsNKmuiX/rK1TcSemRxuSeG+ydJSvJYE4U
+wwaNlOs1dmcgQF+4xlyG6H3G7l2Zap8loP9Td2IGrZkSv++WF4B+W3j/caMzhJ2
pjMiMrSN32Tzaezmbd0sjXM7R2bJhLy2xJG+zzm+D9X/Mnw+mkkEtLbHVOuKgL2D
sjIN95DoTWlHU0zNEALn2X2SPAWuV+iOqG86Y6I/0iD6vMvvaE0iYB8kG28xn85f
WSxk8me0fyAFtA5Rxy8SHiBLV1vYvywP65I6HwNPp0GL0KLShis9KWQHoYbpDm/h
ZArZ1rcANeiFFP3ykCPH8Uk28StN4Lq4CvKX2L+PrzuTX/NYthe07AVy+4R1IHIi
Evge0tNOEdD1vf91iQzCsskDzMGsIim6XbiIuEp5nw/O/cAOegeOitPHGNjsUGMS
wvXkqDJgTfKE/gpLGVrxiGosQGj/jE1vCGomd85KgEj093isGcmG0VHASBU/q1G+
4y1pMIIXI7bHRz/47uMQuJyRmdPSuSGLZufTiLhlSW/6Fq+AQNoGTrhCF14XF/mi
Myq6e3wxyaOUDP9dG3n1eBo70/l3oWdzwkPriiII0FoD9ZfmaMxbFSgxbJrYgHvF
k2gWqtMToYDoLzqb71yu
=OayP
-----END PGP SIGNATURE-----

--SlnaBQtdWG0gYnqZ--

--===============1638346888527606248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1638346888527606248==--
