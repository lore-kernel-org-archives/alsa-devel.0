From: Mark Brown <broonie@kernel.org>
Subject: Re: Feasibility of adding alternative audio transport
 besides I2S/PWM/SPDIF, etc
Date: Tue, 13 Oct 2015 16:37:57 +0100
Message-ID: <20151013153757.GI14956@sirena.org.uk>
References: <CAG5mAdwOugskZrHHzeQ-GSu6mAZoN3nybOvupB09FBk2oTwJnw@mail.gmail.com>
 <1444383296.2479.8.camel@loki>
 <CAG5mAdwDFfeJgjsmhYddDvYW1oDDB3AOnPjX8DS4wbSHEADiqA@mail.gmail.com>
 <1444730265.7124.24.camel@loki>
 <20151013123245.GF14956@sirena.org.uk>
 <CAG5mAdzTihx=4xpneEbNoEwqdrRkspgqqu=pjGZwxonaRc37SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5289682219539479276=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61D95261AA1
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 17:38:08 +0200 (CEST)
In-Reply-To: <CAG5mAdzTihx=4xpneEbNoEwqdrRkspgqqu=pjGZwxonaRc37SQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5289682219539479276==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 08:33:26AM -0700, Caleb Crome wrote:
> On Tue, Oct 13, 2015 at 5:32 AM, Mark Brown <broonie@kernel.org> wrote:

> > Well, it's not triggerd from the CODEC side which is a bit different to
> > what the CODEC vendors were trying - it sounds more like what some of
> > the DSP vendors are doing with bursting data into the DSP over a message
> > based interface which maps pretty well onto the existing copy()
> > operation.

> That sounds right.  Send over a messaging interface, rather than an
> audio interface.  Which copy() operation do you mean?

The one in snd_pcm_ops.

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHSVVAAoJECTWi3JdVIfQnwsH/jBRL60Wn0yQiLbGRXf3I7T1
YhbNG6piq3Iv8AP/ebXgv1RQu4iBswhH6KHCOjFxn5tNX1MMnUAQdvirXQ+Z8sBu
gokF+ZlL5LZYYhbPl9Cq6Q8wD9regFEwVJHxCFJriX7U3lNct+NEFOIAbuz59n2w
qvKh7G7+QuFtnLXXdfbd0J6iGKKNmzwvZa1hoxT4CnWyA0ZNPiXuDd5lGjfNbzSl
GpI5Z0yxo1AvlKvX2uoqZBGwT4hZ0TPKItTgZbB1qgQt/ylVUq4PA8HDyUqumNdh
Ntxv0USDIzdCBUvUm2GrSJv/boZU4xS5J++6nIjJOwuXdDIIW1oGG0mAkMOZgJY=
=20jT
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--

--===============5289682219539479276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5289682219539479276==--
