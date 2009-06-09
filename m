From: Paul Shen <boshen9@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Tue, 9 Jun 2009 17:39:53 +0800
Message-ID: <1719ee7f0906090239m578d1ab3j80a7ebc15f9cc51e@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<1244276805.15998.102.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 612AD245CB
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 11:39:55 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3710895bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 02:39:54 -0700 (PDT)
In-Reply-To: <1244276805.15998.102.camel@brutus>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Would you please give some informations about your platform ?
Thus I can test the patches with your method.

2009/6/6 Daniel Ribeiro <drwyrm@gmail.com>:
> Em Qua, 2009-06-03 =E0s 20:33 +0800, Eric Miao escreveu:
>> Make the pxa I2S configuration generic, add support for Left_J, add
>> support for variable frame width like 32fs, 48fs, 64fs and 96fs
>>
>> Signed-off-by: Paul Shen <bshen9@marvell.com>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>> Cc: Daniel Mack <daniel@caiaq.de>
>> ---
>> =A0arch/arm/mach-pxa/include/mach/regs-ssp.h | =A0 14 +++---
>> =A0sound/soc/pxa/pxa-ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 62 =
++++++++++++++--------------
>> =A0sound/soc/pxa/pxa-ssp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
9 ++++
>> =A03 files changed, 47 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h
>> b/arch/arm/mach-pxa/include/mach/regs-ssp.h
>> index 6a2ed35..27f0cd4 100644
>> --- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
>> +++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
>> @@ -108,21 +108,21 @@
>> =A0#define SSSR_TINT =A0 =A0 =A0 =A0 =A0 =A0(1 << 19) =A0 =A0 =A0 /* Rec=
eiver Time-out Interrupt */
>> =A0#define SSSR_PINT =A0 =A0 =A0 =A0 =A0 =A0(1 << 18) =A0 =A0 =A0 /* Per=
ipheral Trailing Byte Interrupt */
>>
>> -#if defined(CONFIG_PXA3xx)
>> -#define SSPSP_EDMYSTOP(x) =A0 =A0((x) << 28) =A0 =A0 /* Extended Dummy =
Stop */
>> -#define SSPSP_EDMYSTRT(x) =A0 =A0((x) << 26) =A0 =A0 /* Extended Dummy =
Start */
>> -#endif
>> -
>> =A0#define SSPSP_FSRT =A0 =A0 =A0 =A0 =A0 (1 << 25) =A0 =A0 =A0 /* Frame=
 Sync Relative Timing */
>> -#define SSPSP_DMYSTOP(x) =A0 =A0 ((x) << 23) =A0 =A0 /* Dummy Stop */
>> =A0#define SSPSP_SFRMWDTH(x) =A0 =A0((x) << 16) =A0 =A0 /* Serial Frame =
Width */
>> =A0#define SSPSP_SFRMDLY(x) =A0 =A0 ((x) << 9) =A0 =A0 =A0/* Serial Fram=
e Delay */
>> -#define SSPSP_DMYSTRT(x) =A0 =A0 ((x) << 7) =A0 =A0 =A0/* Dummy Start */
>> =A0#define SSPSP_STRTDLY(x) =A0 =A0 ((x) << 4) =A0 =A0 =A0/* Start Delay=
 */
>> =A0#define SSPSP_ETDS =A0 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* End=
 of Transfer data State */
>> =A0#define SSPSP_SFRMP =A0 =A0 =A0 =A0 =A0(1 << 2) =A0 =A0 =A0 =A0/* Ser=
ial Frame Polarity */
>> =A0#define SSPSP_SCMODE(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0((x) << 0) =A0 =A0=
 =A0/* Serial Bit Rate Clock Mode */
>>
>> +/* NOTE: PXA3xx extends the bit number of dummy start and stop, the mac=
ros
>> + * below are compatible with PXA25x/27x as long as the parameter is wit=
hin
>> + * the correct limits, driver code has to take care of this.
>> + */
>> +#define SSPSP_DMYSTRT(x) =A0 =A0 ((((x) & 3) << 7) =A0| ((((x) >> 2) & =
3) << 26))
>> +#define SSPSP_DMYSTOP(x) =A0 =A0 ((((x) & 3) << 23) | ((((x) >> 2) & 7)=
 << 28))
>> +
>> =A0#define SSACD_SCDB =A0 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* SSP=
SYSCLK Divider Bypass */
>> =A0#define SSACD_ACPS(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((x) << 4) =A0 =
=A0 =A0/* Audio clock PLL select */
>> =A0#define SSACD_ACDS(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((x) << 0) =A0 =
=A0 =A0/* Audio clock divider select */
>> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
>> index 6fc7876..2831c16 100644
>> --- a/sound/soc/pxa/pxa-ssp.c
>> +++ b/sound/soc/pxa/pxa-ssp.c
>> @@ -463,7 +463,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *c=
pu_dai,
>>
>> =A0 =A0 =A0 switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
>> - =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_PSP;
>> + =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
>> + =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_PSP | SSCR0_MOD;
>
> Why do you enforce network mode here?
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* See hw_params() */
>> @@ -541,6 +542,7 @@ static int pxa_ssp_hw_params(struct
>> snd_pcm_substream *substream,
>> =A0 =A0 =A0 int chn =3D params_channels(params);
>> =A0 =A0 =A0 u32 sscr0;
>> =A0 =A0 =A0 u32 sspsp;
>> + =A0 =A0 int frame_width;
>> =A0 =A0 =A0 int width =3D snd_pcm_format_physical_width(params_format(pa=
rams));
>> =A0 =A0 =A0 int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
>>
>> @@ -585,40 +587,38 @@ static int pxa_ssp_hw_params(struct
>> snd_pcm_substream *substream,
>>
>> =A0 =A0 =A0 switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
>> - =A0 =A0 =A0 =A0 =A0 =A0sspsp =3D ssp_read_reg(ssp, SSPSP);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((ssp_get_scr(ssp) =3D=3D 4) && (width =3D=
=3D 16)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This is a special case wher=
e the bitclk is 64fs
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and we're not dealing with 2=
*32 bits of audio
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * samples.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The SSP values used for that=
 are all found out by
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * trying and failing a lot; so=
me of the registers
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * needed for that mode are onl=
y available on PXA3xx.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 sspsp =3D ssp_read_reg(ssp, SSPSP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 frame_width =3D PXA_SSP_FRM_WIDTH(priv->dai_fm=
t);
>
> I would expect FRM_WIDTH to also change SSCR0_EDSS and SSCR0_DataSize
>
>>
>> -#ifdef CONFIG_PXA3xx
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_pxa3xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(widt=
h * 2);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMDLY(width=
 * 4);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_EDMYSTOP(3);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTOP(3);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTRT(1);
>> -#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (frame_width < width * 2)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> -#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The frame width is the widt=
h the LRCLK is
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* asserted for; the delay i=
s expressed in
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* half cycle units. =A0We n=
eed the extra cycle
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* because the data starts c=
locking out one BCLK
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* after LRCLK changes polar=
ity.
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (frame_width =3D=3D width * 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* frame width is exactly doub=
le of data sample width,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* use FSRT instead
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(widt=
h + 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMDLY((widt=
h + 1) * 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_FSRT | SSPSP_=
SFRMWDTH(width);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTRT(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTOP((fram=
e_width / 2 - width - 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(fram=
e_width / 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSPSP, sspsp);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
>> + =A0 =A0 =A0 =A0 =A0 =A0 sspsp =3D ssp_read_reg(ssp, SSPSP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 frame_width =3D PXA_SSP_FRM_WIDTH(priv->dai_fm=
t);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (frame_width < width * 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (frame_width =3D=3D width * 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(widt=
h);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_DMYSTOP((fram=
e_width / 2 - width));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp |=3D SSPSP_SFRMWDTH(fram=
e_width / 2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSPSP, sspsp);
>> diff --git a/sound/soc/pxa/pxa-ssp.h b/sound/soc/pxa/pxa-ssp.h
>> index 91deadd..fda51d0 100644
>> --- a/sound/soc/pxa/pxa-ssp.h
>> +++ b/sound/soc/pxa/pxa-ssp.h
>> @@ -40,6 +40,15 @@
>> =A0#define PXA_SSP_CLK_SCDB_1 =A0 =A0 =A0 =A0 =A0 1
>> =A0#define PXA_SSP_CLK_SCDB_8 =A0 =A0 =A0 =A0 =A0 2
>>
>> +/* frame size definitions for I2S and Left_J formats - default is
>> + * 32fs, other possibilities are 48fs, 64fs and 96fs
>> + */
>> +#define PXA_SSP_FRM_32FS =A0 =A0 (0 << 16)
>> +#define PXA_SSP_FRM_48FS =A0 =A0 (1 << 16)
>> +#define PXA_SSP_FRM_64FS =A0 =A0 (2 << 16)
>> +#define PXA_SSP_FRM_96FS =A0 =A0 (3 << 16)
>> +#define PXA_SSP_FRM_WIDTH(x) (((((x) >> 16) & 0x3) + 2) << 4)
>> +
>> =A0#define PXA_SSP_PLL_OUT =A00
>>
>> =A0extern struct snd_soc_dai pxa_ssp_dai[4];
>
> I am testing this patch with PXA272 slave of clock and frame,
> DAIFMT_LEFT_J, tdm_slot(3,2), and it causes my audio to play with double
> speed. (with tdm_slot(1,1) it plays at half speed).
>
> Values that are known to work fine for my board are:
> SSCR0 =3D 0x1000bf
> SSPSP =3D 0x100002
>
>
> --
> Daniel Ribeiro
>


Would you please give me code extract about your SSP, codec
configurations and clock setting?

-- =

Paul Shen
