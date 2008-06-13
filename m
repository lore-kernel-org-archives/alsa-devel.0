From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
 fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 09:26:04 -0500
Message-ID: <4852837C.6050401@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>	
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>	
	<20080613134206.GA29575@rakim.wolfsonmicro.main>
	<9e4733910806130710k38c45e18p29188e1426851339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D285D10380E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:26:10 +0200 (CEST)
In-Reply-To: <9e4733910806130710k38c45e18p29188e1426851339@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> On 6/13/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, Jun 12, 2008 at 10:57:39PM -0400, Jon Smirl wrote:
>>
>>  > In my model a lot of the code in your fabric driver would be pushed
>>  > into the ssi driver. So if you used ssi and a codec in the standard
>>  > manner, the board wouldn't need a fabric driver at all. That would
>>  > probably be the case for most AC97/HDA systems.
>>
>>
>> I'd certainly like to see some standard support for setting up at least
>>  AC97 DAI links automatically based on the probed codec.  That bit could
>>  probably be done by the core.  HDA should be amenable to this model too
>>  but I haven't looked at it in anything more than passing detail yet.
>>
>>  That's only part of the story, though.  What's much more tricky is
>>  making the decision that you've got all the components for the sound
>>  subsystem - for example, there are AC97 codecs like the WM9712 and
>>  WM9713 which also have I2S interfaces.  You also get systems which need
>>  to jump through hoops to set up the clocking since they're doing
>>  non-standard things.  Simple systems would probably need an explict flag
>>  to say that they could be handled as such, which isn't a million miles
>>  off having something to load a generic machine driver.
> 
> We can't eliminate a fabric driver is all cases, I'd just like to
> minimize its need. This code has the card and codec creation code in
> the fabric driver, I would push down into the ssi driver. Code in the
> ssi would locate the codec and load it. The model needs to be able to
> function if there is no need for a fabric driver.

Like I said earlier, I don't like this idea.  I don't want all this gunk in the
SSI driver, and I don't see anything wrong with the fabric driver being the
master that sets up all the inter-device connections.

> That also flips things around, now the ssi driver needs to locate the
> fabric driver, not the other way around. In this model the fabric
> driver doesn't need to make a device, it just becomes a library of
> code called by the ssi driver.

The DMA driver is already a library that is called by the SSI.  It registers
itself as a regular driver, but under ASoC V2, it really acts like a library.

> Code in the ssi driver could make a
> list of codec parameters, pass it to the fabric driver for
> modification, and then set it into the codec.

That sounds too complicated.

> We're missing a cross platform way to set parameters into a codec. 

No we're not.  ASoC already provides an API for sending parameters to a codec,
and if we need more than that, we can create platform resources and pass those
to the codec.

-- 
Timur Tabi
Linux kernel developer at Freescale
