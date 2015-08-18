From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Mon, 17 Aug 2015 22:27:33 -0700
Message-ID: <20150818052733.GH10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <55CEF0A8.5030707@metafoo.de>
 <20150815155035.GG10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D0F4C@SHSMSX101.ccr.corp.intel.com>
 <1439807999.2420.25.camel@loki>
 <20150817200502.GZ10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D1B67@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2291391191513864804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id D2CEF2608ED
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 07:27:36 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8480D1B67@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============2291391191513864804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eY8wQnuu3RZDiCQc"
Content-Disposition: inline


--eY8wQnuu3RZDiCQc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 05:17:36AM +0000, Lin, Mengdong wrote:

> I feel it's not enough to just "adding constraints to a fully defined lin=
k" for FE DAIs.
> We need to determine the number of FE DAIs (thus FE DAI links as well) fo=
r a specific version of FW based on its topology info.

There's two things going on here.  One is configuring the limits on the
DAIs that represent physical connections in the system, the other is
creating new fully software DAIs for DSP<->AP links.  The two cases are
separate.

> If you prefer not using any dummy DAI link but creating the links from sc=
ratch when we detect them in firmware, can we add new field into "struct sn=
d_soc_card" to specify the components for topology?=20
> After all, topology may not only come from the platform component.=20

We need to come up with some mechanism for it.  I'm not clear what a new
field in the card would be, I'd more expect some runtime calls from the
topology code but perhaps there's some way of doing this in a data
driven way that I've just not thought of.

--eY8wQnuu3RZDiCQc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0sJEAAoJECTWi3JdVIfQSQUH/jI6Z//EE5YySgAVwL00CBDT
Ia6WqKrAId++F3al4+GXLS4RPk07YbFr/YYkZktR5NkoKJFAGFMNgnPyWpL97lu2
VM8n6MvjKBEauy2xaPzA4JfYO8S9qSQqrDlcYtNTCNK0/hItK4MpY9MneS+5UMW2
MyBYW2G8z3LtfyE3EKI9BxhzBxIvvrNGB3cWA7S9ox0FJaR6f2b+zMYC1kloEuUG
9AMnfzSXMa/KIb0IgUv1XZrml06RjuJhFJKRCCkuiYgN6xtG2f2g3hLGQwUjxhyp
5ibYcIgkrPndQeginPO5bsja7a0Byf8XHhpOQJDOcryiJk+p09hHxCbZTFJ367M=
=ZyS1
-----END PGP SIGNATURE-----

--eY8wQnuu3RZDiCQc--

--===============2291391191513864804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2291391191513864804==--
