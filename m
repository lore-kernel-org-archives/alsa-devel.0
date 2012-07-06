From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix locking during codec
	shutdown
Date: Fri, 6 Jul 2012 17:02:21 +0100
Message-ID: <20120706160220.GG4017@opensource.wolfsonmicro.com>
References: <1341590225-20837-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6597440053499339538=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AADD0104580
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 18:02:28 +0200 (CEST)
In-Reply-To: <1341590225-20837-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6597440053499339538==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 04:57:05PM +0100, Liam Girdwood wrote:
> Codec shutdown performs a DAPM power sequence that might cause conflicts
> and/or race conditions if another stream power event is running simultaneously.
> Use card's dapm mutex to protect any potential race condition between them.

There's a bigger problem here if we're managing to run into this - the
shutdown function is only supposed to be being called while the system
is in the middle of shutting down so we've probably got a bunch of other
races further up the stack to worry about too...

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9wuiAAoJEBus8iNuMP3dkTcP/jMJEqUGoImf+9Yll7Kg+NB1
EJingr7VlY+AlRmPxyGSHWlGUikhhYRZOogkUZDPbI85loMawNsBtUFQy+aoegsZ
OTbzEULiVZFM7yI6oIqHkLDyTfKfMxzP4OIyZCs1xRasbJdqooS8iPw342t8fzoL
5OYnftjylrK2rw5P5GRck431S3aufLwmeJAE++z8mafmgDSlIYCMDFFopua9mqMR
gTqkajTVU+BUHZ+4D/3TOJeuEugeSBh8uiyPxD/VbKuRgqC9CIOwhrH8PL5/DQSW
Z26A1jK3HYXCzryaWR03lwS6KJ3hS5aU2sOS6b+/ZnqSR9uTst3YqfJIqXlWXX2w
kmfWO19kIdtL6/HVAOrppj/4Qil6HiknThzMHP3t7kT5RzBZ1vkb/aW6hfDLkyWV
3uBWfqzR2Ack6XNUJJ0kh4hcsKJTeZYUQStRB4wG1sm4p35i4YZuUMIAGDpBrO/N
rSG+F/3BLjdWnMjzcDCztSFd/G3UIvFfn9wNKxg56/YEo2TZ1yuvLByMjUuQKEDq
spGd+7Ck5/NXImoHCiUtxvv8cIUSWmXiqFJVkTVOelUhujWDP1U/490Ng2PM7h2/
7XjoNL8eV5kozRaexIuAEUw//SHa4a+g2ND7zbuuSAL0nL/1dtfJEwPn1wkZWvgH
ihignFhcVxNwU5V/Qz3N
=76sV
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--

--===============6597440053499339538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6597440053499339538==--
