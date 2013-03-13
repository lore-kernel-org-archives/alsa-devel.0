From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/10] ASoC: dmaengine_pcm: Add open
 function for DT DMA request
Date: Wed, 13 Mar 2013 10:49:45 +0000
Message-ID: <20130313104945.GI25610@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
 <20130313021712.GD27461@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0188182391086391191=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F74B265E0A
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:50:43 +0100 (CET)
In-Reply-To: <20130313021712.GD27461@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0188182391086391191==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2013 at 10:18:29AM +0800, Shawn Guo wrote:

> I did not see any objection from you on that patch, so I'm waiting for
> you to publish a branch for it, so that my mxs-dma generic binding
> series can move forward.

I commented on the removal of the const from the name parameter (and
ideally an in order version of the patch series would be nice) but in
general I was mostly waiting for review and test from other people.  DT
and dmaengine both seem endless sources of problems so I'd rather make
sure everyone's had a chance to look.

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFm7AAoJELSic+t+oim9TsEP/iczbnrnxmXhIrAdzUi15G3M
ldYDFmpKkBen8gK2DrpzGhV9EskCnvRNJ74HCWMwnxbS/XIacQG0EvT2XsGcf/nb
HxpDn654+4bMCoJ5qDWLCw2cuwi1AyCQdG0WbbXY0v8JbfgYggjktRYrYk9tTYuc
8oo24aPyAQgtJqx5p85utyGV34eaAulLsM4RSSCHF0ICaWeTNbSltLDZUcr7EZrA
MVeSHlBoXzdq2m8ITI0/5DzUP904w5vjkbZbW7I4CG2fTg4EPI3W1kySElLz8Mjr
iSLpNUr+0LSonoXXCNC+PwmZpbR2bR27kFxOkEe6rwB8b7qdnSh9t5J9ba+yaHPO
uDtE6UiQB3JAy1/vnyldoVUWETdF1OS6aptKiiL7+hXYpRx9cV519C8V5rknPFIK
7ZhJvuIWPL1mj13R53SsYfAeWQP8zFn1lT2JxeTrn9bTAsmRJn5MpMvjmhI30s5U
wutl9NjpcAaDeR5LGGcEjFNy+quBGFRiwVH61poaHiQ4ajIbNaW7NMgbAu1EPH49
ZfkMq8TLqs3zhPOCqD0NgpIOIoyz5oBD3ICe/BB8QVRWcfM0T5ng4UGZTAidhEZg
4n7fUVTqnGS86JiLnnCEi+7/VZ/iwgGsySrZ3hfTxET5XBKsBkZ/4CiYK7UPkryd
oMBbqqY3+05n/zZGoz8o
=QheD
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--

--===============0188182391086391191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0188182391086391191==--
