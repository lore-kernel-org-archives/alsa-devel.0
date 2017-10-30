From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8741: Add digital mute callback
Date: Mon, 30 Oct 2017 16:13:35 +0000
Message-ID: <20171030161335.6nxmjjnxbmunij7i@sirena.co.uk>
References: <1509352096-5491-1-git-send-email-sergej@taudac.com>
 <20171030154110.5vl2ajatnsr5c4sm@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3515150764075345528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 037E9266AE1
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 17:13:40 +0100 (CET)
In-Reply-To: <20171030154110.5vl2ajatnsr5c4sm@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, ce3a@gmx.de, ckeepax@opensource.wolfsonmicro.com, Sergej Sawazki <sergej@taudac.com>
List-Id: alsa-devel@alsa-project.org


--===============3515150764075345528==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cml7legsyzt2oaua"
Content-Disposition: inline


--cml7legsyzt2oaua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2017 at 03:41:35PM +0000, Charles Keepax wrote:
> On Mon, Oct 30, 2017 at 09:28:16AM +0100, Sergej Sawazki wrote:

> > +	dev_dbg(codec->dev, "wm8741_mute:    mute = %d\n", mute);

> It is still not really normal style to include the function name
> in the debug messages. How about just "digital mute = %d\n" or
> something like that?

Or just don't log anything and rely on framework level diagnostics if
they're needed.

--cml7legsyzt2oaua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln3T68ACgkQJNaLcl1U
h9DVSwf/asqXLKhlYrhOzfENpiltIfWUiyV7G1XhxxTJ7gXOsWOZu0xMaQeCVv7/
oMItPNnPzSsNWMOjrBJoVI1Y0q/4Y1al9eAZCkFHqRpkgRU2A+DmFStjvcyNoS6E
jOifMlx9qhnOt7NQh3bTaBQN4E3LwaPnHQneJE99UEOx7oj/8T1UMjvr/3Fsd+d0
W9RclA5DlQIlYjwGxz6KRt6yu0CIb+P0XjQbRaHn3qiPgm1bNLQG41GEdB0baIt+
eY9NjUIV/ffTAql+G5tYxxiHC875EzFtqibYWhImNVXntNsISdN+g9MVLwQvUpre
T/hMwrxaqHllT6vKAsqYphjxR6ttGw==
=s7A/
-----END PGP SIGNATURE-----

--cml7legsyzt2oaua--

--===============3515150764075345528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3515150764075345528==--
