From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: simple-card: add Device Tree
	support
Date: Fri, 4 Jan 2013 19:37:13 +0000
Message-ID: <20130104193712.GN4627@opensource.wolfsonmicro.com>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5335060318640759412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3256A264F07
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 20:37:14 +0100 (CET)
In-Reply-To: <50E71618.8090302@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5335060318640759412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UOYwgDhKKQYesrzQ"
Content-Disposition: inline


--UOYwgDhKKQYesrzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2013 at 10:49:12AM -0700, Stephen Warren wrote:
> On 12/25/2012 11:53 PM, Kuninori Morimoto wrote:

> > +- simple,asoc,cpu		: phandle for platform

> "cpu" isn't a very good name; it couuld mean anything. "platform" is an
> ASoC-specific term. I think this would be better written as:

> simple-audio,cpu-audio-controller : phandle of the CPU's audio controller

> or perhaps:

> simple-audio,cpu-port : phandle of the CPU's audio port

> or since I assume this binding assumes I2S rather than say AC'97 or
> SlimBus, perhaps:

> simple-audio,i2c-controller : phandle of the CPU's I2S controller

The binding is pretty agnostic as to the interface given that the
bus-specifics are in optional properties.

> > +- simple,asoc,sysclk			: system clock rate

> "clock-frequency" rather than "sysclk" would be more consistent with
> other bindings.

I think specifying the particular clock being referenced is useful here
- we may also end up wanting to specify the BCLK or sample rate due to
some hardware limitation on some system both of which are clocks too.

--UOYwgDhKKQYesrzQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ5y89AAoJELSic+t+oim9TZ0P/2qQosCjIeeZB4UoZumYs/ea
V+sSt+UwQ55mHADa4qektWLW8OGr/ZQvmUrRBNy+mUvbnZOWzdOeYGwZd4Fnm+et
366JOtScRiNir9EAg93787tKi7xhJi84nvOZhOu2vgN/SIZNp3YWcyaJW4TskNSH
N/BFcSv1t6mPxdaTQbUXcB9EFYv3R5PKrZ+mbbg7+6r5SSqfN+Z+UirX5sqZ/7TD
qAB/GluTJ+lYJPTXXYZ0Lb3J+0JmFlsYUeB89HIvGZkCy7h7KvDjRXRLocT/wwAF
dR2RXw+FkCUtZGE161HeeQ780AZ1hfcJGQdPYm+TRKU1G9CLQPAkgln5+N5z8aI+
oR4ug5RiYja9hr1Fp1eENe0SXwqXCa0J6lNTsCVhcFUy3uJKZQ1tEwzOtD5+G/gh
IyFAjyTI+0er99eC58tJIznTeX779oDzyn+Ayz2zfH0uwkE1eUSb50ncvi2IZrZp
5mZIVnYgyL4QCRLkhiqlONIBr8f1uJxpPhcTJD9Ddk/0sy46DHM/xUm+lUAmcUVy
LRsqjEeq+PEsZOgb/ObCsztdUiVfeQJ2PNW2n/j8M0oGwA5taZeUbAHg8VlWMZcY
TVURyxLDnEfJRgR4WuVqDMYR4slOxoacpo74/sqpZGAgJAQMGCC7qSnMnqqAZynl
J6t3nRkLBWNfDD2CWTCN
=sCrV
-----END PGP SIGNATURE-----

--UOYwgDhKKQYesrzQ--

--===============5335060318640759412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5335060318640759412==--
