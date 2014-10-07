From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: fix sig_bits determination
 in soc_pcm_apply_msb()
Date: Tue, 7 Oct 2014 19:15:15 +0100
Message-ID: <20141007181515.GW4609@sirena.org.uk>
References: <1412685226-7935-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3565602728241415509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6285526070A
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:15:38 +0200 (CEST)
In-Reply-To: <1412685226-7935-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3565602728241415509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vHrcnSuaBi45WmF/"
Content-Disposition: inline


--vHrcnSuaBi45WmF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 02:33:46PM +0200, Daniel Mack wrote:
> In the SNDRV_PCM_STREAM_CAPTURE branch in soc_pcm_apply_msb(), look at
> sig_bits of the capture stream, not the playback one.

Applied, thanks.

--vHrcnSuaBi45WmF/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNC2yAAoJECTWi3JdVIfQFBEH/RRtTTv6ACo/60fDp/g9Dzg7
hN8kNtd3rcaHPGvv51TDK9cJDd4DL1EttbZn1aKXAW7eR3c0ZzP3BRwwpTCUmqkx
A6HufJM7NtAn8Rr6u0WQ6EpPCkZ/qpZVb7xsWnwK5Bflhwkih6J+/fEDQNpbIk+P
GJ9CU0hps0LZRih/jYyePBkk61LGIRSM9Dd1N0GzgjssFq2XoDpp5X+wNpklM1Ei
3bxDcFtQB5MR0Rei/EUSIxlN5I/rkmBsUo8PYrL7k0tWPOylRmjToM506s9iIal+
ffK9i9LZzyQHI/pKaJ84pxJDxsd+3iykgO7VHnmZZamPf0zO6r/VR4MKqrqubis=
=o6eB
-----END PGP SIGNATURE-----

--vHrcnSuaBi45WmF/--

--===============3565602728241415509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3565602728241415509==--
