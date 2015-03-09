From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5100: match wait_for_completion_timeout return
 type
Date: Mon, 9 Mar 2015 11:26:08 +0000
Message-ID: <20150309112608.GG28806@sirena.org.uk>
References: <1425812227-24172-1-git-send-email-hofrat@osadl.org>
 <20150308184902.GT28806@sirena.org.uk>
 <20150309062226.GA9226@opentech.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cV8yfgwCnzpki16T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150309062226.GA9226@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Axel Lin <axel.lin@ingics.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--cV8yfgwCnzpki16T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 07:22:26AM +0100, Nicholas Mc Guire wrote:
> On Sun, 08 Mar 2015, Mark Brown wrote:

> > You are sending these to a very large CC list many of whom have no
> > obvious connection to the driver - please take care to ensure that the
> > people you are sending patches to are likely to want to review the code,
> > this helps keep people's mailboxes less noisy.

> sorry if I messed that up - my understanding was that
> it should go out to all that scripts/get_mainteiner.pl shows
> for the espective file. Should some of those listed
> not be put on the CC list - or only maintainers+mailinglists ?

No, if you're doing that based on the --git option it'll typically get a
lot of false positives for people doing coe cleanups for things.
Without git it's a bit more reliable but may miss people who work on the
code but aren't in MAINTAINERS.

--cV8yfgwCnzpki16T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/YNPAAoJECTWi3JdVIfQunkH/2flhKxvABPEIsspcsp8zhC0
MTwFayMdd77UPNPHNm1J6NrBgtnHLr7Tg6bEVubOB3IpovUDSPnAyoeZXWkOozDg
cB/0DBcBvaHMkeBDAVWHBnE8W65OORYTZf5nGe3M7C/l+x/o44xouNQLtxdpH5os
8zhYjYvFLPQTqxZ/1lDGqyVpoKwnpGAwMYgfGXxzB7hfQvZV2P6wuUYcdZVcUkXF
ev/TYV/cwcLyCL16UZs4gOKm1fXJoaeHBVC4lvu70lfbkj9K8dUcICEP+hAqzB5A
4exVgzg2Qmr/5etV69SzAnaOHSaCgdR75FgAXmRmjw6QS0UfMs7daDzfSspMQeM=
=ze8Z
-----END PGP SIGNATURE-----

--cV8yfgwCnzpki16T--
