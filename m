From: Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Wed, 05 Apr 2017 16:04:30 +0200
Message-ID: <1491401070.1810.10.camel@gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
 <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
 <2c31e502-4171-7426-1c24-c258a4d02c55@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D592266BA4
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 16:04:32 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id t20so3003348wra.2
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 07:04:32 -0700 (PDT)
In-Reply-To: <2c31e502-4171-7426-1c24-c258a4d02c55@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

(resend from my alsa-devel registered email address)

On Wed, 2017-04-05 at 09:54 +0200, Arnaud Mouiche wrote:
> 
> 
> On 04/04/2017 22:28, Fabio Estevam wrote:
> > 
> > 
> > On Tue, Apr 4, 2017 at 5:09 PM, Arnaud Mouiche
> > <arnaud.mouiche@invoxia.com> wrote:
> > 
> > > 
> > > 
> > > SCR bit 3 (NET) is also set, so you should be in network mode with a long
> > > frame sync.
> > > In fact, you can entirely simulate a I2S behavior using Network mode. you
> > > should just be careful about the way everything is configured (eg. place of
> > > samples in the stream)
> > While debugging this issue I noticed that when I put the oscilloscope
> > probe in the LRCLK SGTL5000 pin the swap did not occur anymore.
> > 
> > After removing the probe the swap occurred frequently.
> > 
> > So decided to change the SGTL5000 LRCLK pin strength value:
> > 
> > --- a/sound/soc/codecs/sgtl5000.c
> > +++ b/sound/soc/codecs/sgtl5000.c
> > @@ -1118,7 +1118,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
> >                          SGTL5000_DAC_MUTE_RIGHT |
> >                          SGTL5000_DAC_MUTE_LEFT);
> > 
> > -       snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
> > +       snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x035f);
> > 
> >          snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
> >                          SGTL5000_HP_ZCD_EN |
> > 
> > and the swap does not happen.
> > 
> > So it seems that no change is needed on the imx-ssi side :-)
> Good catch. All of this makes sense.
> The SSI surely detect a glitch at the start of the stream and takes it 
> for a sync frame, but not followed by the expected 32x2 bits.
> It also explain why Caleb and I are not able to reproduce, since we 
> connect SSI internally using the audmux, leaving no place for such glitch.
> 
> If only Max can validate this fix...

Reverting the previous patch (setting TE and RE) and changing the drive
strenght to 0x035f fixes the channel swap on the Colibri iMX6DL.
e.g. 1000 playback starts do all have the correct channel assignment.

Looks like having the the LRCLK a bit earlier through the increased drive
strength changes the timing in a way that when the SSI samples that signal
with its correct state.
Probably the previous patch with TE and RE changes the sampling time in
the SSI which made it work in our use case.

Max

> 
> But what is strange is that writing TE and EN at once also avoid the 
> issue... or it means the issue was really timing dependent.
> 
> Do you know which one is started first ?
> - fsl_ssi_trigger(SNDRV_PCM_TRIGGER_START)
> or
> - stgl5000 PCM bus being turned on
> 
> We can expect that stgl5000 turns the PCM clocks first, and then SSI is 
> turned on. Otherwise anything can happened when the codec starts its 
> clocking.
> 
> Maybe we should look at the Fsync state when idle, and see how it behave 
> during the startup. Depending of pull-up /down-down configuration of the 
> pads, it may be leaved in a undefined state with undefined transitions 
> when stgl5000 turns its output on...
> 
> Another way to definitively fix this kind of issue is to use 
> SND_SOC_DAIFMT_CBS_CFS
> - the codec generates the N*8*64 kHz or 44.1*64 kHz precise bitclock 
> (something which is not flexible for the SSI who is connected to a fix 
> PLL output clock)
> - but the SSI generate the Sync, leaving no place for wrong detection.
> Unfortunately, stgl5000 doesn't seem to support this mode.
> 
> Arnaud
> 
