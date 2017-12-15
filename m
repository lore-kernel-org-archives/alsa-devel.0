From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [alsa-devel] [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Fri, 15 Dec 2017 10:08:50 -0600
Message-ID: <20171215160848.iuycdjc7v5crbnxi@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
 <20171214093244.udrjwgfvpxpc3jq7@localhost.localdomain>
 <20171214222955.qicmzltikkwaazly@localhost.localdomain>
 <20171214224309.btsuh3ew5lkqfpcf@localhost.localdomain>
 <20171215113654.a47ddf2bo44ziucl@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171215113654.a47ddf2bo44ziucl@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 15, 2017 at 11:36:54AM +0000, Charles Keepax wrote:

> Hmm... might need to think about the case of whether to share a
> clock depends a little on what the hardware actually looks like.
> 
> But basically my point is that writing random CODEC registers
> from the machine driver is not very nice. You want to be making
> use of ASoC calls etc. to have the CODEC driver apply the setting
> you want.
> 
> For example you might call snd_soc_dai_set_fmt to configure
> who is master/slave, but you wouldn't want to write the bit
> that selects master mode on the CODEC directly from the machine
> driver.

I completely agree. ASoC calls would be better or maybe something in the
DT. The register setting needs to reflect what the physical connections
are. There is no ASRC on the chip so to have the ADC run at a different
rate you would need to use an extra bclk and lrclk and configure
it for that. The current version configures the chip so that the DAC and
ADCs run synchronously which only needs the bclk, lrclk, din, and dout
to function. Doing this in the machine driver is indeed broken as it is
making assumptions.

The next version will either set a sane default using your suggestion
or it will implement something through the device tree. I will think on
it a bit more.
