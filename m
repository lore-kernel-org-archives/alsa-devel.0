From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
	slot_width override.
Date: Tue, 16 Jun 2009 12:28:15 +0200
Message-ID: <74d0deb30906160328n564ab4a5uecc44cb4d057caa5@mail.gmail.com>
References: <1245113071.24109.559.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 84D4F103822
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 12:28:16 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3350281ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2009 03:28:15 -0700 (PDT)
In-Reply-To: <1245113071.24109.559.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

2009/6/16 Daniel Ribeiro <drwyrm@gmail.com>:
> Extend set_tdm_slot to allow the user to arbitrarily set the frame width
> and active TX/RX slots.
>
> Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
> still doesn't handle the slot_width override.
>
> While being there, correct an incorrect use of SlotsPerFrm(7) use in
> bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).
>
> (this series is meant for Mark's for-2.6.32 branch)
>
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
>
> ---
> =A0include/sound/soc-dai.h =A0 | =A0 =A05 +++--
> =A0sound/soc/codecs/wm9081.c | =A0 =A05 +++--
> =A0sound/soc/pxa/magician.c =A0| =A0 =A02 +-
> =A0sound/soc/pxa/pxa-ssp.c =A0 | =A0 27 ++++++++++++++++++++-------

FWIW, the patchset doesn't break magician.
Tested-by: Philipp Zabel <philipp.zabel@gmail.com>
in my dev tree (for-2.6.31 and for-2.6.32 trees merged).

regards
Philipp

> =A0sound/soc/soc-core.c =A0 =A0 =A0| =A0 =A09 ++++++---
> =A05 files changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 352d7ee..6692410 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -106,7 +106,7 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
> =A0int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
>
> =A0int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
> - =A0 =A0 =A0 unsigned int mask, int slots);
> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int =
slot_width);
>
> =A0int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
>
> @@ -140,7 +140,8 @@ struct snd_soc_dai_ops {
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
> =A0 =A0 =A0 =A0int (*set_tdm_slot)(struct snd_soc_dai *dai,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mask, int slots);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int slots, int slot_width);
> =A0 =A0 =A0 =A0int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
>
> =A0 =A0 =A0 =A0/*
> diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
> index 86fc57e..c47d573 100644
> --- a/sound/soc/codecs/wm9081.c
> +++ b/sound/soc/codecs/wm9081.c
> @@ -1206,8 +1206,9 @@ static int wm9081_set_sysclk(struct snd_soc_dai *co=
dec_dai,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/* FIXME: Needs to handle slot_width */
> =A0static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int=
 mask, int slots)
> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int =
slot_width)
> =A0{
> =A0 =A0 =A0 =A0struct snd_soc_codec *codec =3D dai->codec;
> =A0 =A0 =A0 =A0unsigned int aif1 =3D wm9081_read(codec, WM9081_AUDIO_INTE=
RFACE_1);
> @@ -1219,7 +1220,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *=
dai,
>
> =A0 =A0 =A0 =A0aif1 |=3D (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
>
> - =A0 =A0 =A0 switch (mask) {
> + =A0 =A0 =A0 switch (rx_mask) {
> =A0 =A0 =A0 =A0case 1:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 2:
> diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
> index c89a3cd..34437d8 100644
> --- a/sound/soc/pxa/magician.c
> +++ b/sound/soc/pxa/magician.c
> @@ -188,7 +188,7 @@ static int magician_playback_hw_params(struct snd_pcm=
_substream *substream,
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
> + =A0 =A0 =A0 ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 0, 1, width);
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index e22c5ce..5b9ed64 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -375,21 +375,34 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *=
cpu_dai,
> =A0* Set the active slots in TDM/Network mode
> =A0*/
> =A0static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
> - =A0 =A0 =A0 unsigned int mask, int slots)
> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int =
slot_width)
> =A0{
> =A0 =A0 =A0 =A0struct ssp_priv *priv =3D cpu_dai->private_data;
> =A0 =A0 =A0 =A0struct ssp_device *ssp =3D priv->dev.ssp;
> =A0 =A0 =A0 =A0u32 sscr0;
>
> - =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
> + =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0);
> + =A0 =A0 =A0 sscr0 &=3D ~(SSCR0_MOD | SSCR0_SlotsPerFrm(8) | SSCR0_EDSS =
| SSCR0_DSS);
> +
> + =A0 =A0 =A0 /* set slot width */
> + =A0 =A0 =A0 if (slot_width > 16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(slot=
_width - 16);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_DataSize(slot_width);
>
> - =A0 =A0 =A0 /* set number of active slots */
> - =A0 =A0 =A0 sscr0 |=3D SSCR0_SlotsPerFrm(slots);
> + =A0 =A0 =A0 if (slots > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable network mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_MOD;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set number of active slots */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_SlotsPerFrm(slots);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set active slot mask */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSTSA, tx_mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSRSA, rx_mask);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSCR0, sscr0);
>
> - =A0 =A0 =A0 /* set active slot mask */
> - =A0 =A0 =A0 ssp_write_reg(ssp, SSTSA, mask);
> - =A0 =A0 =A0 ssp_write_reg(ssp, SSRSA, mask);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index e1a920c..c72a8e8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2133,17 +2133,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
> =A0/**
> =A0* snd_soc_dai_set_tdm_slot - configure DAI TDM.
> =A0* @dai: DAI
> - * @mask: DAI specific mask representing used slots.
> + * @tx_mask: bitmask representing active TX slots.
> + * @rx_mask: bitmask representing active RX slots.
> =A0* @slots: Number of slots in use.
> + * @slot_width: Width in bits for each slot.
> =A0*
> =A0* Configures a DAI for TDM operation. Both mask and slots are codec an=
d DAI
> =A0* specific.
> =A0*/
> =A0int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
> - =A0 =A0 =A0 unsigned int mask, int slots)
> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int =
slot_width)
> =A0{
> =A0 =A0 =A0 =A0if (dai->ops && dai->ops->set_tdm_slot)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dai->ops->set_tdm_slot(dai, mask, sl=
ots);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dai->ops->set_tdm_slot(dai, tx_mask,=
 rx_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slots, slot=
_width);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
> --
> tg: (c787980..) asoc/set_tdm_slot (depends on: asoc/remove-code-duplicati=
on)
>
> --
> Daniel Ribeiro
>
