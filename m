From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Tue, 26 May 2015 14:32:56 +0100
Message-ID: <20150526133256.GQ21577@sirena.org.uk>
References: <20150522125634.GX21391@sirena.org.uk>
 <s5hwq00enw8.wl-tiwai@suse.de>
 <20150522174106.GV21577@sirena.org.uk>
 <s5hsiao32g6.wl-tiwai@suse.de> <20150523055156.GZ3140@localhost>
 <20150525104828.GA21577@sirena.org.uk>
 <20150525112150.GE3140@localhost> <s5hbnh827n4.wl-tiwai@suse.de>
 <20150525135854.GV21391@sirena.org.uk>
 <s5h617f29os.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0312607323940687203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C81EC26589D
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 15:33:04 +0200 (CEST)
In-Reply-To: <s5h617f29os.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0312607323940687203==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tjqVXn9sJ2F3KEH2"
Content-Disposition: inline


--tjqVXn9sJ2F3KEH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 07:24:03AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Mon, May 25, 2015 at 01:55:59PM +0200, Takashi Iwai wrote:

> > > Once when we get the common criteria for matching (both for asoc and
> > > legacy), we can move to the unified match method.

> > I really don't understand this idea that we need to work out what the
> > common criteria for matching are, HDA is an enumerable bus isn't it?

> The common match method *does* exist.  It's just shifted to two parts,
> one for ASoC and one for legacy, because of two different objects.

What are these objects supposed to be then and why does the bus for HDA
CODECs know about the differences between them?  They're both called HDA
CODECs which might lead one to think that they are supposed to represent
the same thing.

> > I'm also wondering how this interacts with the Tegra HDA device by the
> > way...

> It's a part of HDA legacy.  No difference from any other HDA devices.
> What's the problem with Tegra?

People keep talking about PCI as being a differentator here, though
apparently the Intel systems are all PCI so perhaps not.

--tjqVXn9sJ2F3KEH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZHYHAAoJECTWi3JdVIfQBJYH/RmPDmk/jMkjThZg9ghxodB9
y3nYbKEWRs+c3rbDl+qS4ifxkW4X96LLvOQQ0R8Bv3+boqSr54znROtiw4QhvFJB
cQ5ZB7N3pFnIq87GyJpLBYz/oNHHc22lNemg1j1wep+ej6M1IShEr5GxzkDNIPeo
WqtnPmtdxFmHa5wVUHzhdklXMvyz3GHFzSXLEG8+cG3iBlQmUIxi8s2acH2oK4u/
5S3wJlxN5K+j8IPQC6v5voMzhXJS7CH0GS18TXtCa1NOt++/NSITxiIk8Ic7H6IJ
GEVSWhsz6TsFeBfS1d5w4rU7thqOejLbN7Ih6RYLyyTge5+NJTQj8mCh+KaRTRM=
=gVka
-----END PGP SIGNATURE-----

--tjqVXn9sJ2F3KEH2--

--===============0312607323940687203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0312607323940687203==--
