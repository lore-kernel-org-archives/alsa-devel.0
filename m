From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
 rt5645_enable_push_button_irq
Date: Wed, 15 Jul 2015 09:50:12 +0100
Message-ID: <20150715085012.GJ11162@sirena.org.uk>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
 <20150714102833.GP11162@sirena.org.uk>
 <20150715010530.GA10273@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7750822010541978312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AB182605B7
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 10:50:27 +0200 (CEST)
In-Reply-To: <20150715010530.GA10273@google.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7750822010541978312==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9yFTe2a/dxBPvyUm"
Content-Disposition: inline


--9yFTe2a/dxBPvyUm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 09:05:30AM +0800, Nicolas Boichat wrote:
> On Tue, Jul 14, 2015 at 6:28 PM, Mark Brown <broonie@kernel.org> wrote:

> if (dapm)
> 	snd_soc_dapm_force_enable_pin(dapm, ...)
> else
> 	regmap_update_bits(...)

> If guess something like this might be preferable:
> if (rt5645->codec) {
> 	dapm = snd_soc_codec_get_dapm(rt5645->codec);
> }

> and then:

> if (dapm)
> 	snd_soc_dapm_force_enable_pin(dapm, ...)

> regmap_update_bits(...)

> Does that make sense?

No, that still has the problem that you don't handle the !dapm case
properly since as soon as DAPM kicks in it'll power everything off.

> Is there a better way to communicate my intent in this series? Maybe
> patch 1/3 should convert everyhing to this pattern:
> snd_soc_dapm_force_enable_pin(dapm, ...)
> regmap_update_bits(...)

Your intent is clear, the problem is that the code doesn't actually do
what it's supposed to do - see previous e-mail.

--9yFTe2a/dxBPvyUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVph7DAAoJECTWi3JdVIfQ7NkH/1voG1uTCLJ6eQTmSAFUukZi
PQmm+a6AfUfUKNr1Q3rn5Nz+H1JjIxalckplVQxmK6Jk3cDY//lc5UJd13MNIqea
qoPO1HMKRMmZKpdo8/PERnv9gCy0n7nqiYxXkIUvdynL7CUtTOkXgQHuAZ7r5tTF
bhyVbnFR5ATKjec24keq0PSCOavfyVvThsdCkrDueeevLn7mPO+LMTKOOQP/9fEm
ilh9h9vrXiIqHnItOgvUTJ8oAdW9YEXvNr3A/glC9yd4VT00PHItDR2d1V3wzLuN
/rn+nWsVe3ceh+6R3cxpOLhfkcf0B8xCZSXPSE9FrWoQ4HKaHOjsZy3vcXvZqKY=
=wQ0z
-----END PGP SIGNATURE-----

--9yFTe2a/dxBPvyUm--

--===============7750822010541978312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7750822010541978312==--
