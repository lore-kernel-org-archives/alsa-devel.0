From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Wed, 29 Jul 2015 22:20:29 +0530
Message-ID: <20150729165029.GG29916@localhost>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8454322648671339175=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E8AD265DF5
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 18:48:43 +0200 (CEST)
In-Reply-To: <20150729123323.GC20130@sirena.org.uk>
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


--===============8454322648671339175==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 01:33:23PM +0100, Mark Brown wrote:
> On Tue, Jul 21, 2015 at 11:53:57PM +0530, Vinod Koul wrote:
>=20
> > +	case SKL_CH_CFG_I2S_DUAL_STEREO_1:
> > +		config =3D (0xFFFF00FF | (SKL_CHANNEL_LEFT << 8)
> > +			| (SKL_CHANNEL_RIGHT << 12));
> > +		break;
> > +
> > +	default:
> > +		config =3D  0xFFFFFFFF;
> > +	}
>=20
> Missing break.
Should default have one always :)

>=20
> > +/*
> > + * Allocates queue for each module.
> > + * if dynamic, the pin_index is allocated 0 to max_pin.
> > + * In static, the pin_index is fixed based on module_id and instance id
> > + */
> > +static int skl_alloc_queue(struct skl_module_pin *mpin,
> > +			struct skl_module_inst_id id, int max)
> > +{
> > +	struct skl_module_pin m_pin =3D skl_get_queue(mpin, id, max);
> > +
> > +	if (m_pin.pin_index < 0)
> > +		return -EINVAL;
> > +
> > +	if (m_pin.is_dynamic) {
> > +			m_pin.in_use =3D true;
> > +			m_pin.id.module_id =3D id.module_id;
> > +			m_pin.id.instance_id =3D id.instance_id;
> > +	}
>=20
> Double indentation here.  It's really unclear to me why a static pin
> doesn't need to get merked as in use?
Oops, will fix

In static pin case, the pins come from topology binary where these are fixed
for a configuration, so don't need to be allocated thus marked and hence
freed.

--=20
~Vinod
--=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuQRVAAoJEHwUBw8lI4NHlR8P/jmfQsaLU2kZVGDD4PglYbjc
/6s7a9Ywc/4NF9eYF5et/DLocTXMbPO+l+zuBJ6VcrI+kpt2awx5DSBPqDm2TqHU
MNmKN5bUuE6hn1PLcEjjZnGKsrVb9jUC5q0DLJ6z0N2PJRNfSG0TApkOac0s5WMQ
cp93IkWu5RYBZx9Ues2IgOu2LCTBwIe+98QoYLnFu6NWSkba18CZlIIsYP+VjlHX
amJuRrtgJxJvmAryqDJ2680LVUZyn5gjvCH+wuYLZIm+KfrcmdJJHViqarrfg8FU
Z7salzsN70ZwMEKiIsIdJuA63nYVQW4IvAM9hhGsCByfKluNHzdzcaLxMTVoBkKh
Hb0Kq2qKftx8Aw+pC0rDbjm3KEQTM4i7cLDBb59MshEaeeST6KGyt5ROFQMoP68s
ZUalOcf+ShpMopRCJiOSbWHwQV7z9H8D3d+r6xU4Xb0Rcmd+Fyq3I2q0absZ8dxY
CFRVZk+bOkk6CsMvDgh3e8k0ZGS8qFgdsUhLDLyBDuzC3ADyxFZD3dAfT52aBXGH
8aNfPdSS0fWEL2SLhzDAJeZ5DQ0Grw9dj4KOY2YbbbsNgJdGtA2OEXn7cqAV3ewG
u+WcqOBJaE1aeSs3UkjGmshmx3ytP4TvV4r+eZkdJOa9FhbWe0nHnJoq7e1hKL/R
0JxuX05mTa/EX7iuNd9n
=nV0Q
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============8454322648671339175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8454322648671339175==--
