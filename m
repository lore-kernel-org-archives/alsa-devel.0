From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/12] ASoC: txx9: use
	dmaengine_terminate_all() API
Date: Mon, 13 Oct 2014 08:44:41 +0100
Message-ID: <20141013074441.GC27755@sirena.org.uk>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
 <1413042040-28222-11-git-send-email-vinod.koul@intel.com>
 <5439591B.4020701@metafoo.de> <20141011155411.GA1638@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4618106430092065269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6B6B2604C2
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 09:45:18 +0200 (CEST)
In-Reply-To: <20141011155411.GA1638@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4618106430092065269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i1dAbsF9+zgeqzLb"
Content-Disposition: inline


--i1dAbsF9+zgeqzLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 11, 2014 at 09:24:11PM +0530, Vinod Koul wrote:
> On Sat, Oct 11, 2014 at 06:21:47PM +0200, Lars-Peter Clausen wrote:

> > I already send a similar patch a while ago. It is on it's way into 3.18.

> I will drop this one then

> I did grep the linux-next when I started on this and found no reductions
> from what I had in dmaengine-next

It's ff495d3a8ea4d (ASoC: txx9: Don't opencode DMAengine API calls) from
August which is in Linus' tree now.

--i1dAbsF9+zgeqzLb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO4LoAAoJECTWi3JdVIfQ+d4H/R7VqgNgx9tyXiG0+v+rFTkH
5zC51jH2U/co/4w/3MavhyNL9W14OpVmTEEHNNqnm0sXHaN1vjKhkij6+xXyYbav
jU+ni+mh+kqYSWcJkUEwFrmQedIC1hZertXcG0GJRV5G6bJgzMRexJUfGBEpzwJX
a/u3oMY9PKtxGxGmokXq4Dz+r1om96hHHredbP9muqpGGPQerg4RgZPkRdN1cJ3e
iIghlTM647LYuzl68tYTzIwpL/r0oxdVZfIm/wTmVldb/5G/zH3pT4JKcrDTfqxo
HfQB4Lrh4GbJY1/FO9TSbX4EBd+3rf+A0BuRtJuA+A8ecQLI2J5xeIiK7QNCG+4=
=7Qj5
-----END PGP SIGNATURE-----

--i1dAbsF9+zgeqzLb--

--===============4618106430092065269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4618106430092065269==--
