From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo Semiconductor's
 TSCS42xx audio CODEC
Date: Wed, 13 Dec 2017 09:40:00 -0600
Message-ID: <20171213153958.6fgpujl33kzuszur@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
 <20171212225134.mmwigvfgi7fbvgyz@localhost.localdomain>
 <20171213104732.GB6416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213104732.GB6416@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 10:47:32AM +0000, Mark Brown wrote:
> The things the driver is doing automatically to mute the DACs and ADCs
> should be moved to user control if they're not suitable for doing
> automatically.
> 
The mutes can work normally without the PLL stuff. I have removed the PLL
stuff from the next version and have added a DAPM widget to handle the
PLL power up/down.

> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.
I apologize again. I realized that I had done that after it was too
late. 

Thanks for the reviews and all the help. I believe this driver has improved
through this process.
