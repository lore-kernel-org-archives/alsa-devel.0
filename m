From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] dmaengine: Add wrapper for
 device_tx_status callback
Date: Wed, 20 Jun 2012 15:40:06 +0100
Message-ID: <20120620144006.GR3978@opensource.wolfsonmicro.com>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8090284116840400339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E51C924607
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 16:40:10 +0200 (CEST)
In-Reply-To: <1339438302-12417-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@iki.fi>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8090284116840400339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="562f9N4fbIs+fPrJ"
Content-Disposition: inline


--562f9N4fbIs+fPrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 08:11:40PM +0200, Lars-Peter Clausen wrote:
> This patch adds a small inline wrapper for the devivce_tx_status callback of a
> dma device. This makes the source code of users of this function a bit more
> compact and a bit more legible.

Applied all, thanks.

--562f9N4fbIs+fPrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4eCjAAoJEBus8iNuMP3d+ZUQAJwVvTjZ/gcTXLadtJGWfJ0I
d84NSrgHHUh7N375g/xSj4STKimbgoppOnW06mZaQ7mvdOVvOs+i5yy95WcP1Mpa
dY+HiUk+T3vR8+s/MrC34HjHiK7IFRknCnPF7mnb223NpTVXwj7KHOwyXLqSUguL
F8BZIhnkN6DAVEDJRvd/mF2G/LNmW5LyLzisW+TcoxvmZzEG0RvgDnn0J2a3XMW3
MhC6TSPyZzrGN8+3SLbai+vDkQggbxzpJMG4JIFCMxJ1eScAIkTE4d3GKFFd7EGo
5LKvOs/HGYXRLE8z/1XFW5OpvfuNoah4ZY+lYTnLIiSxyOwy0dOdFZ+Ky+1byUXY
ddJ2r1/KVF6jnfNDdpHmlLaRuGtOorJixAZi/C41Vm9XFcMRe/ea3pEmFIAKOoc+
XrjSezlZ3xYx9+EeleTQLoz0lz5JKagvac+MUX0ZlnTBEuq/7/rYxJ5iL6jJjb0x
M9WYdPYQAMCrzqjoEDs67PYqLytEz21tlaZ+bYoIyzRHhlipIEGszRo1A5MC/nQK
fAhAAjbqtXNsN5Cy3ztv2vwZQWx/8WH06ZWapJyY1no+aqcj9zSuPThjP1U+BYuu
rQ7IIfvKJz57j4GzMxCdYYAj6jFdVA5ylmW0aYxg1QV3F3z3LMFSlqcgiVAxQUDi
cML6lXvyjEUbEm9FxIg5
=gQwJ
-----END PGP SIGNATURE-----

--562f9N4fbIs+fPrJ--

--===============8090284116840400339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8090284116840400339==--
