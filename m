From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/10] ASoC: dmaengine_pcm: Add open
 function for DT DMA request
Date: Fri, 15 Mar 2013 01:12:11 +0000
Message-ID: <20130315011210.GB4931@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
 <20130313021712.GD27461@S2101-09.ap.freescale.net>
 <20130313104945.GI25610@opensource.wolfsonmicro.com>
 <20130314060442.GB27654@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3519052183084772807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F4B1261639
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 02:12:14 +0100 (CET)
In-Reply-To: <20130314060442.GB27654@S2101-09.ap.freescale.net>
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


--===============3519052183084772807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2013 at 02:04:45PM +0800, Shawn Guo wrote:

> I just double checked my mailbox and can only see the conversation
> between you and rmk, nothing particularly on the removal of the const
> from the name parameter.  Or I'm still missing something?

You're missing the bit where I complained about you doing that - you
should be adding the const to the dmaengine side, not removing it from
the client side.  Unless there's some reason it should be modifiable,
but that'd be very surprising.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQnVkAAoJELSic+t+oim9nZcP/ReTzuTSEBQaa/0jm/6GDsCq
6Xnbzjhux8H8FlGhqJ6yVzQURCsRn7ERhNuwzOtssXjXg3V8BsVDcYiExFuGwNne
MqPNL+t708GL/EcYqaDMXkDNEOBg3/wssVIbnkCPa0SGnbyjJ0rwB2ASGxhWVNy0
K15T4NZYbj4RBQEIGYYIz0IwaShScq+3m6/G/0War/avrkiWiXwNdGko04uVDbOi
r4zjTuyineB02UkOQE2QnJBwWuqBxXzFurJv8bjyHrvzrlb6Vz/3ZC+8MD8UknvL
LgMji+MowGJqDjQbmWmiKseGiuCJ+mxnxvxL77/2i2+XVk8cmPOu9SS06bY9RZ36
1tn9m2zvteQh3JHGgN+24k9+4SXI9gNfyl0iME/tc81yd/naXBNAMkaZs4QOzVCy
k/jZC1iPd0qGpvOvT/NTpHe2ustGvf+fT+qcT5kbvF2MLCli4NllfeIwqyXUfnmp
6E0gWMsZTE2BwBFUCCDDNOwsvG2lknGmpFS/GRTMNGYZ5GdWZtmHlTIdif2+32+d
CtqJHBpEeVFTL5Goki1QrPgQW9fFzqyUdiVIo9fnhBKLxP7gCZnzq7CSh3eFDXKM
Wlg5l6xlpgbpyW1Ymjz99omCXNlC2Gmze2fBsTXxMqkpBO8Z77wrueKks2fCWW6e
HClyvsOoCjz7oTPEty9D
=Y31P
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--

--===============3519052183084772807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3519052183084772807==--
