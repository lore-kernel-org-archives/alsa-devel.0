From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Wed, 9 Jan 2019 19:22:41 +0000
Message-ID: <20190109192241.GN10405@sirena.org.uk>
References: <20181216185429.GA20408@gerhold.net>
 <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
 <20181217180330.GA845@gerhold.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3712927829489043180=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA96926742C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 20:22:44 +0100 (CET)
In-Reply-To: <20181217180330.GA845@gerhold.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3712927829489043180==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Content-Disposition: inline


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 07:03:31PM +0100, Stephan Gerhold wrote:

> Side note:
> I have considered fixing this in the DSDT table a few times before but=20
> have never tried it because it kind of feels wrong to me. It would=20
> probably work, but I believe the kernel is at fault here:

> I've been fixing mistakes and adding missing GPIOs to the DSDT, but is=20
> this really the case here? Everything that is needed for the driver=20
> exists in the ACPI table. If this was a BYT-CR device, it would work=20
> as-is, with no additional modifications.

> Now, in order to fulfill the current expectations for BYT-T devices,
> I would need to add 4 additional IRQs that would never be used.
> But which IRQs would I list there? Dummy/invalid IRQs? To me, that
> does not sound like the DSDT will become any more valid.

> Let me know what you think! :)

This thread appears to have died without a conclusion I can see?  I
don't have strong feelings here, it seems like it's a choice between
different evils so people working on the platform should make the call.

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2SgAACgkQJNaLcl1U
h9DwsQf+OUfLOqPMpz9rL27isif7JFMmktQQGtIrbhUjFxDeAJHruy+lEAboHjF1
HP6yhPveqFGaeBlmu68zYbeHW+x3wA5KE7yZQkFeJ+HUMv8YIuvK5NDzPLGchvhd
/xafxr+w4aDbNhDXK9oT4CnT2OEbTjIQzsKJN2+yo/fMfaBZZHN7+ha8YM6/W6cs
DxNSZ2ePBk3YgqxOHYiUSGj2dDH81eDHvd8hQwrwFgNx+96u6ZKR2xU7yUc6OX/7
rGAY1cvDjC96POjDNs9UtKWLkM/jAavI1tF4iUl/l8jEJ7lTg9jUxGxBDDpK0R8l
qweJBV1/KRKIMD8M28yGKkY9tZLIIQ==
=HpPU
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--

--===============3712927829489043180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3712927829489043180==--
