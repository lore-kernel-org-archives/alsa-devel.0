From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] sound: soc: skylake: no need to check
 return value of debugfs_create functions
Date: Mon, 24 Jun 2019 14:33:36 +0100
Message-ID: <20190624133336.GN5316@sirena.org.uk>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-2-gregkh@linuxfoundation.org>
 <f85fe797-f843-bf71-549a-00a169d527dd@intel.com>
 <s5h4l4hwe1c.wl-tiwai@suse.de>
 <20190624105334.GJ5316@sirena.org.uk>
 <s5htvcfxgy9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9084037110082583946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79E0DF8065B
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 15:33:47 +0200 (CEST)
In-Reply-To: <s5htvcfxgy9.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9084037110082583946==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="02TgiDMAH4DLwn5E"
Content-Disposition: inline


--02TgiDMAH4DLwn5E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 03:15:26PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Currently debugfs doesn't report any errors other than via the return
> > codes (at least in the common creation stuff) so it's up to the callers
> > to do that.

> So this should be changed to follow a la sysfs creation error, IMO.
> At least, the name conflicts etc should be reported more obviously.

Indeed, that'd mitigate the problems with just making everything
silently fail a lot - so long as we say there's a problem people are a
lot less likely to be mislead if anything goes wrong.

--02TgiDMAH4DLwn5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Q0S8ACgkQJNaLcl1U
h9BWVQf9E8l2s4xvp6lqiI30M3mbXjCdZiFrDHm1K6g9YJaChL7wzVAezIG9QkJ0
CsrY3lv3PN9Bsr1SIKssmAT0TDYCkSh8fB2nT8vwuCzM9hait9zNHMMlsStig04s
D9KFfvui5J6l6H24iNAGpaRnDlfFyGfkDaiWWp20usOTB/hOgPTKkDNmE+a6bsjZ
AV0sn/FlBt1E1O5GOmuCTU2mbNQYdOGnYFLReRsB6rFJNYSfkwty0UhrY984hv3v
ekZi/VlW5Di84xs1pLmqnverk1YVp5bWZh7i10bvKsj5JWTNWsHVOZ2pRvqbOgTI
LkzgIggSD60RvGYVRciMwBQP6g3Haw==
=1+72
-----END PGP SIGNATURE-----

--02TgiDMAH4DLwn5E--

--===============9084037110082583946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9084037110082583946==--
