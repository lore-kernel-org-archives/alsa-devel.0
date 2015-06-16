From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH 1/4] ASoC: wm8960: codec mclk should be
 enabled early to avoid jack detect error
Date: Tue, 16 Jun 2015 17:30:21 +0800
Message-ID: <20150616093019.GA26119@shlinux2>
References: <cover.1434020423.git.zidan.wang@freescale.com>
 <880838f666b591f5ffb0de1e39df5e3734846246.1434020423.git.zidan.wang@freescale.com>
 <20150611162028.GT14071@sirena.org.uk> <20150612063231.GA23608@shlinux2>
 <20150612103349.GE1921@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150612103349.GE1921@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 12, 2015 at 11:33:49AM +0100, Mark Brown wrote:
> On Fri, Jun 12, 2015 at 02:32:33PM +0800, Zidan Wang wrote:
> 
> > I have done some test today, and found that after mclk enable, we should delay
> > at least 150ms to prepare the jack detect function. So no need to move mclk
> > enable to startup.
> 
> No, this makes no sense - jack detection is not related to playback at
> all.  The system should be able to detect if something is connected at
> any time.  What this says is that you need to keep MCLK enabled while
> jack detection is available.

This may be the wm8960 codec hardware issue. In generally, we will connect the headphone detect
output to the CPU GPIO and let CPU to deal with the headphone jack detect event. The wm8960 have
the feature to auto detect headphone jack itself, so in order to save CPU pin, we connect the
headphone detect output to the codec headphone jack detect pin(RINPUT3/JD2).

This issue is abnormal. Anyone else who using the community driver meet the same issue?

Best Regards,
Zidan Wang
