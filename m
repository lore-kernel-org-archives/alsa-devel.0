From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/9] ASoC: Intel: Skylake: Driver updates
Date: Thu, 15 Sep 2016 10:07:18 +0530
Message-ID: <20160915043717.GT13920@localhost>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
 <20160914165043.GD27974@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8030692918163621852=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 018E1266636
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 06:28:59 +0200 (CEST)
In-Reply-To: <20160914165043.GD27974@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8030692918163621852==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2016 at 05:50:43PM +0100, Mark Brown wrote:
> On Wed, Aug 24, 2016 at 06:03:12PM +0530, Vinod Koul wrote:
>=20
> >  - The module instance IDs are manged in driver now.
>=20
> > Dharageswari R (5):
> >   ASoC: Intel: Skylake: Unload all the loadable modules
> >   ASoC: Intel: Skylake: Create dynamic instance ids for DSP modules
> >   ASoC: Intel: Skylake: Use private instance id of modules in IPC
> >   ASoC: Intel: Skylake: Table for module instance id and private id
> >   ASoC: Intel: Skylake: Override the actual instance id's to pvt_id's
>=20
> I really don't understand what the point of these changes is at all,
> sorry.  This makes it really hard to tell if they're doing what they're
> supposed to.

No issues, I will try to add more details on these bits.

The point of these changes is to allocate and manage an 'instance id' in
kernel.

Topology gives its own ID but thats just a free running values and we may
have more instance in complete graph than max allowed instance for that
module as not all parts of graph will be operation simultaneously.

So the way is to allocate and manage them in driver. We have used ffz to
maintain the ids, but ffz works on 32 bits, the max instance of some modules
is more than that so we added implementation on top of ffz for 128bits.

Later the patches use this and add a table for quick ref of used ids for
sending to DSPs.

Please do let me know if it helps, will add more details in patch changelog=
s...

Thanks
--=20
~Vinod

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2iV9AAoJEHwUBw8lI4NHOUoP/iKWiRQtLZHgCnX0eQzGxQWS
Fs2GpmzbsjFr+1hi5GomwC2t4kVQhGed/FJWqrlEaq6Z2E+jbWkaryvlw3qfmeRj
H2DbjWQnRGsZgzFlh/q7rvl1tckh4+5GuSluP+IEOezGd1aa4IV0XRPwC2E5TNtF
m0JsrVcmntBcx9FcRYxaWd0ker34UV1LJFhR+9y0VRWj7P9dVE3zxxV71Tg5ASdy
DS62Z8qiqgf2B9KdiWJxUSNTHZHMLGdpUy29rr0zaamoS3V1i2s7U0SfVZbckHfX
inSEI5QBZeqOwPyBYhyYuk1XIb8TMCH4Wn9Xw6rz+C6UoGJHz+Fcu2jqxT2RNfwh
y4L2WmHBY9y2pQ4grdo4GrhtTPvvviN0LKJjGMPDeg4OHdylRKIXOeVoA7uVorIg
Lc4/2kfe5V7m/Spw2fGVTwbdIQe25IhyRjuKCg4u7Tqw7KVVlVdEHXgt8SP+2t5V
Vd3DEnbRP3Z3ukM08TeqJt9LCEnwtyeKwr3efi3bL11xu4+0Bwk+MsfNdqKTACOd
xgmVQ0+A8ghFQ/QU5IKrX2ZrRwl/DnMNFkVkMkx1FWMDNL3xiydFg1iEynO0N3Ve
31Tp3eknTRTKLUkjA4ANWiLC0I/YdjcR2MAGcAq24diYn7KCXG56qbOk2dgWn0+i
DfMPxxre3UuFhc7+VC+D
=kVPT
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============8030692918163621852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8030692918163621852==--
