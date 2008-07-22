From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Tue, 22 Jul 2008 15:30:12 -0400
Message-ID: <9e4733910807221230x9eadd58s4dc8ec18c1200914@mail.gmail.com>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
	<20080722190933.GA20555@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B86D10381B
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 21:30:13 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so376064yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2008 12:30:12 -0700 (PDT)
In-Reply-To: <20080722190933.GA20555@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/22/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 21, 2008 at 07:25:21PM -0400, Jon Smirl wrote:
>
>  >  /* codec IO */
>  > -#define snd_soc_read(codec, reg) codec->read(codec, reg)
>  > -#define snd_soc_write(codec, reg, value) codec->write(codec, reg, value)
>  > +#define snd_soc_read(codec, reg, value, size) codec->read(codec, reg,
>  > value, size)
>  > +#define snd_soc_write(codec, reg, value, size) codec->write(codec,
>  > reg, value, size)
>
>
> I appreciate that this is just a work in progress but I did want to flag
>  up the effect that this will have on drivers for CODECs with normally
>  sized registers.  Given that this is a fairly unusual case it doesn't
>  seem sensible to cause drivers to have difficulties writing the
>  equivalent of:
>
>         snd_soc_write(codec, REG_CONTROL, MAKE_IT_WORK);
>
>  if we don't have to.
>
>  There's two cases where we have a problem currently: one is with
>  registers up to 32 bits which I think everyone agrees should Just Work
>  and the other is much bigger registers like these 32 byte registers your
>  CODEC has which are a bit more tricky :/ .

My new plan is to make it work on 32bit registers like it does
currently, instead of 16b. I only need to use bitfield masks in the
first 32bits.

Then to access the wide registers I would encode it into the register
names. So if the big mixer register is at 0x40 and it is 32 bytes wide
the defines would look like this.

#define MIXER_CHANNEL_0 0x0040
#define MIXER_CHANNEL_1 0x0140
#define MIXER_CHANNEL_2 0x0240
#define MIXER_CHANNEL_3 0x0340
...
#define MIXER_CHANNEL_7 0x0740

In my register access routine I know 0x0340 is not a legal register
which implies that you want the fourth 32bit word from the 256bit
register. The upper layers won't be the wiser.

To update a 64 bit value there are two sequential 32 bit fields. Mute
the sound before updating them in pieces.

#define LOUNDNESS_LOWER 0x0090
#define LOUNDNESS_UPPER 0x0190

I can get away with updating thing in pieces since I have a 400Kb i2c channel.

This scheme works for the loop displaying all registers since printing
them is implement in my driver. My code knows the length of the
registers and can print the entire register.

I still need to unpack the standard control defines into a structure
to get more width since the basic unit of operation is now 32 bits.

What I'm missing is a fast way to bulk load a bunch of registers. If
you change equalization settings from jazz to classical I need to
update 50 registers in bulk.

Once I can build again I'll do a new round, I'm still dealing with
merge conflicts. My MMC driver is a total mess.

-- 
Jon Smirl
jonsmirl@gmail.com
