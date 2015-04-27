From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 6/7] ASoC: hda: Add support for SSP register
	settings
Date: Mon, 27 Apr 2015 15:15:09 +0100
Message-ID: <20150427141509.GS22845@sirena.org.uk>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
 <20150424175532.GD22845@sirena.org.uk>
 <20150426141831.GS2738@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3987775671812655599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 620D7260631
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 16:15:19 +0200 (CEST)
In-Reply-To: <20150426141831.GS2738@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3987775671812655599==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TrbAYn63cdnBtVX6"
Content-Disposition: inline


--TrbAYn63cdnBtVX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2015 at 07:48:31PM +0530, Vinod Koul wrote:
> On Fri, Apr 24, 2015 at 06:55:32PM +0100, Mark Brown wrote:

> > > +		/* Dont add odd number of dummy bits, since I2S requires
> > > +		 * dummy bit after each slot/channel
> > > +		 */

> > It does?

> For us unfortuntely yes. We send 24 bit audio to codec and clock divider
> doesn't give us 48clocks per frame, so we have to add dummy clocks in each
> slot and send 25 clocks per slot

So it's the hardware rather than I2S itself :)

--TrbAYn63cdnBtVX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPkRsAAoJECTWi3JdVIfQwQEH/jb/+rXd7J9G6qOGg3ZuLl+/
goRmJOtmm+khetWVbpDCaQzON5dluXSdH6WJaGFYOABM2zclhi+nh1kEEtMndnkB
WbCpOCr8R+VEZ5iZRnuUkLjQsOkDnMpFrRzMh7GO3WsboteNnccRxafX93LsEX/C
u25B7lAZ9yTu47+VoMDD5TAYkZLrjFWpBb9SRmmnuTJpKAKkSxpTts4WhBWc+t0/
BJtZXTbcaupn/4fjNjLOr03LI8lsE7N6oNc6zVr1BvJNtnzBAj9/q0tvqI/dOJJG
pupdU4I7O4HfoudgmbvGOKDggSDEZbGmlrbKb25JzfErDUnsFqgVZYiGyVxGhZU=
=czJ/
-----END PGP SIGNATURE-----

--TrbAYn63cdnBtVX6--

--===============3987775671812655599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3987775671812655599==--
