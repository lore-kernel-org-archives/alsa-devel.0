From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Tue, 21 Apr 2015 17:35:02 +0100
Message-ID: <20150421163502.GL22845@sirena.org.uk>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk>
 <1429609673.3793.14.camel@loki> <s5hlhhlztnr.wl-tiwai@suse.de>
 <1429620227.3793.31.camel@loki>
 <20150421150342.GJ22845@sirena.org.uk>
 <s5hy4llmrnr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3758504261718557893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71C9626149D
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 18:35:13 +0200 (CEST)
In-Reply-To: <s5hy4llmrnr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3758504261718557893==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Content-Disposition: inline


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 05:23:36PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > That's sounding like an awfully small number if we're trying to be
> > infititely future proof (obviously the default value for that is 640k!).
> > We'd also need to go through and give *all* the structures padding.  How
> > about just adding length fields instead with a rule that if the
> > structure is bigger than you know about just ignore anything at the end?

> In theory, having only "abi" field should be enough, as we can know
> the size predefined for each ABI version.  But I agree that it'd be
> friendlier for a parser if the header itself declares its size,
> e.g. via a header_size field or embedding the size into some check
> field like ioctl.

The trouble with the ABI version information is that it tells new
kernels how to handle old tables but old kernels will have no idea what
to do with new firmwares.

--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNnw1AAoJECTWi3JdVIfQelwIAIT6A36xpblWaYGF3y/jzYmL
xN74bqo90mRJ+eKgNbisOeDIId4Di5Pz2FrA7PPhJqf319/ulO3r/GWmQQHrNo8V
HRHuJJZ1AXXDiQgYmjsSd7ZB8jcqFWsAGBEE9Bw0Yt88wrvekZtX+HEHjv5ybdlr
K1ZVPPdwXJ9R7/0v7YeN0rW1zKyizKB0ezwrE3TKRi5pF3g7IJmK9dr2nielVUOZ
WI7rPi71ZwshVnyA7UJRprjt85BpjXItiHoKiiboAN7LV2HRUQBQO2gB5X77LlGV
JWLOMOPSJN+VObxWU8PKi4MvwIGrADAcW1dV5Q2J2XtP5WEiD7FJVAjmiNiwoOw=
=CXbZ
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--

--===============3758504261718557893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3758504261718557893==--
