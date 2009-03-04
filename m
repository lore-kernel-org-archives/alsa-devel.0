From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 4/4] pxa-ssp: switch from network mode to
	psp
Date: Wed, 4 Mar 2009 21:56:01 +0100
Message-ID: <74d0deb30903041256u8eeea03n5500cd59afadd86e@mail.gmail.com>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<1236197820-21022-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A6F3103833
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:56:02 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so2311023yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 04 Mar 2009 12:56:01 -0800 (PST)
In-Reply-To: <1236197820-21022-4-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 4, 2009 at 9:17 PM, Daniel Mack <daniel@caiaq.de> wrote:
> This patch uses the SSP's PSP functionality to provide I2S timings. The
> particular problem is that even though the datasheets state it should be
> possbible, there is no mode which uses the network feature with its
> associated time slots in a sane way to do what we need.
>
> Hence, in order to have full 64 bit I2S on the wire, we need to fiddle
> around with the SSP and the timing paramters a lot. There are some
> constants left in the code which can't be replaced by names because the
> true meaning of their registers remains nebulous.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Signed-off-by: Tim Ruetz <tim@caiaq.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@kernel.org>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> =A0sound/soc/pxa/pxa-ssp.c | =A0 39 +++++++++++++++++++++----------------=
--
> =A01 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 45fb600..97f11d6 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -319,6 +319,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai =
*cpu_dai,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case PXA_SSP_CLK_EXT:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->sysclk =3D freq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_set_scr(&priv->dev, 4);

Shouldn't this be somehow set by set_dai_clkdiv instead?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D SSCR0_ECS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case PXA_SSP_CLK_NET:
> @@ -551,17 +552,13 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *=
cpu_dai,
>
> =A0 =A0 =A0 =A0switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_I2S:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_PSP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_NF:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_FSRT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_IF:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMP | SS=
PSP_FSRT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_IB_IF:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sspsp |=3D SSPSP_SFRMP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;

Removal of SSPSP_FSRT from NB/IB selection seems to be correct from the doc=
s.
Can you check if IB could be properly handled by setting SCMODE(1)?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> @@ -652,33 +649,39 @@ static int pxa_ssp_hw_params(struct snd_pcm_substre=
am *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case SNDRV_PCM_FORMAT_S24_LE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(8)=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must be in network mode (2 slots) for=
 24 bit stereo */

This is still dubious ...
S24_LE is 24-bit sound LSB-aligned in 32-bit frames, so DataSize
should be 32 here.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case SNDRV_PCM_FORMAT_S32_LE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16=
));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must be in network mode (2 slots) for=
 32 bit stereo */

How is it possible to send 64bit in one frame otherwise?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSCR0, sscr0);
>
> =A0 =A0 =A0 =A0switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_I2S:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Cleared when the DAI format is set */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp =3D ssp_read_reg(ssp, SSPSP) | SSPSP_=
SFRMWDTH(width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp =3D ssp_read_reg(ssp, SSPSP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (priv->dai_fmt & SND_SOC_DAIFMT_FRAM=
E_FORMAT_MASK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_FF_I2S_32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* These values are all fou=
nd out by trying and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* failing a lot. PXA's S=
SP is all black magic and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* does not work like des=
cribed in any datasheet.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(3=
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMDLY(32=
 * 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_EDMYSTOP(3=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTOP(3);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTRT(1);

Wha?! Amazing. And this really works?
How the hell can this result in 16 bits of data followed by 16 bits of
zeroes, twice :)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Cleared when the DAI for=
mat is set */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(w=
idth);

Not good for DSP_A/B.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSPSP, sspsp);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* We always use a network mode so we always require TDM sl=
ots
> - =A0 =A0 =A0 =A0* - complain loudly and fail if they've not been set up =
yet.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ssp->pdev->dev, "No TDM timeslot c=
onfigured\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0dump_registers(ssp);
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.6.1.3
>
>

regards
Philipp
