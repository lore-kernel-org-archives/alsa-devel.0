From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: zx: Add ZTE zx296702 pcm
	support
Date: Fri, 22 May 2015 12:35:12 +0100
Message-ID: <20150522113512.GF21391@sirena.org.uk>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
 <CABymUCNRH13mO0xXBB6tAZokxWhZFE5CxURxpNgoVs+enU240w@mail.gmail.com>
 <20150521200442.GE21577@sirena.org.uk>
 <CABymUCMYZP9CQ7gj4XXKVmHZ-5vfsxx=8o6aDGSsoWWREc=Zpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7768388727495320420=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9839E265AB0
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:08:14 +0200 (CEST)
In-Reply-To: <CABymUCMYZP9CQ7gj4XXKVmHZ-5vfsxx=8o6aDGSsoWWREc=Zpg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7768388727495320420==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2015 at 09:08:51AM +0800, Jun Nie wrote:
> 2015-05-22 4:04 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > My previous suggestion was to have a CODEC driver for the HDMI IP - I'm
> > not sure why that would require a "direct call"?

> I mean I have to direct call HDMI API in HDMI codec driver, is that acceptable?

I don't know what you mean when you talk about "direct call HDMI API" -
what is the HDMI API to which you refer here?

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXxRvAAoJECTWi3JdVIfQTXEH+wXIWLk/UokzyciPfrBIwEom
I9uyXluDUlto267R9Il00me4QAN2D5gd+LwiHYPWOV9TDMipRSMna0C2HswJwD90
kwLvoT5P6HSh3B1bUsypz6ujoojHL3/iAtRKLqfrfLd3fyqBqevHeVNfJnkBXuW9
9gxAxQLSLXQ303Ma9Py7Ee0Y4+IDAjKpnYJePfCDx3jPp76+/NSpUJWaOn8WMHMI
nc91vmdCH+no+uTcwB2cngrLrdyDGXI+qx0wSOEHerqGE9Zqd0FikCGPe5NRkpnf
RUaRkXVckrwQ7/35IBwNMpM5JEwMC8GPkN/LDgIYivqa2+8IYiMB+X5syj3Wq50=
=PkOw
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

--===============7768388727495320420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7768388727495320420==--
