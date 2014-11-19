From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: rockchip-i2s: dt: add an
 optional property "i2s_clk_out"
Date: Wed, 19 Nov 2014 10:10:33 +0000
Message-ID: <20141119101033.GW22111@sirena.org.uk>
References: <1416366365-4632-2-git-send-email-jay.xu@rock-chips.com>
 <1416384447-29391-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3824458192591107525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE7BF2604A6
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 11:11:10 +0100 (CET)
In-Reply-To: <1416384447-29391-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jianqun Xu <jay.xu@rock-chips.com>
Cc: huangtao@rock-chips.com, alsa-devel@alsa-project.org, heiko@sntech.de, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3824458192591107525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxfMsoqvp1jUizWj"
Content-Disposition: inline


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 04:07:27PM +0800, Jianqun Xu wrote:
> Add an property "i2s_clk_out", which enables to output clock to outside
> of rockchip SoCs. Let's make it optional since not each board needs it.

Don't send new patches as individual followups to patches in the series,
repost the series.  It becomes very difficult to follow what the current
series is (which is the latest version of everything, what ordering, is
everything still in the current version of the series).

--cxfMsoqvp1jUizWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbGyYAAoJECTWi3JdVIfQSykH/1uSVGqRMROmMaERGIblI/+q
ku9API9K0Jy5rUkFH6VNhF6CLe5Elt7pEESv5TbluSdjG+iT3v9CM7MbAftepUzT
NQrYkMAW71NtKA3Ml4mT+QmcIGCxADnbykJ6ZTPj5MoOjxOH3AkpjKy1MAdVAG2s
cEY2fb6A6MmmQokurkm9wbiDQn54J+0piYCwMbFrSA8zzHR/mX6TCiaBbkR1VUxB
cUbQL2hbZslSvGPi5YHhXZVUm7vTEQ9EhPRbI5kPoOT9HydN9BoeLaJr9n5pRv/9
1gt/DNffIqeTpr7UwffrwJkjg/0VsVoL+/q/h5EZUmYg7twKtzB/6HX81y2ftmQ=
=KcGU
-----END PGP SIGNATURE-----

--cxfMsoqvp1jUizWj--

--===============3824458192591107525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3824458192591107525==--
