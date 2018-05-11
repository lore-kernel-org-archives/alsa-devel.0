From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: nau8810: change the target of
	MIC BIAS supply
Date: Fri, 11 May 2018 11:23:41 +0900
Message-ID: <20180511022341.GG949@sirena.org.uk>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
 <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
 <20180503231047.GB13402@sirena.org.uk>
 <5AEBB308.6020006@nuvoton.com>
 <20180505010110.GI13402@sirena.org.uk>
 <5AEFF8D8.5090003@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7271056212785854608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FC22267790
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:23:47 +0200 (CEST)
In-Reply-To: <5AEFF8D8.5090003@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============7271056212785854608==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 07, 2018 at 02:57:28PM +0800, John Hsu wrote:

> Yes, you are right. In the driver, we suppose that the input of codec
> is microphone always. Therefore, we make the micbias on to provide the
> power of microphone automatically if any input path is enabled.
> What advice do you have to deal with micbias? Thank you.

Like I say you should just provide the MICBIAS pin and leave it up to
the machine drivers to connect it to whatever microphones it is being
used with.  This means deleting the route from the driver and (in order
to avoid breaking them) adding the relevant route to any machine drivers
that are in mainline already.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr0/qwACgkQJNaLcl1U
h9Ay8wf9EpyU64WXbVNyZNVjMct91WPLDrRKl1wGJmkmL9Deas6oN+oXL8EKrTxp
g7vx1/3XpJObetlvK+CYxTVWxCpKQhUEGnc5Cj2pkvYs1t/QYd4bmIZacdOZkrKi
ObUgQjSTjbmIoV7urediSQBcUB9H5/6J8E5wD1DQOyWNobsomJRFN049d1Vg+815
m8WHCZKFEC43fQEzvjwBSdwQ3YhwZ6ppQUPEYdapwxqA2KqrWP4lASXWWHeDIhMn
5oEHhU+bk5pwEkevUaTAeMXknSRQSJAX/ZnSFZFVfxHq3T8tPEqRuu6QVebr7gfv
/Zpd2NI8mM9wzSbR9RUMn7yYINreRA==
=AQf7
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--

--===============7271056212785854608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7271056212785854608==--
