From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/5] ASoC: dapm: Rename
 soc_widget_update_bits_locked() to soc_widget_update_bits()
Date: Tue, 22 Apr 2014 13:25:30 +0100
Message-ID: <20140422122530.GX12304@sirena.org.uk>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6435972690238856370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1422625EA
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:25:36 +0200 (CEST)
In-Reply-To: <1398165797-22997-5-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6435972690238856370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vZA0c23d8KJOGLy8"
Content-Disposition: inline


--vZA0c23d8KJOGLy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 01:23:16PM +0200, Lars-Peter Clausen wrote:
> There is no unlocked version of soc_widget_update_bits_locked() and there is no
> plan to introduce it in the near future, so drop the _locked suffix.

Applied, thanks.

--vZA0c23d8KJOGLy8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVl+2AAoJELSic+t+oim90QEP/1yNS/83qcNmZCLRwmBI2mQm
X+LZo2PXNP4mleQE7y8HhtqPqCLlPV/lYBcc2HE7qH9l/Dlu0NEfiYkc72SE/yTN
u79pPY/odALkR8rGNadNDwLRuyMVgZAZSEX8RRfp7X2IxZI9bvb+NPAj4jXKrmGN
Lgk4jiUcYLBb2qobCXM99vAgaXC22QqxRGQuDxr5eWB53O676h2U6qIwWMYwd9x0
t/+vhcnmFJwEsDvomoEjlQqw44Ly0L+TkK5g2MLqUTR6IFl1pHTYc6TgAIGEZX/H
8W7WmNW8PjJLkRLQTMQbh1kUrLRNuBsrlaOeZMSu6w+hABTzSG5mIupx65QstHwW
j/t7wYxNyidK4yT0hcJwEktJFbZMBuZJpb4Om/gadY22jYJdDrfCmeiN9lFYqbyK
R5cx2KMyLegJHazZ8wiB4BSj8wxkk/nEdcK1RiKrCU3NbvEaGu7B/n1RA+8nGh2D
CZKX1TC0xKP18NFrYcgmqdOhelg7fUQQli2s6hxHDPqM8aqjDYi6JfBtq115UCO0
zVI1tW1B0v4x/U6XbliPq/fe69c6WSEKCI2C2bYIq54YI9zOTDldEaQg8fUs7DLC
azMXptDJtohwnD3b9dLYdsSzm15LCBm6RNTLfaAEvUyU9H4q3H3oMnW347GIcvHs
DCgjwdQwK7ld+oO6o8+n
=x/DL
-----END PGP SIGNATURE-----

--vZA0c23d8KJOGLy8--

--===============6435972690238856370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6435972690238856370==--
