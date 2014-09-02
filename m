From: Mark Brown <broonie@kernel.org>
Subject: Re: simle-card DT style for DPCM
Date: Tue, 2 Sep 2014 12:34:07 +0100
Message-ID: <20140902113407.GV29327@sirena.org.uk>
References: <877g1o18ka.wl%kuninori.morimoto.gx@gmail.com>
 <20140901143047.GX29327@sirena.org.uk>
 <87mwaikdzx.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5241717964579427426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1CE726519B
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 13:34:32 +0200 (CEST)
In-Reply-To: <87mwaikdzx.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5241717964579427426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L7QcuKEPlEDqpLxW"
Content-Disposition: inline


--L7QcuKEPlEDqpLxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 06:28:04PM -0700, Kuninori Morimoto wrote:

> > I think here what I'd expect to see is only one CPU DAI specified for
> > the back end link in the CPU that is actually linked to the CODEC and
> > the front ends being worked out by the drivers, unless there are systems
> > where the set of front ends can be configured at system build time (as
> > opposed to from software at runtime) somehow.

> This means BE don't know who is FE.
> The implementation can be more easy if it has
> connect-to / connect-from property
> (I'm not sure this is good naming...)

We don't need to get this from DT if it's fixed in the SoC - the driver
for the SoC can know this.  The whole front end/back end thing is a bit
of a Linuxism.

--L7QcuKEPlEDqpLxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBassAAoJELSic+t+oim93qsP/RCnL/EZxICw8vGHXva9pmaR
/cZUKeMBwYOV/0fP+ZekDRHP3tLq1gFc1z81NwHPfesI8T45HHRQSBPWWiVQYwJP
1yCu8BuPXVgVZd7Cz97N7l2zPXENyllm4SJI2ROQsDyxxoU9obx1BQgJQVq/zVqc
O5xDI7q3xny8i/caUrJKey8SF53b3ERov/bxdb+xCA71SVEkaXeVml5LEuDiQ71P
Ir9zLMY95TvfMLPp0ivCeEVpOXIkyDwqKh826G2GRmjHQL4wJb8A+4cHR8n6LC17
x8X60Ui32izoVXdnpiHeum2+vhluKt1Gn1UKownNpjDwvDMu/1sCqRjKx5nh5m4X
G0EIFZuCBUyrTYikkY4nfGbjIumo06Beb+f9qq/ge2s923jyR4QXRsim5n0szECO
Lxcu5/fHsiKwFjM5T15yUoGadkZ5Dod7FZp3Ovv5DwTWNXrIx9cyjQvN5My4pT/c
f8K4v4MRHwiUasmb83YD8hCWEBiH1mjjiYn0U4kVvO8i1nkLXYygpLSUFJx1z3rH
YjjoWDfkCXhWu7jHuFFZaSLd2DW1zUPmkcRkKRSkzsTjF03yqXq0ZSsOuRb0DfKs
HR5ZBj90AEgcUUAMBeVCtduRS7ca9pdDFFrHP2B2wE9IVW0AvBKcZjAur6H8+jp3
JhR0iULuYNn35p6T9UPA
=JE0d
-----END PGP SIGNATURE-----

--L7QcuKEPlEDqpLxW--

--===============5241717964579427426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5241717964579427426==--
