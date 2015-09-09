From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Wed, 9 Sep 2015 17:19:19 +0100
Message-ID: <20150909161919.GC20922@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <alpine.DEB.2.10.1509090954430.3157@heelroid>
 <s5hfv2nd45t.wl-tiwai@suse.de>
 <20150909155737.GB20922@sirena.org.uk>
 <s5hvbbjbmzx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3656052967466390004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AFC72604FA
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 18:19:30 +0200 (CEST)
In-Reply-To: <s5hvbbjbmzx.wl-tiwai@suse.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3656052967466390004==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2015 at 06:01:22PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It'll be because nobody is checking !OF ASoC configurations and paying
> > attention to warnings - with !OF the functions are inline in the header
> > and the compiler can tell nothing happens.

> Yes, but non-OF ASoC gets more popular on x86 nowadays, so this should
> be covered regularly, too.

Hopefully Intel will be paying attention here!  :P

> > > I'm considering whether adding __must_check to of_property_read*()
> > > would make sense.  Then it'll be caught no matter which gcc version is
> > > used.  But this would hit too many spots.

> > Well, if they're all buggy...

> Not all of them are buggy, of course.  Some codes set the default
> fallback value beforehand.  But, if thinking of future use, it might
> be better to make the check mandatory.  No strong opinion here,
> though.

I don't know how clear it is that a failed read won't overwrite existing
data in the value variable.  The other option would be to have Kconfig
able to generate all*config with select options (like OF) disabled and
then get the build bots to start covering those as a standard
configuration.

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8FwGAAoJECTWi3JdVIfQIGMH/Apzv7iUWQ8ovfrsqIfuA6Tw
JfuaR7FQsnRjg2iYVx83e3nPm3K3dssX3qLtxWJ2zlgbyBhMGBC5dAmPagajiXGU
dm6yOQDp0qSrYg2hC5dWFzwKTdxk3ZYomOgV4sNrMLeF/6ZcH+ExtuCBhA8oJzlJ
973A58GZd8lc+Z+uiJcZRVQ9GcT82BboEufwCS8JPaX7D4CbxYXHmzmDQt1LumHR
U/tAu6uUQJjChkmJiZTlJcsNdGCbfc8d2EM6b9CzrZKxVTpVFDzbzNkcbaMsd171
eIv9n6QWRt/t/jHRhxOH2Qu5VZYAELRC23mjTamX/PYeoUdVWQ4OO997AyIn+48=
=y/9d
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--

--===============3656052967466390004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3656052967466390004==--
