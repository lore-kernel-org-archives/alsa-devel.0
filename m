From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Add PCM512x driver
Date: Sun, 23 Feb 2014 12:07:55 +0900
Message-ID: <20140223030755.GW25940@sirena.org.uk>
References: <1391689575-4039-1-git-send-email-broonie@kernel.org>
 <s5hr47gv1yi.wl%tiwai@suse.de>
 <20140206130735.GP32298@sirena.org.uk>
 <s5hwqgsy8b4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5089101804103315654=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E857B2650AF
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:11:51 +0100 (CET)
In-Reply-To: <s5hwqgsy8b4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Florian Meier <florian.meier@koalo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5089101804103315654==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ha+eVGMYkthbTTrH"
Content-Disposition: inline


--Ha+eVGMYkthbTTrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:22:23PM +0100, Takashi Iwai wrote:

> I audited through the current code, and indeed there are quite a few
> bugs because of this.  I'm going to send a full patch series including
> cleanups to alsa-devel ML.  Since I split patches over each driver, it
> ended up 102 patches.  So, be prepared :)

OK, I think that's everything handled now.

> There are still open issues after this, and let's discuss in another
> thread.

What were these?

--Ha+eVGMYkthbTTrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWYIAAoJELSic+t+oim9UOEQAIDLDx7ETITH74DGjMkZQ+8t
9b22OSav80PQfwKDyUiu+3D0lY0NQYQGdWJ/dQbazuhG57tXUrKHHrWI5XzeFE+R
k05rGsxqN9dLsuTZJ/rrpRLfBJ2iPEAduJ5R/BtZXzLzY8vzccS1DDC2n6BZ7sBc
J8iwQF3H33kaK+ok0FSMCJ+qL6DpiC+AivRRaLWYnoyOpSkP/1s/on6sqxSq2xHG
WesCDNWgr7YLSTrKuLgLjGQ4yQ0P9IVgKtTYeJpOKCWnx00M7rsPwwyU2R/AI9Hm
tsvdxAjFZexV/V6lW0P9O9m+VUfsd2o+YMsXJ5csz/4HbErdHDNx4wqJlQuUC+Ic
TT4FwOFDOML5VVjrCTiiT1Bdc/S2hvovs5R5QKAzwKj/p7c6m3SSsF3D0Co33kgA
KPA/7Mo+UK5S0jgl5vjXJaRIeXzYC66xXN0PHZ88wo1HvpFk3rZWKBZVZZhUXsLn
TSMS1+4qVqj20OoLEJkWElwf+SdfMvkCNBWLY2rVJ8C5O5/AIsVl3AJiLXk67NAJ
LXzXUF84zMJ68cZX/2SVMrcbloxKCcGlhHR7rnaMti1sFycDmm2n/VIsZV4/fwTQ
C8UdI2I/rPX3tUy4xFD3A9iMq1cvg9hxFUxWe+LegGXLFPsDoi/ADr9k7GC79jwr
GDICwNhcC6EiBqn+2pk1
=nF50
-----END PGP SIGNATURE-----

--Ha+eVGMYkthbTTrH--

--===============5089101804103315654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5089101804103315654==--
