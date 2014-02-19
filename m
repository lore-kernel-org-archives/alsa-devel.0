From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 20:43:03 +0900
Message-ID: <20140219114303.GJ2669@sirena.org.uk>
References: <1392808032-25756-1-git-send-email-zonque@gmail.com>
 <20140219111529.GI2669@sirena.org.uk> <53049467.60106@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7129060852178267600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 024FD2655EE
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:43:39 +0100 (CET)
In-Reply-To: <53049467.60106@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: brian.austin@cirrus.com, subaparts@yandex.ru, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============7129060852178267600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+oKQImcMW7gsUQ7z"
Content-Disposition: inline


--+oKQImcMW7gsUQ7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 12:24:23PM +0100, Daniel Mack wrote:
> On 02/19/2014 12:15 PM, Mark Brown wrote:
> > On Wed, Feb 19, 2014 at 12:07:12PM +0100, Daniel Mack wrote:

> >> +	if (gpio_is_valid(cs4271->gpio_nreset)) {
> >>  		/* Set codec to the reset state */
> >>  		gpio_set_value(cs4271->gpio_nreset, 0);
> >> +		devm_gpio_free(codec->dev, cs4271->gpio_nreset);
> >> +	}

> > If it's being requested as a managed resource shouldn't it be being
> > freed automatically?

> Nope, as the module itself will not go away necessarily. I hit the bug
> when unloading and reloading the machine driver. cs4271_probe(codec)
> will fail to acquire and drive the reset line, and the codec stays in reset.

The fix here is to move the resource acquisition to the bus level probe
instead of the ASoC card startup.

--+oKQImcMW7gsUQ7z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBJjEAAoJELSic+t+oim9dTMQAIN4M/dy08ODjtNceqxaNoTt
G++aaVyDIPoqbGjHXsp5+swX3xrn+adMPQko+8xNNK8h5xuD7VJi/gpRZQnZJeG9
hfa2BX5bBAkQkIFPR0Y2CanEnC2mWjP3EipeV0y0TOg7nzBuCySVgmY/b03p1trM
jjgfiC2Gj93IYgHxEaaJfTwaNOZzg+u3xfj0xn7HWF2DTJ9/NAzb0CaaLKK/Qkqz
PhnLnqrHEh6u2PNBLVRKIVkPRkc/09A3UVi5rO1d+7bH0lEgnj8AX90r5XqsSQaM
ekALONt0Fr8+MHqPj1+5ZdWvgmMKwkfEHaGv9L3LM1xSJMHmyGn5+aExoSBNnwd1
9f0FCvm8ceJuvypQRGBIRDCXHLRbQ14oxGnW/GwufqurAU6htccaSMAC1eMGCaRl
6r4HGsB+lGSPpQl2pBrosjlGYtT7MUfpcA7v4MbohI9H+xvn7yXp7VFWUasXtxdb
Ws3HkHw37bs7WRyEv/mD1GEYLyYi/W4EXHt4FHdcO6Re0ow9k4ogStR3Hso1PtcQ
FFvt8JpK2Rd6rx42Jpbv3h8EPr/MnHcBSVCbsw4ufZKH/SRvzQ2EaungXEY6M19Q
xxuLDBgXRAoIGl6FhwhA6NQEc6c5rSME/DG7kXljMsKnkDoPQQ8lI7JvvKYwd1Ba
8p1HOLfYCjkmOvvHfq6K
=cGw5
-----END PGP SIGNATURE-----

--+oKQImcMW7gsUQ7z--

--===============7129060852178267600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7129060852178267600==--
