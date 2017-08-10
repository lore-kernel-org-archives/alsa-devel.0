From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [PATCH v3 3/5] ASoC: codecs: msm8916-wcd-analog: add MBHC support
Date: Thu, 10 Aug 2017 09:33:29 -0400
Message-ID: <20170810133329.7lqcg3tucgp5jxii@workotop.localdomain>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
 <20170809164927.19663-4-srinivas.kandagatla@linaro.org>
 <20170809211054.4owecfeoxxud5evh@workotop.localdomain>
 <76eb6edf-1754-6679-6218-028b12dce49a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76eb6edf-1754-6679-6218-028b12dce49a@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Aug 10, 2017 at 11:02:34AM +0100, Srinivas Kandagatla wrote:
> Hi Damien,
> Thanks for testing.
> 
> On 09/08/17 22:10, Damien Riegel wrote:
> > Hi Srinivas,
> > 
> > On Wed, Aug 09, 2017 at 06:49:25PM +0200, srinivas.kandagatla@linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > MBHC (MultiButton Headset Control) support is available in pm8921 in two
> > > blocks, one to detect mechanical headset insertion and removal and other
> > > block to support headset type detection and 5 button detection and othe
> > > features like impedance calculation.
> > > 
> > > This patch adds support to:
> > > 1> Support to NC and NO type of headset Jacks.
> > > 2> Mechanical insertion and detection of headset jack.
> > > 3> Detect a 3 pole Headphone and a 4 pole Headset.
> > > 4> Detect 5 buttons.
> > > 
> > > Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
> > > headset/headphones.
> > 
> > I have the same issue with this patchset, KEY_MEDIA is being reported
> > when unplugging a headset. I added a few traces and what I observe is
> Am unable to reproduce the same issue, I tried atleast 6 different mix of
> headset/headphones.
> here is my evtest log:  http://paste.ubuntu.com/25282592/
> 
> Could you explain bit more about your setup, so that I can try to reproduce
> the same issue.
> 
> My setup is DB410c + Audio Mezz board
> https://www.arrow.com/en/products/audiomezz/seeed-technology-limited

I'm using a hardware based on Intrinsyc Open-Q 410 Development Kit:
https://www.intrinsyc.com/snapdragon-embedded-development-kits/snapdragon-410-development-kit/

We use the same SoM with a different carrier board, but connections to
the jack connector are routed the same way on both carrier boards.

> > that the "button pressed" irq is fired when unplugging, but no "button
> > released" irq follows. To get a "button released" irq, I need to either
> > plug a headset, or plug-and-unplug headphones.
> > 
> > So basically, detection fails because we don't get the "button pressed"
> > irq prior to the mechanical switch irq. Do you know what could explain
> > the MBHC not firing the "button released" irq when unplugging headset?
> > 
> Can you also share output of evetest and /proc/interrupts so that i can see
> if the extra logic of masking btn0 is creating the issue, we can also try
> removing the btn0 accessory detect logic and see if we get correct button
> press/releases.

It's definitely what's causing the headphones to be reported as headset,
but not what's causing the interrupt not to be triggered in the first
place. I don't have access to the hardware right now, so I'll provide
you with logs next week.

Thanks,
-- 
Damien
