From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: simple-audio-card and external dynamic clock
Date: Tue, 5 Apr 2016 13:49:39 +0300
Message-ID: <57039843.4060806@ti.com>
References: <56F46168.7040201@laposte.net> <5702E300.8060101@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 342A3265469
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 12:49:44 +0200 (CEST)
In-Reply-To: <5702E300.8060101@laposte.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: emmanuel.fuste@laposte.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/05/16 00:56, Emmanuel Fust=E9 wrote:
> Le 24/03/2016 22:51, Emmanuel Fust=E9 a =E9crit :
>> Hello,
>>
>> I m very new to ASoC (and not native english speaker) so be indulgent ;-)
>> The context  : am335x-boneblack.
>> I want to drive simple I2S targets. With the ongoing developments, and
>> recent patches posted here, this is a very simple job for the
>> simple-audio-card machine driver even with fixed external master clock.
>> I want to go further using a programmable external clock (si570) which is
>> not very complicated thanks to the CCF.
>> But now I want to use the dynamic nature of this external master clock
>> (through CCF) to be able to generate 44.1khz AND 48 multiples of fs whic=
h is
>> not natively possible on the BBB because of integer fs scaling only and/=
or
>> no dedicated audio PLL.
>> I know that the same could be achieved on the BBB with switching between
>> internal clock (24mhz) and external one (24.576mhz) gated by GPIO1_27, b=
ut
>> this is another story.
>>
>> Which direction is the right one ?
>> - dedicated machine driver ?
>> - or something more generic / reusable implemented in the simple-audio-c=
ard
>> drivers through helpers routines ?

simple card does not support dynamic switching between clocks and it does n=
ot
have support for clock changing runtime - the rate is checked when the driv=
er
probes.

>> - or something else ?
>>
> =

> Ok,
> =

> I did a little bit of homework and mailing list digging.
> If I understand the "problem"  correctly, here we are:
> - ASoc is now completely CCF aware

whatever this means ;)

> - McASP driver is not, but it is not a real problem in most use cases whe=
n we
> omit the possibilities offered by AHCLKX or if we use a static AHCLKX
> configuration.

True that the McASP driver is not using the CCF API to configure it's inter=
nal
clocking setup but I think none of the DAI drivers are doing it right now. =
The
external clocks are configured with CCF bindings.
It is a bit more complicated thing to implement as it sounds as:
- we need to make sure that the current way of clock configuration remains
operational.
- how the clock tree design will look like, what names are we going to use,
how to craft out the DT bindings.
- not small amount of code to add the clock provider functionality for inpu=
ts,
outputs, gates, muxes and dividers in McASP driver.
- how legacy (non DT boot will be affected)? Most of daVinci is not going to
be converted to DT :(
- How this is going to be integrated in a system level clock tree?
A simple thing like when McASP is outputing a reference clock via AHCLKX pin
and McASP is built as module. In DT we need to describe the McASP clock tree
and it's integration into the system clock tree, right? So let's say AUXCLK=
 is
used as reference clock for McASP and it is sending a clock out via it's
AHCLKX pin to an external codec. When the kernel boots the clock tree needs=
 to
be built up and based on the DT description a clock path is going through a
module which does not exist in the kernel yet (it is a module, loaded later)
so the CCF can not check these clocks as the clocks are not yet registered.
Probably building McASP in the kernel can solve this.

and there are other 'small' issues we are not aware of right now.

> My use case needs two different level of ccf work on the McASP driver:
> First, a "basic" conversion to CCF to be able to use simple-audio-card,
> choosing the used clock (AHCLKX or AUXCLK) with the
> assigned-clocks/assigned-clock-parents standard DT properties as it seems=
 to
> be the way to go (February discussion about selecting system clocks by ID=
 ).

Yes, since the ID based fix is not accepted, we should get CCF to do the sa=
me
thing. That way we can stop using any clock related support from the simple=
 card.

> Next, a more advanced support for the external AHCLKX case, which could be
> driven by a programmable clock (clk_set_rate available). Most use cases w=
ould
> be covered by a 24mhz and 24.576mhz AHCLKX and the correct divisors sets =
as
> need by the McASP driver.
> With more complexity, arbitrary I2S rate (with arbitrary AHCLKX) or better
> accuracy ( dynamic switching between internal AUXCLK @24mhz and external =
fixed
> AHCLKX @24.576mhz) could be achieved.
> And no need for a machine driver, simple-audio-card would be sufficient.
> =

> Right ?

I have not checked it, but it might be possible that with CCF we can do the
divider change up in the clock tree but switching between reference clocks =
is
a bit more problematic.

-- =

P=E9ter
