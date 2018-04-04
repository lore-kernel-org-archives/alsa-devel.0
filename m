From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Date: Wed, 4 Apr 2018 15:46:22 +0100
Message-ID: <20180404144622.GE7691@sirena.org.uk>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
 <20180404102425.cwj7vzvrvi2obcoi@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6139418206011800799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B6202675FC
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 16:46:32 +0200 (CEST)
In-Reply-To: <20180404102425.cwj7vzvrvi2obcoi@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ladislav Michl <ladis@linux-mips.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Colin King <colin.king@canonical.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6139418206011800799==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2018 at 01:24:26PM +0300, Dan Carpenter wrote:

> Trivial patches should just be trivial instead of evolving into a thread
> that lasts for days.

Indeed, and it's usually easier to just send a further trivial patch
rather than just talk about it.

> Why is "buff += 8;" indented too far?  And why does every line end in a
> space character?  And I think about it for 10 minutes and then delete my
> patch because it's too much hassle to deal with for something small.

The other option is to just send it and not worry too much about it
getting applied or not.

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrE5T0ACgkQJNaLcl1U
h9B76wf/aaCZ6Rv8dYbsjZdyld31M/xsNOwpdFiEgAF2iOsClaidV7P1z7rFYUJx
iPeJbZ9x03hp2DU3fpn3ReDLpA8pZoqrhgZNebMOs+ye1guK6Gp/PiKbyusvZ9E+
81c8S8U6e0UjXP8ZlAD5PYTyJcOL7REXwHeUdbUF8nvGmhEF9nwqumCsqUp8Jb5M
g6rVjbdH4ab2P4zrWjAkjfKGLbbPaIHPMjz9BlTghpSqAg4FKCSjounsT0aulvR2
/qwQrzfzuHQ3SabW9AuugF6DR2b8V2cdM/d+E58OGf9twS77rgc4uUez0paCij/i
3foKesQaDPJMMpSzPbed+KPM/Fg7rg==
=Yp6y
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

--===============6139418206011800799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6139418206011800799==--
