From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: Intel: Skylake: free codec
	objects on removal
Date: Tue, 15 Mar 2016 10:07:43 +0000
Message-ID: <20160315100743.GM2566@sirena.org.uk>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
 <1458035836-1843-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1006051078315580038=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87A99261298
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 11:08:08 +0100 (CET)
In-Reply-To: <1458035836-1843-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1006051078315580038==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UUMz/kfoogzZ9WLZ"
Content-Disposition: inline


--UUMz/kfoogzZ9WLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 03:27:12PM +0530, Vinod Koul wrote:

> +/*
> + * codec destructor
> + */
> +static void skl_codecs_remove(struct hdac_ext_bus *ebus)
> +{
> +	snd_hdac_ext_bus_device_remove(ebus);
> +}

> +	skl_codecs_remove(ebus);

Why the wrapper here?

--UUMz/kfoogzZ9WLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW597uAAoJECTWi3JdVIfQdT4H/30VtdChpOu4N+3VHFBriUaU
oO7RTo3OlYfJSCFnqniAaLLPhhE4PC6hq6An1mI4rgG2ub20Z6GEEqlLRpSUTr2A
l2YnMV9I4+RMbQslWFvR+27pTWQTwwehvMuhz1UpFEm1KbokHznUnfUJ2HPOUZZo
i0hcd02SfNRLyyq+xtoxun48/fybcHMe0Sb0NIVXNAcPrWn1Xn7g4TvfHPIQxzKm
XuZWumIfNsydQncBgx0WEZANE6rH7wvvLcP6dIX4X0xKVkx6Ho2zPJhtdtWSZVER
jMSnVkIgvw9anSWLnM/jrYt3L5yoJpGc1gB17f3Ec65j39tBpCK2UCVMC/7pyug=
=z2gT
-----END PGP SIGNATURE-----

--UUMz/kfoogzZ9WLZ--

--===============1006051078315580038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1006051078315580038==--
