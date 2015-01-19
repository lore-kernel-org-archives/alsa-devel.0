From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add delay for output disable
Date: Mon, 19 Jan 2015 17:07:06 +0000
Message-ID: <20150119170706.GG2809@sirena.org.uk>
References: <1421682586-6303-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150119162432.GF2809@sirena.org.uk>
 <20150119165850.GY14516@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2188559045893134383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A99102610A1
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 18:07:16 +0100 (CET)
In-Reply-To: <20150119165850.GY14516@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2188559045893134383==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2015 at 04:58:50PM +0000, Charles Keepax wrote:

> Similar to the power up the delay needs to be cumulative as the
> write sequences will queue themselves up if the last one is still
> running when the next one is started. It is fairly long for a
> udelay I will replace with an msleep(1) instead.

Given that you are needing to delay per output it's probably going to be
better to do the coalescing of the delays - record how much delay is
going to be needed when stopping the clock then do that at once when
doing that.  It's going to be more friendly for the rest of the system
to see a single delay than to delay, schedule the thread again and then
almost immediately enter another delay.

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUvTm5AAoJECTWi3JdVIfQ4scH/2luSd80l4q9rPH26acb+vH9
6TAYQa0Ap/CQKzeLtvyaW58IsJcaWu3bVNgZXjaXj6/5ZokIoZmFGKFRHLcqbnEe
mA+b+Z3qshn59wYTvHPor81jR2uvgOaitpZRLJOYtxIJoxo8jM6ONjs0h19vcQTw
mL/F+bKplTKsgyxi0KTBhQhIJHfc+nkdn79qjZe25zL5clrNQ0JWZW5+n8EBq43Z
IUoToRTDi5lGHgwdLFb3E51xNdur2zmWcfkHwkHpxZMz93M11+0E1x2CpHzHM5Xx
vRrPuqBYLdb9qaRNkjdZRYpbjRf8zkLAmEpOMaILgadURVBWQxtDWhBBPI0kDSY=
=GWoQ
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--

--===============2188559045893134383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2188559045893134383==--
