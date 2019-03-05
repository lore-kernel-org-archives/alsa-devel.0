From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Tue, 5 Mar 2019 09:35:29 +0000
Message-ID: <20190305093529.dls55rg6ftjnwobm@shell.armlinux.org.uk>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EF00F896CE
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2019 10:35:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190305044232.GA15636@workstation>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 05, 2019 at 01:42:32PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Mon, Mar 04, 2019 at 11:59:52AM -0500, Sven Van Asbroeck wrote:
> > Negotiation seems to work ok, but bclk_ratio is exposed to
> > userspace via snd_pcm_hw_params, which is not acceptable.
> > 
> > Constrain bclk_ratio by:
> > - cpu   dai capabilities && rules
> > - codec dai capabilities && rules
> > - minimum bclk_ratio is sample_width * channels
> > 
> > In hw_params_choose(), pick the smallest supported bclk_ratio,
> > which should correspond to the most efficient solution.
> > 
> > If cpu and codec dais do not specify or constrain supported
> > bclk_ratios, alsa will pick sample_width * channels.
> > 
> > Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> > ---
> >  include/sound/pcm.h         | 11 +++++++++++
> >  include/sound/soc.h         |  2 ++
> >  include/uapi/sound/asound.h |  5 +++--
> >  sound/core/pcm_native.c     | 34 +++++++++++++++++++++++++++++++++-
> >  sound/soc/soc-pcm.c         |  8 ++++++++
> >  5 files changed, 57 insertions(+), 3 deletions(-)
> 
> In UAPI of Linux sound subsystem, sample formats are represented
> in enumerators prefixed with 'SNDRV_PCM_FORMAT_'. In the enumerators,
> sample bits and padding bits are represented:
> 
>               S8 S16 S20 S24 S32 S18_3 S20_3 S24_3
> sample-bits:   8  16  20  24  32  18    20    24 (=width)
> padding-bits:  0   0  12   8   0   6    12     0
> total bits:    8  16  32  32  32  24    24    24 (=physical_width)
>  
> When indicating a certain bit ratio of BCLK/WS from userspace,
> applications use correct combination of the above format (=physical_width)
> and the number of samples per audio data frame (=channels).

You seem to be conflating the in-memory format with the on-wire format.
These are two entirely different things.  Your table above clearly shows
the in-memory format, not the on-wire format.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
