From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: hdmi-codec: Fix module unloading
 caused kernel crash
Date: Tue, 20 Feb 2018 13:57:10 +0000
Message-ID: <20180220135710.GG6378@sirena.org.uk>
References: <20180220123010.5373-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3240307330369072374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FC51266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 14:57:13 +0100 (CET)
In-Reply-To: <20180220123010.5373-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============3240307330369072374==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 02:30:10PM +0200, Peter Ujfalusi wrote:

> Commit cd6111b26280a ("ASoC: hdmi-codec: add channel mapping control")
> should not have added the kfree(hcp->chmap_info); to the hdmi_codec_remove
> function.

That commit is in Linus' tree so this should go there too but this won't
apply against there as it's against -next with the component conversion,
could you respin on top of Linus' tree please?

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMKTUACgkQJNaLcl1U
h9DLxQf+LJvHO8EUhaQ4ZegseX1o40GZtk1TShzqrrY1kraddRGAoMpsqOEDVCx6
iZucrNpjJBTdOQSWHGd25rCeVmRcEcPiZA9mKvpVhAxDqhEdTfL7XFYoyjnRC7Ak
nV8L+oRsEcqpUFy+QCTt41vYI39ON79YQb2DqQWTwBU/upvf1AdfJxESzSQPCyQ0
OS2MSTnpASDIUjySlzbjg1L0aVznHbptB8r9du3WQ+PDz4YQWXZ57IRwkYQh4CHo
ARc3Tp3D/ziRlpmZt0RJI2h8tWAYsZmmt61NMCo610nlr59L9SyPm014ZbBnW+Hm
p2rS5GTi5liudFIhj80xCgrzJRt1qw==
=INTs
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

--===============3240307330369072374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3240307330369072374==--
