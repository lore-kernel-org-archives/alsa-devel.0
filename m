From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Wed, 25 May 2016 11:18:01 +0100
Message-ID: <20160525101801.GT8206@sirena.org.uk>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
 <20160524164151.GM8206@sirena.org.uk>
 <57448A42.9050606@synopsys.com>
 <20160524175144.GO8206@sirena.org.uk>
 <57457A63.5060702@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6603181306679551285=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B77E26054D
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2016 12:18:15 +0200 (CEST)
In-Reply-To: <57457A63.5060702@synopsys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6603181306679551285==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xt4oM5y0t/70YhQj"
Content-Disposition: inline


--xt4oM5y0t/70YhQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 11:11:47AM +0100, Jose Abreu wrote:

> I think I will take the second option. Something like this:
> "
>     ret = snd_dmaengine_pcm_register(...)
>     if (ret == -EPROBE_DEFER)
>         return ret;
>     else
>         pio_register(...);
> "?

Sure.  You should print a diagnostic if you fail to get the DMA, for any
real system it's going to be a bug.

--xt4oM5y0t/70YhQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRXvYAAoJECTWi3JdVIfQFRoH/ROHC8Unn9zInOyNPAcXrAfI
bQY4pVZGjlHMM3ep1+PkJqUFOToTnVpItVq8b0XUfppWJd8n3FG9BzMcAHVWmLou
/wGb8BJXjk3WYxBtBsDNPRvixJviOmDoXTbIq3bpp5oqxEyvOVAvmheHrhB+JMlG
+MzhX2PpSuolXboq5chOIL4CD4fiXKs6I2AwYwL6C3Q2qTR2L7IJuZLFH3q7oNgC
W0Md+XAZJfPMj4B5olkmr26R+XEu2VgaScVuNoEfnrML24/D1wPXZ0uC/MgGdRYG
g0sAdjnoDmqqFsJs5SzF9Cyp5Iyv14UD5LSjHYJl7s+9auBZUZwEpV9ZXznoikw=
=C0EL
-----END PGP SIGNATURE-----

--xt4oM5y0t/70YhQj--

--===============6603181306679551285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6603181306679551285==--
