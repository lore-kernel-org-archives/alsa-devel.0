From: Arun Shamanna Lakshmi <aruns@nvidia.com>
Subject: RE: [PATCH] ASoC: dapm: Add support for multi register mux
Date: Fri, 4 Apr 2014 00:34:28 -0700
Message-ID: <781A12BB53C15A4BB37291FDE08C03F3A05CDCE1AA@HQMAIL02.nvidia.com>
References: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
 <533D1B65.3030405@metafoo.de>
 <781A12BB53C15A4BB37291FDE08C03F3A05CDCDF9F@HQMAIL02.nvidia.com>
 <533E5FD4.8040403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <533E5FD4.8040403@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Songhee Baek <sbaek@nvidia.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Friday, April 04, 2014 12:32 AM
> To: Arun Shamanna Lakshmi
> Cc: lgirdwood@gmail.com; broonie@kernel.org;
> swarren@wwwdotorg.org; perex@perex.cz; tiwai@suse.de; alsa-
> devel@alsa-project.org; linux-kernel@vger.kernel.org; Songhee Baek
> Subject: Re: [PATCH] ASoC: dapm: Add support for multi register mux
> 
> On 04/03/2014 10:11 PM, Arun Shamanna Lakshmi wrote:
> [...]
> >> Here as well, default for bit_pos should be 0.
> >
> > This means when 'None' of the options are selected, by default, it
> > enumerates to 0. Since we are using __ffs, BIT(0) of Register-0 also
> > enumerates to 0. That's the reason why I used just ffs in the first place.
> > Let me know your opinion. My value table looks like below.
> >
> > #define MUX_VALUE(npart, nbit)	(nbit + 32 * npart)
> > static const int mux_values[] = {
> > 	0,
> > 	MUX_VALUE(0, 0),
> > 	.
> > 	.
> > 	.
> > 	MUX_VALUE(0, 31),
> > 	/* above inputs are for part0 mux */
> > 	MUX_VALUE(1, 0),
> > 	.
> > 	.
> > 	.
> > 	MUX_VALUE(1, 31),
> > 	/* above inputs are for part1 mux */
> > 	MUX_VALUE(2, 0),
> > 	.
> > 	.
> > 	.
> > 	MUX_VALUE(2, 31),
> > 	/* above inputs are for part2 mux */
> > };
> 
> Ok, so having none of the input selected should be a valid user selectable
> option?

Yes. If 'None' is selected, it goes and clears the register. So, can we have ffs( )
instead of __ffs( ) ? It would fix this case.

- Arun
