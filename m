From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Wed, 11 Mar 2009 19:10:28 +0100
Message-ID: <74d0deb30903111110h4e441959yec421225a4b90cc9@mail.gmail.com>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<20090309153629.GB24787@buzzloop.caiaq.de>
	<20090309174443.GG13593@sirena.org.uk>
	<20090310154741.GC10574@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 1943D10387E
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 19:10:29 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so434365ywa.2
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 11:10:28 -0700 (PDT)
In-Reply-To: <20090310154741.GC10574@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Mar 10, 2009 at 4:47 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Mon, Mar 09, 2009 at 05:44:46PM +0000, Mark Brown wrote:
>> On Mon, Mar 09, 2009 at 04:36:29PM +0100, Daniel Mack wrote:
>>
>> > Mark says he'd rather like me to use/abuse the set_clk_div() interface
>> > for that but IMO that's an evil hack. The next CPU would need a similar
>> > thing to be used with this codec, so there should be a clean way to
>> > achive that.
>>
>> The point here is that this is already fairly widely supported with some
>> combination of that approach and network mode and adding a third method
>> only makes things more complex, especially with more flexibile devices
>> which are capable of supporting combinations of these options
>
> Ok, there might be an even more straight-forward solution for this
> problem: As we know already from the DIV_SCR divider what our
> BCLK/LRCLK ratio is, we can add a special case for the mode I need, as
> implemented in the patch below.
>
> Philipp, could you test that again on your board, please?
> Applies on top of the other one ("pxa-ssp: don't touch ssp registers
> ...") I just posted.

Tested-by me. Of course this still doesn't help me to enable 16-bit
DMA transfers for stereo, but it doesn't hurt either.

> Thanks,
> Daniel
>
>
> From cbd130dfeca4d65acd34cd6a3ca6d1a45885985f Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Tue, 10 Mar 2009 16:33:35 +0100
> Subject: [PATCH 1/2] pxa-ssp: switch from network mode to PSP
>
> This switches the pxa ssp port usage from network mode to PSP mode.
> Removed some comments and checks for configured TDM channels.
> A special case is added to support configuration where BCLK =3D 64fs. We
> need to do some black magic in this case which doesn't look nice but
> there is unfortunately no other option than that.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
> =A0sound/soc/pxa/pxa-ssp.c | =A0 56 ++++++++++++++++++++++++++++++-------=
---------
> =A01 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 7fc13f0..1b3a81c 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -45,6 +45,7 @@
> =A0struct ssp_priv {
> =A0 =A0 =A0 =A0struct ssp_dev dev;
> =A0 =A0 =A0 =A0unsigned int sysclk;
> + =A0 =A0 =A0 unsigned int scr_div;

Really needed? Or could we just check SSCR0 below?

> =A0 =A0 =A0 =A0int dai_fmt;
> =A0#ifdef CONFIG_PM
> =A0 =A0 =A0 =A0struct ssp_state state;
> @@ -281,11 +282,13 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_d=
ai)
> =A0* ssp_set_clkdiv - set SSP clock divider
> =A0* @div: serial clock rate divider
> =A0*/
> -static void ssp_set_scr(struct ssp_dev *dev, u32 div)
> +static void ssp_set_scr(struct ssp_priv *priv, u32 div)
> =A0{
> + =A0 =A0 =A0 struct ssp_dev *dev =3D &priv->dev;
> =A0 =A0 =A0 =A0struct ssp_device *ssp =3D dev->ssp;
> =A0 =A0 =A0 =A0u32 sscr0 =3D ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
>
> + =A0 =A0 =A0 priv->scr_div =3D div;
> =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
> =A0}
>
> @@ -327,7 +330,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai =
*cpu_dai,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case PXA_SSP_CLK_AUDIO:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->sysclk =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_set_scr(&priv->dev, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_set_scr(priv, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D SSCR0_ACS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> @@ -388,7 +391,7 @@ static int pxa_ssp_set_dai_clkdiv(struct snd_soc_dai =
*cpu_dai,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSACD, val);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case PXA_SSP_DIV_SCR:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_set_scr(&priv->dev, div);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_set_scr(priv, div);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> @@ -547,18 +550,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *=
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_IB_IF:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMP | SS=
PSP_SCMODE(3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -644,37 +646,51 @@ static int pxa_ssp_hw_params(struct snd_pcm_substre=
am *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D SSCR0_FPCKE;
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D SSCR0_DataSize(16);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* use network mode (2 slots) for 16 bit st=
ereo */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case SNDRV_PCM_FORMAT_S24_LE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(8)=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must be in network mode (2 slots) for=
 24 bit stereo */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case SNDRV_PCM_FORMAT_S32_LE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16=
));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must be in network mode (2 slots) for=
 32 bit stereo */
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((priv->scr_div =3D=3D 4) && (width =3D=
=3D 16)) {

sscr0 & SSCR0_SCR =3D=3D SSCR0_SerClkDiv(4) instead?

Probably not, it just replaces data bloat by code bloat.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This is a special case w=
here the bitclk is 64fs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and we're not dealing =
with 2*32 bits of audio
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* samples.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The SSP values used fo=
r that are all found out by
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* trying and failing a l=
ot; some of the registers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* needed for that mode a=
re only available on PXA3xx.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> +#ifdef CONFIG_PXA3xx
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_pxa3xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIN=
VAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(w=
idth * 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMDLY(wi=
dth * 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_EDMYSTOP(3=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTOP(3);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTRT(1);
> +#else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(w=
idth);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSPSP, sspsp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
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

I wonder if this check was useful in some case? If so, we could
replace it with something like this:

@@ -667,10 +667,11 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 		break;
 	}

-	/* We always use a network mode so we always require TDM slots
+	/* If we are using a network mode, require TDM slots
 	 * - complain loudly and fail if they've not been set up yet.
 	 */
-	if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
+	if ((ssp_read_reg(ssp, SSCR0) & SSCR0_MOD) &&
+	    !(ssp_read_reg(ssp, SSTSA) & 0xf)) {
 		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
 		return -EINVAL;
 	}

> =A0 =A0 =A0 =A0dump_registers(ssp);
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.6.2
>
>

regards
Philipp
