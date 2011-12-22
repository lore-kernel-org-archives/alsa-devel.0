From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 3/3 v2] sound/soc/lapis: add platform driver for ML7213
 IOH I2S
Date: Thu, 22 Dec 2011 17:10:24 +0900
Message-ID: <CANKRQnjCTAX02wJt7StjB0rXkg3Q6bPBRYCbkgq6vS5NFd97Fg@mail.gmail.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<1324349144-12784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111220132314.GQ2866@opensource.wolfsonmicro.com>
	<CANKRQng8N3oS2o17HPUZeonXB3KLBK9oNQj-zd9+aUUvWcTo0A@mail.gmail.com>
	<20111222005816.GB27144@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111222005816.GB27144@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/22 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Dec 21, 2011 at 08:22:56PM +0900, Tomoya MORINAGA wrote:
>> 2011/12/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>> > On Tue, Dec 20, 2011 at 11:45:44AM +0900, Tomoya MORINAGA wrote:
>
>> >> + =A0 =A0 iowrite32(I2S_TX_FINT | I2S_TX_AFINT | I2S_TX_EINT | I2=
S_TX_AEINT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 i2s_data->iobase + I2SISTTX_OFFSET + of=
fset);
>
>> > This appears to unconditionally acknowledge all interrupts, genera=
lly
>> > you should only acknowledge interrupts that have been handled.
>> > Otherwise it's possible that interrupts may be dropped if they're
>> > flagged between the status read and acknowledgement write.
>
>> I can understand your saying.
>> If following your saying, only called by i2s_dma_tx_complete is enou=
gh.
>
>> However I think adding clearing interrupt status at both before and
>> after i2s communicating start/finish is better.
>
> No, the issue is that you're acknowleding a hard coded set of
> interrupts, not the interrupts that were actually handled. =A0The ord=
ering
> isn't really the issue, the issue is that you could acknowledge thing=
s
> that weren't handled. =A0For example:
>
> =A0 1. ISR runs, reads status A
> =A0 2. Condition B happens
> =A0 3. ISR handles condition A.
> =A0 4. ISR acknowledges both A and B.
>
> would mean that B would just get ignored.
I can understand your saying.
However, in case of Tx interrupt, only ALMOST-EMPTY occurs. in case of
Rx, only Rx ALMOST-FULL occurs.
So as long as a user uses ML7213 I2S, your mentioned behavior is never =
happened.


>
>> >> +static bool filter(struct dma_chan *chan, void *slave)
>
>> > This needs a better name. =A0It's not namespaced and it's not clea=
r what
>> > it's filtering.
>
>> In case of using Linux standard DMA API, function "filter" is the mo=
st
>> popular name.
>> Almost drivers which use standard use "filter".
>
> I suspect they may have the filter immediately next to the code that
> uses it, which certainly isn't the case here.
They have the "filter" function immediately next to the code uses
"dma_request_channel".
Anyway, if you want me to change the name, I can change the name.
Please decide it.

>
>> >> +ioh_i2s_write(struct snd_pcm_substream *substream, const void *d=
ata, int len)
>> >> +{
>> >> + =A0 =A0 int rem1;
>> >> + =A0 =A0 int rem2;
>
>> > What is this supposed to do? =A0There's an awful lot of it, and it=
 looks
>> > like it's supposed to be rewriting the data format for some reason=
 which
>> > isn't something that a driver ought to be doing (apart from anythi=
ng
>> > else it does rather defeat the point of DMA).
>
>> This driver has buffer which is for preventing noisy sound =A0by jit=
ter
>> So, this buffer is variable.
>
> You're implementing some sort of custom buffering in your driver? =A0=
That
> sounds terribly unidiomatic - pretty much all DMA drivers are very th=
in
> and manage to work well, I'd expect this is masking some problems in =
the
> code rather than anything else. =A0Can you provide more detail on wha=
t
> this is working around?
Not sorted but queuing only.
In sound/voice control system, queuing is not rare, I think.
If necessary, though this method is very common, I can send the method
of the queue.

>
>> >> + =A0 =A0 num =3D ((int)dma->tx_avail) / (I2S_AEMPTY_THRESH * 4);
>
>> > That case looks *very* suspect.
>
>> This is correct.
>> Why do you think so ?
>
> I can't tell what it's supposed to do, and casting that isn't super
> clear especially casting to integer types tends to be a big red flag.

Currently, "tx_avail" is "int" type. So, "(int)" is redundant.
Maybe, once type of "tx_avail" is not "int" but something pointer type.
I'll modify like below.
num =3D dma->tx_avail / (I2S_AEMPTY_THRESH * 4);


thanks,
tomoya
