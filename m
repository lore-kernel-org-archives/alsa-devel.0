From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add
 set_tdm_slot functionality
Date: Mon, 29 Jan 2018 09:40:39 +0100
Message-ID: <20180129084039.bysenf2y72hqbajq@flea.lan>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
 <CAGb2v65-Cg4GNL6YcJin6x27bu+R4-X8zjhjYO3pnpatGvE+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6169308199357629498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 983A82673D6
 for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2018 09:40:50 +0100 (CET)
In-Reply-To: <CAGb2v65-Cg4GNL6YcJin6x27bu+R4-X8zjhjYO3pnpatGvE+ew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Code Kipper <codekipper@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6169308199357629498==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="55uq6xzd4dh6xbnq"
Content-Disposition: inline


--55uq6xzd4dh6xbnq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 03:38:40PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jan 29, 2018 at 3:34 PM, Code Kipper <codekipper@gmail.com> wrote:
> > On 29 January 2018 at 02:50, Chen-Yu Tsai <wens@csie.org> wrote:
> >> On Wed, Jan 24, 2018 at 10:10 PM,  <codekipper@gmail.com> wrote:
> >>> From: Marcus Cooper <codekipper@gmail.com>
> >>>
> >>> Some codecs require a different amount of a bit clocks per frame than
> >>> what is calculated by the sample width. Use the tdm slot bindings to
> >>> provide this mechanism.
> >>>
> >>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >>> ---
> >>>  sound/soc/sunxi/sun4i-i2s.c | 23 +++++++++++++++++++++--
> >>>  1 file changed, 21 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >>> index dca1143c1150..d7a9141514cf 100644
> >>> --- a/sound/soc/sunxi/sun4i-i2s.c
> >>> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >>> @@ -96,6 +96,7 @@
> >>>  #define SUN8I_I2S_CTRL_BCLK_OUT                        BIT(18)
> >>>  #define SUN8I_I2S_CTRL_LRCK_OUT                        BIT(17)
> >>>
> >>> +#define SUN8I_I2S_FMT0_LRCK_MAX_PERIOD         (GENMASK(17, 8) >> 8)
> >>>  #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK                GENMASK(17, 8)
> >>>  #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)     ((period - 1) << 8)
> >>>
> >>> @@ -193,6 +194,9 @@ struct sun4i_i2s {
> >>>         struct regmap_field     *field_rxchansel;
> >>>
> >>>         const struct sun4i_i2s_quirks   *variant;
> >>> +
> >>> +       unsigned int    tdm_slots;
> >>> +       unsigned int    slot_width;
> >>>  };
> >>>
> >>>  struct sun4i_i2s_clk_div {
> >>> @@ -344,7 +348,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_=
dai *dai,
> >>>         if (i2s->variant->has_fmt_set_lrck_period)
> >>>                 regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> >>>                                    SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> >>> -                                  SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> >>> +                                  SUN8I_I2S_FMT0_LRCK_PERIOD(word_si=
ze));
> >>>
> >>>         return 0;
> >>>  }
> >>> @@ -418,7 +422,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_sub=
stream *substream,
> >>>                            sr + i2s->variant->fmt_offset);
> >>>
> >>>         return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> >>> -                                     params_width(params));
> >>> +                                     i2s->tdm_slots ?
> >>> +                                     i2s->slot_width : params_width(=
params));
> >>>  }
> >>>
> >>>  static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int f=
mt)
> >>> @@ -691,6 +696,19 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_d=
ai *dai, int clk_id,
> >>>         return 0;
> >>>  }
> >>>
> >>> +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
> >>> +       unsigned int tx_mask, unsigned int rx_mask,
> >>> +       int slots, int width)
> >>> +{
> >>> +       struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> >>> +
> >>> +       i2s->tdm_slots =3D slots;
> >>> +
> >>> +       i2s->slot_width =3D width;
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>
> >> IIRC some of the DAI controllers actually support TDM. Would this
> >> change conflict with that in the future?
> >
> > Hi Wens,
> > I'm not sure..I was looking for a clean example of being able to
> > override the number of bclks in the lrclk width and some other
> > devices(Rpi) were doing it this way.  I open to suggestions,
>=20
> I'm not familiar with the issue either. If Mark doesn't have any
> objections, we could merge it for now, and fix it later if there
> are any complications.
>=20
> BTW, you didn't provide a device tree example (if any) for how
> to use this.

Could it be that it's just not i2s but some other format?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--55uq6xzd4dh6xbnq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu3gYACgkQ0rTAlCFN
r3R7kxAAjG9SzIPMrmN5HTS5inlMgzH2qjvCg5P+7FkA0XhFkX3b4W6rWlwjdU02
kgl9U6sG/VCcnFbJpjFztKxPWa3xa1XTOY6hnB6WYSVTO/QtgJ12jPjXzJUNsbsm
ocsTRGpMPFr1kipReUtELW+wAmk2Q2kTkk4dQ4/4noSTDzbGCKD0K4hHURWKMP2y
eCbL9nkKZuukLRtd5xr2PEGhAfmLseOvt6r7U9bQNmYxOysxqqfbf5pgw/sS0zrV
jOjGk8doVAhi69MJOvYYOiDRC2Z1lUxPU1pLY6G3rgPTwfDGEfXOx2PiZF2ZToyy
Evh6NDHryst/9FWTauJGDQNnKJnGXJbKIt8SH0j3eAiEPhT+ctCm8XAFwpG2GgGN
2p3ESmho7bUScerLnhA/HVHpuRQ2Bzr6J0KdiLWY4QHqz81vyHyp/1SEghETI5IS
4bchmGne8/7kmIA2Gsih8zCFuhgvvPBjCPg1CV/IxT1Xc/YYjtRnD/zGNLrkviXn
HSBoEpJ1Rx0+nMK1sDHuNdXe9s8sE6wm90Nl+fDfPFAwet8lRuCqDHdwmHJ+qr8n
5PXQXChN1cxxIjcSrR/IMnsxzf8F5aDQe9tcqa9BQaIt+vHrnxse1acc2sjOIzTS
Lx7O6FUc6YcLH/rAmYNw6Ly5HROXt5EfBv98ybIH8Gs5h8L1T2w=
=85hs
-----END PGP SIGNATURE-----

--55uq6xzd4dh6xbnq--

--===============6169308199357629498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6169308199357629498==--
