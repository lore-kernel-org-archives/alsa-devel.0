From: Mark Brown <broonie@kernel.org>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Tue, 16 Jul 2013 17:57:08 +0100
Message-ID: <20130716165708.GT22506@sirena.org.uk>
References: <51E55925.5080208@gmail.com> <20130716162043.GS22506@sirena.org.uk>
 <51E575E3.3040409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6030588174959348701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5858E265094
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 18:57:10 +0200 (CEST)
In-Reply-To: <51E575E3.3040409@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6030588174959348701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="15k5Fuw+yLfT1d9X"
Content-Disposition: inline


--15k5Fuw+yLfT1d9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 06:33:39PM +0200, Daniel Mack wrote:
> On 16.07.2013 18:20, Mark Brown wrote:

> > No, no feature here.  Off the top of my head I'd suggest soc-pcm plus a
> > virtual DAI for the second link.

> That would still require userspace to open and configure both
> subdevices, right?

Shouldn't.

> Do you think it's a good idea to teach DAI links support for more than
> one codec? At a glance, it seems quite possible: the modes and rates
> would be limited down to the intersection of those of each codec, and
> the PCM callbacks would be relayed to all codecs in the list.

In principal yet but we want better DAPM integration I think - having an
unused device on the link probably ought not have any impact on other
devices for example.

--15k5Fuw+yLfT1d9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5XthAAoJELSic+t+oim9y7sP/RERnucd86P5gc64qk8j7Gq0
cHAfRHUcIXJFlGNtG/7fm7a+pjs59LQe5uiTgIHRUwyLjszJfssFI81QR1bC+hFw
3ibJITwKJqopcE0Uue18sy72PWNd3I2/vgEx775fS+cIm0N42YN9MlA6l+m5rMMh
D0yRNp2fV9WScGo4p8h3+Enmg0iKIqX9Xb5d5/4yIiyrvb19LVlCF1eoFnCFY4/4
FQlwlYcpdUPQHtKe7kLRCJCXhI0HGJDwD7ThxThNUZyN/zQYrX6KOkFeUBr7Fnh7
2uXX7LZX0HWnaQHFtxrM2qP7YXr+gVVoBhJuphJ2PL0QjdyOqAaMze5pryDJ8Y0X
SrtZiV/9yqXt1HNVXdJ1nqqCgz9uIU4oSdHIWsD8g2HAeif4T5X9UpkvWUd5xrTW
tgT3S8wwAIJgW0wduS0gtGUb39eJGY+3EKCLGB5I+ts8bCELDceFxmh12jUmttOH
yJ7ffzd85BrPa92T+bg+Zxx9jy/hPKj9miHoUcQQXdo4zOC7MvQ4BLKLZQ8eN2mp
59bFgmbjNKZARlvOBzt3o+mGw8NIO9jzurSz7aPtzllHhzo8wYqJHTqDpCfjh0z9
ZJr+WJoZ18rK+nnK+sV4QDdSo8NzjVGpAnuI2VTaasjMqxJW7ri24hg0DMxwKtV1
FZP2s8fQScdare3zJ8CF
=R3e5
-----END PGP SIGNATURE-----

--15k5Fuw+yLfT1d9X--

--===============6030588174959348701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6030588174959348701==--
