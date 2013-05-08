From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Wed, 08 May 2013 07:26:22 -0700
Message-ID: <518A608E.8030802@boundarydevices.com>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
 <20130508103150.GW7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B7F02619F5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 16:26:28 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id bg2so1372024pad.39
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 07:26:28 -0700 (PDT)
In-Reply-To: <20130508103150.GW7478@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Matt Sealey <matt@genesi-usa.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, "zengzm.kernel" <zengzm.kernel@gmail.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 05/08/2013 03:31 AM, Mark Brown wrote:
> On Tue, May 07, 2013 at 03:06:39PM -0500, Matt Sealey wrote:
>> On Mon, May 6, 2013 at 5:06 PM, Mark Brown <broonie@kernel.org> wrote:
 >
 > ...
 >
>> Because that's what Freescale did in their code as per their comments
>> - if only because they needed to do this kind of setup before the
>> cache/defaults were populated. I assume they populate the cache from
>> the chip at probe because the defaults change per revision and the
>> presence of VDDD or not may change some of the registers in the cache.
>
> We just have no idea why they're doing what they're doing; this is all
> guesswork.  I've not seen anything that indicates that anyone who's sent
> any code has any understanding of what they're changing.
>
>> It may also be on boards like i.MX6 Sabrelite that the "defaults" are
>> not the "defaults" over a warm reboot, since the chip never powers off
>> (just "optionally" loses clock depending on whether CLKO is
>> reconfigured or not at some point) and probably retains everything you
>> ever set.

That's exactly right for SABRE Lite. Hitting the reset button or
invoking a processor reset doesn't reset the SGTL5000, so when
Linux boots, the registers are in an unknown state.

>
> This is why most drivers do a hardware reset of the device on gaining
> control of it, in order to ensure that the hardware is in a known state.
> I see  that the driver doesn't do that except through the regulators.  I
> see this driver doesn't do that which isn't terribly clever, though it's
> not clear that the chip has suitable support.
>
>> We want to do two possible things...
>> * At probe, dump some known good defaults into the chip and use those as
 >> a cache
>> * At probe, read out all the registers assuming they're already known
>> good defaults into a cache
>
> Clearly the first option is more sane since otherwise you've no idea if
> the chip is configured sensibly.
>

I agree. It seems that the 'cache' is currently mixing two things:
     1.) **presumed** power-on defaults for the chip, and
     2.) cached values of the registers

Since we can't ensure that we're starting with power-on-reset, the
entire initial cache is potentially wrong.

>> The intent being in the first case to make for damn sure the codec is
>> in a well known state, and in the second case JUST to reduce i2c
>> writes further down the line. Freescale seem to like the second one,
>
> This isn't the sole function of the register cache, it's also used to
> implement most of suspend and resume and to allow the device to be
> powered off when idle but still present controls.
>
>> Mainline is doing the first set, although it's definitely possible
>> those defaults are not the true defaults if they were derived from a
>> board like the Sabrelite where a warm reboot might retain all the
>> state from previous boots.. the precedence of that list of defaults is
>> basically unknown.. and I recall Freescale updating them in the BSP a
>> lot.
>
> I'd *really* hope that the defaults come from the chip datasheet.  If
> they don't that's extremely disappointing.
>
>> So the problem here might be some quirky board designs, a random
>> implementation of an erratum workaround with no documentation, a bunch
>
> My impression based on what I'm seeing here, including things like your
> comments about lots of register default changes, is that people working
> on the driver haven't had much understanding of what they're doing and
> have got confused as a result.  Sounds like a good first step is getting
> the register defaults sane...
>

An initial pass of writing all of the default register values with a
sort of 'cache flush' appears to be the right thing.

Then it doesn't even matter if the values match the datasheet, or if
the spec changes over time. If the values are reasonable, the device
will function properly.
