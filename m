From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Wed, 04 Nov 2015 20:35:18 +0100
Message-ID: <87oaf9bls9.fsf@belgarion.home>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
	<20151104183322.GD2549@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151104183322.GD2549@ck-lbox> (Charles Keepax's message of
	"Wed, 4 Nov 2015 18:33:22 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:

> On Wed, Nov 04, 2015 at 06:12:44PM +0100, Robert Jarzmik wrote:
>> The Wolfson WM9713 provides 8 GPIOs. If the gpiolib is compiled in the
>> kernel, declare a gpio chip.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>
> You should probably make a seperate driver within GPIO for this
> and then tie the two together, using an MFD. I appreciate that is
> more work but it is likely a nicer solution overall.

I'd like to first have a confirmation from :
 - Mark (Brown)
 - and Lee (Jones)

The confirmation I'm looking for states that :
 - the wm9713 should have a part in the mfd tree
 - the gpio part should be in drivers/gpio
 - the sound soc codecs will remain as is
 - if the future driver/mfd/wm9713.c is technically sound, it will be accepted

I remember at least one example where the MFD approach was rejected from mfd
tree for pxa gpios, so I won't work unless I have a confirmation from both
maintainers.

Thanks.

-- 
Robert
