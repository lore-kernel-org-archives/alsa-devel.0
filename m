From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Fri, 9 Mar 2012 12:20:59 +0000
Message-ID: <20120309122058.GK3273@opensource.wolfsonmicro.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4670572880059393707=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 691C610BC24
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:21:01 +0100 (CET)
In-Reply-To: <1331248757-3408-4-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4670572880059393707==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 01:19:17AM +0200, Grazvydas Ignotas wrote:

> +	frames.min = frames.min + frames.min / 2;

Call me picky but I'd like some brackets here as I had to think for a
few seconds if that was (frames.min + frames.min) / 2.  But

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfWjAAoJEBus8iNuMP3dPzgP/3ffrv8hibDnTTOQVjw5qjgB
MLLpy/kh3bN9+/+dOg08n+7LwNo5PDE3/PPKjObEXiJnTxg2Q4wLxX1uQdlqM2Ds
5onVsI27m1M2KHsvj88jAbJ1wbCK7w1QmYaStY6ZgTXSbQZZZkaNnfV4EpO/7Z0Q
AZ8kZicHTL029n7cp9WaBCsJynhmZtCnVfofOWDpp05KBRtA9SYR/tDzd5g9V3MB
7tSVdXq6HxJsFhuBUHXFyDVZN5T6PaNa1qb4dcEfYgH6oRF9DcJ0y643GCk1ttLR
qv96j4W9dxm1g92u6czvOZs3YpRgUOE0y3KLv9gCmvfr73itpYcxkgQWzPaRKgZL
PWqFbLKEhsGJESqv8BfVcdYHWbICecuj1q9j+wXCmGsuOzsg/O0SZ5qYH5HEr4Sf
0ZD/FS/QHXWElFe165pJND9GFTuoRtIkfHUptEq7AhqJ+U18RfB+smIrQ8zsp0FL
F05iCyzLpBCTvymz09HJt4jUFEhOERNE7OxW03N0MWVv/oViRNTT+lFxPxkkzJ/X
0DYku0FpZAFrdzeKFsfScBeFEr3R5W82pucKSsxTmuzMa0E17IBDv6EGaHlfLbpx
Ir8jVhVYh5F9z3E3yYjQUIG3gYFZ/UgL6ddDXSuoWD1AEV0tuXwP5qmQhk7RcoD4
DzRKYS8MkO1jow7+QHta
=oEJp
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--

--===============4670572880059393707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4670572880059393707==--
