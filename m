From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer
 after period elapse occurs
Date: Tue, 18 Aug 2015 17:35:29 -0700
Message-ID: <20150819003529.GO10748@sirena.org.uk>
References: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
 <20150817195555.GY10748@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718D71126@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3551163182344671925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EDF5265132
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 18:23:00 +0200 (CEST)
In-Reply-To: <0485FB02182A4744A8B06D69AB7BF8E718D71126@ORSMSX113.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fang, Yang A" <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "Mirche,
 Dinesh" <dinesh.mirche@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan, Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============3551163182344671925==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dyeNwb3VXvZMW7tj"
Content-Disposition: inline


--dyeNwb3VXvZMW7tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 05:33:33PM +0000, Fang, Yang A wrote:

> > > We should not read sst hw_ptr and pcm_delay in
> > > sst_platform_pcm_pointer Since it will be ricky if
> > > sst_platform_pcm_pointer is called while dsp is updating the
> > > timestamp.Now read sst hw_ptr after period elapse interrupt occurs.

> > So I guess there's still some risk that we could run into problems here=
 if we
> > take too long to service the interrupt and/or the period is very short?=
  Is
> > there anything we can do to improve that?

>  I think before and after the patch. There is no difference in term of=20
>  handling the period elapse interrupt . because before the patch=20
>  sst_period_elapsed calls the snd_pcm_period_elapsed which in turn=20
>  calling the sst_platform_pcm_pointer which calls the stream_read_tstamp.

I'm not sure I understand what the patch fixes then?  My concern is that
we're just moving the timing around which changes but doesn't address
the race condition.

--dyeNwb3VXvZMW7tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV089QAAoJECTWi3JdVIfQyfEH/iDQcJq92f4/c/WegEJ0rTls
+4wE78PiglZL/dqcRu5D2ep4sR7JO9vk/efNKp8S4oOFribLrb3FxX0g7c5UqpXc
D7EtiNVdhFkpWFfvy3hVepHQJuHzj4Ka5Bf3oioKmSASlLEHqck/olciAQ/Fd4KN
197yOWLqBMZd5EvK7lsnYrqcwrBmhKc/3xG/HL8Hpk314N8xoecYiWXEq5LEJtw1
SkW1CIIgwz9k20Kuf/8mhCl4jbhs7fx15aJ2mODgL4vNOBS6LsXbadCM1ZKxkUhQ
1tR4hm+GQEA9ex6gkuQWCBWC5orNSZNaURz3Eek3PNDzPrMLFXxKCmLM6mKBq6s=
=5IAR
-----END PGP SIGNATURE-----

--dyeNwb3VXvZMW7tj--

--===============3551163182344671925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3551163182344671925==--
