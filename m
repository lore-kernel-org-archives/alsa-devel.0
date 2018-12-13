From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7 v2] ASoC: merge audio-graph-scu into
 audio-graph - final step
Date: Thu, 13 Dec 2018 15:20:55 +0000
Message-ID: <20181213152055.GM10669@sirena.org.uk>
References: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
 <20181213030219.GJ39861@atomide.com>
 <20181213033750.GK39861@atomide.com>
 <87zhta14la.wl-kuninori.morimoto.gx@renesas.com>
 <20181213043445.GL39861@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1333127685313474297=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FE626789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 16:20:57 +0100 (CET)
In-Reply-To: <20181213043445.GL39861@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1333127685313474297==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 08:34:45PM -0800, Tony Lindgren wrote:
> * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 03:45]:
> > But.. Hmm...
> > to keep compatibility, use previous style, make sense  ?

> > 	if (endpoint had reg)
> > 		use it
> > 	else if (port had reg)
> > 		use it
> > 	else
> > 		use endpoint count

> I guess it that works and is easy to add :) Maybe warn about needing to
> add a reg property too?

Yes, both of these seem like a good idea.

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSeNYACgkQJNaLcl1U
h9AaCgf/dSn/4NDL+RSmVyAAb896EoskC6jWgcOpI+fzluG/A+C+M4s9+maHBc8P
KHQ56fH2O1J+UCnoJBw2XLyByZZfKbOXgwUDIhJcPiaUI4rGv8xdWTTYGn4DVJNK
XNCDE9AIAbxvVABKeBgFLSKNBbJxispcaXuDZdLveM8bOk9YmJZ37uzHgPrSadc5
ZfiKO2/8c+AKcWS7tvy0Q/jHWxpfsCbbkL8HE5pXBpcam29xzBBSEg6VM058P9Jm
tckDvkCxYTllaMLJnz4D6/dvcUlp0Eh9k+6btaYaLblXtgVIos+BjDC0DxlF1e1q
c41Pj6fV+csKa3LnmNvZ1z+W91wUAA==
=ukKk
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--

--===============1333127685313474297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1333127685313474297==--
