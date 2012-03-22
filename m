From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Subject: Re: [PATCH 01/16] ASoC: core: Add multi reg control
	struct & macros
Date: Thu, 22 Mar 2012 16:46:56 +0100
Message-ID: <4F6B4970.3080003@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213859.GG3177@opensource.wolfsonmicro.com>
	<4F69C493.7070109@stericsson.com>
	<20120321124029.GD3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id C20CF103ED7
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 16:47:46 +0100 (CET)
In-Reply-To: <20120321124029.GD3226@opensource.wolfsonmicro.com>
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

On 2012-03-21 13:40, Mark Brown wrote:

> On Wed, Mar 21, 2012 at 01:07:47PM +0100, Kristoffer KARLSSON wrote:
> 
> *NEVER* top post...
> 
>> I believe that the assumption that all the registers are contiguous would
>> pose a troublesome limitation in this case.
> 
> ...it leads to people reading contextless things like this and having no
> idea what you're talking about.
> 
> You should also fix your mailer to word wrap within 80 columns - note
> how the quote above wraps.
 

Adjusted mailer. Thank you for the notice.

>> suggested would work just fine, we also have other controls with signed
>> 32-bit values that span four 8-bit registers that mapped in the following
>> manner:
> 
>> bits	31-24	23-16	15-8	7-0
>> reg	0x59	0x5A	0x59	0x5A
> 
>> This means that to write one complete 32-bit value we would actually need
>> to write to the same 8-bit registers twice.
> 
> This makes no sense - how do the vales "span four 8-bit registers" while
> using only two register addresses?


Every write to register 0x5A copies the written data to the correct active
internal chunk of bits of the composite (which after chip boot up is the upper
bit parts of the complete 32-bit parameter) then it automatically (as part of
the write operation) toggles an internal shift pointer inside the chip that
makes the subsequent write to registers 0x59 and 0x5A point to the lower most
bits of the full 32-bit parameter. Writing to register 0x5A the second time
hence copies the written data the lower bit parts and then toggles the internal
shift back to point to the upper bits again allowing for another pass of
writing of the complete 32-bit value parameter.

In our hardware there is no way to determine the current toggle position of the
above described internal shift pointer (or even to reset it) so it becomes very
important to make sure to write exactly twice to both 0x59 and 0x5A and in that
very order to make sure that the internal shift pointer always afterwards is
pointing to the upper most bits of the 32-bit value allowing for configuring of
a new 32-bit value.

>> Also I believe that the definition S1R,S2R,S4R together with S8R might in
>> fact already be a fairly complete set with no need to add some new crop of
>> macros for this in future. Why? Well since the value handled by 
>> ASoC-framework when setting/reading a integer control is of type long 
>> (snd_ctl_elem_value) in combination with the fact that 1 byte being the
>> smallest register size in framework means that in a 64-bit world this would
>> translate to a maximum of eight registers mapping the composite value of.
>> that long value.
> 
> What happens when someone wants unsigned controls, or stereo controls,
> or 24 bit registers or anything else?  There's way more things can vary
> than just the word size.
 

This is true. In light of this a single parametrized macro like you suggested
would be preferable. This will allow for more variants like you said. I agree.

>> Anyhow in light of the situation above do you think we could stick to the
>> submitted approach or do you have some other suggestion on how to define
>> the signed 32-bit value control with registers mapped in the above
>> described fashion?
> 
> No, sorry.  This stuff just all seems really painful to use, I'd at
> least hope for more parameterisation.


I will make a new patch that adds only one macro with a parameter exposing a
register base (ie. the starting register) in combination with a parameter for
register count like you suggested. While this approach will not support the
very type of register mapping discussed above it will work just fine for the
several other multi register controls we also have in our hardware that really
are contiguous and also supports reading back the composite signed value. For
these controls this parameterized single macro would work just fine.

For the three special composite controls we have in our hardware that requires
writing to the same register several times during configuration of one single
parameter I propose a separate solution due to the fact that the hardware does
not even support reading back those values since a read operation does not
trigger the internal shift toggle like the write operations do, which means
that only half the complete composite value can ever be read back. To handle
these three controls I propose a separate new macro that allows for caching of
the lastly written composite long value stored in that control's private value
member allowing for any client reading back the lastly configured parameter
while still the 8-bit chunks of the composite value can be written to the
hardware in the specific sequence required for that parameter.

I will submit this additional second patch also in full so that you can have a
look at it to see if you agree that it would be generic enough for addition to
the asoc-core framework or if we need to keep these additional cached controls
only as a specific implementation in our codec driver due to the
characteristics of our hardware design which does not allow for read back of
the complete composite value in all cases.

But for the first control type (composite control composed of a parameterized
number of contiguous 8-bit registers) I think we agree on the implementation of
a single macro for that now. I believe that it could be called
SOC_SINGLE_XR8_SX then? Do you agree?
