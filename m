From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: docs: add clocking examples for DAI formats
Date: Mon, 18 Apr 2016 12:55:23 +0000
Message-ID: <AM4PR02MB12998486C09055D610F9077FBC6B0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Language: sv-SE
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@lysator.liu.se" <peda@lysator.liu.se>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Apr 18, 2016 at 11:39:50AM +0200, Peter Rosin wrote:
> 
> > +I2S
> > + .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
> > +-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-
> 
> There is an actual spec for I2S which is going to be clearer than ASCII
> art:
> 
>    https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf
> 
> is the first hit on google (there's a bunch of electrical stuff in there
> that gets roundly ignord these days but the clocking stuff is in there).

Yes, but where are the equivalent docs for the other formats?

> In general I'd rather have some words rather than just pictures, ASCII
> art as the only thing is pretty hard to read.

I'll post a v2 with some words about each format. Or will you reject
anything with ASCII art?

Cheers,
Peter
