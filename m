From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42l52: Reorder Min/Max and
 update to SX_TLV for Beep Volume
Date: Mon, 5 Aug 2013 21:24:39 +0100
Message-ID: <20130805202439.GA30764@sirena.org.uk>
References: <alpine.DEB.2.10.1308051508140.5288@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6630095213467998540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ECFB7265213
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 22:24:41 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1308051508140.5288@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6630095213467998540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 03:08:47PM -0500, Brian Austin wrote:
> Beep Volume Min/Max was backwards.
> Change to SOC_SONGLE_SX_TLV for correct volume representation

This doesn't apply against v3.11-rc4 - can you check what's going on
there please?  I don't see any obvious issues by eye which is
worrying...

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAAoEAAoJELSic+t+oim9LokP/AmEWDnJnX4ChxFk1m1Ru7WV
PP+uH0hlW62hKNKENmnvzif29xvRAaHKqRDGpdTA6QKqQg7MsDo52n7HdqM4QB3n
Q7XzzM6UA9Ktp8geqhRkT+OUt4ggxHNvTJgwG198dwc3LU8fIgA5SfsoP1no4fAc
0/mrbMCkFNXmbfEqJKX5ORgTk7h57vNmwIapKGJL797rrK6ie8eKj2PNYbtThkgd
vov7ctFDL1xs7Taf+X7TIZ5WMG+pLNtGGErGISmr9A/TI1wcERU/PLJBLqPtflOc
BpwLXDjPmJ2+4+syWHodDkGGJotLlmTj1zTJBiFnsDw1ei4IpcT51ebEdL5CYNq3
rOBh92hgpOvFvDvM/ZrQ8DfJPS/qB3XHhKqiKqQ11PLxThB+7cVEDYq/zUXzEmxd
GeXNldIYsouws1W9V8Rh7uaCe/s0wt6EoVD4JFcIoUE9NNkk51/gvxosEE55DDfM
RKBhU+/otOB9Ki2vlYZbZieIt1WNzK7oZZuadRrtitwCtnBwB/ezd62efxqUqQxe
FXDTwm7W8qPwxm3BRs+PpDSbpYbepRY77cX0S1mtS+Y038gOVTFLLKEj6G8eKuCu
p3DIEoGdgntlAZaPmJvX8kgFL4EJquEvnho8E9sVZfQznhTjqr/UI13melxoueWO
M9q9J5LZfTr34MjUMntz
=9gBg
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--===============6630095213467998540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6630095213467998540==--
