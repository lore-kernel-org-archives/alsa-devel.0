From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/8] ASoC: Intel: Skylake: Initialize
 and load DSP controls
Date: Tue, 6 Oct 2015 17:23:47 +0100
Message-ID: <20151006162347.GA30592@sirena.org.uk>
References: <1443020604-22282-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6373728991554265786=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D20D265716
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 18:24:09 +0200 (CEST)
In-Reply-To: <1443020604-22282-7-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6373728991554265786==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2015 at 08:33:22PM +0530, Vinod Koul wrote:

>  	if (link_dev->link_prepared) {
> -		dev_dbg(dai->dev, "already stream is prepared - returning\n");
> +		dev_info(dai->dev, "already stream is prepared - returning\n");
>  		return 0;
>  	}

Why is the severity of this being raised and if it does need raising why
isn't it a warning or error?

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE/WQAAoJECTWi3JdVIfQ/AMH/A4cCB97jpOgapRFppxXBi7h
VWNsJVg6E4PGL/xYlzo62gOq8glrwbvwMcleQ+QOYdRRt6w5KMgiYm5flLnJSKrL
W4DFM5qazDKpDfl1+knHD++QlK2K+TMnIp6/Vro16pLCSU8v4zhJLkHsnskzJt6y
oSJNU+hAEObu9Y4mSMMPmHltOpgbOJojgDa99tstQFMiMIUp0dx/N3K68rvm7rWh
QZ6FBFqmdySuz36BrhSyxRkhI8BJD9HSi+RNZjmNyX9M6j3+waON/mDH4gaonsEY
xk+KPpRlb+IrQ47ytY6ANLW7/BRurC7EDaVnQUp5c4aamZa5uK1uhbgEW2hEk+4=
=dDOC
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============6373728991554265786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6373728991554265786==--
