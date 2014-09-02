From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Tue, 2 Sep 2014 10:52:25 +0530
Message-ID: <20140902052225.GA1610@intel.com>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140827203737.GY17528@sirena.org.uk>
 <20140901121753.GC12898@vinod.koul@linux.intel.com>
 <20140901125114.GV29327@sirena.org.uk>
 <20140901135702.GA14646@vinod.koul@linux.intel.com>
 <20140901144134.GY29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9150277179861142862=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 46DF126597C
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 07:42:51 +0200 (CEST)
In-Reply-To: <20140901144134.GY29327@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9150277179861142862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2014 at 03:41:34PM +0100, Mark Brown wrote:
> On Mon, Sep 01, 2014 at 07:27:07PM +0530, Subhransu S. Prusty wrote:
> > On Mon, Sep 01, 2014 at 01:51:14PM +0100, Mark Brown wrote:
> > > On Mon, Sep 01, 2014 at 05:47:53PM +0530, Subhransu S. Prusty wrote:
>=20
> > > > > I'd expect much louder complaints if we try to free something tha=
t's not
> > > > > allocated - what happens if we end up reallocating something quic=
kly and
> > > > > then double freeing?  Better to complain if we hit such a code pa=
th.
> > >=20
> > > > "freed" is a block which is passed by the caller to be freed up. Wi=
ll add a
> > > > comment.
>=20
> > > How would that address the problem?  Obviously the caller is trying to
> > > free what they're passing in.
>=20
> > sst_create_block() which allocates the memory and sst_free_block() which
> > frees the memory are called in a synchronous way. A single thread who is
> > allocating waits till a response arrives, if that response is valid then
> > after processing the response the sst_free_block() is called to free up=
 the
> > memory. So the double freeing will not happen. Does this address your c=
oncern?
>=20
> No.  You've described what happens when things are working and
> everything is operating correctly and there are no bugs in the kernel,
> the goal with error checking is to provide robustness against the
> possibility that one of those things isn't true so we can tell what went
> wrong more easily than if we get memory corruption.
Lets assume a wrong case here is triggered due to some other issue. So we
get invoked twice for the same pointer.
Since the function holds the lock and searches the object in the list, only
first access will find the object and start to free it and relinquish the
lock.

Now, the second access will not find this and return, so no harm done.

I agree that we need to at least put a log indicating such a scenario
did occur and we failed to find the object. So we can return immediately
after freeing up and then if we hit end of function implying we haven't fou=
nd
the object we should complain.

Would that help?

--=20
~Vinod

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUBVQRAAoJEHwUBw8lI4NH0j8QALi+o9Yyzqt0UahBuOqlRIGx
okR+A/UuM4Gl6UwwhuvmqcSIHO8QWoUdjCGMyTXAtYwQU65k45KEcWXjxOi27jya
S8Z5m7TtI6IuDnS9mxMVS6PLIQvLiycuzeoSnxhiREMOc1OLmEdcEsiF+/EUSWtQ
gs0QmNi/irvvOs2C7Vc20Vp8Jhg8sim+6o6jYVFGwCQbq4us7YHVwn1BjXSmRRDp
xUNEnRYIY2gywrIJ1rwRYarnVEzGnYvuahu5lmieFaWtunK0eqd7O6R2iiki93KM
i0ko7ox8Y9PdSXwIwBzdku/VI+Kf7rAjjx2aP6nfkzmOnO1ICHn4bziRu2ONhxPq
oD4G7kThSlkIjaKFlooc8vxEBMx0IYAJB2h7M9ZT1xg+CU7yozLS5Ukv2/gXt4zz
wpx0PQ7IBf5pjb6SE1QVRWzXnjM7XsNFmATo5854oScjIZ7tDs4tsnvvnwAx5qoc
YZncaSJezWEWovQQwkzFNhqO8uMXAVZLvyeoZ5A2/RLKRiwAyL+rDNZyeGi/6oLb
lqI1coZXgQ6ZcZK2NmrzFfL4yGY6v4ZP0J5Cb+fNRR0COLrVgmvLXFBCAD8HE5mF
t5qGYdJXF8zT20Yk4W3b6uKJzFKnRIK2Y9zHPMfo7TlWaIqIJDsDA+DV+nYBzYce
Jis6jKdkzDSlZDEuZtyh
=vZsO
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============9150277179861142862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9150277179861142862==--
