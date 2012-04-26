From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: dpcm: Add Dynamic PCM core
	operations.
Date: Thu, 26 Apr 2012 17:54:59 +0100
Message-ID: <20120426165459.GN3207@opensource.wolfsonmicro.com>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5471182628353353156=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5668F10BB9D
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:55:01 +0200 (CEST)
In-Reply-To: <1335352373-5237-1-git-send-email-lrg@ti.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5471182628353353156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCXyoJ//PRyfzsc9"
Content-Disposition: inline


--KCXyoJ//PRyfzsc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2012 at 12:12:49PM +0100, Liam Girdwood wrote:
> The Dynamic PCM core allows digital audio data to be dynamically
> routed between different ALSA PCMs and DAI links on SoC CPUs with
> on chip DSP devices. e.g. audio data could be played on pcm:0,0 and
> routed to any (or all) SoC DAI links.

I've applied all these now - after recovering from the shock of seeing
them! :)

I think we need to have a look at/think about the no_pcm flag, partly
just in relation to the CODEC<->CODEC code as that's also figuring out
that there's no PCM but it does it just by checking that there's no DMA
driver specified.  But I'm not sure what the best thing to do is here
without seeing a machine driver or two.

--KCXyoJ//PRyfzsc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmX3bAAoJEBus8iNuMP3d3jsP/1LeHZ/bRBZ7slWAvzqL5DMg
kX8/LeAal81yWnvGzpCKMMeEftFkNKPQYaj170rk2ZhHWJqW2hNUVWxDZiXYHt39
OVzVW2ZcNUfTHtfG5b7hF/cmPqR08FZmnPC2N3Mt47ri01duS3+el/6/+rJFZjeY
oZmOy3+49wkJOLURiwVidpxJqN3kYTXsThrbC7+XtF71eXlv02WZX3gdIHLrwmlS
7MgLAC3enn5ljT9yIY0BVJpo+ccPKM1wG0iRjdU5dVKj1Fhnyi+IZnxQIG/KvGYT
fVj4gqWRPj+uIjITHNbzYIRqwxDQVsadywWLu3frdkXALbhUKjecKXTLLYli0q3d
5D5QCmgi5Hh1t5d8MISE5Hvh+VlR1K90WYhPsPyNRJVgCVNo64INiYAJJzS5MHF7
xO72KRYfHdcedRHbh1gsHdxDyFwFQyqRKybFsr0sjc3HIZZ3RU9XJ5/8XE8OB1p7
GDH1M3CuyDvkcJoUGWH+pAc9ZZe1DdLXWdQFyGVTrDYhE/1ZR0S7licrE2iKooPW
kBJIpc3vp4xAceejel+gyvj+cSwiljle06ES2N7wQo5gd6XtWzDqyUzNfr06bBrR
1kB0In83w4H3zqu5WUVALCvvNWeRNVxlI2VWNk9hkZSGFYlLKdDl6lrpEaN/LGbO
p063egeH+p6t5QNDsw9z
=Yq1P
-----END PGP SIGNATURE-----

--KCXyoJ//PRyfzsc9--

--===============5471182628353353156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5471182628353353156==--
