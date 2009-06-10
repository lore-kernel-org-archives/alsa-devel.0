From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH] ASoC: Automatically set TDM if needed on
	pxa-ssp and allow frame width override when using TDM.
Date: Wed, 10 Jun 2009 14:05:29 +0200
Message-ID: <74d0deb30906100505q55185f32u513eadeeefc432a5@mail.gmail.com>
References: <1244567590.7406.100.camel@brutus>
	<1719ee7f0906100444l187377f4l9a91b0f24338e032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B75324365
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 14:12:00 +0200 (CEST)
Received: by ewy23 with SMTP id 23so805315ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 05:11:59 -0700 (PDT)
In-Reply-To: <1719ee7f0906100444l187377f4l9a91b0f24338e032@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Shen <boshen9@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2009 at 1:44 PM, Paul Shen<boshen9@gmail.com> wrote:
> 2009/6/10 Daniel Ribeiro <drwyrm@gmail.com>:
>> * Extend set_tdm_slot to allow the user to arbitrarily set the frame
>> =A0width and active TX/RX slots.
>> * Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
>> * Makes SSCR0_MOD optional.
>> * Automatically sets network mode when needed if set_tdm_slot was
>> =A0never called.
>> * Clears SSCR1_RWOT case SSCR0_MOD is set.
>> * Updates magician.c and wm9081.c for the new set_tdm_slot()
>>
>> (Patch is based on Mark's for-2.6.32 branch)
>>
>> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
>>
>> ---
>> =A0include/sound/soc-dai.h =A0 | =A0 =A05 +
>> =A0sound/soc/codecs/wm9081.c | =A0 =A04 -
>> =A0sound/soc/pxa/magician.c =A0| =A0 =A02
>> =A0sound/soc/pxa/pxa-ssp.c =A0 | =A0119 ++++++++++++++++++++++++++++----=
--------------
>> =A0sound/soc/soc-core.c =A0 =A0 =A0| =A0 =A09 ++-
>> =A05 files changed, 85 insertions(+), 54 deletions(-)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index 352d7ee..f96cc36 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -106,7 +106,7 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
>> =A0int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
>>
>> =A0int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
>> - =A0 =A0 =A0 unsigned int mask, int slots);
>> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int=
 frame_width);
>>
>> =A0int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
>>
>> @@ -140,7 +140,8 @@ struct snd_soc_dai_ops {
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
>> =A0 =A0 =A0 =A0int (*set_tdm_slot)(struct snd_soc_dai *dai,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int mask, int slots);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int slots, int frame_width);
>> =A0 =A0 =A0 =A0int (*set_tristate)(struct snd_soc_dai *dai, int tristate=
);
>>
>> =A0 =A0 =A0 =A0/*
>> diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
>> index 86fc57e..85c720a 100644
>> --- a/sound/soc/codecs/wm9081.c
>> +++ b/sound/soc/codecs/wm9081.c
>> @@ -1207,7 +1207,7 @@ static int wm9081_set_sysclk(struct snd_soc_dai *c=
odec_dai,
>> =A0}
>>
>> =A0static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned in=
t mask, int slots)
>> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int=
 frame_width)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_codec *codec =3D dai->codec;
>> =A0 =A0 =A0 =A0unsigned int aif1 =3D wm9081_read(codec, WM9081_AUDIO_INT=
ERFACE_1);
>> @@ -1219,7 +1219,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai =
*dai,
>>
>> =A0 =A0 =A0 =A0aif1 |=3D (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
>>
>> - =A0 =A0 =A0 switch (mask) {
>> + =A0 =A0 =A0 switch (tx_mask) {
>> =A0 =A0 =A0 =A0case 1:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0case 2:
>> diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
>> index c89a3cd..2345869 100644
>> --- a/sound/soc/pxa/magician.c
>> +++ b/sound/soc/pxa/magician.c
>> @@ -188,7 +188,7 @@ static int magician_playback_hw_params(struct snd_pc=
m_substream *substream,
>> =A0 =A0 =A0 =A0if (ret < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>>
>> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
>> + =A0 =A0 =A0 ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1, 1, 16);
>> =A0 =A0 =A0 =A0if (ret < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>>
>> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
>> index 46d14f3..f0931e7 100644
>> --- a/sound/soc/pxa/pxa-ssp.c
>> +++ b/sound/soc/pxa/pxa-ssp.c
>> @@ -375,21 +375,34 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai =
*cpu_dai,
>> =A0* Set the active slots in TDM/Network mode
>> =A0*/
>> =A0static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
>> - =A0 =A0 =A0 unsigned int mask, int slots)
>> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int=
 frame_width)
>> =A0{
>> =A0 =A0 =A0 =A0struct ssp_priv *priv =3D cpu_dai->private_data;
>> =A0 =A0 =A0 =A0struct ssp_device *ssp =3D priv->dev.ssp;
>> =A0 =A0 =A0 =A0u32 sscr0;
>>
>> - =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
>> + =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0);
>> + =A0 =A0 =A0 sscr0 &=3D ~(SSCR0_MOD | SSCR0_SlotsPerFrm(7) | SSCR0_EDSS=
 | SSCR0_DSS);
>> +
>> + =A0 =A0 =A0 /* set frame width */
>> + =A0 =A0 =A0 if (frame_width > 16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(fra=
me_width - 16);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_DataSize(frame_width);
>> +
>> + =A0 =A0 =A0 if (slots > 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable network mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_MOD;
>>
> Seems the frame_width has no =A0such relations with sampe width, the
> sample width is defined on runtime by the audio files.
> Make a example sample with =A0paly a often used 16bit sample width
> stereo aduio file.
>
> When you play 16bit audio sample with =A02*16 bit frame ,
> =A0 =A0 =A0 =A0 frame =A0 --|____________|------------------|____________=
_|---
> =A0 =A0 =A0 =A0 data =A0 =A0 =A0--<=3D=3D=3D=3D=3D=3D>-<=3D=3D=3D=3D=3D=
=3D>-<=3D=3D=3D=3D=3D=3D>-
> =A0 =A0 =A0 =A0 here the datasize should be SSCR0_DataSize(16), the frame=
 size is 32
>
> also you can play 16bit audio sample with 2*32 frame,
> =A0 =A0 =A0 =A0 frame
> --|_________________________|------------------------------------|____
> =A0 =A0 =A0 =A0 data =A0 =A0 --<=3D=3D=3D=3D=3D=3D>-------------------<=
=3D=3D=3D=3D=3D=3D>-------------------<=3D=3D
> =A0 =A0 =A0 =A0 here the datasize is also DataSize(16), but the frame siz=
e is 64.
>
> Do I misunderstand you?

Hmm right, the real frame width is DataSize * slots. So maybe
       /* set data size */
       data_size =3D frame_width/slots;
       if (data_size > 16)
               sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(data_size - 16);
       else
               sscr0 |=3D SSCR0_DataSize(data_size);
would be more appropriate. Or have that parameter be sample_width
instead, as Mark initially proposed.

>> - =A0 =A0 =A0 /* set number of active slots */
>> - =A0 =A0 =A0 sscr0 |=3D SSCR0_SlotsPerFrm(slots);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set number of active slots */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_SlotsPerFrm(slots);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set active slot mask */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSTSA, tx_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSRSA, rx_mask);
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSCR0, sscr0);
>>
>> - =A0 =A0 =A0 /* set active slot mask */
>> - =A0 =A0 =A0 ssp_write_reg(ssp, SSTSA, mask);
>> - =A0 =A0 =A0 ssp_write_reg(ssp, SSRSA, mask);
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> @@ -439,8 +452,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *c=
pu_dai,
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* reset port settings */
>> - =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0) &
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (SSCR0_ECS | =A0SSCR0_NCS | SSCR0_MOD | SS=
CR0_ACS);
>> + =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0) & (SSCR0_ECS | SSCR0_NC=
S | SSCR0_MOD |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSCR0_ACS | SSCR0_EDSS | S=
SCR0_DSS);
>> =A0 =A0 =A0 =A0sscr1 =3D SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
>> =A0 =A0 =A0 =A0sspsp =3D 0;
>>
>> @@ -487,7 +500,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *c=
pu_dai,
>> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_DSP_A:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sspsp |=3D SSPSP_FSRT;
>> =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_DSP_B:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_PSP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>> @@ -537,48 +550,70 @@ static int pxa_ssp_hw_params(struct snd_pcm_substr=
eam *substream,
>> =A0 =A0 =A0 =A0struct ssp_priv *priv =3D cpu_dai->private_data;
>> =A0 =A0 =A0 =A0struct ssp_device *ssp =3D priv->dev.ssp;
>> =A0 =A0 =A0 =A0int chn =3D params_channels(params);
>> - =A0 =A0 =A0 u32 sscr0;
>> - =A0 =A0 =A0 u32 sspsp;
>> + =A0 =A0 =A0 u32 sscr0, sscr1, sspsp;
>> =A0 =A0 =A0 =A0int width =3D snd_pcm_format_physical_width(params_format=
(params));
>> - =A0 =A0 =A0 int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
>> + =A0 =A0 =A0 int frame_width;
>> +
>> + =A0 =A0 =A0 /* check if the user explicitly set a frame_width */
>> + =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0);
>> +
>> + =A0 =A0 =A0 if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_width =3D (sscr0 & SSCR0_DSS) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sscr0 & SSCR0_EDSS ? 17 :=
 1);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_width =3D width * chn;
>>
>> =A0 =A0 =A0 =A0/* generate correct DMA params */
>> =A0 =A0 =A0 =A0if (cpu_dai->dma_data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(cpu_dai->dma_data);
>>
>> - =A0 =A0 =A0 /* Network mode with one active slot (ttsa =3D=3D 1) can b=
e used
>> - =A0 =A0 =A0 =A0* to force 16-bit frame width on the wire (for S16_LE),=
 even
>> - =A0 =A0 =A0 =A0* with two channels. Use 16-bit DMA transfers for this =
case.
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((chn =3D=3D 2) && (ttsa !=
=3D 1)) || (width =3D=3D 32),
>> + =A0 =A0 =A0 cpu_dai->dma_data =3D ssp_get_dma_params(ssp, frame_width =
> 16,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0substream->stream =3D=3D =
SNDRV_PCM_STREAM_PLAYBACK);
>>
>> =A0 =A0 =A0 =A0/* we can only change the settings if the port is not in =
use */
>> - =A0 =A0 =A0 if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
>> + =A0 =A0 =A0 if (sscr0 & SSCR0_SSE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>>
>> - =A0 =A0 =A0 /* clear selected SSP bits */
>> - =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_E=
DSS);
>> - =A0 =A0 =A0 ssp_write_reg(ssp, SSCR0, sscr0);
>> -
>> - =A0 =A0 =A0 /* bit size */
>> - =A0 =A0 =A0 sscr0 =3D ssp_read_reg(ssp, SSCR0);
>> - =A0 =A0 =A0 switch (params_format(params)) {
>> - =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S16_LE:
>> + =A0 =A0 =A0 /* FIXME: What this is for? */
>> =A0#ifdef CONFIG_PXA3xx
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_pxa3xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_FPCKE;
>> + =A0 =A0 =A0 if (width =3D=3D 16 && cpu_is_pxa3xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_FPCKE;
>> =A0#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_DataSize(16);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S24_LE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(8)=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S32_LE:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16=
));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 if (!(sscr0 & (SSCR0_EDSS | SSCR0_DSS))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Frame width not set yet, we are not usi=
ng network mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (frame_width > 16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_EDSS | SS=
CR0_DataSize(frame_width - 16);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_DataSize(=
frame_width);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (frame_width > 32) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Network mode is neede=
d to support this frame_width
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We assume that the wi=
re is not networked and setup
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a "fake" network mode=
 here.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int slots =3D frame_width =
/ 32;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_MOD;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr0 |=3D SSCR0_SlotsPerF=
rm(slots);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Set active slots. Onl=
y set an active TX slot
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if we are going to us=
e it.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSRSA, =
slots - 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->stream =3D=
=3D SNDRV_PCM_STREAM_PLAYBACK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_=
reg(ssp, SSTSA, slots - 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 /* If SSCR0_MOD is set we can't use SSCR1_RWOT */
>> + =A0 =A0 =A0 if (sscr0 & SSCR0_MOD) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sscr1 =3D ssp_read_reg(ssp, SSCR1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_write_reg(ssp, SSCR1, sscr1 & ~SSCR1_R=
WOT);
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0ssp_write_reg(ssp, SSCR0, sscr0);
>>
>> =A0 =A0 =A0 =A0switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> @@ -625,14 +660,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substre=
am *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 /* When we use a network mode, we always require TDM slots
>> - =A0 =A0 =A0 =A0* - complain loudly and fail if they've not been set up=
 yet.
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if ((sscr0 & SSCR0_MOD) && !ttsa) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ssp->pdev->dev, "No TDM timeslot =
configured\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0dump_registers(ssp);
>>
>> =A0 =A0 =A0 =A0return 0;
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index e1a920c..69becf2 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -2133,17 +2133,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
>> =A0/**
>> =A0* snd_soc_dai_set_tdm_slot - configure DAI TDM.
>> =A0* @dai: DAI
>> - * @mask: DAI specific mask representing used slots.
>> + * @tx_mask: bitmask representing active TX slots.
>> + * @rx_mask: bitmask representing active RX slots.
>> =A0* @slots: Number of slots in use.
>> + * @frame_width: Width in bits for each slot.
>> =A0*
>> =A0* Configures a DAI for TDM operation. Both mask and slots are codec a=
nd DAI
>> =A0* specific.
>> =A0*/
>> =A0int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
>> - =A0 =A0 =A0 unsigned int mask, int slots)
>> + =A0 =A0 =A0 unsigned int tx_mask, unsigned int rx_mask, int slots, int=
 frame_width)
>> =A0{
>> =A0 =A0 =A0 =A0if (dai->ops && dai->ops->set_tdm_slot)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dai->ops->set_tdm_slot(dai, mask, s=
lots);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dai->ops->set_tdm_slot(dai, tx_mask=
, rx_mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slots, fra=
me_width);
>> =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0}
>>
>> --
>> Daniel Ribeiro
>>
>
>
>
> --
> Paul Shen
>

regards
Philipp
