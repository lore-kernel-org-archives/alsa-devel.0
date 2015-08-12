From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Wed, 12 Aug 2015 16:08:31 -0700
Message-ID: <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com
 [209.85.213.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 68B9A2608ED
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 01:08:32 +0200 (CEST)
Received: by vkbc123 with SMTP id c123so11711515vkb.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 16:08:31 -0700 (PDT)
In-Reply-To: <20150811163954.GM10748@sirena.org.uk>
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
Cc: mfelton1@nuvoton.com, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

>> Moved it to ALSA controls. Though I still feel a bit uncomfortable
>> that the default control value is not usable.
>> I have to set "ADC Decimation Rate" and "DAC Oversampling Rate"
>> controls in userspace from its defaults to "128".

>Setting the default isn't too bad in this case (especially with a
>comment explaining why) - that doesn't preclude also providing user
>configuration.

What is the best way to set default control value? Just a regmap_write()?

>> After discussing it with my teammates who works on Intel+NAU8825
>> platform I found that they use MCLK only at playback/capture time. The
>> rest of the time VCO is suppose to be sysclk source. Thus using
>> get_clk() is not flexible for all cases.
>
> I'm sorry, I don't understand.  What makes you say that "using get_clk()
> is not flexible for all cases", I can't quite parse that bit?

My initial assumption was that you are talking about moving complete
clock handling (clock initialization, MCLK frequency calculation based
on rate, policy of switching clock sources i.e. everything that
platform drivers do) to the the driver code.

I've looked at other codec drivers and did not find many examples of
using clk api. The drivers seems expect clock signal is pre-configured
already. e.g. tegra has a utility function that configures audio
clocks tegra_asoc_utils_set_rate() and it actively used in tegra-based
platform drivers.

Locally I tried to move clock initialization out of platform code to
codec itself. Codec calls devm_clk_get() in init and sets frequency in
nau8825_set_sysclk(). See it here
https://github.com/anatol/linux/tree/nau8825  It works fine on a
Tegra-based device. But I found that devm_clk_get() is DTS specific
and does not work with ACPI. We need NAU8825 driver for Intel platform
as well.


>> I was following code from ts3a227e driver that does the same.
>
> That device is specifically tied to Chromebooks which have a defined
> mapping, as opposed to being a generic device which is usable on a range
> of devices.

I do not see anything Chromebook specific about this chip

http://www.ti.com/product/ts3a227e


>> > This function doesn't appear to affect the hardware.  I would expect
>> > that the jack detection hardware is turned off when not in use.
>
>> Disabling jack detection means disable HeadsetCompletion IRQ. But the
>> IRQ handler does a bunch of manual stuff like grounding/ungrounding
>> jack pins. If IRQ handler is not called then neither playback nor
>> capture will not work.
>
> The assumption would be that if the system doesn't have or need jack
> detection then the jack pins won't be reconfigurable anyway.
>
>> At this point this function just sets jack structure needed later in
>> IRQ handler.
>
> I can see what it's doing, I'd just also expect it to also be starting
> and stopping the detection in the hardware.

If we move IRQ enabling from init() function to enable_jack_detect()
then it means chip will be unusable after the init(). It won't be able
to playback nor capture audio. All developers will be forced to call
nau88225_enable_jack_detect() from their platform driver to enable
basic chip functionality. I think it is better if basic functionality
is enabled during driver init and does not require additional steps.

It is better if I rename nau8825_enable_jack_detect() to
nau8825_set_jack() to make cleaner what the function suppose to do. It
sets jack structure that driver uses to report events to upper level.
If the jack pointer is not set then driver still handles jack
insert/eject internally but does not report it to the userspace.
