From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add ASRC support
Date: Mon, 30 Jun 2014 15:50:56 +0100
Message-ID: <20140630145056.GZ23300@sirena.org.uk>
References: <1403866691-5031-1-git-send-email-bardliao@realtek.com>
 <53AD7A1A.2090501@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D75C87F7@RTITMBSV03.realtek.com.tw>
 <53B13FB2.1090304@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7592517270826875519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EECCB261A1A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 16:51:16 +0200 (CEST)
In-Reply-To: <53B13FB2.1090304@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7592517270826875519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Llo4hPm8J4nvJ7do"
Content-Disposition: inline


--Llo4hPm8J4nvJ7do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 12:45:06PM +0200, Lars-Peter Clausen wrote:
> On 06/30/2014 08:09 AM, Bard Liao wrote:

> >To turn on/off rt5640's ASRC function is not decided by only one
> >condition. To make it flexible, I prefer to use a control to enable/
> >disable ASRC function.

> But the driver should be able to autodetect those conditions, shouldn't it?

That depends; we're back to issues with the clock API again.  If the
device is slave on an interface which is ultimately clocked from a clock
which is also fed directly to the device it's not going to be able to
tell that the two are synchronous even if we have the common clock API.

However this still shouldn't be exposed directly to userspace since the
clocking is generally handled entirely in the kernel.

--Llo4hPm8J4nvJ7do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsXlNAAoJELSic+t+oim9TisP/jR7J+Ch/YNEPKSpCw0XbDFx
mgl+a8wuskstdOaK6ZH12DzvW0LDlMYRlHatp15Lv6cYxhve3oub5iUa2pQUsUtX
53qoWhQiReg1pLjusJINZVisDF8u7oIK+Zk9I0QQ0qEVq8SBMG1xIdVhHdYATSTR
DW3JvS/X5Xk3BG9edeEFW43BJQYiPQPNv5bMUCa+1yhTQqTWX+SrK0yDY2qsqskZ
6xa6TuIMCCZTIp1wmlB9KdCiQlw1XKmubht4V0Xxk50cPhc1sp09PjbweqbE4Erc
n21v7qVWCeJyB5frWuM7HiNo8rRNknO8wqIjeP29Ns00G+R5jBBoAOCm8csWm+lJ
EeV6NQY2hZpCczKrst6hCIS3cZ5BNQ92zz/yAUh7TpLgbI8byQ0PdeFU3XC6LcFF
Oe3AzroENLSgJz3wnkPDNSunIsu8LQNoLfUhebi3TRutmiRBldZnT7+TboazACGV
WtBTgUfFacGzQb8Clvci/1uYh84E76aBJ/7Xh+zaSuxGOrpKy9hvHU0D8l61v82+
NrsCZ6IPqLxv+qCCILYJZAZWOl2icLdpxF37puVDKVt6ZfyhTlbi/V9xJ27hntzZ
TcbTPrrmZcZQCOj+a40sFypPPFrGm3N/Gx05GW+036ggSojgVyNGKSzpbTZasNf4
hpM5HXKIElahvMnfZqGK
=f4wA
-----END PGP SIGNATURE-----

--Llo4hPm8J4nvJ7do--

--===============7592517270826875519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7592517270826875519==--
