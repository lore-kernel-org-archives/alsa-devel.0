From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Use generic control handlers for S8
	control
Date: Tue, 28 Oct 2014 00:20:59 +0000
Message-ID: <20141028002059.GJ18557@sirena.org.uk>
References: <1414261556-16212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2493833060562297377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EB1D261A2F
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 01:21:21 +0100 (CET)
In-Reply-To: <1414261556-16212-1-git-send-email-lars@metafoo.de>
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


--===============2493833060562297377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a0kvDU9Y5772Ejco"
Content-Disposition: inline


--a0kvDU9Y5772Ejco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 25, 2014 at 08:25:56PM +0200, Lars-Peter Clausen wrote:
> Commit f227b88f0fce ("ASoC: core: Add signed register volume control logic")
> added support for signed control to the generic volsw control handler.
> This makes it possible to use them for the S8 control as well, rather than
> having to use a custom control handler implementation.

Applied, thanks.

--a0kvDU9Y5772Ejco
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUTuFqAAoJECTWi3JdVIfQI8wH/jwnpEvxhdFM40pTPh7X+G0z
ip5V6IDmqnBrIRkYAESj49SmnvYNu4rt9Ukn+chIHzGOuVmnVgCsx7WuimBrwmCH
UKcO5EAfmoAzWEQWr40WtqUZukL7f3SC+0c2GfSPkDrPS3dHZ9kp7MseYLzvGFlz
yA3zeX9hfoKAYHVH5Hkrekdb3Aota/4JHAPgl8yLRQFO4ROMPpXB8HkqMHIhdBf2
rXYInpmbZWWoNPKHEe1ZIKQWOjicYQ4IXsafD4nNZkfVEsfh6gcnEAVV6dzWyvwZ
Ji0CEM9Xxt+u+mlmAQ0mm221RA8VnuO+69xhZkl3pL+jkWqaeOmrJFv6zWPOfkU=
=Jin5
-----END PGP SIGNATURE-----

--a0kvDU9Y5772Ejco--

--===============2493833060562297377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2493833060562297377==--
