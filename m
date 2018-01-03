From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Wed, 3 Jan 2018 11:28:44 +0000
Message-ID: <20180103112844.GB5603@sirena.org.uk>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
 <f2b24e22-6e4c-cd9d-e6c1-e9546d98b8c4@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1606286823938044088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 745F12668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 12:28:49 +0100 (CET)
In-Reply-To: <f2b24e22-6e4c-cd9d-e6c1-e9546d98b8c4@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============1606286823938044088==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 12:01:38PM +0100, Hans de Goede wrote:

> Right, we have existing machines with a rt5645 and an internal
> analog mic, but those have been broken sofar (I can confirm
> this for Cherry Trail based devices, I assume it applies
> elsewhere) because without the next patch in this series we
> were never actually enabling micbias. So this change should be
> fine as analog mic support has been broken sofar anyways AFAIK.

Are you sure this also applies to non-x86 platforms?  This analysis
needs to be in the changelog.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpMvmsACgkQJNaLcl1U
h9DJywf+IUWajqLTEsXY3Skux2owrigFQ+i+R1WKMO/wH094YnIBHtPiMl6YKC0k
aMTmntjegqgSEK2RTMmRrUgVQ2EWFSdNpW0rWkHNmfOxgqIZAZF0sdm/qDFs5NpQ
sx7KYntJdbXo3edXb5ulBXOI2rLynV5Lxp7qqV5b2m5GmlIvumhj+FIO+ME/H2z3
Np7psenVI3G2k132VNbdEYQGs+cWrJyKPodyXslRUUr9Ot3yCY850RE9q+m0dDKE
UcMn9rjvo2GPbPYSAZsrl7UY6eCTzikLiUnYK9U144NNZqDThLwqsqycrDX0qT2S
v+3gv4LiHI3aAUnsGH3W9vA0KhbhtQ==
=8uks
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

--===============1606286823938044088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1606286823938044088==--
