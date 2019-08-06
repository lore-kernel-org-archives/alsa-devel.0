From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/28] ASoC: soc-core: don't check widget
 for snd_soc_dapm_new_controls()
Date: Tue, 6 Aug 2019 19:07:10 +0100
Message-ID: <20190806180710.GF4527@sirena.org.uk>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87r25z2ihd.wl-kuninori.morimoto.gx@renesas.com>
 <203f012de6a77b8994060448b30dc795f03a0528.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0577432686455028227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CAFEF800F3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 20:07:13 +0200 (CEST)
In-Reply-To: <203f012de6a77b8994060448b30dc795f03a0528.camel@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0577432686455028227==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2019 at 09:35:58PM -0700, Ranjani Sridharan wrote:
> On Tue, 2019-08-06 at 10:28 +0900, Kuninori Morimoto wrote:

> > -	if (card->dapm_widgets)
> > -		snd_soc_dapm_new_controls(&card->dapm, card-
> > >dapm_widgets,
> > -					  card->num_dapm_widgets);
> > +	snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
> > +				  card->num_dapm_widgets);

> Should the return value be checked here?

Preexisting bug but yes.

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Jwc0ACgkQJNaLcl1U
h9Aj0Qf7BvIDkZATcOjgqjyaHnBkFVcL9CKKmwNmkmyw/daxDGA3IqKGauU4oeM3
WmcKquqdTK9kNcqNeumOvDIcrYxbvM0HzfUKYc8bT++yNBXL0E13yw3HRGBDqBkt
uofcuqrF2ASQxOa/Xlti1CmuS8kMKHKEoSX2/J7d584UjdAV3wn3PNWnoWgpez/O
JXXLLznC1Wown9xQg1oTBT84gHXrm2kV/T+HpDq7YyJL/1yyY54G8wEQLE+uit62
7dHfOPw9P1XRL1DA77m9Oao2XSpaXv5HQjEdZ0B/6+cpE5v1VoPv5rLCfVDcQYoI
rtB1sQ89hlA2mjNHGc/tbp5D2pn/LA==
=6dh/
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--

--===============0577432686455028227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0577432686455028227==--
