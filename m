From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH V4 1/3] ASoC: Alchemy AC97C/I2SC audio
	support
Date: Mon, 25 Jul 2011 13:02:58 +0200
Message-ID: <CAOLZvyEpHe_TUygZV7cstg_m1RqdNSg88KwJdkwZF55ThQzn0g@mail.gmail.com>
References: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com>
	<1311502311-16916-2-git-send-email-manuel.lauss@googlemail.com>
	<4E2D3825.1070905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4E2D3825.1070905@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 25, 2011 at 11:32 AM, Liam Girdwood <lrg@ti.com> wrote:
> On 24/07/11 11:11, Manuel Lauss wrote:
>> This patch adds ASoC support for the AC97 and I2S controllers
>> on the old Au1000/Au1500/Au1100 chips,
>>
>> AC97 Tested on a Db1500. =A0I2S untested since none of the boards
>> actually have an I2S codec wired up (just test pins).
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> V4: dropped hunk which removed I2S constants in au1000.h header to avoid=
 merge
>> =A0 =A0 conflicts with other patches, use the context structure in psc.h=
 since it
>> =A0 =A0 fits really well.
>> V3: implemented feedback from Lars-Peter Clausen: src tidying, no more
>> =A0 =A0 automatic dma device registration, split off db1000 board code.
>> V2: added untested I2S controller driver for completeness, removed the a=
udio
>> =A0 =A0 defines from the au1000 header as well.
>>
>
> Looks mostly OK, I just have some questions below:-
>> +#define AC97_RATES =A0 =A0 \
>> + =A0 =A0 =A0 SNDRV_PCM_RATE_8000_44100
>
> Just curious, is there any reason this doesn't support 48kHz ?

No reason really; fixed.


>> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
>> new file mode 100644
>> index 0000000..20fedbd
>> +static int alchemy_pcm_hw_params(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
snd_pcm_hw_params *hw_params)
>> +{
>> + =A0 =A0 =A0 struct audio_stream *stream =3D ss_to_as(substream);
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 err =3D snd_pcm_lib_malloc_pages(substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0params_buffer_bytes(hw_params));
>> + =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 return au1000_setup_dma_link(stream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0params_period_bytes(hw_params),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0params_periods(hw_params));
>
>
> What happens if this fails ? You already have malloc'ed some pages.

also fixed,


>> +static int alchemy_pcm_new(struct snd_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai =
*dai,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_pcm *pcm)
>
> This API call has been updated to only pass the rtd *

fixed,


>> diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
>> +static inline unsigned long RD(struct au1xpsc_audio_data *ctx, int reg)
>> +{
>> + =A0 =A0 =A0 return __raw_readl(ctx->mmio + reg);
>> +}
>> +
>> +static inline void WR(struct au1xpsc_audio_data *ctx, int reg, unsigned=
 long v)
>> +{
>> + =A0 =A0 =A0 __raw_writel(v, ctx->mmio + reg);
>> + =A0 =A0 =A0 wmb();
>> +}
>
> Btw, just wondering if arch/mips already supplies a suitable RD()/WR() fo=
r you ?

with the proper context, no.  I've used these kind of macros in other
code, though :)


>> +static unsigned long msbits_to_reg(int msbits)
>> +{
>> + =A0 =A0 =A0 switch (msbits) {
>> + =A0 =A0 =A0 case 8: =A0return CFG_SZ_8;
>> + =A0 =A0 =A0 case 16: return CFG_SZ_16;
>> + =A0 =A0 =A0 case 18: return CFG_SZ_18;
>> + =A0 =A0 =A0 case 20: return CFG_SZ_20;
>> + =A0 =A0 =A0 case 24: return CFG_SZ_24;
>
> It's best to format all the switch statements consistently throughout you=
r code.

also fixed,


>> +static int au1xi2s_drvsuspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct au1xpsc_audio_data *ctx =3D dev_get_drvdata(dev);
>> +
>> + =A0 =A0 =A0 WR(ctx, I2S_ENABLE, EN_D); =A0 =A0 =A0/* clock off, disabl=
e */
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int au1xi2s_drvresume(struct device *dev)
>> +{
>
> Should we not enalbe the clock here (i.e. in order to balance the clock o=
ff in suspend) ?

According to the datasheet, these bits only control internal clock
supply to the I2S module
itself.  It's reenabled in the trigger callback.  Clock for the codec
is controlled through
another register in the central clock block.   As I wrote, this is an
untested driver since none
of the boards I have actually have an I2S codec wired up.  So this is
all guesswork based
on vague datasheets ;)


>> diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
>> index b30eadd..c59b9e5 100644
>> --- a/sound/soc/au1x/psc.h
>> +++ b/sound/soc/au1x/psc.h
>> @@ -1,7 +1,7 @@
>> =A0/*
>> - * Au12x0/Au1550 PSC ALSA ASoC audio support.
>> + * Alchemy ALSA ASoC audio support.
>> =A0 *
>> - * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
>> + * (c) 2007-2011 MSC Vertriebsges.m.b.H.,
>> =A0 * =A0 =A0 Manuel Lauss <manuel.lauss@gmail.com>
>> =A0 *
>> =A0 * This program is free software; you can redistribute it and/or modi=
fy
>> @@ -13,7 +13,13 @@
>> =A0#ifndef _AU1X_PCM_H
>> =A0#define _AU1X_PCM_H
>>
>> -/* DBDMA helpers */
>> +#define PCM_TX 0
>> +#define PCM_RX 1
>
> Is there any need for these macros, SNDRV_PCM_STREAM_PLAYBACK and SNDRV_P=
CMP_STREAM_CAPTURE should be used for this type of logic.

As long as they both stay 0 and 1, might as well use them directly.  Fixed.
I'll remove them in a follow-up patch for the PSC drivers.

Thanks for the review!
        Manuel Lauss
