From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 11:47:20 +0100
Message-ID: <20120723104720.GK4435@opensource.wolfsonmicro.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8685470325562278429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44429265269
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:47:19 +0200 (CEST)
In-Reply-To: <1343039946.1726.4830.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8685470325562278429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Content-Disposition: inline


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 04:09:06PM +0530, Vinod Koul wrote:
> On Mon, 2012-07-23 at 11:18 +0100, Mark Brown wrote:

> > It's not immediately clear to me that we shouldn't be flagging an
> > overrun here - obviously if there's just a pure delay introduced by the

> Take the case of a DSP which employs DMA on input and output (of the
> DSP)
> At start, DSP would buffer some data, assuming a period. And assume app
> has filed one period only. So at start as we buffered a period, ALSA
> threw up wrong xrun, as it wasn't aware that this buffer is not yet
> rendered.

> Using this notion, ALSA knows that there is some buffer in DSP and used
> that for xrun as well as delay calculations.

I'm having a hard time relating this to what I was saying.  The point
here is that if the device keeps marching on consuming data (as most
cyclic DMAs would) then there's still going to be an underrun even if
there's a buffer that causes a delay in the user hearing it.

> > > This patch tries to add a new field "soc_delay" to represent buffering done in
> > > DSPs. This value is also used for the xrun calculations in ALSA.

> > soc_delay seems like a very unclear name for this.

> I am not good with names, perhaps soc_buffer is good name :-) ?

The "soc" is the problem here - this shouldn't be specific to some sort
of hardware.

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDSuwAAoJEBus8iNuMP3dDqsQAIz0k4iOT3urM9KM7I0AL5KE
9mHTiHyfK7UojDcnHSLPkQYWAuLtZmCnYJE8Fl83+WqwhN/Y5fStjOY0qTOZBCm3
HaljGr0OHD8J+O8kCvCygh8VhHdTpMYMCssOOIt1aX5AnHO89G/7sQBH79HsX5Na
J7vXBuYdHxSZDy0rNte1+/AR5CXlkPuDUsZbfOkmrTzdLhaiJwdaxoj68alX8wSf
JvQxmj/Er3VaohxTigWtAyeN2fv1mlr4F4GFgUokYfDGOVSEGK4v+Rd7kD+YvBLV
RXjC9AvitGz8mhNk20U+ndjtmjW1G/vYv4G6Mm423xJZxgK3Wy/8HKVdOEaRa78H
zzRlONDh5gG+b9z6tjxe5RwxNYOCErCe+JAmVtFYMbi59ry5AVBs5ebkXQO7Ew1C
OwHnQWN4GWAHjwWvGV6IqV/VIXRn3s6XhnQIGPMWq+5bK4m+sS0wh348c4TStVRR
q9GgQhs2qwbEzM1YVTsEfTJS/nuFHYL6WmLRlvsisT3AfuPSiRytSCI9HAZ1MeV/
DfqFVJCDtjlVoaebzNry0Wp4EIdXpk1QAGMtYPTGbxRQ0RxrBGFM9l5cJcFbrnz4
tWGrzkNRnhs7TrKW81w6IwctlQ/8qGDvuESpQUFQE2UU4kuaJncq3aquNbbtasn2
cIRfIACe3ljr70BwHfQQ
=MHbY
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--

--===============8685470325562278429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8685470325562278429==--
