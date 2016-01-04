From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Mon, 4 Jan 2016 21:12:24 +0530
Message-ID: <20160104154224.GI2940@localhost>
References: <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
 <20151201025654.GJ3901@localhost>
 <20151201122747.GG1929@sirena.org.uk>
 <20151202052330.GE1854@localhost>
 <20151202103241.GC1929@sirena.org.uk>
 <20151216144806.GO1854@localhost>
 <20151230180344.GB16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0061004535884378660=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EE4532604DF
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 16:38:56 +0100 (CET)
In-Reply-To: <20151230180344.GB16023@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0061004535884378660==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2015 at 06:03:44PM +0000, Mark Brown wrote:
> On Wed, Dec 16, 2015 at 08:18:06PM +0530, Vinod Koul wrote:
> > On Wed, Dec 02, 2015 at 10:32:41AM +0000, Mark Brown wrote:
>=20
> > > But neither of these is a CODEC so why would the CODEC flag be set in
> > > the DAI?  Unless your "Codec" here is genuinely the CODEC rather than
> > > the CPU DAI connected to the CODEC in which case surely this is just a
> > > normal DAI link?
>=20
> > Sorry Mark for late reply..
>=20
> > You are right this is like a normal link, and yes that is _exactly_ we =
need,
> > but we also need parameters to be specified for this as this is hostles=
s.
>=20
> > The moment I add 'params" core will do different connections which do n=
ot
> > work for us.
>=20
> > I am okay if you have something else in mind which solves our problem :)
>=20
> Isn't this what the DPCM fixup() is supposed to handle?

Yes you are right but it doesn't. Fixup will be invoked only when
someone invoked hw_params, but for the loop in this case since we
register a PCM and not a dai-link widget the DAPM trigger for loop
patch does not find any dailink widgets and does not invoke hw_params
or fixup.

Looking at this I think we should modify the snd_soc_dapm_new_dai_widgets()
and add template.event, but not sure if it was cause other issues..

> As I keep
> saying I really think these systems would work a lot better if they were
> representing the DSP as a CODEC, that makes everything much more
> consistent and less riddled with special cases.

The problem is manging DMAs and params, today codec approach does not
help me with these, but yes I will keep looking for ways to enhnace to
core as discussed in the ELC with you :)

Thanks
--=20
~Vinod

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWipLgAAoJEHwUBw8lI4NHsbIP/Am6mt6xZGhICfTB/n2jXg8n
MApGBhvchfG8F1EgZx7wZhyx3/rXcPUJTTi9lx4IjoJ8eSjRtzjmuFk1rYHCq75c
9ra7JamTNW10px1CCp3YPO4eYCYshUJPPKiDupixxd5ynasKXjHEcTfZZbmm1w0C
AunLXKLdAAuPeTcvH7D5GlEQ25OlteDZxH7cpJ8j8D7Pra+DD4qFYetsQTWQoWDA
iWn7pXMqdHiAhuVddz4w8HIMeDimAUpaw+k/kN2DCI1+U2q6rOUsDj0SzwmKnj0q
obRTpA0TosW9+8lycqk7+0bO8UycyxQs0Ra5our2SnKmQnyU+CqQu+Uvp2n78YDd
RElf5aRiayvyuuaUzPgyRoTYlo8PVJUpIj8ZhM5Jf0JIgWm7mz/4Abb50vorrvbZ
Y08o9jsqh8Qc/xanzxjsbMeiEr0X84HbMXFfyUe96ytzMXK4+0HUYxt0fI1woA5m
z6QrW6HAu8C8t4FAc1Jticwng4F/ewLIYuV2WSyh+9n2EySha3fHt/OHUBFy6osF
md2gVoBv54QZnF8JmfK6WM3YUao6xrUEMztgthIp3x8IUtelQ4m/bUDBt0D6mr1I
3N7YAeyZdQ/1rR6SKoNJmngbnxBGj+E06vjQP8Hghi+tEeOHxbttup/gEJSN8oGA
NOfQKjwsrj3c7sEfNJ8E
=q1NN
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--===============0061004535884378660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0061004535884378660==--
