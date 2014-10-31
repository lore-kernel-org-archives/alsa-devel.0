From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/14] ASoC: ad1980: Cleanup printk usage
Date: Fri, 31 Oct 2014 17:19:25 +0000
Message-ID: <20141031171925.GI18557@sirena.org.uk>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
 <1414699271-22797-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4867246898841805141=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C9182606E7
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:19:52 +0100 (CET)
In-Reply-To: <1414699271-22797-3-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4867246898841805141==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yUywCxqRN707SWcy"
Content-Disposition: inline


--yUywCxqRN707SWcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 09:00:59PM +0100, Lars-Peter Clausen wrote:
> Use dev_err()/dev_warn() instead of printk(KERN_ERR/KERN_WARNING. This is
> common practice and makes it easy to find out which device generated the
> message. While we are at it also align the error messages with the other
> AC'97 drivers.

Applied, thanks.

--yUywCxqRN707SWcy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU8ScAAoJECTWi3JdVIfQnmwH/03oSpBTwHgdOCafGPPni0fR
M4bRpzrhoASGLCwQgUFgqodqtj1WEDkZfg7Sm73rDkbYVFYh2mSQZn2nz7QEvngv
w2UDVkFODiU1DciSffqnreLfyuzAx9WaTVnIf47ulL4P/F7IeFnQKJCtZSd+3nEW
9/6HXv07MKJtQXdGfQ4mwuB8qpOhgbdlEBP4h7dsxexO1iGz5UMqWouHLQoJq0+q
v+qj2eYmd2cfdWTb6a2biVYTFWAiX9Sxg6jubZXdSqxyyrdHeTyc+LXmn/L8Oi5Q
SMKLt0YhgTvZgnzl1NJ7pUWSrJkB7BQKIz5HAU3h+0SZEeouMatbh68D5yv8W3g=
=DdGK
-----END PGP SIGNATURE-----

--yUywCxqRN707SWcy--

--===============4867246898841805141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4867246898841805141==--
