From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
Date: Tue, 26 Jun 2018 15:18:37 +0100
Message-ID: <20180626141837.GF1779@sirena.org.uk>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
 <1530008318.2900.44.camel@baylibre.com>
 <20180626115526.GC1779@sirena.org.uk>
 <1530014920.2900.50.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5788577026255188529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C0F267715
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 16:18:40 +0200 (CEST)
In-Reply-To: <1530014920.2900.50.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jiada_wang@mentor.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============5788577026255188529==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 02:08:40PM +0200, Jerome Brunet wrote:

> From comment here and in other mails, I get that you are not big fan of D=
PCM :)
> It is indeed a complex beast ...

> It there anything else we can use to represent audio routing within the S=
oC ?
> The SoC I'm working on make heavy use of this, unfortunately.=20

The goal is to be able to propagate digital configuration along audio
paths in much the same way as we currently do for power with DAPM.  Lars
did a presentation with a good writeup of a proposal for that at ELC-E a
few years ago.  Unfortunately the only person that is really able to
find time to work on this at the minute is Morimoto-san, this is what
his componentization changes are driving towards - part of the design is
that everything in the system will be a component and we can therefore
treat every device identically.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsySzkACgkQJNaLcl1U
h9BeMAf/S/+T+a9a2BmSaYJTz8xBAweB70bnNa1smJN+ebaAu6zaz5OqOoCzrlh3
LDmZHNQYSVxx28hdko1q7ZjLE42mOWY7Xrs5DEBRCuJHJtfeXzFWsNyAv9tOyBEf
CxwnWsSQNeQftrI9XH1+2CITMbUJ9PR3Ifvu2X2ua5VhJP82qfOLed12H7yWYy6A
fU36dYPLWd5V9l6kFHiO9tbnhLUaVCXx4Faa/HgkmzIp0fzSjRdGU65+K7vjPXaj
GHpNKo3jR+3INlv43zPHwatYpGcmrvGwwQW92TAes8/Nj/Q6Nn7B5yqJAhOUMiiw
aoA4AxHRlnspfQlhZxB/nIXNG7TkTQ==
=aRcD
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

--===============5788577026255188529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5788577026255188529==--
