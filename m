From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/12] ASoC: SOF: Add DSP firmware trace
	event support
Date: Mon, 3 Sep 2018 17:25:03 +0100
Message-ID: <20180903162503.GS10302@sirena.org.uk>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7945517365601788516=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 505B82673F4
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 18:25:04 +0200 (CEST)
In-Reply-To: <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7945517365601788516==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mln0rGgUGuXEqmuI"
Content-Disposition: inline


--mln0rGgUGuXEqmuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 04:19:05PM +0100, Liam Girdwood wrote:

> Add a trace event buffer that can be used by userspace to read DSP runtime
> trace events alongside bespoke trace data in realtime for firmware debug.

Should this be integrated into the Linux trace event mechanism rather
than open coded?  It would at least be nice to not call this a trace
event buffer - when I initially read this I was expecting it to be for
the standard Linux stuff which obviously it isn't.

--mln0rGgUGuXEqmuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNYF4ACgkQJNaLcl1U
h9BHZwf+LyUo2xQK3HGovkTIg8xequr1VESaYsog79rUCvuhsiyg1Hvrs/oFXNvY
wi+fc29NRAIHNCzeHZvSh5Z8Kb/7IfkoHt1UmtBmlpy+c8KbN3M8/o8Jep+GZBa+
JFv6AHVF/qroIkQIFNHTH7eh+IycD9K0U5WioYKq81Tbk6iJXaIi9ImqXRqPoaQI
ks/88WVjq6FEVibGlM9xr+BfSK2/sweLYu+2gzQClKG7Jj3bzZUmaTi1zaR2ibcd
Odv8D5L7hzRGi0kotZfDVl1bi3cV1tlEsLe3sHThMzbgL1mFPe/n3pOP+eoHHVKL
FISR83SgE/yKbwxWsj2xsDDSfnyxhQ==
=MCVe
-----END PGP SIGNATURE-----

--mln0rGgUGuXEqmuI--

--===============7945517365601788516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7945517365601788516==--
