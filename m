From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: drop support for PlayPaq with WM8510
Date: Wed, 23 Nov 2011 11:10:21 +0000
Message-ID: <20111123111021.GF21073@opensource.wolfsonmicro.com>
References: <1322041150.1753.25.camel@x61.thuisdomein>
 <20111123102933.GI4332@opensource.wolfsonmicro.com>
 <1322046346.1753.59.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322046346.1753.59.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 12:05:46PM +0100, Paul Bolle wrote:
> On Wed, 2011-11-23 at 10:29 +0000, Mark Brown wrote:
> > Applied, thanks.  Please do always use subject lines which match the
> > subsystem you're submitting against.

> I'll try to do that. But I'm not so familiar with the sound system. What
> actually is the subsystem I should have used here?

ASoC for this stuff, ALSA in general.  The easiest way to do this is to
run 'git log' on the files you're changing and see what all the other
commits are using.
