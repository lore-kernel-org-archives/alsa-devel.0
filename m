From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Subject: Re: [PATCH 05/16] ASoC: core: Add strobe control
Date: Thu, 22 Mar 2012 17:20:06 +0100
Message-ID: <4F6B5136.5040208@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-6-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213356.GE3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
	[207.126.144.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E84E3103E76
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 17:20:55 +0100 (CET)
In-Reply-To: <20120313213356.GE3177@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 2012-03-13 22:33, Mark Brown wrote:

> On Tue, Mar 13, 2012 at 04:11:32PM +0100, Ola Lilja wrote:
>> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>>
>> Added support for a control that strobes a bit in
>> a register to high then back to low (or the inverse).
>>
>> This is typically useful for hardware that requires
>> strobing a singe bit to trigger some functionality
>> and where exposing the bit in a normal enum control
>> would require the user to first manually set then
>> again unset the bit again for the strobe to trigger.
>>
>> Get/put accessors added.
>>
>> snd_soc_get_enum_strobe
>> snd_soc_put_enum_strobe
>>
>> Also a generic convenience macros added.
>>
>> SOC_ENUM_STROBE
> 
> Based on this description it's hard to see why this control is patterned
> after an enum - why would we have an enumerated control to bounce a
> single register bit on then off?


I originally chose to pattern this control after an enum since enum controls
would allow for exposing such intuitive textual information to the client about
the state of the control for this type of use case.

The idea being that the enum would have two options like ('Ready'/'Apply' or
possibly 'Idle'/'Activate'). Setting 'Apply' would then strobe the bit high
then low and a consecutive read for a client of this control would then return
'Ready' to signify that the hardware is ready for a new strobe push.

I suppose that the control might as well be modeled after a SOC_SINGLE instead.
I noticed that a SOC_SINGLE_EXT with max = 1 would  set element type to BOOLEAN
in snd_soc_info_volsw which I guess also would work just fine for this type of
control.

Do you think that SOC_SINGLE would be a choice to pattern this control from?

Or would you prefer that the control still be textual but more specifically
force only exactly two textual options and not just any generic enum?
