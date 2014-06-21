From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 04/11] ASoC: Auto disconnect pins from
 all DAPM contexts
Date: Sat, 21 Jun 2014 21:07:07 +0100
Message-ID: <20140621200707.GR5099@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2986869019447848275=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8602651CF
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:07:31 +0200 (CEST)
In-Reply-To: <1402935191-18398-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2986869019447848275==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lA9F05uMKC/Ah7SI"
Content-Disposition: inline


--lA9F05uMKC/Ah7SI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:04PM +0200, Lars-Peter Clausen wrote:
> Currently only pins in CODEC DAPM contexts are automatically marked as
> non-connected if the card has the fully_routed flag set. This makes sense since
> widgets which qualify for auto-disconnection are only found in CODEC DAPM
> contexts. But with componentisation this is going to change, so consider all
> widgets for auto-disconnection.

Applied, thanks.

--lA9F05uMKC/Ah7SI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeXoAAoJELSic+t+oim9o0EP/1hsw3S5GTJ+SzoaRElGgb+o
jZsTwIbD3bt3QxbmDxkf4X0LUrz686eZzblIW1o4UFzuMJPnqXNhqDoFr9ajyIur
JaavPl4DV9qfKCpbg5s7wjny51hftySTQFdrdZnfPad8/LGQHrM0+q3bvuX02UvH
5KwuoOQovpr721jRBbAPGisYsXx4wPtFatECMHjjl2TXXpLmctdLu7ewvWrAVdVJ
AfPQLCYU6yT59++DareRKCcnscnchz7T94jt08OIm9yXlCeRofS3+MicfhGzPlHR
SRPbEB5sxx3hBrCtaPeE+pfiBkNZmeSkgXDV5FBV81kaaCHoJ9G0FuRB6RQsQnc/
tlA28uGZjjq4IGZGxV9W209m4j59YV7rZNsiNEQ9iE9hEDl7tJvTc2DMH1zSORDP
lbqM8eDD7DrWJ6nU+pD+8sgGDUcHMcv/OLUsdbzxtQHQxu4M5CkFPYpRTZa4o6HF
i5CfHwh6euUGyqEJkG69QG6V7smFxOy0SAkoYe382mGa0dBqJCtMFyoCrjxqy2o9
nynWOOytb7wRA/we8aoPkrzM4uFGjJvRAEzkwIYWahb4+KHkDhBt2/JjXyKCHeAb
l44J15H1gUm5uTmRICzvRfEX7IGyV1DTpNM/x663Z1QRQf9GXVSi/TjJG4gNv7eR
2dNfdc4bypuicOuZ5j9M
=dJpD
-----END PGP SIGNATURE-----

--lA9F05uMKC/Ah7SI--

--===============2986869019447848275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2986869019447848275==--
