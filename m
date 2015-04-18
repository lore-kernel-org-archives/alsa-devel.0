From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: sti: add binding for ASoc driver
Date: Sat, 18 Apr 2015 14:12:46 +0100
Message-ID: <20150418131246.GU26185@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1721316365588209052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF93C2619BE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 15:12:53 +0200 (CEST)
In-Reply-To: <1429018531-29025-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1721316365588209052==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNjIDde0W37E3OQP"
Content-Disposition: inline


--eNjIDde0W37E3OQP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2015 at 03:35:25PM +0200, Arnaud Pouliquen wrote:

> Add Asoc driver bindings documentation.

ASoC.

> +- cpu-dai: sti-asoc-platform subnode that describes properties for a CPU-DAI instance.
> +Required properties:
> +  - dai-name: DAI name that describes the IP.
> +  - dai-type: DAI functionality.
> +	"uni-player" for playback.
> +	"uni-reader" for capture.

It would be more idiomatic to do this with eithe ra commpatible string
or a specifically named node.

> +Optional properties:
> +  - standby:  standby mode activation deactivation. this mode is specific to
> +	      Uni player IP and allows to transmit bus clock and a pattern data
> +	      while audio stream is stopped or paused.

I'm not entirely sure what the above means but it sounds like some
software configuration rather than a property of the hardware?  Or do
some variants of the IP lack this functionality?

> +  - auto-suspend-delay: runtime auto suspend delay (in ms) before deactivating
> +			stanby mode. Equivalent to the DAPM mechanism but for
> +			CPU DAI.

DAPM works perfectly well for on SoC components, please use it.

--eNjIDde0W37E3OQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMlhNAAoJECTWi3JdVIfQvXkH/1xVz0OhIcmvyTz/3YkNbiqq
xNNr9KX+qWWFboMNJwt3tJ7O4hHm79ag2iz2z9WY+2D/fxjpIapBsALiQcYXL3Ez
IXPm72c4ZbK4a0lu4KORISe7XlHOfcQcNzLxKs/1x8fU3WE/NA8KSNBSMvFA4KPs
AzgeDYtNjLS+g7Riee+DFv+NULV6MfV1v5Y6O7XrkdODUL4hd1AQekQTrHnMIUuW
Mj8zmGrJAxjjr8TXIcqteI+MLMIwbc3hVy9KEzBD5XDR1MGK/GEzJXu8UbTP+C8o
6366DHLPf5Uvg5VcFvKQouNzJIC4iorhP4dFlTzpRTFSVEnCV7tsggdl/Ug4swE=
=UFJT
-----END PGP SIGNATURE-----

--eNjIDde0W37E3OQP--

--===============1721316365588209052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1721316365588209052==--
