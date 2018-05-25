From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dpcm: fix BE dai not hw_free and
	shutdown
Date: Fri, 25 May 2018 12:31:05 +0100
Message-ID: <20180525113105.GL4828@sirena.org.uk>
References: <1526980408-1935-1-git-send-email-kaichieh.chuang@mediatek.com>
 <1526980408-1935-2-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4439075734590549088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE95426765F
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 13:31:39 +0200 (CEST)
In-Reply-To: <1526980408-1935-2-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============4439075734590549088==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opU1cLy5W6t5oyvs"
Content-Disposition: inline


--opU1cLy5W6t5oyvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 05:13:27PM +0800, KaiChieh Chuang wrote:
> In case, one BE is used by two FE1/FE2
> FE1--->BE-->
> FE2--->
>=20
> When FE1/FE2 call dpcm_be_dai_hw_free() together
> the BE users will be 2 (> 1), hence cannot be hw_free.
> The be state will leave at, ex. SND_SOC_DPCM_STATE_STOP
>=20
> Later FE1/FE2 call dpcm_be_dai_shutdown(),
> will be skip due to wrong state.
> Leaving the BE not being hw_free and shutdown.
>=20
> This patch add a flag in snd_soc_dpcm to denote
> the hw_free cannot be excute for this fe->be dpcm.
> The BE dai will be hw_free later when calling
> dpcm_be_dai_shutdown() if still in invalid state.

This works but feels messy and fragile - the problem here is that we use
the users count to decide if we can do a hw_free() but we don't
decrement that users count until shutdown which leaves the race
condition you're fixing here.  We probably need to add a second refcount
here for hw_free() which also feels a bit messy but is probably robust.

Another option is to just unconditionally do the hw_free() and clean up
if we're in the wrong state rather than checking the flag (so basically
your patch but ignoring the flag), that is simpler and should be robust
- I can't think of any reason that'd be a problem?

--opU1cLy5W6t5oyvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsH8/kACgkQJNaLcl1U
h9Dfcwf+IuAJT159YFdE+NkdVSx6u4a/dWY/wzlJN4MWF9/ZsUDM40mO1KusNXJP
iWAhO1IHSfCErJ1W7Vnu04bUj3Y5rXjY+RLJQ91WagJt/AMuXPzOuAroCH8n/9LH
/enwbIBWRl/UFsycQVAHDPCsKUBLibxiy6oUktke8NFmbLEF5xP2DWrrsw5xz0WZ
3oMXmbm7FZjZ3jo+odm5UU9r/WYpMjHfl54qEa3yrVqga0WPZrkmr+2rmz7vNGp4
Mk+QiJnrUOx5GcuibhZREQUiVoHMKvQ9Tt/VDgPqncdIlb+tNfML64PaNvfAwg44
nm2wpQdQWJDfoRt64zcZDzTPHt5+Gw==
=rBYJ
-----END PGP SIGNATURE-----

--opU1cLy5W6t5oyvs--

--===============4439075734590549088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4439075734590549088==--
