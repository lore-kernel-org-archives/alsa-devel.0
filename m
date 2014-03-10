From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 10:10:38 +0000
Message-ID: <20140310101038.GO28112@sirena.org.uk>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com> <531D756A.6000505@metafoo.de>
 <20140310091250.GD28112@sirena.org.uk>
 <531D84E1.8050706@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8771021461193178995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53412265071
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 11:10:55 +0100 (CET)
In-Reply-To: <531D84E1.8050706@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8771021461193178995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Afp4e3CscGk5BalI"
Content-Disposition: inline


--Afp4e3CscGk5BalI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 10:24:49AM +0100, Lars-Peter Clausen wrote:
> On 03/10/2014 10:12 AM, Mark Brown wrote:

> >In general anything keying this stuff off DT is going to have that sort
> >of thing going on - most if not all of the things that are registering
> >in several chunks are doing so because some of it is conditional.

> Before we had the support for card table based setup you'd had to
> register them in chunks, because the components became available one
> after another and you couldn't register DAPM elements for one
> component in the callback of another one. When using the table based
> setup the widgets are registered before all components are
> registered and the routes are registered after all the components
> have been registered.

No, that's not the case at all - what makes you think that's the case?
All table based setup did was move things from code to data, I'm not
sure what you mean by registering DAPM elements from one component in
the callback for another.  The only thing that should be registering
things for other components is the card and the general idea was to
register everything in late_probe().

--Afp4e3CscGk5BalI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHY+bAAoJELSic+t+oim9S7QP/RfgoCPBkxqIcbtSCpP1BOT1
SFKwc6hojyWLMNeDIz/ym5iFjLxCwSZLw7ydrAWIW0dVsBUX7v3vPGQgAXZKoKUn
DkoT8ejckodYeHav4kobmaw4ML+l66VD6M1vwKjeUSJYG9JhDQWefEbylKwOR84Y
u6ymyDAuSvyFHPSmY6bw3n8eOiMUp5ugBm3LoTfjv8pfUqbTt7JokiE4qi0QvWC/
+AQp5+nbAxH+W+6y1DAF+iIE8mduEhS08vg9+RkikNeiryWfUqV1I0IsP6yYX5jK
OzmHJ4+NhCcd69Qb7bCIamwDhv9umxN62GtUnmOcX+nm1PXDH7zTRORHrjdvVWqt
YdpLgAwJcweyiCtsrZbO1eViIDm/XEJqQnmqxbPCExMxd7pmn0Js+sbq/AV/Ptif
C/OYtu/1a+8KaMbxt3xS8G4bhQ5faGM/gW81H93EdIzX8rYE2yfoQZt5mrYNNBOu
koPCssJ7T9RR3X19P1EGZFOilffiYh2Q65UaLh3OxVDdKKfqiBbhwSSCq5aEBK3A
eWvlt9H5+xkKC5QAm947Ee30KOexY7LSqkBlhJYNEG1C9zLFgWgRR1YYo6cP5nNm
K7NqHj3vF9Daoez2yTIG/BKyiOlQY95M0vQu8SHMsNIwGzWBIO8y2mdEtweeClfH
7bp2peNCZA7YpIIPeC0D
=iwxj
-----END PGP SIGNATURE-----

--Afp4e3CscGk5BalI--

--===============8771021461193178995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8771021461193178995==--
