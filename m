From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 1/6] ASoC: Intel: mrfld: add the gain
	controls
Date: Wed, 15 Oct 2014 15:08:17 +0200
Message-ID: <20141015130817.GF27755@sirena.org.uk>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
 <1413356701-8535-2-git-send-email-vinod.koul@intel.com>
 <20141015104947.GC27755@sirena.org.uk>
 <20141015102303.GM1638@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1453321414346802332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32BAB260432
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 15:08:42 +0200 (CEST)
In-Reply-To: <20141015102303.GM1638@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1453321414346802332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EM2zIRCtNCod1hEe"
Content-Disposition: inline


--EM2zIRCtNCod1hEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 15, 2014 at 03:53:03PM +0530, Vinod Koul wrote:
> On Wed, Oct 15, 2014 at 12:49:47PM +0200, Mark Brown wrote:
> > On Wed, Oct 15, 2014 at 12:34:56PM +0530, Vinod Koul wrote:

> > > +/* the SST_GAIN macro above will create three alsa controls for each
> > > + * instance invoked, gain, mute and ramp duration, which use the same gain
> > > + * cell sst_gain to keep track of data
> > > + *
> > > + * To calculate number of gain cell instances we need to device by 3 in
> > > + * below caulcation for gain cell memory.
> > > + * This gets rid of static number and issues while adding new controls
> > > + */
> > > +static struct sst_gain_value sst_gains[ARRAY_SIZE(sst_gain_controls)/3];

> > The use of ARRAY_SIZE() is nice here but I'm a bit confused about the
> > divide by 3 - there's an entry in sst_gains referenced for each element
> > in sst_gain_controls.

> Thats is the reason added the comment above.

The comment isn't very clear (splitting it into multiple paragraphs
doesn't help since it looks like the calculation stands separately to
the controls), and everything would be a lot simpler if there were a
define for the number of controls created per SST_GAIN() rather than
just hard coding the magic number.

--EM2zIRCtNCod1hEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPnHBAAoJECTWi3JdVIfQHWQH/AhPcDzeQngd/d8aSkEIAQQ2
LB96k5LGJw1g+7X7GAJ5ILUDvx9IN+oPsM6NTP0c6WeWyJR4+O+C5YKI0TFerENL
tVFJAQp+4QHQbWrzj3XYTOxsWTC2gMMp8eoCrXoA5wKNMWUfNragVbxcoUFZIXYD
8ohn/DRl30kfga1wOMNFDXFJwh7ke8CZYrsHPNEUYSuGPjzfzXLUwgporSkH3dUJ
Z3tnW9ASWU7Zh2mMk0qfDk4GP71qfm2+6yb/PjBx/pas62Sejrpd2ZcsyJryDrnQ
texwwvfYL0RUt+qGsWpVDCmL0ODKQl3GOBrRUdt4XSg1A54TffaNp+sVyOkyxZQ=
=komC
-----END PGP SIGNATURE-----

--EM2zIRCtNCod1hEe--

--===============1453321414346802332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1453321414346802332==--
