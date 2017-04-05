From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Wed, 5 Apr 2017 09:54:37 +0200
Message-ID: <2c31e502-4171-7426-1c24-c258a4d02c55@invoxia.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
 <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
 <CAOMZO5DzNqKdOHOb_SXQwzEDfD1B4yQVjYxYaHhFHzWNUSE-ig@mail.gmail.com>
 <CAG5mAdzKuWHMQLiDOzabdp9Xxs1z5sYNdkt17kGge-4wop5nFA@mail.gmail.com>
 <e5c3ee01-e807-e74d-f90f-2c207a74e539@invoxia.com>
 <CAOMZO5Ahe7fYxZH28J7B0wDFmRc1J2aJv6qoktHoKo15s4b9uQ@mail.gmail.com>
 <CAOMZO5A8AExfYR+JuBaLAQsRNUs3Og13PGv9ychD7j4rwMhx2A@mail.gmail.com>
 <9c489e80-2579-3739-1343-2b3587667680@invoxia.com>
 <CAOMZO5CaqpELX0pPS0g7_bi0eEokhtxJtavphssnUi8iJ15XLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E6CCF2666E1
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 09:54:41 +0200 (CEST)
Received: by mail-wr0-f177.google.com with SMTP id w11so3618764wrc.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 00:54:41 -0700 (PDT)
In-Reply-To: <CAOMZO5CaqpELX0pPS0g7_bi0eEokhtxJtavphssnUi8iJ15XLQ@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <kernel@pengutronix.de>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org



On 04/04/2017 22:28, Fabio Estevam wrote:
> On Tue, Apr 4, 2017 at 5:09 PM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
>
>> SCR bit 3 (NET) is also set, so you should be in network mode with a long
>> frame sync.
>> In fact, you can entirely simulate a I2S behavior using Network mode. you
>> should just be careful about the way everything is configured (eg. place of
>> samples in the stream)
> While debugging this issue I noticed that when I put the oscilloscope
> probe in the LRCLK SGTL5000 pin the swap did not occur anymore.
>
> After removing the probe the swap occurred frequently.
>
> So decided to change the SGTL5000 LRCLK pin strength value:
>
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -1118,7 +1118,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
>                          SGTL5000_DAC_MUTE_RIGHT |
>                          SGTL5000_DAC_MUTE_LEFT);
>
> -       snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
> +       snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x035f);
>
>          snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
>                          SGTL5000_HP_ZCD_EN |
>
> and the swap does not happen.
>
> So it seems that no change is needed on the imx-ssi side :-)
Good catch. All of this makes sense.
The SSI surely detect a glitch at the start of the stream and takes it 
for a sync frame, but not followed by the expected 32x2 bits.
It also explain why Caleb and I are not able to reproduce, since we 
connect SSI internally using the audmux, leaving no place for such glitch.

If only Max can validate this fix...
But what is strange is that writing TE and EN at once also avoid the 
issue... or it means the issue was really timing dependent.

Do you know which one is started first ?
- fsl_ssi_trigger(SNDRV_PCM_TRIGGER_START)
or
- stgl5000 PCM bus being turned on

We can expect that stgl5000 turns the PCM clocks first, and then SSI is 
turned on. Otherwise anything can happened when the codec starts its 
clocking.

Maybe we should look at the Fsync state when idle, and see how it behave 
during the startup. Depending of pull-up /down-down configuration of the 
pads, it may be leaved in a undefined state with undefined transitions 
when stgl5000 turns its output on...

Another way to definitively fix this kind of issue is to use 
SND_SOC_DAIFMT_CBS_CFS
- the codec generates the N*8*64 kHz or 44.1*64 kHz precise bitclock 
(something which is not flexible for the SSI who is connected to a fix 
PLL output clock)
- but the SSI generate the Sync, leaving no place for wrong detection.
Unfortunately, stgl5000 doesn't seem to support this mode.

Arnaud
