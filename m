From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] clk: x86: Add Atom PMC platform clocks
Date: Wed, 31 Aug 2016 18:08:58 +0100
Message-ID: <20160831170858.GA6560@sirena.org.uk>
References: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160831003722.GH12510@codeaurora.org>
 <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, mturquette@baylibre.com, alsa-devel@alsa-project.org, tiwai@suse.de, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 30, 2016 at 08:35:55PM -0500, Pierre-Louis Bossart wrote:
> On 8/30/16 7:37 PM, Stephen Boyd wrote:

> > It's sad that this can't be compiled on any platform. Has there
> > been any move towards making this into a regmap provider so that
> > this clk driver can use cross platform regmap APIs instead? Or

> it's not clear to me what cross-platform goals you are hinting at and what
> the concern is. We can add more framework stuff and make the code more
> elegant but at the end of the day we will write in a very limited set of
> registers (2 for audio - on/off and 19.2/25MHz selection) and the use of
> this functionality is restricted to Baytrail and Cherrytrail.

If code can be compiled on a wide range of platforms then that means
that it's much easier to get build coverage of the code.  This is
helpful for anyone doing any kind of cross tree updates - things like
updating APIs for example.  The fewer configurations they have to touch
to get everything built the easier it is for them.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXxw8pAAoJECTWi3JdVIfQ00oIAIWAl1ODhtK28ysDr78ek/9M
CsSNAuuC+EFhJ9w4xbwyZWNMfRl+2WPnjWAyqHnQlrkjt3yDi31mP94FWwNSvEgB
n65Bia9mSAcuaIXIXUrinBMVz66WheW44yj423lF8ef5QatTVLKOH/gocYQCfZDK
XzCz7iRw3aM7qViE2CxB/K30jsf6zU0oNjcz4xo3rrQp6q/9QVuNHwGoLd5Yzxyv
69Ag+hxxIgQtlnSm3IaNtSKw0s7zCMWefZBqywuheuANyGRx+iDvOyugYyjZl24d
ecK3X2azq60DEOjQSCzuOrDsMD5g/egg2QzCAaoVEbRICUuhGnk8l4O7fTIyMTM=
=bss6
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
