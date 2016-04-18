From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: docs: add clocking examples for DAI formats
Date: Mon, 18 Apr 2016 20:49:32 +0000
Message-ID: <AM4PR02MB1299226084B681EE68C93958BC6B0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Language: sv-SE
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@lysator.liu.se" <peda@lysator.liu.se>
List-Id: alsa-devel@alsa-project.org

On 2016-04-18 17:11, Mark Brown wrote:
> On Mon, Apr 18, 2016 at 01:18:47PM +0000, Peter Rosin wrote:
>> Mark Brown wrote:
> 
>>>
>>> There aren't any (beyond the usual references to the Wolfson datasheets
>>> which I'd suggest should be in here) but that doesn't mean we should
>>> ignore this spec when we have it.
> 
>> This is exactly the problem. For an outsider, it's impossible to know that
>> wolfson has the correct definition of the modes. Why should wolfson datasheets
>> trumph nxp or ti datasheets (or whatever), if there is an inconsistency?
> 
> I'm not quite sure what your concern is here?  I'm saying that where
> there are specs we should link to them.  I'm not saying we can't add
> to that.

I'm just saying that I don't know which specs to trust.

E.g. a random wolfson datasheet (wm8778) says that DSP mode B will have BCLK and
LRC like this when it is clk master

 .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
       .---.                                                       .---.
-------'   '-------------------------------------------------------'   '-----

and that it will accept the negative LRC flank later when it is clk slave,
with a figure showing this as the extreme:

 .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
---.   .-------------------------------------------------------.   .-----
   '---'                                                       '---'

Then we have the tfa9879 datasheet from nxp which has this for its long sync
format:

-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-
 '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-'
-----. .---------------------------------------------------------. .-----
     '-'                                                         '-'

This is all very difficult to match up for someone who doesn't work with this
on a day-to-day basis and know it by heart. Why should I go to some random
wolfson datasheet for info?

I don't know if the nxp long sync format is compatible with DSP mode B with
inverted BCLK, but it certainly looks like it might be. The LRC is low for
only half a cycle and that is not acceptable according to the wolfson
datasheet, but is that a limitation in wm8778 or is the tfa9879 problematic?
How would you suppose I figure out if the tfa9879 driver should declare
compatibility with DSP mode B with inverted BCLK if there is no documentation
of what *ASoC* thinks that DSP mode B really is?

This info is desperately missing, that is all that I'm saying.

With this background, I'm a bit reluctant to add links to some datasheet,
because they tend to describe how the chip in question behaves, and not the
protocol as such. But sure, the I2S spec is something else as it's independent
from any particular chip.

BTW, I found out that I had misunderstood DSP mode A in v1/v2 of the patch, so
a v3 is coming up where I'll also add a link to the I2S spec. If there is any
particular link that you think I should add for any other format spec, please
holler.

Cheers,
Peter
