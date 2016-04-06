From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: simple-audio-card and external dynamic clock
Date: Wed, 6 Apr 2016 09:54:37 +0300
Message-ID: <5704B2AD.10201@ti.com>
References: <56F46168.7040201@laposte.net> <5702E300.8060101@laposte.net>
 <57039843.4060806@ti.com> <57040DAE.2060002@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 86EDA26506E
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 08:54:41 +0200 (CEST)
In-Reply-To: <57040DAE.2060002@laposte.net>
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

On 04/05/16 22:10, Emmanuel Fust=E9 wrote:
> Le 05/04/2016 12:49, Peter Ujfalusi a =E9crit :
>> On 04/05/16 00:56, Emmanuel Fust=E9 wrote:
>>> Le 24/03/2016 22:51, Emmanuel Fust=E9 a =E9crit :
>>>> Hello,
>>>>
>>>> I m very new to ASoC (and not native english speaker) so be indulgent =
;-)
>>>> The context  : am335x-boneblack.
>>>> I want to drive simple I2S targets. With the ongoing developments, and
>>>> recent patches posted here, this is a very simple job for the
>>>> simple-audio-card machine driver even with fixed external master clock.
>>>> I want to go further using a programmable external clock (si570) which=
 is
>>>> not very complicated thanks to the CCF.
>>>> But now I want to use the dynamic nature of this external master clock
>>>> (through CCF) to be able to generate 44.1khz AND 48 multiples of fs wh=
ich is
>>>> not natively possible on the BBB because of integer fs scaling only an=
d/or
>>>> no dedicated audio PLL.
>>>> I know that the same could be achieved on the BBB with switching betwe=
en
>>>> internal clock (24mhz) and external one (24.576mhz) gated by GPIO1_27,=
 but
>>>> this is another story.
>>>>
>>>> Which direction is the right one ?
>>>> - dedicated machine driver ?
>>>> - or something more generic / reusable implemented in the simple-audio=
-card
>>>> drivers through helpers routines ?
>> simple card does not support dynamic switching between clocks and it doe=
s not
>> have support for clock changing runtime - the rate is checked when the d=
river
>> probes.
>>
>>>> - or something else ?
>>>>
>>> Ok,
>>>
>>> I did a little bit of homework and mailing list digging.
>>> If I understand the "problem"  correctly, here we are:
>>> - ASoc is now completely CCF aware
>> whatever this means ;)
>>
>>> - McASP driver is not, but it is not a real problem in most use cases w=
hen we
>>> omit the possibilities offered by AHCLKX or if we use a static AHCLKX
>>> configuration.
>> True that the McASP driver is not using the CCF API to configure it's in=
ternal
>> clocking setup but I think none of the DAI drivers are doing it right no=
w. The
>> external clocks are configured with CCF bindings.
>> It is a bit more complicated thing to implement as it sounds as:
>> - we need to make sure that the current way of clock configuration remai=
ns
>> operational.
>> - how the clock tree design will look like, what names are we going to u=
se,
>> how to craft out the DT bindings.
>> - not small amount of code to add the clock provider functionality for i=
nputs,
>> outputs, gates, muxes and dividers in McASP driver.
>> - how legacy (non DT boot will be affected)? Most of daVinci is not goin=
g to
>> be converted to DT :(
>> - How this is going to be integrated in a system level clock tree?
>> A simple thing like when McASP is outputing a reference clock via AHCLKX=
 pin
>> and McASP is built as module. In DT we need to describe the McASP clock =
tree
>> and it's integration into the system clock tree, right? So let's say AUX=
CLK is
>> used as reference clock for McASP and it is sending a clock out via it's
>> AHCLKX pin to an external codec. When the kernel boots the clock tree ne=
eds to
>> be built up and based on the DT description a clock path is going throug=
h a
>> module which does not exist in the kernel yet (it is a module, loaded la=
ter)
>> so the CCF can not check these clocks as the clocks are not yet register=
ed.
>> Probably building McASP in the kernel can solve this.
>>
>> and there are other 'small' issues we are not aware of right now.
>>
>>> My use case needs two different level of ccf work on the McASP driver:
>>> First, a "basic" conversion to CCF to be able to use simple-audio-card,
>>> choosing the used clock (AHCLKX or AUXCLK) with the
>>> assigned-clocks/assigned-clock-parents standard DT properties as it see=
ms to
>>> be the way to go (February discussion about selecting system clocks by =
ID ).
>> Yes, since the ID based fix is not accepted, we should get CCF to do the=
 same
>> thing. That way we can stop using any clock related support from the sim=
ple
>> card.
>>
>>> Next, a more advanced support for the external AHCLKX case, which could=
 be
>>> driven by a programmable clock (clk_set_rate available). Most use cases=
 would
>>> be covered by a 24mhz and 24.576mhz AHCLKX and the correct divisors set=
s as
>>> need by the McASP driver.
>>> With more complexity, arbitrary I2S rate (with arbitrary AHCLKX) or bet=
ter
>>> accuracy ( dynamic switching between internal AUXCLK @24mhz and externa=
l fixed
>>> AHCLKX @24.576mhz) could be achieved.
>>> And no need for a machine driver, simple-audio-card would be sufficient.
>>>
>>> Right ?
>> I have not checked it, but it might be possible that with CCF we can do =
the
>> divider change up in the clock tree but switching between reference cloc=
ks is
>> a bit more problematic.
>>
> Ok, things are not simple ;)

Yeah, and one thing came to my mind: daVinci architecture does not use CCF.=
..

> So for an "advanced" use of the McASP IP on Linux, specific machine drive=
r and
> perhaps a little bit of davinci-mcasp modifications are still required.

I would pick this series:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104316.h=
tml
for now to get things working till we can figure out the CCF way of
configuring the clocks inside McASP.
This is what we are doing with TI internal releases used by our customers.

> I will be around to see any  future progress on the mcasp driver front and
> will try to help as I could if possible.

I will try to prioritize the CCF work as I will have at least one board
upstream where the clock selection is needed for audio.

> Thank you for your detailed and very instructive answer.

I'll CC you also when I have something to test.

-- =

P=E9ter
