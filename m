From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
 rt5645_enable_push_button_irq
Date: Wed, 15 Jul 2015 12:56:44 +0100
Message-ID: <20150715115644.GQ11162@sirena.org.uk>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
 <CANMq1KB_qkH41AiBeMDX6oJVyeOMEi1Tgwoxt9jar0Upqb=L4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1336544102123316839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D028265E1D
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:56:56 +0200 (CEST)
In-Reply-To: <CANMq1KB_qkH41AiBeMDX6oJVyeOMEi1Tgwoxt9jar0Upqb=L4A@mail.gmail.com>
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


--===============1336544102123316839==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doTn56zXo1e2vq52"
Content-Disposition: inline


--doTn56zXo1e2vq52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 07:50:50PM +0800, Nicolas Boichat wrote:

> > Thanks for the review. I think what we need is something like
> > +               snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
> > +               snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
> > +               snd_soc_dapm_sync(dapm);
> > +               if (!codec->component.card->instantiated) {
> > +                       regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
> > +                               RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
> > +                               RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
> > +               }

> Just to make sure I understand... With the code above, the dapm state
> is consistent. However, DAPM will only set the regmap bits when the
> card is instantiated. So why do we still need to update the regmap? To
> make sure we do not miss an early jack/button event? Or would we still
> get jack irq if the pins are enabled a little later? (I guess we can
> live with missing a button event at that stage, but we need the jack
> state to be correct)

I'm assuming it's something to do with early detection, I don't really
know though.

> Also, I'm going to update rt5645_irq_detection to do nothing if the
> codec is not initialized yet (just like rt286.c does). That should be
> ok as we call rt5645_irq from rt5645_set_jack_detect, after the codec
> is ready, which will update the initial jack status, and setup the
> DAPM pins. Does that sound ok?

Yes.

--doTn56zXo1e2vq52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpkp7AAoJECTWi3JdVIfQuKEH/ApsY27OHDKwps7LOpNGrf1u
qDLfZvQJjlA1Rm5XvSm4RAXP+49DTxwT42u2iNgJBzJYDtZb4dJdKcZqtWjwxiok
DDzNGHXxGmFi+ICkqlkmx+T45ivNKRmLXxGY4BH7T3SDvXM6tqihIeXbocok00v0
LYioJn+sQH7PZsqj/iIfS40Mj8ox0/szYQkSNbMrsDlmsxBZx1QM5cEeaOU4ZLeu
lKfav1qhZ4JHmtzqLKt6AfHp+bvC6JNfvPHgndeil3PJXy/7qXVphlYvKRMTu6Ft
XxEfkFsHXAV0Dm/2to6f3XXWIvq3wt9bYu07zR4Z2I5zfbnlZxleELQf4jzq8co=
=4x0p
-----END PGP SIGNATURE-----

--doTn56zXo1e2vq52--

--===============1336544102123316839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1336544102123316839==--
