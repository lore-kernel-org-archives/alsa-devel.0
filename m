From: Mark Brown <broonie@kernel.org>
Subject: Re: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Tue, 13 Oct 2015 13:32:45 +0100
Message-ID: <20151013123245.GF14956@sirena.org.uk>
References: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
 <1444383296.2479.8.camel@loki>
 <CAG5mAdwDFfeJgjsmhYddDvYW1oDDB3AOnPjX8DS4wbSHEADiqA@mail.gmail.com>
 <1444730265.7124.24.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7918869619683365348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A049261A8C
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 14:32:53 +0200 (CEST)
In-Reply-To: <1444730265.7124.24.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Caleb Crome <caleb@crome.org>, "Gautier, Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7918869619683365348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 10:57:45AM +0100, Liam Girdwood wrote:
> On Fri, 2015-10-09 at 09:11 -0700, Caleb Crome wrote:

> > Sorry, I wasn't clear.  The point is to use the 'generic' SPI API in
> > the linux kernel to stream the data, and *not* use an audio format.
> > So, the idea is, the external micro would buffer up a block of data,
> > (in our case, maybe 160 samples * 32 channels  = 10 kBytes), then use
> > the SPI port to read and write to the micro as if it were a memory or
> > something like that to transfer the data.  So the external micro would
> > appear to the CPU as an external register bank, and would do all the
> > audio aggregation.

> Ok, so this sounds like a burst based DAI where the host sends audio
> data in bursts then sleeps. I think this has been done by some codec
> vendors, but I dont know if any code is upstream.

Well, it's not triggerd from the CODEC side which is a bit different to
what the CODEC vendors were trying - it sounds more like what some of
the DSP vendors are doing with bursting data into the DSP over a message
based interface which maps pretty well onto the existing copy()
operation.

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHPnsAAoJECTWi3JdVIfQcJUH/RnqPqNXfuyoRHsKRnW1Gtrf
/tNKB+mjBSieoLmH/DW5DPxh5VkA7kq/8LcBDFOab/UqRCgesBh3cjo0fFwfQ66Z
R4oblF+Azu6cE6iK5EznCzKWXsWNGLCFlfMSWO9VGwhrpsJ/GMSZyW3z50cJu6l8
/aqd89HMV/ll8jlixtzV5qvC3/Dh3aAfL9QTKvjSC6jVm+6Uzg468SLnO3QdSrHJ
yJ7qgglSSO6jus/FrinatxKpbjD2id3Xr56TKW9bvZ5gzGdFhOH9UxxiZEM266z1
NUu1qJm4g41+z3px465p7agM9Rj4avlTu+rSwIU2smOtUZxLQiMFzfd9Bk1Rmzc=
=kZO7
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

--===============7918869619683365348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7918869619683365348==--
