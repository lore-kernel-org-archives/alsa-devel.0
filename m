From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Thu, 30 Jul 2015 08:45:07 +0530
Message-ID: <20150730031507.GI29916@localhost>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
 <20150729165029.GG29916@localhost>
 <20150729175631.GK11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7620965728786863489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C056260688
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 05:13:19 +0200 (CEST)
In-Reply-To: <20150729175631.GK11162@sirena.org.uk>
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


--===============7620965728786863489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 06:56:31PM +0100, Mark Brown wrote:
> On Wed, Jul 29, 2015 at 10:20:29PM +0530, Vinod Koul wrote:
> > On Wed, Jul 29, 2015 at 01:33:23PM +0100, Mark Brown wrote:
>=20
> > > > +static int skl_alloc_queue(struct skl_module_pin *mpin,
> > > > +			struct skl_module_inst_id id, int max)
> > > > +{
> > > > +	struct skl_module_pin m_pin =3D skl_get_queue(mpin, id, max);
> > > > +
> > > > +	if (m_pin.pin_index < 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (m_pin.is_dynamic) {
> > > > +			m_pin.in_use =3D true;
> > > > +			m_pin.id.module_id =3D id.module_id;
> > > > +			m_pin.id.instance_id =3D id.instance_id;
> > > > +	}
>=20
> > > Double indentation here.  It's really unclear to me why a static pin
> > > doesn't need to get merked as in use?
>=20
> > Oops, will fix
>=20
> > In static pin case, the pins come from topology binary where these are =
fixed
> > for a configuration, so don't need to be allocated thus marked and hence
> > freed.
>=20
> But isn't this also protecting against attempts to use the resource
> multiple times within the configuration (or shouldn't we be doing that)?
In case of static since a module pin is allocated while designing
topology we shouldn't have clash as per design of topology

For example I have a Gain module connected to Mixer. Gain module pin 0 will
be allocated to connect to Mixer Pin0. I wont assign Pin0 to any other
module if I am doing static mapping.

Whereas in dynamic we will check for first free pin and allocate.

If all the pins has same meaning then dynamic would make sense, but non
linear modules need reference signals so they have special pins so we need
both approaches here

> Please bear in mind that this stuff has basically zero documentation or
> explanation so I'm kind of guessing as to what this is supposed to do.
I did try to add explanation where I felt was missing, but yes this is good
feedback, I will add more bits in next rev. Also please do point out where
you feel we missed.

Thanks
--=20
~Vinod

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuZa7AAoJEHwUBw8lI4NHuMcP/0ZFFpKtAsBw6KOp/hSXshSZ
lUYFJjW9lV7QV2K0/RowZnhCyRkAHoZQlSrw6V3WCIgMMHSMXLjzvjQ0TlHfsCoR
SghIJ5obGninHeozi/SKwUJ6GRX1XDxYVR8vWDconsZjWMKJmZYtoSEimNzhttUx
vOZybu0F8k31oLzBMCoi3Ukz+wuiaWArYM/7vyje63vVB/vM+O+oswByfxlQOu0u
M55KMsjfrTjraC2OX26waf+Hzbc0HQkZGuYSHbdWdbwaV7hTYJulsZEFHVbu0oc3
jqP+AXZxUpVJCJBZw8UHchTRoDVmTkXp/0PNfGLZMdfhz/DjiELNwM03XAMYxr6f
sHW+grfY297YY8SqZ/FnMbab46+WCRLWscUgwOLRzCJkHsfS9V8Q9cKn2osdRPZG
ZMa4cV4elZDOfNJ+s2bcqLPg7DQ7TpBCQgJx3hZdSIahHnlQofQyuBli1RcBF8/e
elzO7d4TGW0/MBM+ULiOoBecRc/f1w0QTtVNG0AeaNFDXqfYqSnjf1VKm/TKeAzz
hiUyWd0R3147echlRS4w7veb2/SPpUS9oiJgNJO4zgOrSlZd57yNxY3jIVTY2edP
YWoxSUp5HBLcw7LXRptoWD7ElVMcsIAObSizsmw+LJvK4FJ2Zy+Ke+VSxNYRcO2S
9kiEyYDtgS8iyimqD81e
=sDDL
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--

--===============7620965728786863489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7620965728786863489==--
