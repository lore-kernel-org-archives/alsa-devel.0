From: Mark Brown <broonie@kernel.org>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 19 Mar 2015 14:19:53 +0000
Message-ID: <20150319141953.GU2869@sirena.org.uk>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <s5h3851t6xx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1947511693489109509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA8F7260577
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 15:20:02 +0100 (CET)
In-Reply-To: <s5h3851t6xx.wl-tiwai@suse.de>
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
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1947511693489109509==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="twKjCw1/F6C/WBH6"
Content-Disposition: inline


--twKjCw1/F6C/WBH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 03:09:30PM +0100, Takashi Iwai wrote:

> As far as I understand correctly, so far ASoC drivers also report
> headset as boolean (the bits are multiple, but reports are either zero
> or N bits).  So, we agreed on creating boolean "Headset" kctls.

That's right - every input our output that might appear on the port is a
separate boolean flag so we can represent any combination of them.

> One option is to provide multiple boolean kctls ("Headset Mic Jack").
> Another option is to allow enum type for kctl jacks.  Or, yet another
> alternative is to provide an enum ctl (e.g. "Headset Jack Type") in
> addition to a boolean kctl ("Headset Jack").  There can be other ways,
> too...

I think any of those work; my guess is that the "Headset Jack Type" enum
is the one that's going to be least disruptive to the ABI (in that it
keeps the existing control untouched).

--twKjCw1/F6C/WBH6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCtsIAAoJECTWi3JdVIfQfdQH/ibQuSwVHd1CCKlbDyMoDu+t
xaNICKS1Tj6w6oLP8LFbVbkXTOlXZuLabnwlZq3M82gPyP/Lstbk78SId24v+E+6
B4suSuDPHOEe6b7E9SPwvLCZTAjNaMRuZ2T3XFz4wMkTc2JuDrqnNEgarhn2cE0C
9BrWrbY4yuJRxzvvwUDrZrDrEkMnP3PqHRvexHNcFdwSmMW0PvZecGd/At+pAyku
rigQNAnfxndmcTaq3a5fI0vKg7C4kABsxieIyyZwr19iQseJaM56tGXYIQHMnvuY
Yx1NoShFpbwd8gHbZhoyLnwH5PNesQkIDsMiFtgqfy9s4syNB6jcxa6/q+8+2gk=
=EXO+
-----END PGP SIGNATURE-----

--twKjCw1/F6C/WBH6--

--===============1947511693489109509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1947511693489109509==--
