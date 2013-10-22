From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH RESEND] ASoC: dont call dapm_sync while
 reporting jack always
Date: Tue, 22 Oct 2013 21:06:54 +0530
Message-ID: <20131022153654.GQ14013@intel.com>
References: <1382362654-26213-1-git-send-email-vinod.koul@intel.com>
 <20131022083223.GA20821@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4483221699321421616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B9BE1260783
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 18:30:54 +0200 (CEST)
In-Reply-To: <20131022083223.GA20821@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4483221699321421616==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2013 at 09:32:23AM +0100, Mark Brown wrote:
> On Mon, Oct 21, 2013 at 07:07:34PM +0530, Vinod Koul wrote:
> > While reporting the jack status snd_soc_jack_report() invokes snd_soc_d=
apm_sync()
> > always. This should be required when we have pins associated with jack =
and
> > reporting enables or disables these.
> > So add a check for this case
>=20
> Applied, thanks.  It'd be good when doing things like this to say what
> the advantage is; with DAPM the general thing is that it gets called a
> lot so it should be cheap enough to just call all the time.
Okay, my thoughts were that it was obvious. We saw an issue when monkey tes=
ting
with jack, bunch of dapm_sync's got triggered (insertion, reroute from user=
mode,
removal, again reroute from usermode, and so on). The insertion and removal=
 ones
were quite not required for cases with no pins

--=20
~Vinod

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSZpuWAAoJEHwUBw8lI4NHtyIQALVVulW6aJNwoF+eWROezp2M
uB5cEcoAzlegJqrT6VV/Zk/W8JKt1I/4Nd9zhZANqVNYzWe0lN3NSj7WGMyGY60U
hY1g2kiX+D9EKOfUVMIyUzp/y69nS5oVLOePTERX3RCoSili5yXYEKTotUAnGIRj
QlzFNmM2pEmLSxfys7vgH55WpnQnH56G6OZG/GX80AruHY5TTiIIEF9dKZ86ije9
UNN4GIOA2twC/qwpCVOaYcG1F0nDCfHWE6LGEhKxuz4ONfep63XW2veE7Mb+uT58
YhYxaOwISCKRWgGaDhn8/o6xhw7vHdE0AnXuZ0iodwXk0vYuEHAllhmiL0M55qUd
VRUBY7aHbQARpLHFbFP6valj5v0QzHK59i7WoL4ZvzSgPNGB+O00otN0yzoD5kQ5
U9ZbHuqiSS5HNvax9T9OCgsZaRsvGgoGN15yk37xGN6pa8dBmui0m0dYymZWzmK2
qf09xfWT0dev1+SzlNaJYCdPR0uTko/X3xvjFPGDd36Nde9n3YM5X0+pcKLklGsI
XZRSFabLsB1a3rRZAEVTTMo/R89lmm6UVXq1EDeviP9JxKhShOQMbD7Ezdlg/h6y
m+maqXuCqAcIzbEl8j6Ogt7VGmiviBCRarh9JkDaSzDaGUqB2j2dYtR2IUN4V79c
7eQyPAk+dHZXMdwLWcml
=lNWG
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

--===============4483221699321421616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4483221699321421616==--
