From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: core: do not unload topology
 in unregister_component()
Date: Fri, 5 Apr 2019 09:17:29 +0700
Message-ID: <20190405021729.GB2803@sirena.org.uk>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
 <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8280298240764813857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50B69F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:17:41 +0200 (CEST)
In-Reply-To: <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8280298240764813857==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 05:30:38PM -0700, Ranjani Sridharan wrote:
> Typically, topology is loaded when the card is registered
> by the machine driver and the link components are probed.
> Therefore, it should be unloaded when the link components
> are removed. This will make the register/unregister component
> methods balanced.

>  			continue;
> =20
> -		snd_soc_tplg_component_remove(component,
> -					      SND_SOC_TPLG_INDEX_ALL);
>  		snd_soc_component_del_unlocked(component);
>  		found =3D 1;

Isn't this a robustness fix?  It's just freeing anything that's left
over, it doesn't free specific stuff and shouldn't stop anything else
freeing that before so if we made a mistake earlier on it'll clean up
after you.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlymurYACgkQJNaLcl1U
h9BmmQf/bnEUBkePE95E9q7qncujA0d8mfKog79JdvrulCBd0r0+nhpJrkLQHqIG
Agev05323IiTpIhbrr8R0fK+XsV25U/gQ9uzU2KVHDsonO+cpq+/yvaNFZqecmSs
itEB49iMvtjsAplvEpe/QS4nuKW3BgZZsMzH3MJ2cZCZOsvAFW5XDAfeRfB0tePz
VwnqJDib1Mry0wNAFPOCtQWpsNf/fMdcIhui7zPur2P6PqEOlKyIP1kNSnzlgJR0
gaBmYISOHZdRsJhanUyCm4SdBBCeBFEchjbEiLMaOxI8BOsCV8xRc0b19LLGTMEs
mGvfx16/ENJoU+cDz4ascDe1/E8Zqw==
=JJdZ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============8280298240764813857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8280298240764813857==--
