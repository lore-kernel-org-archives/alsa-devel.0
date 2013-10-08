From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Tue, 8 Oct 2013 11:44:57 +0100
Message-ID: <20131008104457.GA21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8322229150382268925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B3A692652A8
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 12:45:03 +0200 (CEST)
In-Reply-To: <20131008094839.GB19005@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8322229150382268925==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ON0CT8LY+wgE1XqS"
Content-Disposition: inline


--ON0CT8LY+wgE1XqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2013 at 11:48:39AM +0200, Markus Pargmann wrote:
> On Tue, Oct 08, 2013 at 10:34:13AM +0100, Mark Brown wrote:

> > I meant just unwinding the things done in the trigger call.

> You mean unwinding when we detect the error? If we return the
> error code from the trigger function, the pcm_native.c will still
> trigger a STOP command which is executed on all components.

Sure, but it's another way of getting consistency and does seem a bit
more obvious.

> > > Another possibility is to explicitly allow multiple _STOPs. Then I could
> > > fix the driver to store the clock state. But I would prefer a generic
> > > solution.

> > You're going to have to handle this anyway to be robust - what happens
> > if it's the clock enable that fails?

> If clk_enable fails, we can return an error code in the mxs-saif trigger
> function. Of course the error handling is missing here, but it is not
> necessary to store the state of the clock to handle errors properly.

Right, but then _STOP will be called without the clock having been
successfully enabled so you'll have an unbalanced clk_disable().

--ON0CT8LY+wgE1XqS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSU+ImAAoJELSic+t+oim9m7IQAJTpr0aHnEMIATD/k1T4C10U
WobS/EZF2yLUaf4xPB29XpWk9EO+HInIJ2+mxq8on3j48J0guskdAzmqFPRm75Se
miJY1DDJaZPEjETzpw0Yi2ASoFugXROzed0Jfky/+HNHGsshmfIW/PJIOJDMpZJT
jm4CP5B0wS9JmO2bqvV2ePdUW4sF1HuXsQSTbecTjydd3XZzrVXaQs2PbX2iDmeK
iPHUT7plTTLn2xYbU0vbEcpz7InWNQyadl1XIO9/rA3kphkoPQJlKFwpyIua5Egv
cKWriSzGPfvk9X6uf8AaxiF+eRZEMiNtoGX59Bb54tlU0Y8BekNtocDu5cypbs9f
CUe/ESKmBda66uYaca5sbeBiEejRkoH4JYq6uOVd5g2lBTJAIoyYwe63QnyLYBNz
lnDgDqle3hVnbgd8cXUaOu6z5u4CVHHZcQj1cbT9SODJd4lmGkb4Z52CaBdweAVg
ffl8Q4hn/86kbffPMv0J5G75gWInL9iZE01+ZvQJIAIWraCFcYmKSiqoSXi/5GK4
ubE7Gt4KtyUD/+anY7cmOxqUdW8adhQCENhaRda9vnOYcH5eWgpxWudqcjSH2v+a
93XJ4Qsb/sPdeMT3soXrZvk3vMyBQWgg49N3TXF1o/rq/gPapRis/9oyqesSmrYA
s87XeY6d5+HjKe+Z/kXO
=pFC5
-----END PGP SIGNATURE-----

--ON0CT8LY+wgE1XqS--

--===============8322229150382268925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8322229150382268925==--
