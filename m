From: Arun KS <getarunks@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
	mode
Date: Tue, 14 Apr 2009 17:02:45 +0530
Message-ID: <dfeb90390904140432o1edb7892hbede4e9014f6dc81@mail.gmail.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090414120221.f0e89499.jarkko.nikula@nokia.com>
	<20090414093133.GB12678@sirena.org.uk>
	<200904141334.33497.peter.ujfalusi@nokia.com>
	<20090414142004.fee14e30.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C12C103826
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 13:32:47 +0200 (CEST)
In-Reply-To: <20090414142004.fee14e30.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext@alsa-project.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I m not able to use my osk5912 to test this.
When i do an aplay with the latest kernel (linux-2.6.30-rc1) i am
getting an me i/o error.

Thanks,
Arun

On Tue, Apr 14, 2009 at 4:50 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wr=
ote:
> On Tue, 14 Apr 2009 12:34:33 +0200
> "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:
>
>> Well, I think the mcbsp module is quite - maybe too - flexible...
>> To have the DSP_B mode correctly (for the tvl320aic32 codec used in osk5=
912 board) the FS polarity has to be handled by the mcbsp as it has been in=
verted. If we don't do this, there is no way to have the MSB at the correct=
 place (it has to be available when the FS is high).
>>
>>
>> The DSP_A mode can use the FS polarity 'correctly' - as it is. Or we can=
 also consider to require to invert the FS polarity, than add 1 bit delay f=
or DSP_A mode.
>>
> I meant something like this below integrating your FWID(0) and temp_fmt f=
rom my earlier commit da6320becf31c40b60d4b1dc6b339c9a766b671c so that SND_=
SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF will produce correct format.
>
> I tested this only with Beagle McBSP3 and oscilloscope but I like to veri=
fy it with real codecs as well :-)
>
>
> Jarkko
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index d6882be..c40ea21 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -272,7 +272,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_DSP_B:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs->srgr2 =A0 =A0 |=3D FPER(wlen * chann=
els - 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs->srgr1 =A0 =A0 |=3D FWID(wlen * channe=
ls - 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs->srgr1 =A0 =A0 |=3D FWID(0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> @@ -291,6 +291,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_=
dai *cpu_dai,
> =A0{
> =A0 =A0 =A0 =A0struct omap_mcbsp_data *mcbsp_data =3D to_mcbsp(cpu_dai->p=
rivate_data);
> =A0 =A0 =A0 =A0struct omap_mcbsp_reg_cfg *regs =3D &mcbsp_data->regs;
> + =A0 =A0 =A0 unsigned int temp_fmt =3D fmt;
>
> =A0 =A0 =A0 =A0if (mcbsp_data->configured)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -317,6 +318,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_=
dai *cpu_dai,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 0-bit data delay */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs->rcr2 =A0 =A0 =A0|=3D RDATDLY(0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs->xcr2 =A0 =A0 =A0|=3D XDATDLY(0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Invert bit clock and FS polarity configu=
ration */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_fmt ^=3D SND_SOC_DAIFMT_IB_IF;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Unsupported data format */
> @@ -340,7 +343,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_=
dai *cpu_dai,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Set bit clock (CLKX/CLKR) and FS polarities */
> - =A0 =A0 =A0 switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> + =A0 =A0 =A0 switch (temp_fmt & SND_SOC_DAIFMT_INV_MASK) {
> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_NB_NF:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Normal BCLK + FS.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
