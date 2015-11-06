From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Fri, 06 Nov 2015 21:47:35 +0100
Message-ID: <87r3k2am8o.fsf@belgarion.home>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
	<20151104183322.GD2549@ck-lbox> <87oaf9bls9.fsf@belgarion.home>
	<20151106092913.GC3378@x1> <20151106092733.GG2549@ck-lbox>
	<20151106094828.GD3378@x1>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151106094828.GD3378@x1> (Lee Jones's message of "Fri, 6 Nov
	2015 09:48:28 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Lee Jones <lee.jones@linaro.org> writes:

> On Fri, 06 Nov 2015, Charles Keepax wrote:
>
>> On Fri, Nov 06, 2015 at 09:29:13AM +0000, Lee Jones wrote:
>> > On Wed, 04 Nov 2015, Robert Jarzmik wrote:
>> > 
>> > > Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:
>> > > 
>> > > > On Wed, Nov 04, 2015 at 06:12:44PM +0100, Robert Jarzmik wrote:
>> > > >> The Wolfson WM9713 provides 8 GPIOs. If the gpiolib is compiled in the
>> > > >> kernel, declare a gpio chip.
>> > > >> 
>> > > >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> 
>> Apologies Lee, we are discussing a patch that adds a GPIO driver
>> into an AC97 CODEC. I had suggested that perhaps we should put
>> the GPIO driver as a seperate driver under GPIO and link the two
>> with an MFD. But Mark has already replied in the thread to say
>> that he doesn't think that will be necessary. Although he did
>> raise some concerns that perhaps it could be done more generally
>> as it should apply to other AC97 CODECs as well.
>> 
>> So I think you can probably safely ignore this for now, sorry
>> for the noise.

Ok, so where I should target this code at ? Should this land in
sound/soc/soc-ac97.c ? Or somewhere else ? I'd like to see where you think the
init_gpio() and free_gpio() should be put.

Cheers.

-- 
Robert
