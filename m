From: Peter Rosin <peda@axentia.se>
Subject: SV: [PATCH] ASoC: docs: add clocking examples for DAI formats
Date: Mon, 18 Apr 2016 13:18:47 +0000
Message-ID: <AM4PR02MB12995405358C13BA5FC4DE44BC6B0@AM4PR02MB1299.eurprd02.prod.outlook.com>
References: <AM4PR02MB12998486C09055D610F9077FBC6B0@AM4PR02MB1299.eurprd02.prod.outlook.com>
 <20160418130313.GD3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160418130313.GD3217@sirena.org.uk>
Content-Language: sv-SE
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@lysator.liu.se" <peda@lysator.liu.se>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Apr 18, 2016 at 12:55:23PM +0000, Peter Rosin wrote:
> > Mark Brown wrote:
> 
> > > There is an actual spec for I2S which is going to be clearer than ASCII
> > > art:
> 
> > >    https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf
> 
> > > is the first hit on google (there's a bunch of electrical stuff in there
> > > that gets roundly ignord these days but the clocking stuff is in there).
> 
> > Yes, but where are the equivalent docs for the other formats?
> 
> There aren't any (beyond the usual references to the Wolfson datasheets
> which I'd suggest should be in here) but that doesn't mean we should
> ignore this spec when we have it.

This is exactly the problem. For an outsider, it's impossible to know that
wolfson has the correct definition of the modes. Why should wolfson datasheets
trumph nxp or ti datasheets (or whatever), if there is an inconsistency?

We need to specify somewhere exactly what Linux means with the different
modes. Because there are bugs in this area, where DAIs claim to support
the same format but are not actually compatible. Which one is buggy then?
And this is not about flank timings or such details, it's about what bits go
where in relation to flanks etc.

> > > In general I'd rather have some words rather than just pictures, ASCII
> > > art as the only thing is pretty hard to read.
> 
> > I'll post a v2 with some words about each format. Or will you reject
> > anything with ASCII art?
> 
> So long as it's comprehensible.

Ok

Cheers,
Peter
