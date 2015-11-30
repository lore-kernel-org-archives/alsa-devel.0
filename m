From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Mon, 30 Nov 2015 16:25:48 +0000
Message-ID: <20151130162548.GZ1929@sirena.org.uk>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0560976810756256629=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF53426156A
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 17:25:52 +0100 (CET)
In-Reply-To: <20151118134843.GU25173@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0560976810756256629==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="70fLfmUGd5x0AJTB"
Content-Disposition: inline


--70fLfmUGd5x0AJTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2015 at 07:18:43PM +0530, Vinod Koul wrote:
> On Wed, Nov 18, 2015 at 01:17:57PM +0000, Mark Brown wrote:

> > So, what I was really thinking of with the renaming was a bigger rename
> > that updates the names in snd_soc_dai_driver and everything that comes
> > from that.  That's a much bigger thing though, let me think about it a
> > bit more.

> ah, yes that kind of change does make sense, but as you observed that will
> be a larger rework. And I think I am up for it in parallel to my SKL work :)

> But that will take a bit of time and I would like update these in bits
> rather than one shot

> Let me know what you think and how you would like to approach this

Can we make the temporary hack be to check if there's a CODEC defined
in the DAI?  It's nasty and fragile but it keeps the hack much better
isolated.

--70fLfmUGd5x0AJTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHiLAAoJECTWi3JdVIfQtdgH+wdL9Vha/eZWy1Qtpw519QWD
Oq2ZP01rIoIpyJFf7SfxAYQM1eyXBu8vz5aTp13C3PkqYJJJ7wa+rzev9/mrHPMV
fX05fWLh43XeBmE1G/AzUVHbR4Ad3Dsc6/lgrzpKaRfVDME9yuY6yrwECfZSwHog
BsPeF2b4P+J11aezxuSZjvQkJ173+yGtmrO4gJYXHXjWytHC1BzILGKjYXgUJg/S
5ybukdxxlPks2E1Wl23CEPmC6Y7raXg+WVwk4uwz61R93ghSJZmm+78dujG4TEbp
YxfL2XnPlIXTZtwMAN2FejM8+pZxDlX+P/GFByxT9i67njJ/jLfWWotdjoIXAcw=
=oq+U
-----END PGP SIGNATURE-----

--70fLfmUGd5x0AJTB--

--===============0560976810756256629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0560976810756256629==--
