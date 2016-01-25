From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: topology: Add support for FE
 DAI & DAI links
Date: Mon, 25 Jan 2016 15:39:54 +0000
Message-ID: <20160125153954.GU6588@sirena.org.uk>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
 <1453721870.2557.28.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2364368230380723051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B56E1260535
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 16:40:01 +0100 (CET)
In-Reply-To: <1453721870.2557.28.camel@loki>
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
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, vinod.koul@intel.com, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2364368230380723051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/ahWLRVyFWNne16C"
Content-Disposition: inline


--/ahWLRVyFWNne16C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 25, 2016 at 11:37:50AM +0000, Liam Girdwood wrote:

> Mengdong, it might be easier to split this patch into 1/3 and 2,3/3
> since 1/3 will be in Takashi's tree, but then that might not be needed
> it Takashi and Mark agree.

They'll need to all end up in one tree at some point since at least one
of the ASoC patches depends on the ALSA core patch.  Usually we do this
by having me apply things (IIRC Takashi has already acked the ALSA
patch).

--/ahWLRVyFWNne16C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWpkHJAAoJECTWi3JdVIfQ1RcH/2Z18rRHkas27m0GoB9gPj5p
QBmpEQANAlsgxFONRHOSwlZwFgJA0TDjrq97p01R7xc0r/4vSbmOs2PtLit3FKRl
jq7eLosFirOJFSsJwDE2Cy4mOZWmbYga69m+EVP3NCrtc0NRrn9sBVbPAHUN6LVG
mPGYEqn/t1tI/Ehv/sySVXdh9XNYqRj/YjQnmbUw+jbFl2UN3qhn0l99quFnXzIb
nSltO7rp2i8FnIU/omdhhCovCSzuRvTA2myFS4Xx/FRSWKkT+j/QdiSAmze3gy6B
RD+mtR6f00l3/nW1yYUwdWw03q1aIV6IOIdOy8hqI7lubDTmagYqPNa2yHQDgLU=
=kjrZ
-----END PGP SIGNATURE-----

--/ahWLRVyFWNne16C--

--===============2364368230380723051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2364368230380723051==--
