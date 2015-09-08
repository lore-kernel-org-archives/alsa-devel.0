From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] How to perform audio offloading in none
 tunneled mode
Date: Tue, 8 Sep 2015 18:32:45 +0100
Message-ID: <20150908173245.GF9751@sirena.org.uk>
References: <E1ZNiBu-0005i8-Ks@finisterre> <55EF06FC.90400@st.com>
 <55EF10CE.3040803@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7106272277391773070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B6A82606CB
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 19:32:55 +0200 (CEST)
In-Reply-To: <55EF10CE.3040803@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
List-Id: alsa-devel@alsa-project.org


--===============7106272277391773070==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2015 at 11:46:06AM -0500, Pierre-Louis Bossart wrote:

> What you are describing is feasible but has issues related to:
> - delay control
> - DSP scheduling (no real means to process data faster than real-time as you
> would want in a data-driven co-processor)
> There are also divergent views on the benefits of offloading intermediate
> operations to a resource-constrained co-processor, you might be better off
> doing everything on the host in terms of power consumption.

Indeed - there's also a big system complexity hit.  It does depend how
loaded things are if it's worth considering.  Part of the reason there's
no standard way to do it is that the benefits are sufficiently unclear
to be concerning.

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7xu8AAoJECTWi3JdVIfQ0ZsH/0WWwBLc9NxLXtEGQYkF1iVc
NwMoa/7MNOpmwf5KIRck47Q5bwVgohtVy7xGrWwvu3/s1+JHlTU4ZIu8QIYBL7vh
hRYcubf/UopQmFMfj7CcV/jLsQvhdxBEO2vc+NbhYQ78IFcxVyozj7C4X9ItGV3O
1t/ZX/9Nyz9agSrEXTq1bzMV5V+2ObDd/yMq6vZQF/8g0SAfYcwjH0u16FKDhbJs
1uW8yC8JlQFdDwxO0PtlrrJs8RlW92gTkcywCyEv+mIv4iwH40u5rp67rUbJ8RgS
wDV9xdzfvaGpki/JCHBDmovJjrdgQcYAUqLOQmIjdYC33T0dNKDkXwrrHNMsFaA=
=MXqi
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--

--===============7106272277391773070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7106272277391773070==--
