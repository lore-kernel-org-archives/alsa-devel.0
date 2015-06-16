From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH 2/4] ASoC: wm8960: support configure
 headphone jack detect pin and polarity from device tree
Date: Tue, 16 Jun 2015 15:47:10 +0800
Message-ID: <20150616074704.GA9262@shlinux2>
References: <cover.1434020423.git.zidan.wang@freescale.com>
 <a9b871099c39cd0ef48e2b85ef93294e97ef8c70.1434020423.git.zidan.wang@freescale.com>
 <20150612125005.GI32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150612125005.GI32730@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 12, 2015 at 01:50:05PM +0100, Charles Keepax wrote:
> On Thu, Jun 11, 2015 at 07:14:34PM +0800, Zidan Wang wrote:
> > The ADCLRC/GPIO1, LINPUT3/JD2 and RINPUT3/JD3 pins can be selected as
> > headphone jack detect inputs to automatically disable the speaker output
> > and enable the headphone.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > ---
> 
> This feels like this is missing some iteraction with DAPM, there
> are DAPM widgets that represent both the Speaker and the
> Headphone, in the case this feature is in use the power state
> DAPM shows may no longer accurately reflects the actual power
> state of the device.
> 
> That said I have no idea if the registers update on the chip to
> reflect this change (my guess is that they don't). I am not
> really sure what the correct way to handle this sort of hardware
> output switching would be in DAPM.
> 
> Thanks,
> Charles
Yes, there are no registers represent that it is playback from headphone
or speaker. So the hardware should connect the headphone detect output 
to CPU GPIO pin instead of the codec headphone detect pin?

Best Regards,
Zidan Wang
