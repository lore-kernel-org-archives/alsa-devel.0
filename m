From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/10] ASoC: dmaengine_pcm: Add open
 function for DT DMA request
Date: Tue, 12 Mar 2013 19:02:07 +0000
Message-ID: <20130312190206.GY19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0911268487793710241=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC7FF265DF9
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 20:02:08 +0100 (CET)
In-Reply-To: <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0911268487793710241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ELMKpCVvjiB+uwRu"
Content-Disposition: inline


--ELMKpCVvjiB+uwRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 10, 2013 at 07:33:09PM +0100, Markus Pargmann wrote:
> Add a function to open a DMA PCM substream using devicetree data
> provided via the client device node. The patch introduces a public
> function and a private subfunction that is called by both open
> functions.

Someone (I think it was Shawn) sent a very similar patch just recently
which appears to have fallen out of my inbox unfortunately - can you
please check what's going on there and coordinate with them?  Let me
know if you can't find the patch and I'll dig it out.

--ELMKpCVvjiB+uwRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3ujAAoJELSic+t+oim9H/8P/j8uNdekHBn0RrtdgHL3ykO5
NNW26DLgtlvPR7bf4IrdMfLr92c4OWvIKALfZwHgGI3ozaiRSzmEIMWY5wNrhAC9
UJi+hY+aJjBrd0jK12jOKmKqDVNnEjqD6y+4+bfueGYZ0o8xNo/WlolfjIcpQfvl
KAPNQ0pmw6LRekNzkTAEYEOR9ZTdYCH1w9n8fw0rVWKgK4ZEkLhrb7aOGsmYqkF5
oOLgIQdZJtVLLuJngvuzg4HnuXBh6ny+ps8zpjphm+GaCOBVOtrYMg1Oc6HmcV0f
LRMwmc6tMOcwnwmQiEZ1lJjle8G96WQENM+2uROkGcuJLFMWbaq0sXxGKI+AeYv1
5Q+zUp99J+42Yfzf2/hZ+4jKT7zYYdDg2oz6njVvu6BCoEZtFgXgGAke8I/JhxYh
n/T+V18ZDFLvHX0PahmaTw8jLmlB+LcJiA2vN7/RJLcoGQo0+GhowIVoKPAPIK6h
3jirA2J4hQCMixF1I6uSCVK3Puqbe+E7u1uSLkSR2suUXfuT47dtdf65o9Eq8S76
zr8Q0B1OtjjfUTigpF2/eEby9LhZhqB/P26oBk5vDQM9KEkFfeho11p5IRNYx+DC
e3HnlZniFS9gAL+JwI48ko5z7tw12o+OXDfOToI+/Ce5GMhr6dHlFgVghOmHY7tW
27m3ESkHyOwHy9kBjCjj
=2vC7
-----END PGP SIGNATURE-----

--ELMKpCVvjiB+uwRu--

--===============0911268487793710241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0911268487793710241==--
