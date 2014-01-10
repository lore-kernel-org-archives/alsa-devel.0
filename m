From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Grant hw_params()
 permission to reprogram FLL
Date: Fri, 10 Jan 2014 11:42:51 +0000
Message-ID: <20140110114251.GE29039@sirena.org.uk>
References: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109182551.GO12858@sirena.org.uk>
 <20140110101907.GA17106@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8956620190348970930=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07415260202
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 12:43:02 +0100 (CET)
In-Reply-To: <20140110101907.GA17106@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8956620190348970930==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 06:19:08PM +0800, Nicolin Chen wrote:
> On Thu, Jan 09, 2014 at 06:25:51PM +0000, Mark Brown wrote:

> > implement bias level changes for non-CPU paths immediately I'm not sure
> > what that's giving you over just using the bias level (which is the way
> > you're supposed to check if the CODEC is active)?

> Aha, I also feel myself a bit obsessed to this modification while knowing
> so well that you're not very into it. But it might be just because, at
> least to me and according to our SRS of Linux BSP, the flexibility and
> capability here is more important than the extra function - bypass paths.
> (No offense taken, just my own feeling from the angle of a common user.)

Well, the common thing here is to use a sound server like PulseAudio -
=66rom an end user point of view only being able to play one thing at once
isn't great either.  It feels like what you may be trying to do here is
tune down the delay that gets applied after playback stops.  That's
runtime tunable with pmdown_time.

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz9y4AAoJELSic+t+oim98e4P/0udehKXArXDqtZv7+m1/Jdm
3f4ta5FUuMb2jDFNl40ov3HA1H7redilURJgnkMYIayIjbkkbFOrbY4xBl+W9Gyi
DWzNV6ltifpXbu4NrVkEQcMRNNBGSb5ff5ha5CzTPD8YCPobiZNKY6fCGYD8uSTH
JyHFHp5OEMwXyhxFGXjn1b4fXLyCMz2aUpDOUoZR9ZBjvK+R2lONM68F2QLmWVGm
E24nvbdykqJmC7hMm4ZK8o7ym7b1EC4J/tKqW8qZpKjJg0x0ydQoAQuhDxEmr2N/
+zAJ4dE5ATLgIpAovJSeFYedIumx+AHGzCoE3NFmYDimFcm27oCnMjv0j/3fCGr7
eGubr6qXulaPONT0IHQSu36KwGpLmHrY+7OKU1zJS6AMXLkHr4VeHmaf3SekYFnl
HYxTKqfZxmSaLw7xFoJKd9Iy5KRhQeXP2pyPelZkx1UQCmXKEXIxpbojt2Q1gYpm
4RJpQ3O3XxKBOakHH1EK47h8tRI/wZG5mLe0AsULOmEjGy57M3hLvcdOd+LBMyuN
L+xD71sierDVu5dEsb9hJdI2E5QvXUxo+GUzt6ntAtdecyk2cuJVM6IMi0K9GEvo
pGvgin3PvJel6zLI8JBA3wqcT1s036/f0CxrysQMuZpGFn2Aq0i1lKZZTuucNxDv
/fxlbVrt9apkO6ed/jcV
=UBRx
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

--===============8956620190348970930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8956620190348970930==--
