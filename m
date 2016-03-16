From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: remove call to
	pci_dev_put
Date: Wed, 16 Mar 2016 21:46:05 +0530
Message-ID: <20160316161605.GX13211@localhost>
References: <1458144438-28912-1-git-send-email-vinod.koul@intel.com>
 <20160316160717.GY2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8618774895469907171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B55692664A9
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 17:11:47 +0100 (CET)
In-Reply-To: <20160316160717.GY2566@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8618774895469907171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2016 at 04:07:17PM +0000, Mark Brown wrote:
> On Wed, Mar 16, 2016 at 09:37:18PM +0530, Vinod Koul wrote:
> > The PCI bus takes pci_dev_get() and pci_dev_put() is also there.
> > So no need for drivers to invoke these. In SKL driver we were
> > calling pci_dev_put() only which is not right, so remove this
>=20
> This doesn't seem to apply against current code (I don't have the
> relevant SHA1s for the dependency) - can you please check and resend?

Thats surprising as I amended the commit in last series and sent this one. I
will re-fetch your tree and do this again.

Thanks
--=20
~Vinod

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6YbFAAoJEHwUBw8lI4NHZ4UP/Rkcvll380+m7DnBxHtX3ANM
bkFs4prUpqVnj7IbLhfpj2SYGfJOto5tnJUNemAj1m73WVx8eFjintNEBgU0rkFO
1/uPeNzr3VtcEiS1RRaZAu34x2YQh1Hgfa+KjgY7Nn7giLit0a3hsInv2RGVLnt+
6HsKztHdfDkdab7HDlXEXo26nXWVoan0INuTZmljeUBo1OngvwMCo6DrEJ6UsJrO
PZiRaQWGMCiHGVtn52Nmzm1mI1y0ufvVb7R7wZOfNmS5/xkE0ktBfladzUJYYsmw
nC1ygFSM4WGWFXcrNNrnhYAfSHF5U83ewDBFDNCDaRARhxIJkc+1bQPv22Ouh4Tc
xyRUy3TQsPE5xuhlizopGNMbfA+t0mkfqAu6QXjvh2/TjEk1dLa5UhG3MQq9uWQc
ekVCaGEeWL5gfzBYXAwI/LMDRyUsqcnSK0kY4rl4bz2z0SZ5pURaGkIPBHb7djv2
i25w6DcV39bo9CbwSAGYAh2DynoyC6RgpU7Ms8JY/JAsLfjkJTLeH3ZL0GrP19iQ
dSCnOM/RadO6fwVeCwPe7ljDmoZpnDFJCEMM8w6m3t5G2jpHyjksvD8VFZGLHfhv
2J+0XQ5JkiussAYfTImopB7WI5FK/2n+SzLHvvayuuvgFtaA3jhBwWFSGFMtU9xl
OXRa0qoaTvtXnq5MnJMr
=4M4g
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--

--===============8618774895469907171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8618774895469907171==--
