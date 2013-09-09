From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH] codecs: mc13783: add spi errate fix
Date: Mon, 9 Sep 2013 17:58:52 +0200
Message-ID: <20130909155852.GE10398@pengutronix.de>
References: <1378735956-17318-1-git-send-email-s.trumtrar@pengutronix.de>
 <20130909145730.GF29403@sirena.org.uk>
 <20130909153328.GO29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130909153328.GO29403@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 09, 2013 at 04:33:28PM +0100, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 03:57:30PM +0100, Mark Brown wrote:
> > On Mon, Sep 09, 2013 at 04:12:36PM +0200, Steffen Trumtrar wrote:
> > > The MC13783 Chip Errata, Rev. 4 says, that depending on SPI clock
> > > and main audio clock speed, the Audio Codec or Stereo DAC do sometimes
> > > not start when programmed to do so. This is due to an internal clock
> > > timing issue related to the loading of the SPI bits into the audio block.
> > 
> > Applied, thanks.
> 
> ...and reverted since PMIC_AUDIO_CODEC isn't defined.  Please fix and
> resend.

Ah, damn. Will resend ASAP. Sorry.

str

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
