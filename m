From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't use
	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 12 Mar 2009 20:09:21 +0100
Message-ID: <74d0deb30903121209ke7e84g7c448b9e14118097@mail.gmail.com>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
	<20090311184416.GA29865@buzzloop.caiaq.de>
	<74d0deb30903111410v5a601709jf779c0d2e64e7de7@mail.gmail.com>
	<20090312004639.GB7462@buzzloop.caiaq.de>
	<20090312102355.GB4038@rakim.wolfsonmicro.main>
	<20090312102749.GA14526@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E4701038BE
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 20:09:22 +0100 (CET)
Received: by gxk2 with SMTP id 2so2087349gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 12:09:21 -0700 (PDT)
In-Reply-To: <20090312102749.GA14526@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 11:27 AM, Daniel Mack <daniel@caiaq.de> wrote:
> On Thu, Mar 12, 2009 at 10:23:56AM +0000, Mark Brown wrote:
>> On Thu, Mar 12, 2009 at 01:46:39AM +0100, Daniel Mack wrote:
>>
>> > (Just for the reference - this one needs to be applied on top of my la=
st
>> > =A0'network vs psp mode' patch, otherwise the second hunk won't apply).
>>
>> Could you please resubmit the most current versions of your outstanding
>> patches? =A0There's too many versions of patches floating around in the
>> middle of threads and I want to make sure I'm looking at the most
>> current versions.
>
> Sorry. See below. There's only one left now and this one shrunk a lot.
>
> Daniel
>
>
> From ad8734e93eed130a55482b0e937729578e6d93c8 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Wed, 11 Mar 2009 19:38:15 +0100
> Subject: [PATCH] pxa-ssp: switch from network mode to PSP
>
> This switches the pxa ssp port usage from network mode to PSP mode.
> Removed some comments and checks for configured TDM channels.
> A special case is added to support configuration where BCLK =3D 64fs. We
> need to do some black magic in this case which doesn't look nice but
> there is unfortunately no other option than that.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
> =A0sound/soc/pxa/pxa-ssp.c | =A0 44 +++++++++++++++++++++++++++++++++----=
-------
> =A01 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 52d97c4..3cde686 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -558,18 +558,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *=
cpu_dai,
>
> =A0 =A0 =A0 =A0switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_I2S:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_PSP;

There is one more thing I didn't think about yet. Disabling network
mode here unconditionally should break Zylonite as is, unless it can
also be changed to use that special 64fs mode.
This code is found in zylonite_voice_hw_params right now:

        /* Use network mode for stereo, one slot per channel. */
        if (params_channels(params) > 1)
                ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 2);
        else
                ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
        if (ret < 0)
                return ret;

And I realize I don't quite understand why it handles the mono case at
all - isn't I2S always stereo?

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
> @@ -655,33 +654,56 @@ static int pxa_ssp_hw_params(struct snd_pcm_substre=
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0sspsp =3D ssp_read_reg(ssp, SSPSP);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((sscr0 & SSCR0_SCR) =3D=3D SSCR0_SerCl=
kDiv(4)) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(width =3D=3D 16)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This is a special case w=
here the bitclk is 64fs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and we're not dealing wit=
h 2*32 bits of audio
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * samples.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The SSP values used for t=
hat are all found out by
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * trying and failing a lot;=
 some of the registers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * needed for that mode are =
only available on PXA3xx.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
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
> + =A0 =A0 =A0 /* When we use a network mode, we always require TDM slots
> =A0 =A0 =A0 =A0 * - complain loudly and fail if they've not been set up y=
et.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
> + =A0 =A0 =A0 if ((sscr0 & SSCR0_MOD) && !(ssp_read_reg(ssp, SSTSA) & 0xf=
)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ssp->pdev->dev, "No TDM timeslot =
configured\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> --
> 1.6.2
>
>
