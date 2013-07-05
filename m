From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Fri, 5 Jul 2013 14:37:52 +0100
Message-ID: <20130705133752.GX27646@sirena.org.uk>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk>
 <1373031306.3233.131.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4471360042159671468=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C5133264EE5
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 15:37:55 +0200 (CEST)
In-Reply-To: <1373031306.3233.131.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============4471360042159671468==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B/AgRt1PX8m/BMcI"
Content-Disposition: inline


--B/AgRt1PX8m/BMcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2013 at 07:05:06PM +0530, Ashish Chavan wrote:
> On Fri, 2013-07-05 at 12:44 +0100, Mark Brown wrote:

> > >  static const struct i2c_device_id da9055_i2c_id[] = {
> > > -	{ "da9055", 0 },
> > > +	{ "da9055-codec", 0 },
> > >  	{ }
> > >  };

> > I can't believe that you've tested this.

> Yes, I have tested this today only. But with 3.6.0-rc4 kernel. That is
> the newest kernel for which I have board and other required support
> available.

Your testing seems like it's not very good then - you do undersand that
the problem that this is supposed to be fixing is that this is a multi
function device?  Please look at how other MFDs in the kernel work.

--B/AgRt1PX8m/BMcI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1swtAAoJELSic+t+oim9N/4P/3IMvnolEj4OiWOiiT70XUjR
0n6BnxhW4n+HnTu2RCGMaGrON/DlT/k5hBEyR4UpTBSXROlDm4VWNSYMH5UWpKpi
eNLg0k2QnDDGSPPiGASsrXReIBHXWvJSWr1bnhuJaQZWV2zkODgSrhhkFw9BI5sR
++C7iG3czIcpbo2iP9ULQDNai6kSYv4IZ6fS8TfFVJTwCiWJk0+SCoDudFxF0j3O
VQqYD54uRPkzpS1Qro4s2MFt7LFSkoPFr0SHoKAkTBrixM0OwhUCoXWUwP+OIPzM
ZUK5vzubDftVG/5YRpD6djCT1vPGLnbZaPQseqD1g/HEefC4svrKrSuTWQTQjw99
5dTbe/IaazjqZrA9Rx/ShIqFsNcatJPNr7WLhXwRJmiBeRErFj/5As7KIEdw4NGj
Bd3tS9aBZwE3M9v2lcB3Cpbc+/6aib6gZBVR8hGKruaB0oGAfzhgz+l/nME/SzKg
0/PM+Q/4MJZbbcMwzU4WebC3OZavuo/IgRyZcbPicBEmuxJ6L6B9GTQ/b5236V1q
OSqSaJXCVGb/DMajIQ1FDKAofrSAc2NU9J6OXsHE0OaZr8twRzcLGtTtJz22G5un
NSSwD2byGzeO7IQC5adD5Lc5oQyr5h2Cew3ek8wVC+BRwHfotV39S5OvK/seRWHY
HxkHHtN8yWWGlgv6pBsV
=O1d2
-----END PGP SIGNATURE-----

--B/AgRt1PX8m/BMcI--

--===============4471360042159671468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4471360042159671468==--
