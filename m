From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 19/25] ASoC: soc-core: don't call
 snd_soc_component_set_jack()
Date: Wed, 28 Aug 2019 13:06:51 +0100
Message-ID: <20190828120651.GG4298@sirena.co.uk>
References: <87pnlhahr6.wl-kuninori.morimoto.gx@renesas.com>
 <87y305932s.wl-kuninori.morimoto.gx@renesas.com>
 <f3ead090-8c2c-6be5-70b8-c6530239302a@intel.com>
 <20190808111417.7033df42@xxx>
 <87blwk1n9m.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7663648602407168528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0CFDF8975C
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 14:06:58 +0200 (CEST)
In-Reply-To: <87blwk1n9m.wl-kuninori.morimoto.gx@renesas.com>
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


--===============7663648602407168528==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 01:24:11PM +0900, Kuninori Morimoto wrote:

> > We can of course add handler to our driver to do this, first version of
> > patch actually did this, before we decided on global option.

> I double-checked framework.
> *All* drivers which are using snd_soc_component_set_jack()
> doesn't care reset jack.
> I think it should be done under driver, not framework,
> but this patch seems have big effect.
> OK, let's skip it.

Yes, I think the current code is better for robustness - we've got a few
things like this where the core will do cleanup even if it's neater to
do it in the driver since it makes it harder for there to be mistakes.

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1mbloACgkQJNaLcl1U
h9Bfawf+MCg4tpUR27zw/69E3SEpK5R6ysf4t9bKaD7td6Fx3dF4BQHA0QXcDVF/
yG+51doNueX8WkcoWZzYdbn5rm290frRL3oy2lyBVBK78gEsjkhfkbCjmMLM5MFd
3A4++r4CTHoMd+xMANJrbwWzCPM1g14uU04KvvARUndbqfTMZrfSRKbmg481xM4Q
V4DPmWDABJ3vSdlWrjQHTZ4DwHLdKz64Px9Ou3qfbDnJMrWbzGpS815X9vUa8yKo
LVNnYmhon/n3Jalg66IpD4a4VKU89GEEq9M1d2cz8HhLlL4wLoV/AjDZq5llt2uZ
InpC/rHoQDU/R+m89mrTEN9kXwnJjw==
=/O0s
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--

--===============7663648602407168528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7663648602407168528==--
