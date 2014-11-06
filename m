From: Peter Rosin <peda@lysator.liu.se>
Subject: [v2] NXP Semiconductors TFA9879 Amplifier Driver
Date: Thu,  6 Nov 2014 17:39:44 +0100
Message-ID: <1415291985-9784-1-git-send-email-peda@lysator.liu.se>
References: <20141106160241.GM8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E767260695
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 17:40:01 +0100 (CET)
In-Reply-To: <20141106160241.GM8509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2014-11-06 17:02, Mark Brown wrote:> On Thu, Nov 06, 2014 at 02:37:31PM +0000, Peter Rosin wrote:
>> > Mark Brown wrote:
>>>> > > > +	if (tfa9879->lsb_justified)
>>>> > > > +		TFA9879_REG(codec, SERIAL_INTERFACE_1, I2S_SET, i2s_set);
>>> > > Why does this need to be reset every time, shouldn't we just be setting the
>>> > > register in set_fmt().?
>> > Yes, I'd sure like to do that, but how do I get to the width in set_fmt()?
> Oh, this has some width related thing in it?

Yes, the amp has a different setting for each lsb-justified width.
(It also supports 18 and 20 bits wide data)

>>>> > > > +	{ TFA9879_MISC_STATUS,		0x0000 }, /* 0x15, read-only */
>>>> > > > +};
>>>> > > > +static bool tfa9879_volatile_register(struct device *dev, unsigned
>>>> > > > +int reg) {
>>>> > > > +	return reg == TFA9879_MISC_STATUS;
>>> > > If the register is volatile it shouldn't have a default value provided.
>> > Then I misunderstood what volatile was meant to do. I'll just nuke the
>> > function. It works fine anyway...
> A volatile register is one that the chip may change autonomously (eg, an
> interrupt status register).

That was what I assumed, and the register behaves like that. I naively
thought that declaring it as volatile would prevent the asoc core from
writing to it. In retrospect, I don't understand why I thought that...
Anyway, that bit can wait until someone actually needs to read the staus.

Here's an update with the following changes since v1:

- squashed patch 2/2
- zapped the TFA9879_REG macro
- zapped tfa9879_probe (which needlessly registered the regmap)
- moved tfa9879_prepare/_shutdown to a DAPM_SUPPLY widget
- zapped the tfa9879_volatile() thing
- made tfa9879_dai_ops const
- erased the redundant "Gain" from the bass/treble volume controls
- using params_width() instead of params_format()

Cheers,
Peter
