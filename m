From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/9] ASoC: Intel: Skylake: Add
 set_tristate DAI ops to enable SSP MCLK
Date: Fri, 6 Jan 2017 18:32:33 +0000
Message-ID: <20170106183233.n6vbqzyczkclnbtc@sirena.org.uk>
References: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
 <1483341277-14475-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8049391713067083999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BA572677FD
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:32:42 +0100 (CET)
In-Reply-To: <1483341277-14475-3-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8049391713067083999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vknwauanvohsuqpa"
Content-Disposition: inline


--vknwauanvohsuqpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 12:44:29PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> Some machine requires MCLK to be enabled before SSP start up, so add
> set_tristate() DAI ops to enable/disable SSP MCLK. This ops will be
> called from machine which requires early MCLK and removes the usage of
> enabling early MLCK in platform DAI prepare by default which is not
> machine specific.

This isn't an *obvious* use of the tristate operation...

> +	/*
> +	 * To enable ssp clk explicitly before gateway copier is configured,
> +	 * need to use dma control IPC.
> +	 * Disable will be done when DSP gateway copier modules are deleted.
> +	 */
> +	if (!tristate)
> +		return skl_dsp_set_dma_control(ctx, mconfig);

So we never clear this?  And to be frank I'd have no idea looking at
this that it's doing anything to do with clocks though that's a bit of a
separate thing.  It feels like DAPM might be a more natural place to do
this, have a clock widget supplying the AIF widget for the interface.
That'd be a bit more idiomatic.

--vknwauanvohsuqpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhv4sEACgkQJNaLcl1U
h9Ca2Af/cSzPXgx7QzNJju/T1l3o8rnx4q0rYT/U3AjWw7i/UwuFq/kDRcKF0M/I
ZdxXkKvzdeltdzDztKzRi+sIiJj2ohU7lrQKCN5PWoMkrddcbrqdxonb0tpxhrw/
lvojRwJfWB03G7Fj8uXdz3ngdSlg4FlFULbO1fxQ3B3oob7msLGk0H0FRQPvwd8L
qINSO8VQGASP30kSTDyyywSBGNv1TO3zX+zaEkrJnCzsQLnd9Q38hTBMqjONztbP
vYl8hZhHQA8XkiE6RvxXM4ZOG22RJxDdphrNe6H7x5wReDiLWAdhp2C2lpOSfLDi
tXsD7iSpawCRD7x6YuJjsOMLAt9Vlg==
=dF6m
-----END PGP SIGNATURE-----

--vknwauanvohsuqpa--

--===============8049391713067083999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8049391713067083999==--
