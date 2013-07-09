From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
Date: Tue, 9 Jul 2013 10:29:17 +0100
Message-ID: <20130709092917.GO27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
 <20130708150721.GK27646@sirena.org.uk>
 <CACQ1gAgJyTSdxAKK7uwG-ybE2ddC90podM3+tOAqQwZUspsU8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4972651622206796902=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACQ1gAgJyTSdxAKK7uwG-ybE2ddC90podM3+tOAqQwZUspsU8Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4972651622206796902==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7FStWnNH2oej3A8m"
Content-Disposition: inline


--7FStWnNH2oej3A8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2013 at 10:19:45AM +0200, Richard Genoud wrote:
> 2013/7/8 Mark Brown <broonie@kernel.org>:

> > The obvious question here is of course if we can use the same driver for
> > both of them.

> I haven't got a g20 to test that, but that's the goal.

I think I do somewhere.

> For now, g20 is still non-DT, so I think it's best to have a DT-only
> driver like this one for the 9x5 family (9g15, 9g25, 9x25, 9g35,
> 9x25).
> When the g20 will move to DT completely, we can drop sam9g20_wm8731.c
> and adjust sam9x5_wm8731.c (mainly master clock and widgets it seems)
> By the way, maybe g45 could use that also (and SAMA5 ?)

If this is the goal then this driver needs a more generic name.

--7FStWnNH2oej3A8m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR29fqAAoJELSic+t+oim9kTUP/RnXfngH4qYtFNxsuGNduDWY
15Xb5BCw5xkGxG0I155ECa/FOvmgatjSIZEKjmTPVuiDgHpTRbPi8df7yQBXkZQB
xKf5PGoW3Zasld8nj5okR6jNNcHM7T+aXtyTM5PD+JylIxoIkRnR3c4Xj9P4COJH
eMncCKIyZ1yFKUkhElBypGLZukR4rkS3dWBxLxl5TthU0RO9uf+T/UhkO9SI4D/c
xPr4Omr7nwD5vcemYfOa5DbxlSUSka5zVZu+E+dFnpFTzjA+dNfIVrx9LxuNmgqR
eVxsBagptVi+AZdjRSUVD7dAktHCyPQ8M5AOikHy2fmH3SR3aXcwVVrnJNHuq7WF
wUPttHxwrI8EnQEjXHno1mb2/siaB6u9fRRh5A6cQ0Bsx3XwZQRB6Ob7HKhuB8JJ
xUvrY3TDUzzOSHVwtfwX5Zg3XRvf2Aa1BVR7D3Hil8ybNcZvFpuKMb7tO25XsFLO
UpnbjU9BNu2K8XxzaTJgPRr/7NVVo6+VUd+OVpFjPxkuGERw22L9dOM5j1H15vn/
RU5TOZ6IXrijBPZxB75v8yKPIK2DdYyUD+KgUMm9q/bNruPUhpTsRmxahNIO41it
ZZWfe4dc0RT3XhV6aZlNVfpx+78Lrukqf30XUT7czTLSg3wPHbdN20JJVMQbW/az
PpVgOwtW0BV6wN7mhVuB
=zh0I
-----END PGP SIGNATURE-----

--7FStWnNH2oej3A8m--


--===============4972651622206796902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4972651622206796902==--
