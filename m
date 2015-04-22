From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Wed, 22 Apr 2015 12:24:05 +0100
Message-ID: <20150422112405.GW22845@sirena.org.uk>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk>
 <1429609673.3793.14.camel@loki> <s5hlhhlztnr.wl-tiwai@suse.de>
 <1429620227.3793.31.camel@loki>
 <20150421150342.GJ22845@sirena.org.uk>
 <s5hy4llmrnr.wl-tiwai@suse.de>
 <20150421163502.GL22845@sirena.org.uk>
 <55367EE4.5030201@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8386303791796489040=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D0722664D8
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 13:24:15 +0200 (CEST)
In-Reply-To: <55367EE4.5030201@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8386303791796489040==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LmcuB6YxSMQAV95c"
Content-Disposition: inline


--LmcuB6YxSMQAV95c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 06:46:28PM +0200, Lars-Peter Clausen wrote:
> On 04/21/2015 06:35 PM, Mark Brown wrote:

> >The trouble with the ABI version information is that it tells new
> >kernels how to handle old tables but old kernels will have no idea what
> >to do with new firmwares.

> What I did for the SigmaDSP firmware format (which can hopefully be
> superseded by this) is to have a header which a block type and the block
> length for each block for exactly this reason. It allows fully backward and
> forward compatibility between kernel versions and does not require a change
> in the ABI each time a new type of block is added. It also keeps the parser
> simple since it does not have to know the size and also makes support for
> vendor blocks quite easy, since the processing of those can be offloaded to
> some vendor callbacks without the core having to be informed what the
> content or size of those vendor blocks is.

Yes, that's what the ex-Wolfson stuff does too (it also has ABI
versioning but most things shouldn't need it).

--LmcuB6YxSMQAV95c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN4TVAAoJECTWi3JdVIfQlaAIAIZpQgdMjKxINBiq7MScCZWt
rFrtrqKu+KwmeSOJ6jzqWoulAY4SVYKD9l09yzS/bECdfvu/JHXzLFkoGT1gA3cT
ZpFTha0HcPWob5MeiD/wmjwyW39ZOITg3agrFdNGesSUSNRSl3KUdHAawlEqq7E8
cMrhsIWMSNjs2ZMbQn0E9coXSTWOMYgUPcLY19FbKenmaT35n9Las+2GcVapo8nV
jDG8RT7fuJtzxoRec84+IjClW6vxVEpKLVd7vtEKPhdRQe/pRbU2lwymmL3l+A7L
pY+G+TKs/3C3hgSzxBeUiteVUTlAgYEvfKq0gvosROeBdchdLDtJGutx/jwkIfo=
=+y63
-----END PGP SIGNATURE-----

--LmcuB6YxSMQAV95c--

--===============8386303791796489040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8386303791796489040==--
