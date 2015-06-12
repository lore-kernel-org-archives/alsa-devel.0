From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH 1/4] ASoC: wm8960: codec mclk should be
 enabled early to avoid jack detect error
Date: Fri, 12 Jun 2015 14:32:33 +0800
Message-ID: <20150612063231.GA23608@shlinux2>
References: <cover.1434020423.git.zidan.wang@freescale.com>
 <880838f666b591f5ffb0de1e39df5e3734846246.1434020423.git.zidan.wang@freescale.com>
 <20150611162028.GT14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150611162028.GT14071@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2015 at 05:20:28PM +0100, Mark Brown wrote:
> On Thu, Jun 11, 2015 at 07:14:33PM +0800, Zidan Wang wrote:
> > It will playback from speaker in the first 2 seconds, then switch to
> > headphone. Steps to reproduce this issue:
> > 1. plug out headphone and playback a wav.
> > 2. stop playback and wait for at least 5 seconds, then
> >    plug in headphone and playback a wav.
> 
> I'd really like to understand the logic behind this in more detail -
> what is the actual problem here and how does this fix it?  You're moving
> the clock management from the bias level setting to the stream startup
> and teardown which doesn't seem directly related, if anything it seems
> like it'd be making things worse since it reduces the proportion of the
> time where the clock is enabled.  My guess is that the jack detection
> needs MCLK enabling.

I select RINPUT3/JD3 pins as headphone jack detect inputs. I found that
it would detected as speaker sometimes even if headphone jack is plugged in.
And it would be reproduced everytime when i followed below steps:
1. Unplug headphone jack and playback a wav. It will playback from speaker.
2. Stop playback and wait for at least 5 seconds, then plug in headphone jack
   and playback a wav. I will playback from speaker in the first 1-2 seconds,
   and then switch to headphone.

I suspect the codec need some time to prepare jack detect function after SYSCLK
enable. When Unplug headphone jack and playback, it will detect as speaker. After
this playback, the mclk will be disabled, and the detect function will be disabled
too. So when you plug in the headphone jack in this moment, the codec can't detect
as headphone. And when playback a wav, it will playback from speaker. After the
headphone jack detect function works, it will switch to headphone.

I have done some test today, and found that after mclk enable, we should delay
at least 150ms to prepare the jack detect function. So no need to move mclk
enable to startup.

Best Regards,
Zidan Wang
