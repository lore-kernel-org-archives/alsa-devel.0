From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: FSL SSI 32 bit transfer (WAS Re: [RFC PATCH] ASoC:
 fsl-ssi: Add support for CBM_CFS 16/24 bit)
Date: Sat, 2 Aug 2014 12:39:17 +0200
Message-ID: <CAOf5uwmO9o6CvY5QrukWjtkCvSF+Q_cpniZTX-UwuPsx7y4Q=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 65C09261AE0
 for <alsa-devel@alsa-project.org>; Sat,  2 Aug 2014 12:39:18 +0200 (CEST)
Received: by mail-wg0-f43.google.com with SMTP id l18so5216175wgh.26
 for <alsa-devel@alsa-project.org>; Sat, 02 Aug 2014 03:39:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi all


I have a quick question. Do you know if 32 bit transfer on dma is
suppose to work on IMX6?
32LE sample 2 channels

Michael

On Thu, Jul 31, 2014 at 7:09 AM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> Il 29/lug/2014 08:18 "Markus Pargmann" <mpa@pengutronix.de> ha scritto:
>
>
>>
>> Hi,
>>
>> On Mon, Jul 28, 2014 at 02:46:38PM +0200, Michael Trimarchi wrote:
>> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>
>> A commit description what you are doing in this patch and how your setup
>> looks like would be good.
>>
>> > ---
>> >  sound/soc/fsl/fsl_ssi.c | 27 +++++++++++++++++++++++++--
>> >  1 file changed, 25 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> > index 9bfef55..743e50d 100644
>> > --- a/sound/soc/fsl/fsl_ssi.c
>> > +++ b/sound/soc/fsl/fsl_ssi.c
>> > @@ -724,10 +724,19 @@ static int fsl_ssi_hw_params(struct
>> > snd_pcm_substream *substream,
>> >               regmap_update_bits(regs, CCSR_SSI_SRCCR,
>> > CCSR_SSI_SxCCR_WL_MASK,
>> >                               wl);
>> >
>> > -     if (!fsl_ssi_is_ac97(ssi_private))
>> > +     if (!fsl_ssi_is_ac97(ssi_private)) {
>> > +             u8 i2smode;
>> > +
>> > +             if (ssi_private->i2s_mode == (CCSR_SSI_SCR_I2S_MODE_NORMAL
>> > |
>> > +                 CCSR_SSI_SCR_NET) && sample_size >= 24)
>>
>> This condition seems a bit fragile using the i2s_mode variable.
>>
>> I don't know about this bitclock master mode, why is this condition
>> necessary, what is the difference with sample_size >= 24?
>>
>
> I will do in better way and cleanup. Problem is how data is packed in 32 bit
> sample. So 24/32 should be master but 16/32 seems a different story. It
> packs like 16/16 bit.
>
> I will take a look during the weekend
>
> Michael
>
>> Regards,
>>
>> Markus
>>
>> > +                     i2smode = CCSR_SSI_SCR_I2S_MODE_MASTER;
>> > +             else
>> > +                     i2smode = ssi_private->i2s_mode;
>> > +
>> >               regmap_update_bits(regs, CCSR_SSI_SCR,
>> >                               CCSR_SSI_SCR_NET |
>> > CCSR_SSI_SCR_I2S_MODE_MASK,
>> > -                             channels == 1 ? 0 :
>> > ssi_private->i2s_mode);
>> > +                             channels == 1 ? 0 : i2smode);
>> > +     }
>> >
>> >       return 0;
>> >  }
>> > @@ -789,6 +798,15 @@ static int _fsl_ssi_set_dai_fmt(struct
>> > fsl_ssi_private *ssi_private,
>> >                                       CCSR_SSI_SxCCR_DC_MASK,
>> >                                       CCSR_SSI_SxCCR_DC(2));
>> >                       break;
>> > +             case SND_SOC_DAIFMT_CBM_CFS:
>> > +                     ssi_private->i2s_mode |=
>> > CCSR_SSI_SCR_I2S_MODE_NORMAL;
>> > +                     regmap_update_bits(regs, CCSR_SSI_STCCR,
>> > +                                     CCSR_SSI_SxCCR_DC_MASK,
>> > +                                     CCSR_SSI_SxCCR_DC(2));
>> > +                     regmap_update_bits(regs, CCSR_SSI_SRCCR,
>> > +                                     CCSR_SSI_SxCCR_DC_MASK,
>> > +                                     CCSR_SSI_SxCCR_DC(2));
>> > +                     break;
>> >               case SND_SOC_DAIFMT_CBM_CFM:
>> >                       ssi_private->i2s_mode |=
>> > CCSR_SSI_SCR_I2S_MODE_SLAVE;
>> >                       break;
>> > @@ -853,6 +871,11 @@ static int _fsl_ssi_set_dai_fmt(struct
>> > fsl_ssi_private *ssi_private,
>> >       case SND_SOC_DAIFMT_CBM_CFM:
>> >               scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
>> >               break;
>> > +     case SND_SOC_DAIFMT_CBM_CFS:
>> > +             strcr &= ~CCSR_SSI_STCR_TXDIR;
>> > +             strcr |= CCSR_SSI_STCR_TFDIR;
>> > +             scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
>> > +             break;
>> >       default:
>> >               return -EINVAL;
>> >       }
>> > --
>> > 1.8.1.2
>> >
>> >
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Industrial Linux Solutions                 |http://www.pengutronix.de/ |
>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone:+49-5121-206917-0   |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:  +49-5121-206917-5555|
