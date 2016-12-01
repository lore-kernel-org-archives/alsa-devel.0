From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42l56: Fix misuse of
 regmap_update_bits
Date: Thu, 1 Dec 2016 08:57:54 -0600
Message-ID: <fc0ed157-8514-47cc-9fbb-235968541a36@EX3.ad.cirrus.com>
References: <1480439449-15975-1-git-send-email-florian.vaussard@heig-vd.ch> <20161201094200.GK1867@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161201094200.GK1867@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Florian Vaussard <florian.vaussard@gmail.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Dec 2016, Charles Keepax wrote:

> On Tue, Nov 29, 2016 at 06:10:49PM +0100, Florian Vaussard wrote:
> > Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
> > and k greater than 0 is wrong. Indeed, _regmap_update_bits will perform
> > (mask & 1), which results in 0 if LSB of mask is 0. Thus the call
> > regmap_update_bits(..., mask, 1) is in reality equivalent to
> > regmap_update_bits(..., mask, 0).
> > 
> > In such a case, the correct use is regmap_update_bits(..., mask, mask).
> > 
> > This driver is performing such a mistake with the CS42L56_AIN*_REF_MASK
> > masks, which equal 0x10, 0x20, 0x40 and 0x80. Fix the driver to make it
> > consistent with the API. Please note that this change is untested,
> > as I do not have this piece of hardware. Testers are welcome!
> > 
> > Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> > ---
> 
> Looks good to me:
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Thanks,
> Charles
> 
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks,
Brian
