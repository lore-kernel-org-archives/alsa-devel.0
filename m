From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 19/25] ASoC: soc-core: don't call
 snd_soc_component_set_jack()
Date: Thu, 29 Aug 2019 10:58:04 +0100
Message-ID: <20190829095804.GA4118@sirena.co.uk>
References: <87pnlhahr6.wl-kuninori.morimoto.gx@renesas.com>
 <87y305932s.wl-kuninori.morimoto.gx@renesas.com>
 <f3ead090-8c2c-6be5-70b8-c6530239302a@intel.com>
 <20190808111417.7033df42@xxx>
 <87blwk1n9m.wl-kuninori.morimoto.gx@renesas.com>
 <20190828120651.GG4298@sirena.co.uk>
 <87a7bsomnz.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5014095392141553262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AF99F89622
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 11:58:10 +0200 (CEST)
In-Reply-To: <87a7bsomnz.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5014095392141553262==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2019 at 09:16:08AM +0900, Kuninori Morimoto wrote:

> I agree we want to have robustness.
> To make clear that it is for robustness,
> I think it is better to have such message/comment on code :)

Sure, that sounds sensible.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1noakACgkQJNaLcl1U
h9BIWwf/WjH9i7rPH0bMcGm+DhPdFmrz6YEaDf8eZpj3l6AXhtTeLzIVtLrVcOlu
wcyznjfNbRcCVJbeUXifc92SvR7trjsJUxMBTkZTEs5d0cRlamxbB07G/isAjRaG
aohZLqTj4aVtuxArWxltHFMfskQYSO36/y7K1+EZRV42NFepKx56uCHmrqCHLWye
lQOmkYlweDhiM2+5Zf8/B84INSQNacG0C0bd2cfhnnPBHpDUr9/afmJEmXS3Y+x+
tsXcL5aUHpDyW6XgD0XAtMwFaa/xYIAydBrD0FEWtXSdtjUBmnPtlgYraf4DuDny
owq64z0/m3kHC75VFD9NGO4orcAhRA==
=u2YX
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============5014095392141553262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5014095392141553262==--
