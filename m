From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Wed, 19 Sep 2012 16:49:15 -0500
Message-ID: <505A3DDB.4060208@freescale.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
 <50589DD7.8050409@freescale.com>
 <CAOMZO5D-oHc8hdakFHPHSW_duAZ+dMuM77wUn=K=7jUMwxmg-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 30434265228
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 23:49:30 +0200 (CEST)
In-Reply-To: <CAOMZO5D-oHc8hdakFHPHSW_duAZ+dMuM77wUn=K=7jUMwxmg-A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, javier.martin@vista-silicon.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> On Tue, Sep 18, 2012 at 1:14 PM, Timur Tabi <timur@freescale.com> wrote:
>> Fabio Estevam wrote:
>>>
>>> Can you please try to play a mono track on your PowerPC platform with these
>>> series applied?
>>
>> I'm pretty sure this won't work.  The SSI is programmed to expect a left
>> and right sample.  There is no code in fsl_ssi.c for checking the channel
>> count and adjusting the hardware accordingly.  I don't see any code like
>> that in imx-ssi.c either, so I don't even know how it's supposed to work.
> 
> It works for me on mx6qsabrelite.

I just don't see how that's possible.

> However, in order to play the mono track at the correct rate I also need:
> 
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -938,7 +938,7 @@ static struct snd_soc_dai_driver sgtl5000_dai = {
>         .name = "sgtl5000",
>         .playback = {
>                 .stream_name = "Playback",
> -               .channels_min = 1,
> +               .channels_min = 2,
>                 .channels_max = 2,
>                 /*
>                  * only support 8~48K + 96

That's because the SGTL5000 codec has (apparently) support for mono audio:

	/* set mono to save power */
	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER, stereo,
			channels == 1 ? 0 : stereo);

The problem I have with mono support is that the I2S standard says the
LRCLK is used to distinguish between the left and right channels of a
given sample.

I do not know of any way to get the SSI to treat the left and right
channel as two separate samples.

I can imagine, however, a situation where the SSI is *tricked* into
thinking that it's playing stereo audio when it really isn't.  The codec
then treats the left and right channels as two different samples, and
fakes out the clock as well.

I don't know of any codec that does this.

I do know of codecs that support a "left/right fill mode" where it
duplicates the data automatically in the left and right timeslots.  But I
don't think any codec that I've used supports this.

> I would like to understand when channels_min should be set to 1 or 2
> in the platform driver (sound/soc/fsl/fsl_ssi.c in this case) or
> inside the codec. Could anyone clarify this, please?

I still have seen no explanation as to how mono audio can work on an I2S
device.  The I2S standard calls for a left and right channel in every
sample, and the playback frequency is based on that sample rate.

-- 
Timur Tabi
Linux kernel developer at Freescale
