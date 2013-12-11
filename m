From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3] ASoC: dmaengine: support deferred probe
 for DMA channels
Date: Wed, 11 Dec 2013 11:15:19 +0000
Message-ID: <20131211111519.GR11468@sirena.org.uk>
References: <1386699062-27933-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4492508671561050587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A796A261691
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 12:15:22 +0100 (CET)
In-Reply-To: <1386699062-27933-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4492508671561050587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QFliEIXSSz7hGqqc"
Content-Disposition: inline


--QFliEIXSSz7hGqqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 11:11:02AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Enhance dmaengine_pcm_request_chan_of() to support deferred probe for
> DMA channels, by using the new dma_request_slave_channel_or_err() API.
> This prevents snd_dmaengine_pcm_register() from succeeding without
> acquiring DMA channels due to the relevant DMA controller not yet being
> registered.

Applied, thanks.

--QFliEIXSSz7hGqqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqElDAAoJELSic+t+oim9eBkP/02HkmL2Vq2v28taQEv0j/cd
4gs+8oAERh4qNhrPxzodMvtX2AqinrGVczp6/10/RMPH+bK1yT0ScUJ6SsrKIxkv
CIzHEydP6p4eN/idxwNBi7VAmPefvZVknSA35e7TsBMHCxWbMxG/nWoWhrGoglVB
1AtbnkMjAO7AwonQeJOwlaBlxG/0AzX8ljZMfSyZ970kIoT4hJ8W+wxMkdusZFdJ
L3W+TyI7eiM5Jl8S0xGd6H4weEGGih9IyE6YLMcOKfBIu2JSlWRoQ27xjGRosBcI
r8Gq0tVXMvqH2pqPVPvH5ZH0GfUgC7vEV222aw25ZBg6XqRuUu1s8E4Jd7b2K1JZ
NTQmdxfacJmsK1elNr9KNLZvSKUVT3Q11Mq43H2b7k0KKe/y1SQBAUyk3fbQqUAd
O48Jhz7497RU9moatJEoXI8wtak5UjQohGgiZDAs7ytWI1gtPtVbYEKIKcjy5SHf
dyAUP9AKeMlltVOtqpPl1DtfffHXWaNxrapoVoDWB5C0anmaEHhHRQ2SQp9EgONe
tQNm2vB4D4Zj07yPH/Va4tayabkZXCXomtZWca9rcGiw2SB2woszz0QP3Bw4XUJm
tpNO129hIb0HDE8E7CULNXuccLDWsymIbaVjQggwEB1cGO0+HxVxqSqKAXreHoBA
RgVyObmR214oBilb0rSx
=62Os
-----END PGP SIGNATURE-----

--QFliEIXSSz7hGqqc--

--===============4492508671561050587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4492508671561050587==--
