From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [alsa-devel][PATCH v7] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Sat, 6 Jan 2018 11:00:01 -0600
Message-ID: <20180106170000.lkofva6unqdv5c6n@localhost.localdomain>
References: <20171219205415.wlu4atv2mdy7i3gb@localhost.localdomain>
 <20180105122242.GC9076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105122242.GC9076@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 12:22:42PM +0000, Mark Brown wrote:

> > +	SOC_ENUM("MBC Band1 Level Detect Switch",
> > +		mbc_level_detection_enums[0]),
> > +	SOC_ENUM("MBC Band2 Level Detect Switch",
> > +		mbc_level_detection_enums[1]),
> > +	SOC_ENUM("MBC Band3 Level Detect Switch",
> > +		mbc_level_detection_enums[2]),
> > +	SOC_ENUM("MBC Band1 Level Detect Win Switch",
> > +		mbc_level_detection_window_enums[0]),
> > +	SOC_ENUM("MBC Band2 Level Detect Win Switch",
> > +		mbc_level_detection_window_enums[1]),
> > +	SOC_ENUM("MBC Band3 Level Detect Win Switch",
> > +		mbc_level_detection_window_enums[2]),
> 
> These are enums so they should probably not have Switch at the end of
> their name, I suspect that might confuse userspace somehow.

v8 will remove Switch from the name.

> > +	SOC_SINGLE("MBC1 Phase Invert", R_DACMBCMUG1, FB_DACMBCMUG1_PHASE,
> > +		1, 0),
> 
> While this is an on/off switch (for inversion) so it ought to end in
> Switch.  Otherwise this driver looks good I think, just those couple of
> small things so I'll apply - please send followup patches fixing.

v8 will add Switch to this.

Thank you again for your time on this.
