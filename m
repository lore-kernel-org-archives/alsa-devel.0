From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Wed, 13 Dec 2017 10:47:32 +0000
Message-ID: <20171213104732.GB6416@sirena.org.uk>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
 <20171212225134.mmwigvfgi7fbvgyz@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4131350418191188549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EEF1426717B
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 11:47:34 +0100 (CET)
In-Reply-To: <20171212225134.mmwigvfgi7fbvgyz@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4131350418191188549==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 04:51:35PM -0600, Steven Eckhoff wrote:

> Also I am not sure what you mean with the mute controls. Could you
> elaborate more on this?

The things the driver is doing automatically to mute the DACs and ADCs
should be moved to user control if they're not suitable for doing
automatically.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxBUMACgkQJNaLcl1U
h9CFfwf/fPgE+mYc3pXDA2yv/EI0ApwN36AWxr0ihx+z5A485MPFke8uyJabOsFR
xMvc+6CJweCwa5cnideSw/RWsegLM5qLsftRu2X0gVpdd+DczmC0PcahqItMv6UN
hmTrCWuvvo3hzxXl3JxBvyhkaUYlBSAVxBTQPGHg39pJmgWSxHSHJsfrByzydepx
IFfCfhs8tBiTFBVZfZech2skH1sR6cVRoAJ9T20gHwDk2Bd4WDrmeXxot8vW02FU
EaFU0CyyOlUgT2+1JrgmwpiDaZK43iRxuNvlbEGGe2TZ2N7TfWjynaLrXQi/AU7O
pBTGsGJx2SbsJ/Ei7cmu5OAaWoZxEw==
=IyZM
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

--===============4131350418191188549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4131350418191188549==--
