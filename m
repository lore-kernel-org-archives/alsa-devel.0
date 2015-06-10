From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Lock mutex in
	rt5645_enable_push_button_irq
Date: Wed, 10 Jun 2015 18:30:20 +0100
Message-ID: <20150610173020.GJ14071@sirena.org.uk>
References: <1433908453-9548-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2530503637915430615=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A26265E17
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 19:30:30 +0200 (CEST)
In-Reply-To: <1433908453-9548-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2530503637915430615==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AA+5rdMLl4Meq7d7"
Content-Disposition: inline


--AA+5rdMLl4Meq7d7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 11:54:13AM +0800, Nicolas Boichat wrote:
> rt5645_enable_push_button_irq uses snd_soc_dapm_*_unlocked
> functions, so it needs to lock the required dapm mutex.

Applied, thanks.

--AA+5rdMLl4Meq7d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHQrAAoJECTWi3JdVIfQnAUH/igNb4F+izLIjjIGBYvFROz3
U8Ts9YPk900huO2kKJf7kdMMMGVqLm2h3AnyMB441qt3LBbkhbQFdbiueyyjmWII
jm3zcYMQoj+feF6HjBx/kGOOuY+4aEzhU/rVTgqBM5IsjQlmrRiwKZcvONv8+ASy
CU6iOHUPkXzNMYYscx7nxkbuSgKx7la9mEqLxzzMmuADcHcV/rbOgnMednpAFKB2
KNAYVH9TDBST17IGzfEfsWm7xq9AyX0tFtN0prXXF/hu8eVAgHX1KCt7IPZVhOxm
SfH4aDUih3W21uzWZOEm6fyU5bZAhJEBRT65ZX/SXP1uHuckENA3RWV0hINqmgw=
=qPY2
-----END PGP SIGNATURE-----

--AA+5rdMLl4Meq7d7--

--===============2530503637915430615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2530503637915430615==--
