From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: SOF: Add OF DSP device support
Date: Mon, 19 Aug 2019 20:24:06 +0100
Message-ID: <20190819192406.GC5563@sirena.co.uk>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
 <20190815164942.GB4841@sirena.co.uk>
 <CAEnQRZAM6VkCewfVYysz-NmPNEz-CSe763Cv-kz9kyNjx8uMtQ@mail.gmail.com>
 <20190819134616.GR5999@X250>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0805854776173964349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com
 [209.85.221.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 728A3F800B6
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 21:24:08 +0200 (CEST)
Received: by mail-wr1-f99.google.com with SMTP id p17so9858708wrf.11
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 12:24:08 -0700 (PDT)
In-Reply-To: <20190819134616.GR5999@X250>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Daniel Baluta <daniel.baluta@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0805854776173964349==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2019 at 03:46:17PM +0200, Shawn Guo wrote:
> On Fri, Aug 16, 2019 at 11:43:13AM +0300, Daniel Baluta wrote:

> > Binding documentation together with the actual dts nodes were sent
> > to Shawn.

> > https://lkml.org/lkml/2019/8/7/682

> > Can you pick 4/5 and 5/5 patches from series above? 1-3 are sent to
> > Mark to go through to alsa tree.

> I just picked up DTS patch (4/5), but DT bindings should generally go
> through driver/subsystem tree as preference.

Right, especially so we get domain experts looking at things before they
are merged.

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1a91YACgkQJNaLcl1U
h9Duhwf+Jun/261NvS0DyKcg4mZ3Us1NgoEMjPfXVxXIlqHD+DSU+kyNcUeAevIi
geJqCRUpDk/8m7yFbVHuVikAoZwEcSAm41PkRYy+jw02WYiIpI/zKmpucsorv3+S
/5yV4qHykS94VSInBhxLI9SOwaPBT0cNfQFLKMmE5R5e2nhKNbbAaby/oCottVGj
nTzSz4wFgDLjwcaopxnxfXYJOwN1l2hg0hK/4+eBTso7+sGqVGfbiVAfmPHAjACY
j1MWzj5e3NuilCp33tJ3ZODBUZ6Er2/8kOaiY73c4I0OZ1ymI9NCtW82LGqneycG
CBZq3Whpox7pAry6kx4vSVO6HniTOQ==
=yP+B
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--

--===============0805854776173964349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0805854776173964349==--
