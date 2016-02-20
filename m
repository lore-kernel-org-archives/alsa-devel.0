From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm9713: fix regmap free path
Date: Sun, 21 Feb 2016 03:07:41 +0900
Message-ID: <20160220180741.GD18327@sirena.org.uk>
References: <1455919722-8299-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6464050234034500311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C1D0B2606D3
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:07:57 +0100 (CET)
In-Reply-To: <1455919722-8299-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6464050234034500311==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WP/lS5xSWAOC+/uo"
Content-Disposition: inline


--WP/lS5xSWAOC+/uo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 19, 2016 at 11:08:42PM +0100, Robert Jarzmik wrote:
> In the conversion to regmap, I assumed that the 2 following functions
> was working symetrically:

This doesn't apply against current code, please check and resend.

--WP/lS5xSWAOC+/uo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyKtsAAoJECTWi3JdVIfQnvEH/0hWG+l5LKYKzNHNOKztsXfT
lU1sfTDMVun+8adR7GGvM6Qx2NuqHbcpj3PYMngknOTSMElva8OW7agLFR1LxCFy
gSGBWCaANOBrwLc70TWuOh5JvJcEG4EAb9tf4s4GphWCOoxICrvbIx7nubmNDtgy
G60+WjT4PS3SniFteIJsRKCeQb18AER1XwdSC0kBhkMaMJYqly4oBdm0jq5/4Y9B
p2/ozChQRM6d/iuY0ngblqB2Yw1s4DFHg+MwzRmaCFy6UMQn4kS997/GWEfu5evX
UUnnb8KGr3D+WoHOX1g3HIt5V0mLwz+TFg4aC1I0giOsoJMLi1d18vrOBgUjSDE=
=lJcM
-----END PGP SIGNATURE-----

--WP/lS5xSWAOC+/uo--

--===============6464050234034500311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6464050234034500311==--
